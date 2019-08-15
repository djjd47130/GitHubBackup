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
  JD.GitHub,
  JD.Ctrls.FontButton, JD.Graphics,
  System.ImageList, Vcl.ImgList,
  Vcl.Controls, Vcl.Graphics;

type
  TDM = class(TDataModule)
    GitHub: TGitHub;
    Repos: TGitHubRepoList;
    Img16: TImageList;
    Img32: TImageList;
    Img24: TImageList;
    Glyphs: TRMProFontGlyphs;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ReposRepoAdd(Sender: TObject; Repo: TGitHubRepo);
    procedure ReposRepoDelete(Sender: TObject; Repo: TGitHubRepo);
    procedure ReposRepoEdit(Sender: TObject; Repo: TGitHubRepo);
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
  ColorManager.BaseColor:= clBlack;

  FConfig:= TJDConfig.Create;
  FConfig.Path:= 'JD Software Inc\GitHub Backup';
  FConfig.Load;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FConfig.Save;
  FreeAndNil(FConfig);
end;

procedure TDM.ReposRepoAdd(Sender: TObject; Repo: TGitHubRepo);
begin
  //
end;

procedure TDM.ReposRepoDelete(Sender: TObject; Repo: TGitHubRepo);
begin
  //
end;

procedure TDM.ReposRepoEdit(Sender: TObject; Repo: TGitHubRepo);
begin
  //
end;

end.
