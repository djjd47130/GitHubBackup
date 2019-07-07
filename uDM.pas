unit uDM;

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
