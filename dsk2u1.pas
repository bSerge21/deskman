unit dsk2u1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, DesktopList, ComCtrls, TrayMan, ExtCtrls, khdef, appstart, shellapi,
  xmldom, XMLIntf, msxmldom, XMLDoc, DirRunner, ImgList, logdut, strdut, dskdefs;

type
  TTimerMode = (tmStart, tmTime);
  
  TForm1 = class(TForm)
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Desktop1: TMenuItem;
    Deletedesktop1: TMenuItem;
    N1: TMenuItem;
    Properties1: TMenuItem;
    TrayMan1: TTrayMan;
    PopupMenu2: TPopupMenu;
    N2: TMenuItem;
    exit1: TMenuItem;
    Panel1: TPanel;
    Hiddenapps1: TMenuItem;
    N3: TMenuItem;
    run1: TMenuItem;
    OpenDialog1: TOpenDialog;
    N4: TMenuItem;
    QuickMenu1: TMenuItem;
    Timer1: TTimer;
    XMLDoc: TXMLDocument;
    DirRunner1: TDirRunner;
    PopupImageList: TImageList;
    lbTime: TLabel;
    N5: TMenuItem;
    N6: TMenuItem;
    popupSysmenu: TPopupMenu;
    sysmenuImages: TImageList;
    N7: TMenuItem;
    Close1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Desktop1Click(Sender: TObject);
    procedure Deletedesktop1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Properties1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TrayMan1Click(Sender: TObject);
    procedure exit1Click(Sender: TObject);
    procedure dskitemClick(Sender: TObject);
    procedure HiddenAppItem1Click(Sender: TObject);
    procedure run1Click(Sender: TObject);
    procedure quickmenuitemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbTimeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbTimeMouseLeave(Sender: TObject);
  private
    TLBPrevMI, TLBCurrentMI: TMenuItem;

    procedure WMADDHIDDENAPP(var Message: TMessage); message WM_ADD_HIDDEN_APP;
    procedure WMDESKTOPSWITCHED(var Message: TMessage); message WM_DESKTOP_SWITCHED;
    procedure WMSHOWSYSMENU(var Message: TMessage); message WM_SHOW_SYSMENU;

    procedure StoreHiddenApp(wnd: THandle; name: string);
    procedure LoadHiddenWindows;
    procedure CreateHiddenItem(hwnd: THandle; name: string);
    procedure DeleteHWLogString(hwnd: THandle);
  public
    PopupImageListIndex: Integer;
    SysmenuImageListIndex: Integer;
    hiddenwinlist: TStringList;

    hLib: HMODULE;
    
    procedure FillPopup;

    procedure LoadConf;    
    procedure LoadQuickMenu;
    procedure LoadQMNode(var node: IXMLNode);
    procedure LoadTLBMenu;
    procedure InsertQMDivider;
    procedure ShowWindi;
    procedure ShowSysMenu;
    procedure gototray;
    procedure SetupPopupImageList;
    procedure StartClock;
    procedure StopClock;
//    procedure CMMOUSELEAVE(var Message: TMessage); message CM_MOUSELEAVE;
  end;

var
  Form1: TForm1;

implementation

uses ApiDut, dsk2dm1, newdsk, khfns, deskprop, windi, Registry, Listdut, mydefs;

{$R *.dfm}

const
  TlbMenuInSubmenu: Boolean = false;
var
  deskman_hiddenwindows_file: string = 'dsk2.hidden.log';
  tlbmenupath: string;

procedure TForm1.FormCreate(Sender: TObject);
var reg: TRegistry;
begin
  LoadConf;
  
  deskman_hiddenwindows_file := startpath + deskman_hiddenwindows_file;
  reg := tregistry.create;
  reg.RootKey := HKEY_CURRENT_USER;
  reg.openkey('Desktop manager', true);
  reg.WriteString('DeskManagerAppName', application.exename);
  reg.free;

  DesktopList1 := TDesktopList.Create(nil);

  hiddenwinlist := tstringlist.create;

  caption := windowcaption;
  GoBottomRight(self);
  DesktopList1.GetDesktops(listbox1.Items);
  hLib := InstallKeyHook;
//  StatusBar1.SimpleText := dm1.DesktopList1.GetCurrentDesktopName;
  Panel1.Caption := DesktopList1.GetCurrentDesktopName;

  SetupPopupImageList;

  FillPopup;
  LoadQuickMenu;
  LoadTLBMenu; //151217
  LoadHiddenWindows;

  timer1.tag := integer(tmStart);
  timer1.enabled := true;//gototray;
end;

procedure TForm1.LoadConf;
var xmlname: string;
    nodes: IXMLNodeList;
    node: IXMLNode;
begin
  xmlname := startpath + 'dsk2.xml';
  if not FileExists(xmlname) then begin
    //AddToDebugLog(xmlname + ' not exists');
    exit;
  end;
  XMLDoc.LoadFromFile(xmlname);
  nodes := XMLDoc.DocumentElement.ChildNodes;
  node := nodes['tlbmenu'];
  tlbmenupath := node.Attributes['path'];
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  DesktopList1.OpenDesktop(listbox1.Itemindex);
end;

procedure TForm1.Desktop1Click(Sender: TObject);
begin
  if dlgnewdesktop.showmodal = mrok then begin
    DesktopList1.AddUserDesktop(dlgnewdesktop.Edit1.Text);
    DesktopList1.GetDesktops(listbox1.Items);
  end;
end;

procedure TForm1.Deletedesktop1Click(Sender: TObject);
begin
  if MessageDlg(Format('Delete desktop %s?', [Listbox1.Items[Listbox1.Itemindex]]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    DesktopList1.DeleteDesktop(Listbox1.Items[Listbox1.Itemindex]);
    DesktopList1.GetDesktops(listbox1.Items);    
  end;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  Deletedesktop1.Visible := ListBox1.ItemIndex > -1;
  Properties1.Visible := ListBox1.ItemIndex > -1;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DesktopList1.SaveDesktops;
  DesktopList1.OpenDefaultDesktop;
  hiddenwinlist.free;
  FreeLibrary(hLib);
end;

procedure TForm1.Properties1Click(Sender: TObject);
begin
  dlgDeskProp.GetData(tdesktop(listbox1.items.objects[listbox1.itemindex]));
  if dlgDeskProp.ShowModal = mrOK then begin
    dlgDeskProp.SetData(tdesktop(listbox1.items.objects[listbox1.itemindex]));
    DesktopList1.SaveDesktops;
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    TrayMan1.HideApp;
end;

procedure TForm1.TrayMan1Click(Sender: TObject);
begin
  Trayman1.SwitchAppVisible;
end;

procedure TForm1.exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.FillPopup;
var i: integer;
    mi: tmenuitem;
begin
  for i := DesktopList1.Count-1 downto 0 do begin
    mi := tmenuitem.create(popupmenu2);
    mi.Caption := DesktopList1.Desktops[i].Name;
    mi.OnClick := dskitemClick;
    popupmenu2.Items.Insert(0, mi);
  end;
end;

procedure TForm1.LoadQMNode(var node: IXMLNode);
var i: integer;
    mi: TDskMenuItem;
    item: IXMLNode;
    caption, command, params: string;
    finfo: SHFILEINFO;
begin 
  for i := 0 to node.ChildNodes.Count - 1 do begin
    item := node.ChildNodes[i];
    caption := item.Attributes['caption'];
    command := item.Attributes['command'];
    if item.HasAttribute('params') then
      params := item.Attributes['params'];

    mi := TDskMenuItem.create(quickmenu1);

    mi.Caption := Caption;
    mi.Hint := command;

    mi.dskCommand := command;
    mi.dskParams := params;

    mi.OnClick := QuickMenuItemClick;
    QuickMenu1.Insert(0+i, mi);

    SHGetFileInfo(pchar(command), 0, finfo, sizeof(finfo),
      SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

    SHGetFileInfo(pchar(command), 0, finfo, sizeof(finfo),
      SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
    mi.ImageIndex := finfo.iIcon;
  end;
end;

procedure TForm1.InsertQMDivider;
var mi: tmenuitem;
begin
  mi := tmenuitem.create(quickmenu1);
  mi.Caption := '-';
  QuickMenu1.Add(mi);
end;

procedure TForm1.ShowSysMenu;
var l: tstringlist;
    i: integer;
    nodes: IXMLNodeList;
    node: IXMLNode;
    mi: TDskMenuItem;
    xmlname, caption, command, params: string;
    finfo: SHFILEINFO;
    item: IXMLNode;
    icon: TIcon;
    cursorpos: TPoint;
begin
  xmlname := startpath + 'deskman.sysmenu.xml';
  if not FileExists(xmlname) then begin
    AddToDebugLog(xmlname + ' not exists');
    exit;
  end;
  XMLDoc.LoadFromFile(xmlname); //  showmessage(format('%d - %d', [popupSysmenu.WindowHandle, handle]));
  nodes := XMLDoc.DocumentElement.ChildNodes;
  node := nodes['sysmenu'];

  popupSysmenu.WindowHandle := handle;
  for i := popupSysmenu.Items.Count - 1 downto 0 do
    popupSysmenu.Items.Delete(i);

  for i := 0 to node.ChildNodes.Count - 1 do begin
    item := node.ChildNodes[i];
    if item.NodeName = 'item' then begin
      caption := item.Attributes['caption'];
      command := item.Attributes['command'];
      if item.HasAttribute('params') then
        params := item.Attributes['params'];
    end
    else if item.NodeName = 'divider' then begin
      caption := '-';
      command := '';
    end;

    mi := TDskMenuItem.create(popupSysmenu);

    mi.Caption := Caption;
    mi.Hint := command;

    mi.dskCommand := command;
    mi.dskParams := params;
    mi.OnClick := QuickMenuItemClick;

    popupSysmenu.Items.Add(mi);

    SHGetFileInfo(pchar(command), 0, finfo, sizeof(finfo),
      SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

    icon := TIcon.Create;
    icon.Handle := finfo.hIcon;
    sysmenuImages.AddIcon(icon);
    //on.SaveToFile('d:\icon.ico');
    mi.ImageIndex := sysmenuImages.Count-1;
    //mi.ImageIndex := finfo.iIcon;
  end;

  mi := TDskMenuItem.create(popupSysmenu);
  mi.caption := '-';
  popupSysmenu.Items.Add(mi);
  mi := TDskMenuItem.create(popupSysmenu);
  mi.caption := 'Close';
  popupSysmenu.Items.Add(mi);

  GetCursorPos(cursorpos);

//  popupSysmenu.Popup(screen.Width div 2, screen.Height div 2);

  popupSysmenu.Popup(cursorpos.X, cursorpos.Y);
{
    item := sysmenu.ChildNodes[i];
    caption := item.Attributes['caption'];
    command := item.Attributes['command'];
    if item.HasAttribute('params') then
      params := item.Attributes['params'];

    fmDskSysMenu.AddItem(caption, command, params);

  fmDskSysMenu.Show;}
end;

procedure TForm1.LoadQuickMenu;
var l: tstringlist;
    i: integer;
    mi: tmenuitem;
    nodes: IXMLNodeList;
    quickmenu, common, thisdsk: IXMLNode;
    fname: string;
begin
  fname := startpath + appname + '.qm.xml';
  if not FileExists(fname) then begin
    AddToDebugLog(format('QuickMenu file %s don''t exists', [fname]));
    exit;
  end;
  
  XMLDoc.LoadFromFile(fname);
  nodes := XMLDoc.DocumentElement.ChildNodes;
  quickmenu := nodes['quickmenu'];
  common := quickmenu.ChildNodes.Nodes['common'];
  thisdsk := quickmenu.ChildNodes.Nodes[DesktopList1.GetCurrentDesktopName];
  LoadQMNode(common);
  if thisdsk <> nil then begin
    InsertQMDivider;
    LoadQMNode(thisdsk);
  end;
  InsertQMDivider;

  //LoadTLBMenu;
end;

procedure TForm1.LoadTLBMenu;
var tlbxmlpath, caption, command: string;
    i: integer;
begin
  if TlbMenuInSubmenu then begin
    TLBCurrentMI := tmenuitem.create(quickmenu1);
    TLBCurrentMI.Caption := 'TLB Menu';
    QuickMenu1.Add(TLBCurrentMI);
    dirrunner1.MenuItem := TLBCurrentMI;
  end
  else
    dirrunner1.MenuItem := QuickMenu1;

  //tlbxmlpath := appdata + 'tlb\menu\';
  dirrunner1.RootDir := tlbmenupath;//tlbxmlpath;
  dirrunner1.filemask := '*.lnk';
  dirrunner1.Run;
end;

procedure TForm1.dskitemClick(Sender: TObject);
begin
  DesktopList1.OpenDesktop((sender as tmenuitem).caption);
end;
//------------------------------------------------------------------------------
procedure TForm1.CreateHiddenItem(hwnd: THandle; name: string);
var item: TMenuItem;
begin
  item := TMenuItem.Create(popupmenu1);
  item.Caption := name;
  item.Tag := hwnd;
  item.OnCLick := HiddenAppItem1Click;
  Hiddenapps1.Add(item);
  Hiddenapps1.Enabled := True;
  Hiddenapps1.Visible := True;
  N6.Visible := True;
end;

procedure TForm1.WMADDHIDDENAPP(var Message: TMessage);
var buf: array[0..255] of char;
begin
  N6.Visible := true;
  GetWindowText(Message.WParam, @buf, 255);
  CreateHiddenItem(Message.WParam, buf);
  StoreHiddenApp(Message.WParam, buf);
end;

procedure TForm1.StoreHiddenApp(wnd: THandle; name: string);
begin
  AppLogFile := deskman_hiddenwindows_file;
  NeedDate := false;
  addtolog(format('%d=%s', [wnd, name]){ATTENTION!, false});
  NeedDate := true;  
end;

procedure TForm1.LoadHiddenWindows;
var i, hwnd: integer;
    s, wintitle: string;
begin
  if not fileexists(deskman_hiddenwindows_file) then exit;
  hiddenwinlist.LoadFromFile(deskman_hiddenwindows_file);

  for i := hiddenwinlist.Count-1 downto 0 do begin
    s := hiddenwinlist[i];
    wintitle := getparam(s, 2, '=');
    s := getparam(s, 1, '=');
    try
      hwnd := strtoint(s);
      CreateHiddenItem(hwnd, wintitle);      
    except
      continue;
    end;
  end;
end;

procedure TForm1.DeleteHWLogString(hwnd: THandle);
var s: string;
    i: integer;
begin
  i := hiddenwinlist.IndexOfName(inttostr(hwnd));
  if i > -1 then
    hiddenwinlist.Delete(i);
  hiddenwinlist.SaveToFile(deskman_hiddenwindows_file);    
end;

procedure TForm1.HiddenAppItem1Click(Sender: TObject);
begin
  Hiddenapps1.Delete(TMenuItem(Sender).MenuIndex);
  ShowWindow(TMenuItem(Sender).Tag, SW_SHOW);
  DeleteHWLogString(TMenuItem(Sender).Tag);
  if Hiddenapps1.Count = 0 then begin
    Hiddenapps1.Visible := False;
    N6.Visible := False;
  end;
end;
//------------------------------------------------------------------------------

procedure TForm1.WMDESKTOPSWITCHED(var Message: TMessage);
begin
  ShowWindi;
end;

procedure TForm1.WMSHOWSYSMENU(var Message: TMessage);
begin
//  if not sysmenuformshowed then
  ShowSysMenu;
end;

procedure TForm1.ShowWindi;
begin
  fmWindi := TfmWindi.create(nil);
  fmWindi.Panel1.Caption := DesktopList1.GetCurrentDesktopName;
  fmWindi.Show;
end;

procedure TForm1.run1Click(Sender: TObject);
begin
  if opendialog1.execute then
    run(opendialog1.filename, '', sw_show);
end;

procedure TForm1.quickmenuitemClick(Sender: TObject);
var mi: TDskMenuItem;
    ShiftState: TShiftState;
begin
//  ShiftState := KeysToShiftState();
//  if ShiftState = [ssRight] then
//  mi.Owner.close;
  mi := TDskMenuItem(Sender);
  shellexecute(0, pchar('open'), pchar(mi.dskcommand), pchar(mi.dskparams), nil, 1);
//  run(mi.dskCommand, mi.dskParams);
end;

procedure TForm1.GotoTray;
var dsk: tdesktop;
begin
  dsk := desktoplist1.GetCurrentDesktop;
  if dsk.DeskInfo.RunShell and WindowExists('Program Manager', dsk.Handle) then 
    TrayMan1.HideApp; //    .SwitchAppVisible;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  case TTimerMode(Timer1.tag) of
    tmStart: begin
      timer1.enabled := false;
      GotoTray;
    end;
    tmTime: begin
      lbTime.Caption := TimeToStr(Time);
    end;
  end;
end;

procedure TForm1.SetupPopupImageList;
var finfo: SHFILEINFO;
begin
  PopupImageListIndex := SHGetFileInfo(pchar(Application.ExeName), 0, finfo, sizeof(finfo),
    SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  PopupImageList.Handle := PopupImageListIndex;
{
  SysmenuImageListIndex := SHGetFileInfo(pchar(Application.ExeName), 0, finfo, sizeof(finfo),
    SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  SysmenuImages.Handle := SysmenuImageListIndex;}
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    if lbTime.Visible then
      StopClock
    else begin
      lbTime.Caption := DateTimeToStr(Now);
      lbTime.Visible := true;
      lbTime.Left := Width - Canvas.TextWidth(lbTime.Caption)-15;
    end;  
  end;
end;

procedure TForm1.StartClock;
begin
  Timer1.Tag := integer(tmTime);
  Timer1.Interval := 1000;
  Timer1.Enabled := true;
  lbTime.Caption := TimeToStr(Time);  
  lbTime.Left := Width - Canvas.TextWidth(lbTime.Caption)-15;
end;

procedure TForm1.StopClock;
begin
  Timer1.Enabled := false;
  lbTime.Visible := false;
end;

procedure TForm1.lbTimeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StopClock;
end;

procedure TForm1.lbTimeMouseLeave(Sender: TObject);
begin
  StartClock;
end;

end.
