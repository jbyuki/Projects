@*=
#include <windows.h>
@includes

@global_variables

@text_manipulation

@wnd_proc


auto CALLBACK WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) -> int
{
	@register_window_class
	@create_window

	@init_resources

	@show_window

	@message_loop

	@release_resources
	return 0;
}

@wnd_proc=
auto CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam) -> LRESULT
{
	@handle_events
	return 0;
}

@global_variables=
char szWindowClass[] = "DesktopApp";
char szMenu[] = "MainMenu";

@register_window_class=
WNDCLASS wc = {};

wc.lpfnWndProc = WndProc;
wc.hInstance = hInstance;
wc.lpszClassName = szWindowClass;
wc.lpszMenuName = szMenu;

RegisterClass(&wc);

@global_variables+=
char szTitle[] = "Calculator v0.1";

@create_window=
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

@show_window=
ShowWindow(hWnd, nCmdShow);
UpdateWindow(hWnd);

@message_loop=
MSG msg;

while(GetMessage(&msg, NULL, 0, 0)) {
	TranslateMessage(&msg);
	DispatchMessage(&msg);
}

return (int)msg.wParam;

@handle_events=
PAINTSTRUCT ps;
HDC hdc;


switch(message) {
case WM_PAINT: {
	@handle_paint_message
	break; }
case WM_DESTROY:
	PostQuitMessage(0);
	break;
case WM_COMMAND: {
	@handle_command_message
	break; }
case WM_KEYDOWN: {
	@handle_keydown_message
	break; }
case WM_CHAR: {
	@handle_char_message
	break; }
default:
	return DefWindowProc(hWnd, message, wParam, lParam);
}

@handle_paint_message=
hdc = BeginPaint(hWnd, &ps);

@select_font
@clear_window
@paint_window

EndPaint(hWnd, &ps);

@includes=
#include <cstring>

@select_font=
if(hfont) {
	SelectObject(hdc, hfont);
}

@clear_window=
FillRect(hdc, &ps.rcPaint, (HBRUSH)(COLOR_WINDOW+1));


@handle_command_message=
WORD hi = HIWORD(wParam);
WORD low = LOWORD(wParam);
switch(hi) {
case 0:
	@handle_menu_message
	break;
default:
	break;
}

@global_variables+=
LOGFONT lf;
DWORD rgbCurrent;
HFONT hfont;

@handle_menu_message=
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
case 203: // close
	PostQuitMessage(0);
	break;
default:
	break;
}

@includes+=
#include <string>
#include <vector>
#include "Vec2.h"



@paint_window=
@paint_text

@paint_text=
@paint_text_init
@paint_text_before
@save_cursor_position
@paint_text_after
@paint_cursor

@includes+=
#include <array>

@global_variables+=
std::array<char, 8192> gap_buffer;
size_t gap_start = 0, gap_end = gap_buffer.size();
size_t view_start = 0;
Vec2i start(5, 5);

@paint_text_init=
Vec2i pos(start);
SIZE s;

GetTextExtentPoint32(hdc, "A", 1, &s);
int h = s.cy;

@paint_text_before=
for(size_t i=0; i<gap_start; ++i) {
	size_t limit = gap_start;
	@peek_next_chars
	@write_characters
}

@peek_next_chars=
size_t n = i;
for(;n < limit; ++n) {
	if(gap_buffer[n] == '\n') {
		break;
	}
}

@write_characters=
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

@global_variables+=
const LONG CURSOR_WIDTH = 2;
HBRUSH white_brush;

@init_resources=
white_brush = CreateSolidBrush(RGB(0, 0, 0));

@release_resources=
DeleteObject(white_brush);

@save_cursor_position=
RECT cursor_rc;
cursor_rc.left = pos.x;
cursor_rc.top = pos.y;
cursor_rc.right = pos.x + CURSOR_WIDTH;
cursor_rc.bottom = pos.y + h;

@paint_cursor=
FillRect(hdc, &cursor_rc, white_brush);

@paint_text_after=
for(size_t i=gap_end; i<gap_buffer.size(); ++i) {
	size_t limit = gap_buffer.size();
	@peek_next_chars
	@write_characters
}

@includes+=
#include <sstream>
#include <algorithm>

@handle_keydown_message=
switch(wParam) {
@handle_keydown_press
default:
	break;
}
InvalidateRect(hWnd, NULL, TRUE);

@text_manipulation=
auto move_left() -> void
{
	if(gap_start > 0 && gap_buffer[gap_start-1] != '\n') {
		gap_buffer[gap_end-1] = gap_buffer[gap_start-1];
		gap_start--;
		gap_end--;
	}
}

@handle_keydown_press=
case VK_LEFT:
	move_left();
	break;

@text_manipulation+=
auto move_right() -> void
{
	if(gap_end < gap_buffer.size() && gap_buffer[gap_end] != '\n') {
		gap_buffer[gap_start] = gap_buffer[gap_end];
		gap_start++;
		gap_end++;
	}
}

@handle_keydown_press+=
case VK_RIGHT:
	move_right();
	break;

@handle_keydown_press+=
case VK_BACK:
	if(gap_start > 0) {
		gap_start--;
	}
	break;

@handle_char_message=
if(wParam >= 0x20 && wParam <= 0x7E) {
	gap_buffer[gap_start++] = (char)wParam;
}
InvalidateRect(hWnd, NULL, TRUE);

@includes+=
#include "parser.h"

@global_variables+=
Parser parser;

@handle_keydown_press+=
case VK_RETURN: {
	@extract_expression
	@parse_expression
	@print_result
	break; }

@extract_expression=
size_t s=0;
for(size_t i=gap_start;i>0; --i) {
	if(gap_buffer[i-1] == '\n') {
		s = i;
		break;
	}
}
std::string input(gap_buffer.begin()+s, gap_buffer.begin()+gap_start);

@parse_expression=
auto exp = parser.process(input);

@includes+=
#include <cstdio>

@print_result=
char result[128];
strcpy(result, "Syntax error!");

if(exp) {
	sprintf(result, "%g", exp->eval());
}

gap_buffer[gap_start++] = '\n';
gap_buffer[gap_start++] = ' ';
gap_buffer[gap_start++] = '=';
gap_buffer[gap_start++] = ' ';

for(int i=0; i<128 && result[i]; ++i) {
	gap_buffer[gap_start++] = result[i];
}
gap_buffer[gap_start++] = '\n';
