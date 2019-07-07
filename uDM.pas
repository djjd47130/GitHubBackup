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
  JD.Config;

type
  TDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FConfig: TJDConfig;
  public
    property Config: TJDConfig read FConfig;
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
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FConfig.Save;
  FreeAndNil(FConfig);
end;

end.
