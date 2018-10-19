unit kh_DskSysMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, dskdefs, shellapi, strdut,
  ExtCtrls;

type
  TSysMenuObj = class
    command, params: string;
    constructor Create(acommand, aparams: String);
  end;

  TfmDskSysMenu = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    procedure ListBox1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddItem(caption, command, params: string);
    procedure execute;    
  end;

var
  fmDskSysMenu: TfmDskSysMenu;
  sysmenuformshowed: boolean = false;

//procedure CreateSysMenuForm;

implementation

uses DesktopList;

{$R *.dfm}

{ TfmDskSysMenu }


{procedure CreateSysMenuForm;
begin
  if fmDskSysMenu = nil then
    fmDskSysMenu := TfmDskSysMenu.Create(nil);
  fmDskSysMenu.Show;
end;}

procedure TfmDskSysMenu.AddItem(caption, command, params: string);
var obj: TSysMenuObj;
begin
  obj := TSysMenuObj.Create(command, params);
  listbox1.Items.AddObject(caption, obj);
end;

{ TSysMenuObj }

constructor TSysMenuObj.Create(acommand, aparams: String);
begin
  command := acommand;
  params := aparams;
end;

procedure TfmDskSysMenu.ListBox1Click(Sender: TObject);
begin
 execute;
 Close;
end;

procedure TfmDskSysMenu.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then close;
end;

procedure TfmDskSysMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  sysmenuformshowed := false;
end;

procedure TfmDskSysMenu.execute;
begin
//  ShowMessage('execute');
end;

procedure TfmDskSysMenu.FormShow(Sender: TObject);
begin
  sysmenuformshowed := true;
end;

end.
