program GitHubBackup;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  JD.GitHub in 'JD.GitHub.pas',
  JD.ListGrid in 'JD.ListGrid.pas' {ListGrid},
  JD.GitHub.Intf in 'JD.GitHub.Intf.pas',
  JD.GitHub.Impl in 'JD.GitHub.Impl.pas',
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
