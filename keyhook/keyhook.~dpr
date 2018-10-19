library keyhook;{$J+}
{
ESC=minimize

}

uses
  Math,
  sysutils,
  dialogs,
  windows,
  classes,
  messages,
  forms,
  menus,
  xmlintf,
  xmldoc,
  khfns in 'khfns.pas',
  ApiDut in '..\..\engi\duts\ApiDut.pas',
  deskprop in '..\forms\deskprop.pas' {dlgDeskProp},
  windi in '..\forms\windi.pas' {fmWindi},
  dskdefs in '..\dskdefs.pas',
  DesktopList in '..\DesktopList.pas',
  eInput1 in '..\..\engi\duts\eInput1.pas' {eInputForm},
  mytypes in '..\..\engi\mytypes.pas',
  StrDut in '..\..\engi\duts\StrDut.pas',
  Listdut in '..\..\engi\duts\Listdut.pas',
  FileDut in '..\..\engi\duts\FileDut.pas',
  MsgDut in '..\..\engi\duts\MsgDut.pas',
  LogDut in '..\..\engi\duts\logdut.pas';

const
  dolog: Boolean = false;
  dolog2: boolean = true;//false;
  CheckFar: Boolean = true;
  enableESC: Boolean = true;
var
  hook: hhook;

procedure GetDesktopList(p: longint);
begin
  DesktopList1 := TDesktopList.Create(nil);
  p := longint(DesktopList1);
end;

procedure SetHookHandle(newhook: hhook);
begin
  hook := newhook;
end;

{procedure HandleDesktopKeys(i: integer);
begin
  DesktopList1.OpenDesktop(i);
end;}

function IsSystemWindow(hwnd: THandle): Boolean;
const
  systemwindowtitles: array [0..2] of string = ('', 'Program Manager', 'explorer');
  systemwindowclasses: array [0..2] of string = ('Progman', 'Shell_TrayWnd', 'WorkerW');
var wndclass: string;  
begin
//  Result := getobjid(systemwindowtitles, wincaption, false) > -1
  wndclass := getwindowclass(hwnd);
  Result := getobjid(systemwindowclasses, wndclass, false) > -1
end;

// === our key handling procedures ==========================================================

{procedure LogWindow(hwnd: thandle);
var wtitle, wclass: string;
begin
  wtitle := getwindowtitle(hwnd);
  wclass := getwindowclass(hwnd);
  addtolog(format('title: %s, class: %s', [wtitle, wclass]));
end;

procedure MinimizeWindow(hwnd: thandle);
begin
  LogWindow(hwnd);
  PostMessage(hwnd, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;}

procedure MakeHiddenWindow(hwnd: thandle);
begin
  if IsSystemWindow(hwnd) or (hwnd = hOurWnd) then exit;
  ShowWindow(hwnd, SW_HIDE);
  PostMessage(hOurWnd, WM_ADD_HIDDEN_APP, hwnd, 0);
end;

procedure SingleWndCommand(hwnd: thandle; msg: Integer);
begin
  PostMessage(hwnd, msg, 0, 0);
end;

procedure OpenDsk(i: integer);
//var DesktopList: TDesktopList;
begin
//  DesktopList := TDesktopList.Create(nil);
  DesktopList1.OpenDesktop(i-1);
//  DesktopList.Free;
end;

procedure blablakey(wintitle: string; hwnd: thandle; wparam, lparam: longint);
begin
  if (pos('Stduviewer', wintitle) > 0) and (char(wparam) in ['+','-']) then begin
  end;
end;

procedure CopyToClipboard;
begin
  addtodebuglog('CopyToClipboard');
end;

procedure alttabproc;
begin
  showmessage('alttab');
end;


// =============================================================================
function HandleKeys(wparam, lparam: longint): Integer;
var hwnd: THandle;
    ShiftState: TShiftState;
    extkey, syswnd, keyup, keydown, prevdown, prevup: boolean;
    wintitle: string;

    wndclass: string; // 31.05.17
    winthread: dword;
    PID: Longint;
            
    val: Extended;
begin
//  val := power(2, 24);
  dolog := true;                                              
  if dolog then
    addtolog(format('wparam: %d, lparam: %s', [wparam, inttohex(lparam, 8)]));

//  ShowMessage(inttostr(wparam));

  ShiftState := KeyDataToShiftState(lparam); //alt := lParam and $20000000 = $20000000;
  keyup := (lParam and $80000000) = $80000000;
  keydown := not keyup;
  prevdown := (lParam and $40000000) = $40000000;
  prevup := not prevdown;
  extkey := (lParam and $1000000) = $1000000; // 24 bit

  hwnd := GetForegroundWindow;
  wintitle := GetWindowTitle(hwnd);
  wndclass := GetWindowClass(hwnd); // 31.05.17

  winthread := GetWindowThreadProcessId(hwnd, @PID);
    
  if keydown then begin
    needdate := true;
    //addtolog(Format('wintitle: %s', [wintitle]));
    //showmessage(wintitle);
  end;  
  syswnd := IsSystemWindow(hwnd);
// 4 2 1 0

  if syswnd then begin
   //Exit;                                  
  end;
//  code := HC_SKIP;

  // --- handling our keys ---
  result := 0;

  //showmessage(inttostr(wparam));
  // 91 - windows key


  case wparam of
    WM_SYSKEYDOWN:
      case lparam of
        VK_TAB: ShowMessage('ALT+TAB');
      end;
  end;

  if ShiftState = [] then begin
    case wparam of
      91: // --- win key --- 
        begin
          if keydown and prevup then
            DesktopList1.ShowOurWindow;
//            result := 1;
  //          exit;
        end;
    end;
  end;   

  if (shiftstate = []) or (shiftstate = [ssShift]) then begin
{    if keyup then
      if dolog2 then begin
        if extkey then
          addtolog(format('ext: %d', [wparam]))
        else
          //addtolog(format('%s(%d)', [char(wparam), wparam]));
          addtolog(format('%s', [char(wparam)]));
      end;}
  end;
  
  if (ShiftState = [ssAlt]) and (keydown) then begin
    case wparam of
//       18: exit; // alt?
        9: alttabproc;
       49..57: begin
         OpenDsk(wparam-48);
         result := 1;
         exit;
       end;

{       // 31.05.17 test               go down
       VK_F12: begin
         ShowMessage(Format('Title: %s, class: %s', [wintitle, wndclass]));
         result := 1;
         exit;
       end;}
    end;
  end;

  if (ShiftState = [ssCtrl]) and keyup then begin // sysmenu
    case wparam of
      {VK_APPS}VK_LWIN: begin
        SendMessage(hOurWnd, WM_SHOW_SYSMENU, 0, 0);//ShowMessage(inttostr(hOurWnd));//DesktopList1.ShowSysMenu; //ShowSysMenu;
        result := 1;
        exit;
      end;

      VK_INSERT: begin // 04.12.17
        CopyToClipboard;
        result := 1;  // 1
        exit;
      end;

    end;
  end;

  if (ShiftState = [ssAlt, ssShift, ssCtrl]) and (keydown) then begin
    case wparam of
       // 31.05.17 test
       VK_F12: begin
         ShowMessage(Format('Title: %s, class: %s', [wintitle, wndclass]));
         result := 1;
         exit;
       end;
    end;
  end;


  case wparam of

    27: // --- ESC ---
      begin
        if enableESC then begin{
          if (shiftstate = [ssCtrl]) and keydown and prevup then
            MinimizeWindow(hwnd);}
          if (shiftstate = [ssShift]) and keydown and prevup then
            MakeHiddenWindow(hwnd);
{          else begin
            result := 0;
            exit;
          end;}
        end 
      end;

    87: // --- W ----
      begin
        if (shiftstate = [ssAlt]) and keydown and prevup then begin
          if CheckFar and (pos('Far', wintitle) > 0) then
          else begin
            SingleWndCommand(hwnd, WM_CLOSE);
            //SendInput need here            
            //SendMessage(hwnd, WM_KEYDOWN, wparam, lparam);
            //result := -1;
          end;  
        end;
      end;

    81: // --- Q ---
      begin
        if (shiftstate = [ssAlt]) and keydown and prevup then begin
          if CheckFar and (pos('Far', wintitle) > 0) then
          else
            SingleWndCommand(hwnd, WM_QUIT);
        end;
      end;

    88: // --- X ----
      begin
        if (shiftstate = [ssAlt]) and keydown and prevup then
          if CheckFar and (pos('Far', wintitle) > 0) then
          else
            SingleWndCommand(hwnd, WM_QUIT);
      end;

    113: // --- F5 ---
      begin
{        if (shiftstate = [ssAlt]) and keydown and prevup then
            MinimizeWindow(hwnd);}
      end;
    114: // --- F5 ---
      begin
{        if (shiftstate = [ssAlt]) and keydown and prevup then
            MakeHiddenWindow(hwnd);}
      end;

{
    116: // --- F5 ---
      begin

      end;
}
  else
    result := 0; // this is not our key, pass it to Windows
  end;
end;

function KeyboardProc(code: integer; wParam, lParam: Longint): Longint; stdcall;
begin
  result := HandleKeys(wParam, lParam);
  if result < 0 then
    result := CallNextHookEx(hook, code, wParam, lParam);
end;

exports
  KeyboardProc,
  SetHookHandle,
  GetDesktopList;

begin
  DesktopList1 := TDesktopList.Create(nil);
//  applogfile := 'c:\windows\temp\applog.log';
  applogfile := 'd:\etc\output\apps\dsk2.log';
  NeedDate := false; // for log
  hOurWnd := FindWindow(nil, pchar(WindowCaption));
end.
