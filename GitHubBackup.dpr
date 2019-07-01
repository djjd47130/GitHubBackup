program GitHubBackup;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  JD.GitHub in 'JD.GitHub.pas',
  JD.IndyUtils in 'JD.IndyUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'GitHub Backup';
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
