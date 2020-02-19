#include <windows.h>
#include <cstring>

#include <string>
#include <vector>
#include "Vec2.h"



#include <array>

#include <sstream>
#include <algorithm>


char szWindowClass[] = "DesktopApp";
char szMenu[] = "MainMenu";

char szTitle[] = "Window Desktop Guided Tour Application";

LOGFONT lf;
DWORD rgbCurrent;
HFONT hfont;

std::array<char, 8192> gap_buffer;
size_t gap_start = 0, gap_end = gap_buffer.size();
size_t view_start = 0;
Vec2i start(5, 5);

const LONG CURSOR_WIDTH = 2;
HBRUSH white_brush;


auto move_left() -> void
{
	if(gap_start > 0) {
		gap_buffer[gap_end-1] = gap_buffer[gap_start-1];
		gap_start--;
		gap_end--;
	}
}

auto move_right() -> void
{
	if(gap_end < gap_buffer.size()) {
		gap_buffer[gap_start] = gap_buffer[gap_end];
		gap_start++;
		gap_end++;
	}
}


auto CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam) -> LRESULT
{
	PAINTSTRUCT ps;
	HDC hdc;
	
	
	switch(message) {
	case WM_PAINT: {
		hdc = BeginPaint(hWnd, &ps);
		
		if(hfont) {
			SelectObject(hdc, hfont);
		}
		
		FillRect(hdc, &ps.rcPaint, (HBRUSH)(COLOR_WINDOW+1));
		
		
		Vec2i pos(start);
		SIZE s;
		
		GetTextExtentPoint32(hdc, "A", 1, &s);
		int h = s.cy;
		
		for(size_t i=0; i<gap_start; ++i) {
			size_t limit = gap_start;
			size_t n = i;
			for(;n < limit; ++n) {
				if(gap_buffer[n] == '\n') {
					break;
				}
			}
			
			if(n > i) {
				TextOut(hdc, pos.x, pos.y, &gap_buffer[i], n-i);
				GetTextExtentPoint32(hdc, &gap_buffer[i], n-i, &s);
				pos.x += s.cx;
				i = n;
			}
			
			if(n < limit) {
				pos.x = start.x;
				pos.y += h;
			}
			
		}
		
		RECT cursor_rc;
		cursor_rc.left = pos.x;
		cursor_rc.top = pos.y;
		cursor_rc.right = pos.x + CURSOR_WIDTH;
		cursor_rc.bottom = pos.y + h;
		
		for(size_t i=gap_end; i<gap_buffer.size(); ++i) {
			size_t limit = gap_buffer.size();
			size_t n = i;
			for(;n < limit; ++n) {
				if(gap_buffer[n] == '\n') {
					break;
				}
			}
			
			if(n > i) {
				TextOut(hdc, pos.x, pos.y, &gap_buffer[i], n-i);
				GetTextExtentPoint32(hdc, &gap_buffer[i], n-i, &s);
				pos.x += s.cx;
				i = n;
			}
			
			if(n < limit) {
				pos.x = start.x;
				pos.y += h;
			}
			
		}
		
		FillRect(hdc, &cursor_rc, white_brush);
		
		
		
		
		EndPaint(hWnd, &ps);
		
		break; }
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	case WM_COMMAND: {
		WORD hi = HIWORD(wParam);
		WORD low = LOWORD(wParam);
		switch(hi) {
		case 0:
			switch(low) {
			case 300: { // font settings
				CHOOSEFONT cf = {};
			
				cf.lStructSize = sizeof(cf);
				cf.hwndOwner = hWnd;
				cf.lpLogFont = &lf;
				cf.rgbColors = rgbCurrent;
				cf.Flags = CF_SCREENFONTS | CF_EFFECTS;
			
				if(ChooseFont(&cf)) {
					hfont = CreateFontIndirect(&lf);
				}
			
				InvalidateRect(hWnd, NULL, FALSE);
			
				break; }
			default:
				break;
			}
			
			break;
		default:
			break;
		}
		
		break; }
	case WM_KEYDOWN: {
		switch(wParam) {
		case VK_LEFT:
			move_left();
			break;
		
		case VK_RIGHT:
			move_right();
			break;
		
		case VK_UP: {
			for(;;) {
				move_left();
		
				if(gap_start == 0 || gap_buffer[gap_start] == '\n') {
					break;
				}
			}
			break;
		}
		
		case VK_DOWN: {
			for(;;) {
				move_right();
		
				if(gap_end == gap_buffer.size() || gap_buffer[gap_end-1] == '\n') {
					break;
				}
			}
			break;
		}
		
		case VK_BACK:
			if(gap_start > 0) {
				gap_start--;
			}
			break;
		case VK_RETURN:
			gap_buffer[gap_start++] = '\n';
			break;
		
		default:
			break;
		}
		InvalidateRect(hWnd, NULL, TRUE);
		
		break; }
	case WM_CHAR: {
		if(wParam >= 0x20 && wParam <= 0x7E) {
			gap_buffer[gap_start++] = (char)wParam;
		}
		InvalidateRect(hWnd, NULL, TRUE);
		break; }
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	
	return 0;
}



auto CALLBACK WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) -> int
{
	WNDCLASS wc = {};
	
	wc.lpfnWndProc = WndProc;
	wc.hInstance = hInstance;
	wc.lpszClassName = szWindowClass;
	wc.lpszMenuName = szMenu;
	
	RegisterClass(&wc);
	
	HWND hWnd = CreateWindow(
		szWindowClass,
		szTitle,
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT, CW_USEDEFAULT,
		500, 500,
		NULL,
		NULL,
		hInstance,
		NULL
	);
	
	if(!hWnd) {
		MessageBox(NULL,
			"Call to CreateWindow failed!",
			"Windows Desktop Guided Tour",
			NULL);
		return 1;
	}
	

	white_brush = CreateSolidBrush(RGB(0, 0, 0));
	
	std::ostringstream oss;
	oss << "Calculator v0.1" << std::endl;
	oss << "---------------" << std::endl;
	oss << std::endl;
	oss << "* VIM-like" << std::endl;
	oss << "* " << std::endl;
	oss << std::endl;
	oss << "By jbyuki";
	
	std::string init_s = oss.str();
	gap_start = init_s.size();
	
	std::copy(init_s.begin(), init_s.end(), gap_buffer.begin());
	

	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);
	

	MSG msg;
	
	while(GetMessage(&msg, NULL, 0, 0)) {
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	
	return (int)msg.wParam;
	

	DeleteObject(white_brush);
	
	return 0;
}

