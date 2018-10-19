unit khinst1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, khdef, ComCtrls, apidut, Menus, khtypes, logdut, math,
  TrayMan;

type
  TForm1 = class(TForm)
    TrayMan1: TTrayMan;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Showapp1: TMenuItem;
    Exit1: TMenuItem;
    exit2: TMenuItem;
    Hiddenapps1: TMenuItem;
    N1: TMenuItem;
    Desktops1: TMenuItem;
    N2: TMenuItem;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure TrayMan1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Showapp1Click(Sender: TObject);
    procedure exit2Click(Sender: TObject);
    procedure HiddenAppItem1Click(Sender: TObject);
  private
    procedure WMADDHIDDENAPP(var Message: TMessage); message WM_ADD_HIDDEN_APP;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DesktopList, khfns;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  caption := windowcaption;
  GoBottomRight(self);
  InstallKeyHook;
{
  DeskManagerAppName := Application.ExeName;
  for i := 0 to dm1.DesktopList1.Count - 1 do
    ListBox1.Items.Add(dm1.DesktopList1.Desktops[i].Name);
}    
end;

procedure TForm1.Button1Click(Sender: TObject);
var threadid: dword;
    res: bool;
    hwnd: THandle;
    pow, step: extended;
begin
  step := strtoint(edit1.text);
  pow := power(2, step);
  edit2.text := format('%e', [pow]);
  exit;
  threadid := GetCurrentThreadId;
  hwnd := GetForegroundWindow;
  postmessage(hwnd, wm_close, 0, 0);
  res := postthreadmessage(threadid, wm_close, 0, 0);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
//  dolog := checkbox1.checked;
end;

procedure TForm1.TrayMan1Click(Sender: TObject);
begin
  trayman1.switchappvisible;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
//  dm1.DesktopList1.Open(listbox1.Items[listbox1.itemindex]);
end;

procedure TForm1.Showapp1Click(Sender: TObject);
begin
  trayman1.ShowApp;
end;

procedure TForm1.WMADDHIDDENAPP(var Message: TMessage);
var AppTitle: String;
    buf: array[0..255] of char;
    item: TMenuItem;
begin
  GetWindowText(Message.WParam, @buf, 255);
  item := TMenuItem.Create(popupmenu1);                                
  item.Caption := buf;
  item.Tag := Message.WParam;
  item.OnCLick := HiddenAppItem1Click;
  Hiddenapps1.Add(item);
  Hiddenapps1.Enabled := True;
end;

procedure TForm1.exit2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.HiddenAppItem1Click(Sender: TObject);
begin
  Hiddenapps1.Delete(TMenuItem(Sender).MenuIndex);
  ShowWindow(TMenuItem(Sender).Tag, SW_SHOW);
  if Hiddenapps1.Count = 0 then
    Hiddenapps1.Enabled := False;
end;

end.
