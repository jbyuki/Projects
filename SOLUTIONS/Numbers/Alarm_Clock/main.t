@*=
#include <windows.h>
@includes

@global_variables

@timer_proc
@wnd_proc

auto CALLBACK WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) -> int
{
	@register_window_class
	@create_window
	@init_controls
	@show_window

	@message_loop
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

@register_window_class=
WNDCLASSEX wcex;

wcex.cbSize = sizeof(WNDCLASSEX);
wcex.style = CS_HREDRAW | CS_VREDRAW;
wcex.lpfnWndProc = WndProc;
wcex.cbClsExtra = 0;
wcex.cbWndExtra = 0;
wcex.hInstance = hInstance;
wcex.hIcon = LoadIcon(hInstance, IDI_APPLICATION);
wcex.hCursor = LoadCursor(NULL, IDC_ARROW);
wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
wcex.lpszMenuName = NULL;
wcex.lpszClassName = szWindowClass;
wcex.hIconSm = LoadIcon(wcex.hInstance, IDI_APPLICATION);

if(!RegisterClassEx(&wcex)) {
	MessageBox(NULL, 
		"Call to RegisterClassEx failed!",
		"Windows Desktop Guided Tour",
		NULL);
	return 1;
}

@global_variables+=
char szTitle[] = "Alarm";


@create_window=
HWND hWnd = CreateWindow(
	szWindowClass,
	szTitle,
	WS_OVERLAPPEDWINDOW,
	CW_USEDEFAULT, CW_USEDEFAULT,
	250, 80,
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

char greetings[] = "Hello, Windows desktop!";

switch(message) {
case WM_PAINT:
	@handle_paint_message
	break;
case WM_DESTROY:
	PostQuitMessage(0);
	break;
case WM_COMMAND:
	@handle_command_message
	break;
default:
	return DefWindowProc(hWnd, message, wParam, lParam);
}

@handle_paint_message=
hdc = BeginPaint(hWnd, &ps);

@paint_window

EndPaint(hWnd, &ps);

@global_variables+=
HWND hWndStartButton;
int BUTTON_WIDTH = 80;
int BUTTON_HEIGHT = 20;

@init_controls=
RECT client_rect;
GetClientRect(hWnd, &client_rect);


@global_variables+=
HWND hWndHourEdit, hWndMinuteEdit, hWndSecondEdit;
int EDIT_WIDTH = 40;
int EDIT_HEIGHT = 40;
const int IDC_EDITBOX_HOUR = 500;
const int IDC_EDITBOX_MINUTE = 501;
const int IDC_EDITBOX_SECOND = 502;

@init_controls+=
hWndHourEdit = CreateWindow(
	"EDIT",
	"00",
	WS_VISIBLE | WS_CHILD | ES_CENTER | ES_NUMBER,
	10 + (5+EDIT_WIDTH)*0, 10,
	EDIT_WIDTH, EDIT_HEIGHT,
	hWnd,
	(HMENU)IDC_EDITBOX_HOUR,
	(HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),
	NULL);

SendMessage(hWndHourEdit, EM_SETLIMITTEXT, 2, 0);

@init_controls+=
hWndMinuteEdit = CreateWindow(
	"EDIT",
	"10",
	WS_VISIBLE | WS_CHILD | ES_CENTER | ES_NUMBER,
	10 + (5+EDIT_WIDTH)*1, 10,
	EDIT_WIDTH, EDIT_HEIGHT,
	hWnd,
	(HMENU)IDC_EDITBOX_MINUTE,
	(HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),
	NULL);

SendMessage(hWndMinuteEdit, EM_SETLIMITTEXT, 2, 0);

@init_controls+=
hWndSecondEdit = CreateWindow(
	"EDIT",
	"00",
	WS_VISIBLE | WS_CHILD | ES_CENTER | ES_NUMBER,
	10 + (5+EDIT_WIDTH)*2, 10,
	EDIT_WIDTH, EDIT_HEIGHT,
	hWnd,
	(HMENU)IDC_EDITBOX_SECOND,
	(HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),
	NULL);

SendMessage(hWndSecondEdit, EM_SETLIMITTEXT, 2, 0);

@global_variables+=
const int IDC_START_BUTTON = 505;

@init_controls+=
hWndStartButton = CreateWindow(
	"BUTTON",
	"Start",
	WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
	10 + (5+EDIT_WIDTH)*3, 10,
	BUTTON_WIDTH, BUTTON_HEIGHT,
	hWnd,
	(HMENU)IDC_START_BUTTON,
	(HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),
	NULL);

@global_variables+=
// 0: stopped, 1: running, 2: finished
int alarm_state = 0;

@timer_proc=
auto CALLBACK WaitOrTimerCallback(PVOID, BOOLEAN TimerWait) -> void
{
	if(TimerWait) {
		PlaySound(TEXT("C:\\Windows\\media\\Alarm01.wav"), NULL, SND_ASYNC | SND_LOOP);
		SendMessage(hWndStartButton, WM_SETTEXT, NULL, (DWORD)"Snooze");
		alarm_state = 2;
	}
}

@global_variables+=
HANDLE hTimer;

@includes=
#include <cstdint>

@handle_command_message=
switch(LOWORD(wParam)) {
case IDC_START_BUTTON:
	switch(alarm_state) {
	case 0: {
		uint32_t wait_for = 0;
		@get_time_to_wait
		// start timer
		CreateTimerQueueTimer(&hTimer, NULL, WaitOrTimerCallback, NULL, wait_for, 0, 0);
		SendMessage(hWndStartButton, WM_SETTEXT, NULL, (DWORD)"Stop");
		alarm_state = 1;
		break; }
	case 1:
		DeleteTimerQueueTimer(NULL, hTimer, NULL); // cancel timer
		SendMessage(hWndStartButton, WM_SETTEXT, NULL, (DWORD)"Start");
		alarm_state = 0;
		break;
	case 2:
		PlaySound(NULL, NULL, 0);
		SendMessage(hWndStartButton, WM_SETTEXT, NULL, (DWORD)"Start");
		alarm_state = 0;
		break;
	}
	break;
@handle_command_event
default:
	break;
}

@includes+=
#include <cstdio>

@get_time_to_wait=
char buf[3];
uint32_t num;

GetWindowText(hWndHourEdit, buf, 3);
sscanf(buf, "%u", &num);
wait_for += num * 3600 * 1000;

GetWindowText(hWndMinuteEdit, buf, 3);
sscanf(buf, "%u", &num);
wait_for += num * 60 * 1000;

GetWindowText(hWndSecondEdit, buf, 3);
sscanf(buf, "%u", &num);
wait_for += num * 1000;
