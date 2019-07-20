unit uRepoDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JD.GitHub,
  JD.GitHub.Common,
  Vcl.ExtCtrls,
  uDM;

type
  TfrmRepoDetail = class(TForm)
    lblRepoName: TLabel;
    lblRepoOwner: TLabel;
    Panel1: TPanel;
    cboBranch: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FRepo: TGitHubRepo;
  public
    procedure Clear;
    procedure LoadRepo(const ARepo: TGitHubRepo);
    procedure LoadBranches;
  end;

var
  frmRepoDetail: TfrmRepoDetail;

implementation

{$R *.dfm}

{ TfrmRepoDetail }

procedure TfrmRepoDetail.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfrmRepoDetail.Clear;
begin

end;

procedure TfrmRepoDetail.LoadRepo(const ARepo: TGitHubRepo);
begin
  FRepo:= ARepo;
  lblRepoName.Caption:= FRepo.Name;
  lblRepoOwner.Caption:= FRepo.O['owner'].S['login'];

  LoadBranches;
end;

procedure TfrmRepoDetail.LoadBranches;
begin
  //cboBranch.Items.Clear;

end;

end.
