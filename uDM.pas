unit uDM;

(*
  Global data module - accessible application-wide

  This unit is intended for anything which the full application
  needs to centralize in a single place to be available from
  anywhere in the application. For example, the configuration.
*)

interface

uses
  System.SysUtils, System.Classes,
  JD.Config,
  JD.GitHub;

type
  TDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FConfig: TJDConfig;
    FGitHub: TGitHub;
  public
    property Config: TJDConfig read FConfig;
    property GitHub: TGitHub read FGitHub;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FConfig:= TJDConfig.Create;
  FConfig.Path:= 'JD Software Inc\GitHub Backup';
  FConfig.Load;
  FGitHub:= TGitHub.Create(nil);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FGitHub);
  FConfig.Save;
  FreeAndNil(FConfig);
end;

end.
