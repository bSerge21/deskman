unit deskprop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DesktopList, ComCtrls, apidut, strdut;

type
  TdlgDeskProp = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbRunshell: TCheckBox;
    cbProptected: TCheckBox;
    edPwd: TEdit;
    edname: TEdit;
    ListBox1: TListBox;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetData(dsk: TDesktop);
    procedure SetData(dsk: TDesktop);
  end;

var
  dlgDeskProp: TdlgDeskProp;

implementation

{$R *.dfm}

{ TdlgDeskProp }

procedure TdlgDeskProp.GetData(dsk: TDeskTop);
begin
  edName.Text := dsk.Name;
  cbRunShell.Checked := dsk.DeskInfo.RunShell;
  cbProptected.Checked := dsk.DeskInfo.isprotected;
  edPwd.Text := dsk.DeskInfo.password;
//  listbox1.Items.AddStrings(dsk.RunList);
end;

procedure TdlgDeskProp.SetData(dsk: TDeskTop);
begin
  dsk.Name := edName.Text;
  dsk.DeskInfo.RunShell := cbRunShell.Checked;
  dsk.DeskInfo.isprotected := cbProptected.Checked;
  dsk.DeskInfo.password := edPwd.Text;
//  dsk.RunList.clear;
//  dsk.RunList.AddStrings(listbox1.items);
end;

procedure TdlgDeskProp.SpeedButton1Click(Sender: TObject);
var name: string;
begin
  if opendialog1.execute then begin
    name := inputbox('Run item', 'Enter item name:', opendialog1.filename);
    listbox1.Items.Add(format('%s=%s', [name, opendialog1.filename]));
  end;
end;

procedure TdlgDeskProp.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_delete then
    listbox1.items.delete(listbox1.itemindex);
end;

procedure TdlgDeskProp.ListBox1DblClick(Sender: TObject);
begin
  run(getparam(listbox1.items[listbox1.itemindex], 2, '='), '', 1);
end;

end.
