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
    FBranches: TGitHubBranches;
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
  cboBranch.Items.Clear;
  if Assigned(FBranches) then begin
    while FBranches.Count > 0 do
      FBranches.Delete(0);
    FreeAndNil(FBranches);
  end;
  FRepo:= nil;

end;

procedure TfrmRepoDetail.LoadRepo(const ARepo: TGitHubRepo);
begin
  Clear;
  FRepo:= ARepo;
  lblRepoName.Caption:= FRepo.Name;
  lblRepoOwner.Caption:= FRepo.O['owner'].S['login'];

  LoadBranches;
end;

procedure TfrmRepoDetail.LoadBranches;
var
  X: Integer;
begin
  FBranches:= DM.GitHub.GetBranches(FRepo.Owner, FRepo.Name, 1);
  for X := 0 to FBranches.Count-1 do begin
    cboBranch.Items.AddObject(FBranches[X].Name, FBranches[X]);
  end;
  cboBranch.ItemIndex:= 0;
end;

end.
