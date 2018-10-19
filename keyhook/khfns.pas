unit khfns;

interface

uses windows;

function InstallKeyHook: HMODULE;

implementation

uses desktoplist, dialogs, sysutils;

type
  hookproc = procedure(H: HHOOK);
  getdl = procedure(dl: longint);

function InstallKeyHook: HMODULE;
const
  DllName = 'keyhook.dll';
var
    kbproc, shproc: pointer;
    newhook: HHOOK;
begin
//  DeskManagerAppName := '';//GetAppPath;
  result := LoadLibrary(DllName);
  if result = 0 then begin
    showmessage('can''t load dll');
    exit;
  end;
{
  dlp := GetProcAddress(hdll, 'GetDesktopList');
  getdl(dlp)(longint(@dl));
  //showmessage(inttostr(dl.count));
}  
  kbproc := GetProcAddress(result, 'KeyboardProc');
  shproc := GetProcAddress(result, 'SetHookHandle');
  newhook := SetWindowsHookEx(WH_KEYBOARD, kbproc, result, 0);
  hookproc(shproc)(newhook);
end;

end.
 