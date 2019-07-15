program GitHubBackup;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  JD.GitHub in 'JD.GitHub.pas',
  JD.IndyUtils in 'JD.IndyUtils.pas',
  uSetup in 'uSetup.pas' {frmSetup},
  JD.Config in 'JD.Config.pas',
  JD.GitHub.Common in 'JD.GitHub.Common.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uRepoDetail in 'uRepoDetail.pas' {frmRepoDetail},
  uAbout in 'uAbout.pas' {frmAbout},
  JD.GitHub.Update in 'JD.GitHub.Update.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'JD GitHub Backup';
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(TfrmRepoDetail, frmRepoDetail);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
