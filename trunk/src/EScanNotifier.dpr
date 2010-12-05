program EScanNotifier;

uses
  ExceptionLog,
  Forms,
  GuiMain in 'GuiMain.pas' {MainForm},
  GuiSettings in 'GuiSettings.pas' {SettingsForm},
  SvnInfo in 'lib\SvnInfo.pas',
  GuiAbout in 'GuiAbout.pas' {AboutForm},
  GuiUpdateManager in 'GuiUpdateManager.pas' {UpdateManagerForm},
  StringFunction in 'lib\StringFunction.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'EPSON Scan Notifier';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TUpdateManagerForm, UpdateManagerForm);
  MainForm.ApplicationRun.Execute;
  Application.Run;
end.
