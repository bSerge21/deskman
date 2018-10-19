program khinst;

uses
  Forms,
  khinst1 in 'khinst1.pas' {Form1},
  khdef in 'khdef.pas',
  AppData in '..\..\engi\AppData.pas',
  DesktopList in '..\..\engi\DesktopList.pas',
  ApiDut in '..\..\engi\duts\ApiDut.pas',
  khfns in 'khfns.pas',
  TrayMan in '..\..\engi\TrayMan.pas',
  khtypes in 'khtypes.pas',
  eInput1 in '..\..\..\engi\duts\eInput1.pas' {eInputForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TeInputForm, eInputForm);
  Application.Run;
end.
