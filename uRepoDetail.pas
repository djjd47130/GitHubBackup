unit uRepoDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JD.GitHub.Common;

type
  TfrmRepoDetail = class(TForm)
    lblRepoName: TLabel;
    lblRepoOwner: TLabel;
  private

  public
    procedure LoadRepo(const ARepo: TRepo);
    procedure Clear;
  end;

var
  frmRepoDetail: TfrmRepoDetail;

implementation

{$R *.dfm}

{ TfrmRepoDetail }

procedure TfrmRepoDetail.LoadRepo(const ARepo: TRepo);
begin
  Self.lblRepoName.Caption:= ARepo.Name;
  //Self.lblRepoOwner.Caption:= ARepo

end;

procedure TfrmRepoDetail.Clear;
begin

end;

end.
