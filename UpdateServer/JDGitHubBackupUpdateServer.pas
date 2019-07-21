unit JDGitHubBackupUpdateServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TJDGitHubBackupUpdateSvr = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  JDGitHubBackupUpdateSvr: TJDGitHubBackupUpdateSvr;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  JDGitHubBackupUpdateSvr.Controller(CtrlCode);
end;

function TJDGitHubBackupUpdateSvr.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TJDGitHubBackupUpdateSvr.ServiceAfterInstall(Sender: TService);
begin
  //TODO: Write description to registry...

end;

end.
