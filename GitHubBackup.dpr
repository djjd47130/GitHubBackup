program GitHubBackup;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  uSetup in 'uSetup.pas' {frmSetup},
  uDM in 'uDM.pas' {DM: TDataModule},
  uRepoDetail in 'uRepoDetail.pas' {frmRepoDetail},
  uAbout in 'uAbout.pas' {frmAbout},
  JD.GitHub.Impl in 'Source\JD.GitHub.Impl.pas',
  JD.GitHub.Intf in 'Source\JD.GitHub.Intf.pas',
  JD.ListGrid in 'Source\JD.ListGrid.pas' {ListGrid},
  JD.GitHub.Common in 'Source\JD.GitHub.Common.pas',
  JD.GitHub in 'Source\JD.GitHub.pas',
  JD.GitHub.Update in 'Source\JD.GitHub.Update.pas',
  JD.Config in 'Source\JD.Config.pas',
  JD.DownloadThread in 'Source\JD.DownloadThread.pas',
  JD.IndyUtils in 'Source\JD.IndyUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'JD GitHub Backup';
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(TfrmRepoDetail, frmRepoDetail);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TListGrid, ListGrid);
  Application.Run;
end.
