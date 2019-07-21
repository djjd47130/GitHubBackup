program JDGitHubBackupSvrSvc;

uses
  Vcl.SvcMgr,
  JDGitHubBackupUpdateServer in 'JDGitHubBackupUpdateServer.pas' {JDGitHubBackupUpdateSvr: TService};

{$R *.RES}

begin
  //TODO: Create service thread
  //TODO: Implement test mode with UI using param switch
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TJDGitHubBackupUpdateSvr, JDGitHubBackupUpdateSvr);
  Application.Run;
end.
