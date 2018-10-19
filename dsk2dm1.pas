unit dsk2dm1;

interface

uses
  SysUtils, Classes, AppData, windows, DesktopList, logdut, forms, dialogs;

type
  Tdm1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

var
  dm1: Tdm1;

implementation

{$R *.dfm}

uses registry;

procedure Tdm1.DataModuleCreate(Sender: TObject);
begin
  DesktopList1 := TDesktopList.Create(nil);
  applogfile := 'c:\applog1.log';
  addtolog('dll started');
end;

end.
