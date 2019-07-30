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
    Panel2: TPanel;
    Label3: TLabel;
    cboCommit: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmRepoDetail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Clear;
end;

procedure TfrmRepoDetail.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfrmRepoDetail.Clear;
var
  X: Integer;
begin
  for X := 0 to cboBranch.Items.Count-1 do begin
    cboBranch.Items.Objects[X].Free;
  end;
  cboBranch.Clear;
  FRepo:= nil;

end;

procedure TfrmRepoDetail.LoadRepo(const ARepo: TGitHubRepo);
begin
  Clear;
  FRepo:= ARepo;
  lblRepoName.Caption:= FRepo.Name;
  lblRepoOwner.Caption:= FRepo.O['owner'].S['login'];

  LoadBranches;

  cboBranch.ItemIndex:= cboBranch.Items.IndexOf(FRepo.DefaultBranch);
  if cboBranch.ItemIndex < 0 then
    cboBranch.ItemIndex:= 0;

end;

procedure TfrmRepoDetail.LoadBranches;
var
  X: Integer;
  BL: TGitHubBranches;
begin
  BL:= DM.GitHub.GetBranches(FRepo.Owner, FRepo.Name, 1);
  try
    for X := 0 to BL.Count-1 do begin
      cboBranch.Items.AddObject(BL[X].Name, BL[X]);
    end;
    cboBranch.ItemIndex:= 0;
  finally
    BL.Free;
  end;
end;

end.
