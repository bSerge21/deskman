unit DesktopList;{$J+}

interface

uses
  Windows, Messages, SysUtils, Classes, Registry, Dialogs, apidut, mytypes, forms, ShellAPI;

const
  DeskManagerAppName: String = '';
  WindowCaption = 'Deskman';
  hOurWnd: THandle = 0;

type
  TWinObject = class
    hwnd: HWND;
    HDSK: HDESK;
  end;

  TDeskEvent = (deSwitched, deListChanged);
{  TDeskEvent = record
    eventtype: TDeskEventType;
    msg: integer;
  end;
}
  TDeskType = (dtUser, dtSystem, dtUnknown, dtRemoved);

  PDeskInfo = ^TDeskInfo;
  TDeskInfo = record
    DeskType: TDeskType;
    Index: Byte;
    RunShell: Boolean;
    isprotected: boolean;
    password: string[12];
    //reserved: string[255];
  end;

  TDesktop = class
  private
//    Handle: HDESK;
  public
    Handle: HDESK;
    Name: String;
    DeskInfo: TDeskInfo;
    constructor Create(AName: String);
  end;

  TDesktopList = class(TComponent)
  private
    reg: TRegistry;
    FList: TStringList;
    FRemovedList: TStringList;    
//    hOurWnd: THandle;
    ourwinlist: TMyStringList;    
    function GetItem(Index: Integer): TDesktop;
    function GetCount: Integer; stdcall;
  protected
    procedure EnumDesktops;
    procedure LoadDesktops;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveDesktops;    
    procedure AddDesktop(Name: String; DeskType: TDeskType; DeskInfo: PDeskInfo);
    procedure AddUserDesktop(Name: String);
    procedure DeleteDesktop(Name: String);
    property Desktops[Index: Integer]: TDesktop read GetItem;// write SetItem;
    property Count: Integer read GetCount;
    procedure OpenDesktop(DesktopName: String); overload;
    procedure OpenDesktop(DesktopIndex: Integer); overload;
    procedure OpenDefaultDesktop;    
    function CloseDesktop(Name: String): boolean; 
    procedure GetDesktops(List: TStrings);
    function GetCurrentDesktop: TDesktop;
    function GetCurrentDesktopName: String;
    procedure NotifyUs(event: TDeskEvent);
    procedure GetOurWins;
    procedure ShowOurWindow;
    procedure ShowSysMenu;
  published
    { Published declarations }
  end;

var
  DesktopList1: TDesktoplist;

procedure Register;

implementation

uses eInput1, khdef, Listdut, dskdefs;

procedure Register;
begin
  RegisterComponents('EngineSoft', [TDesktopList]);
end;

const
  Def  = 'Default';
  DeskRootKey = '\Desktop manager';
  AllDeskKey = DeskRootKey + '\Desktops\';//'\SOFTWARE\esoft\DeskMan\Desktops\';

  da =  DESKTOP_CREATEMENU or
        DESKTOP_CREATEWINDOW or
        DESKTOP_ENUMERATE or
        DESKTOP_HOOKCONTROL or
        DESKTOP_JOURNALPLAYBACK or
        DESKTOP_JOURNALRECORD or
        DESKTOP_READOBJECTS or
        DESKTOP_SWITCHDESKTOP or
        DESKTOP_WRITEOBJECTS;

{ TDesktopList }

constructor TDesktopList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TStringList.Create;
  FRemovedList := TStringList.Create;

  reg := tregistry.create;
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKey(DeskRootKey, true);
  DeskManagerAppName := reg.ReadString('DeskManagerAppName');

  LoadDesktops;
  EnumDesktops;

  ourwinlist := tmystringlist.create;
end;

destructor TDesktopList.Destroy;
begin
  SaveDesktops;
  inherited;
end;

function SortByIndex(List: TStringList; Index1, Index2: Integer): Integer;
var obj1, obj2: TDesktop;
begin
  obj1 := TDesktop(list.objects[index1]);
  obj2 := TDesktop(list.objects[index2]);
  result := ifthen(obj1.DeskInfo.Index, obj2.DeskInfo.Index);
end;

procedure TDesktopList.LoadDesktops;
var keylist: tstringlist;
    i, index: integer;
    //dsk: TDesktop;
    DeskName: String;
    DeskInfo: TDeskInfo;
begin
  reg.closekey;

  reg.OpenKey(DeskRootKey, true);
  DeskManagerAppName := reg.ReadString('DeskManagerAppName');

  reg.OpenKey(AllDeskKey, true);
  keylist := tstringlist.create;
  reg.GetKeyNames(keylist);

  for i := 0 to keylist.count-1 do begin
    DeskName := keylist[i];
    if reg.openkey(AllDeskKey + keylist[i], false) then begin
      reg.ReadBinaryData('data', DeskInfo, sizeof(TDeskInfo));
      if DeskManagerAppName = '' then
        DeskInfo.RunShell := true;
      reg.closekey;
    end;    

//    if DeskInfo.DeskType := dtUser;
      AddDesktop(DeskName, DeskInfo.DeskType, @DeskInfo)
  end;

  keylist.free;
  FList.CustomSort(SortByIndex);
end;

procedure TDesktopList.SaveDesktops;
var i: integer;
begin
  reg.closekey;
  //reg.OpenKey(AllDeskKey, true);
  for i := 0 to flist.count-1 do begin
    if TDesktop(flist.objects[i]).DeskInfo.DeskType <> dtSystem{dtUnknown} then begin
      reg.openkey(AllDeskKey + flist[i], true);
      reg.WriteBinaryData('data', TDesktop(flist.objects[i]).DeskInfo, sizeof(TDeskInfo));
      reg.closekey;
    end;
  end;
end;

function EnumDesktopProc(desktop: PChar; lParam: Longint): LongBool; cdecl;
var isdef, windesk: boolean;
    d: tdesktoplist absolute lparam;
    dtype: tdesktype;
begin
  isdef := desktop = def;
  windesk := (desktop = 'Winlogon') or (desktop = 'Disconnect') or (desktop = 'ChromeRendererDesktop');
  if isdef then
    dtype := dtsystem
  else
    dtype := dtUnknown;
  if not windesk then begin
    d.AddDesktop(desktop, dtype, nil);
  end;  
  result := true;  
end;

procedure TDesktopList.EnumDesktops;
var winsta: longword;
    lparam: Longint;
begin
  winsta := GetProcessWindowStation();
  lparam := integer(self);
  windows.enumdesktops(winsta, @EnumDesktopProc, lparam);
end;        

procedure TDesktopList.AddDesktop(Name: String; DeskType: TDeskType; DeskInfo: PDeskInfo);
var dsk: TDesktop;
    index: integer;
begin
  index := FRemovedList.IndexOf(Name);
  if index > -1 then exit; // для EnumDesktops    
  if (desktype = dtRemoved) and (index = -1) then begin // для LoadDesktops
    FRemovedList.Add(Name);
    exit;
  end;

  index := FList.IndexOf(Name);
  if index = -1 then begin
    dsk := TDesktop.Create(Name);
    if DeskInfo <> nil then
      Dsk.DeskInfo := DeskInfo^
    else begin
      dsk.DeskInfo.DeskType := DeskType;
      //dsk.DeskInfo.Index := 1;
    end;
    if Name = def then
      FList.InsertObject(0, Name, dsk)
    else
{      if dsk.DeskInfo.Index > 0 then
        FList.InsertObject(dsk.DeskInfo.Index, Name, dsk)
      else} // 26.09.08 сортировать будем потом
        FList.AddObject(Name, dsk);
  end
  else
  begin
//    TDesktop(FList[index]).DeskType := dtSystem;
  end;
end;

function TDesktopList.GetCount: Integer;
begin   
//  showmessage('fuck');
  result := flist.count;
end;

function TDesktopList.GetItem;
begin
  result := TDeskTop(FList.Objects[Index]);
end;

{procedure TDesktopList.SetItem(Index: Integer; Value: TDesktop);
begin
  TDesktop(FList.Objects[Index]).Assign(Value);
end;
}

procedure TDesktopList.OpenDefaultDesktop;
begin
  OpenDesktop(Def);
end;

procedure TDesktopList.OpenDesktop(DesktopIndex: Integer);
var name: string;
begin
//  showmessage('here ' + inttostr(desktopindex));
  if DesktopIndex > flist.count-1 then exit;
  name := flist[DesktopIndex];
  OpenDesktop(name);
end;

procedure TDesktopList.OpenDesktop(DesktopName: String);
var dsk: TDesktop;
    index: integer;
    pwd: string;
    r: TRECT;
    res: boolean;
    cx, cy: integer;
    pData: TAppBarData;    
begin
  index := FList.IndexOf(DesktopName);
  if index = -1 then begin
    // --- обробка помилки
    exit;
  end;

  dsk := TDesktop(FList.Objects[index]);

  // check security
  if dsk.DeskInfo.isprotected and (dsk.DeskInfo.password <> '') then begin
//    if eInputbox(Format('Switch to desktop %s', [dsk.Name]), 'Enter password:', pwd, #149) then begin
    if eInputbox(Format('%s', [dsk.Name]), '', pwd, #149) then begin
      if pwd <> dsk.DeskInfo.password then begin
        //ShowMessage('Can''t switch to desktop'); commented at 12/09/2018
        exit;
      end;
    end
    else
      exit;
  end;

  if dsk.Handle = 0 then begin
    dsk.Handle := CreateDesktop(pchar(desktopname), nil, nil, DF_ALLOWOTHERACCOUNTHOOK, da, nil);
    if dsk.Handle = 0 then begin
      // --- обробка помилки
      showmessage(syserrormessage(getlasterror));
    end;
  end;

  r.Left := 0;
  r.Top := 0;

//  cx := GetSystemMetrics(SM_CXMINIMIZED);
//  cy := GetSystemMetrics(SM_CYMINIMIZED);

  if dsk.DeskInfo.RunShell then begin
    if not WindowExists('Program Manager', dsk.Handle) then begin
      Run('explorer.exe', '', SW_SHOW, dsk.Name);
      Run('ctfmon.exe', '', SW_SHOW, dsk.Name);
    end;

//    FillChar(pData, sizeof(pData), 0);
    pData.cbSize := sizeof(pData);
//    cx := SHAppBarMessage(ABM_GETTASKBARPOS, pData);
//    tb_height := pData.rc.Bottom - pData.rc.Top;    
//    SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0); // 1280x994
    r.Right := Screen.Width;
    r.Bottom := pData.rc.Top;
  end
  else begin
    r.Right := Screen.Width;
    r.Bottom := Screen.Height;

//    GetSystemMetrics(SM_CXMINIMIZED);
//    GetSystemMetrics(SM_CYMINIMIZED);

  end;
{
  res := SystemParametersInfo(
    SPI_SETWORKAREA,
    0,
    @r,
    0
  );
}
  if not WindowExists(WindowCaption, dsk.Handle) then
    Run(DeskManagerAppName, '', SW_SHOW, dsk.Name);

  SwitchDesktop(dsk.Handle);

  NotifyUs(deSwitched);
end;

function TDesktopList.CloseDesktop(Name: String): boolean;
var dsk: TDesktop;
    index: integer;
begin
  index := FList.IndexOf(Name);
  if index = -1 then begin
    exit;
  end;

  dsk := TDesktop(FList.Objects[index]);
  if dsk.Handle = 0 then exit;
  result := Windows.CloseDesktop(dsk.Handle);
end;

procedure TDesktopList.GetDesktops(List: TStrings);
begin
  List.Clear;
  List.AddStrings(FList);
end;

procedure TDesktopList.AddUserDesktop(Name: String);
begin
  AddDesktop(Name, dtUser, nil);
end;

procedure TDesktopList.DeleteDesktop(Name: String);
var res: boolean;
    handle: thandle;
    index: integer;
    dsk: tdesktop;
begin
  res := CloseDesktop(name);
  if res then begin
    reg.OpenKey(alldeskkey, false);
    reg.DeleteKey(name);
    flist.delete(flist.indexof(name))
  end
  else begin
    index := FList.IndexOf(Name);
    dsk := TDesktop(flist.objects[index]);
    dsk.DeskInfo.DeskType := dtRemoved;
    SaveDesktops;
  end;
end;

function TDesktopList.GetCurrentDesktop: TDesktop;
var dn: string;
    i: integer;
begin
  result := nil;
  dn := getcurrentdesktopname;
  for i := 0 to flist.Count-1 do begin
    if flist[i] = dn then begin
      result := TDesktop(flist.objects[i]);
      exit;
    end;
  end;
end;

function TDesktopList.GetCurrentDesktopName: string;
var hdsk: THandle;
    dn: array[0..255] of char;
    LengthNeeded: dword;
begin
  result := '';
  hdsk := GetThreadDesktop(GetCurrentThreadId());
  if not GetUserObjectInformation(hdsk, UOI_NAME, @dn, sizeof(dn), LengthNeeded) then exit;
  result := dn;
end;

constructor TDesktop.Create(AName: String);
begin
  Handle := 0;
  Name := AName;
  DeskInfo.RunShell := true;
end;

procedure TDesktopList.NotifyUs(event: TDeskEvent);
var msg: integer;
    i: integer;
begin
  GetOurWins;
  case event of
    deSwitched: msg := WM_DESKTOP_SWITCHED;
  end;

  for i := 0 to ourwinlist.count - 1 do
    SendMessage(twininfo(ourwinlist.objects[i]).Handle, msg, 0, 0);
end;

procedure TDesktopList.ShowSysMenu;
begin
  SendMessage(hOurWnd, WM_SHOW_SYSMENU, 0, 0);
end;

function EnumOurWinProc(wnd: THandle; lParam: LPARAM): boolean; stdcall;
var s: array[0..255] of char;
    wi: TWinObject;
begin
  result := true;
  if GetWindowText(wnd, @s, 255) = 0 then begin
//    showmessage(syserrormessage(getlasterror));
    exit;
  end;  
  if s = 'Deskman' then begin
    wi := TWinObject.Create;
    wi.hwnd := wnd;
    wi.HDSK := lparam;
    desktoplist1.ourwinlist.Addobject(inttostr(wi.hdsk), wi);
  end;
end;

procedure TDesktopList.GetOurWins;
var i: integer;
    dsk: tdesktop;
begin
  ourwinlist.clear;
  for i := 0 to flist.count - 1 do begin
    dsk := tdesktop(flist.objects[i]);
    if dsk.Handle <> 0 then
      EnumDesktopWindows(dsk.Handle, @EnumOurWinProc, dsk.Handle);    
  end;
end;

procedure TDesktopList.ShowOurWindow;
begin
  //ShowMessage(IntToHex(hOurWnd, 8));
  SendMessage(hOurWnd, SW_SHOW, 1, 1);
end;

end.
