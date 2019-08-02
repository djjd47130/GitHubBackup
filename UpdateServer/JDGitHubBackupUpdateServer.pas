unit JDGitHubBackupUpdateServer;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes,
  Vcl.SvcMgr,
  Registry;

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
var
  R: TRegistry;
begin
  R:= TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    R.RootKey:= HKEY_LOCAL_MACHINE;
    //TODO: Write description to registry...



  finally
    FreeAndNil(R);
  end;
end;

end.
