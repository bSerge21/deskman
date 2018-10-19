unit windi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfmWindi = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmWindi: TfmWindi;

implementation

{$R *.dfm}

procedure TfmWindi.Timer1Timer(Sender: TObject);
begin
  timer1.enabled := false;
  close;
end;

procedure TfmWindi.FormShow(Sender: TObject);
begin
  timer1.enabled := true;
end;

procedure TfmWindi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
end;

end.
