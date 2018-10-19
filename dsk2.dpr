program dsk2;

uses
  dialogs,
  Forms,
  dsk2u1 in 'dsk2u1.pas' {Form1},
  newdsk in 'forms\newdsk.pas' {dlgnewdesktop},
  khfns in 'keyhook\khfns.pas',
  deskprop in 'forms\deskprop.pas' {dlgDeskProp},
  windi in 'forms\windi.pas' {fmWindi},
  dskdefs in 'dskdefs.pas',
  DesktopList in 'DesktopList.pas',
  eInput1 in '..\engi\duts\eInput1.pas' {eInputForm},
  mydefs in '..\engi\mydefs.pas',
  khdef in 'keyhook\khdef.pas',
  DirRunner in '..\engi\DirRunner.pas',
  kpMatch in '..\engi\kpMatch.pas',
  LogDut in '..\engi\duts\logdut.pas',
  AppData in '..\engi\AppData.pas',
  ApiDut in '..\engi\duts\apidut.pas',
  mytypes in '..\engi\mytypes.pas',
  Listdut in '..\engi\duts\Listdut.pas',
  StrDut in '..\engi\duts\strdut.pas',
  TrayMan in '..\engi\TrayMan.pas',
  AppStart in '..\engi\duts\appstart.pas',
  FontDut in '..\engi\duts\fontdut.pas';

{$R *.res}

begin
//  if not CreateCheckMutex then begin
  //  exit; // fuck dont work 5.4.18
//  end; тем более что работает но криво
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tdlgnewdesktop, dlgnewdesktop);
  Application.CreateForm(TdlgDeskProp, dlgDeskProp);
  Application.CreateForm(TeInputForm, eInputForm);
  Application.Run;
end.
