program JDGitHubBackup;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles,
  uSetup in 'uSetup.pas' {frmSetup},
  uDM in 'uDM.pas' {DM: TDataModule},
  uRepoDetail in 'uRepoDetail.pas' {frmRepoDetail},
  uAbout in 'uAbout.pas' {frmAbout};

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
  Application.Run;
end.
