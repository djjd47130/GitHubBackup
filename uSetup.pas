unit uSetup;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  uDM;

type
  {$WARN SYMBOL_PLATFORM OFF}
  TfrmSetup = class(TForm)
    Pages: TPageControl;
    tabAccount: TTabSheet;
    tabRepositories: TTabSheet;
    tabView: TTabSheet;
    gbAccountAccess: TGroupBox;
    Label4: TLabel;
    gbBackupDir: TGroupBox;
    txtBackupDir: TEdit;
    btnBrowseDir: TBitBtn;
    lblAccessToken: TLabel;
    txtAccessToken: TEdit;
    dlgBrowseDir: TFileOpenDialog;
    GroupBox1: TGroupBox;
    txtPageSize: TEdit;
    Label1: TLabel;
    pBottom: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    GroupBox2: TGroupBox;
    txtUser: TEdit;
    cboUserType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseDirClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetBackupDir: String;
    function GetToken: String;
    function GetUser: String;
    function GetUserType: Integer;
  public
    procedure LoadFromConfig;
    procedure SaveToConfig;
  public
    property Token: String read GetToken;
    property User: String read GetUser;
    property UserType: Integer read GetUserType;
    property BackupDir: String read GetBackupDir;
  end;
  {$WARN SYMBOL_PLATFORM ON}

var
  frmSetup: TfrmSetup;

implementation

{$R *.dfm}

uses
  System.IOUtils;

procedure TfrmSetup.btnSaveClick(Sender: TObject);
begin
  try
    ForceDirectories(txtBackupDir.Text);
  except
    on E: Exception do begin
      //I guess do nothing here because error will appear anyway...
    end;
  end;
  if not DirectoryExists(txtBackupDir.Text) then begin
    Pages.ActivePageIndex:= 1;
    MessageDlg('Invalid backup directory!', mtError, [mbOK], 0);
    txtBackupDir.SetFocus;
    txtBackupDir.SelectAll;
    Exit;
  end;

  if Trim(txtUser.Text) = '' then begin
    Pages.ActivePageIndex:= 1;
    MessageDlg('Invalid user account!', mtError, [mbOK], 0);
    txtUser.SetFocus;
    txtUser.SelectAll;
    Exit;
  end;

  if Trim(txtAccessToken.Text) = '' then begin
    Pages.ActivePageIndex:= 0;
    MessageDlg('Invalid access token!', mtError, [mbOK], 0);
    txtAccessToken.SetFocus;
    txtAccessToken.SelectAll;
    Exit;
  end;

  ModalResult:= mrOK;
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  Pages.Align:= alClient;
end;

procedure TfrmSetup.FormShow(Sender: TObject);
begin
  if Self.txtBackupDir.Text = '' then begin
    Self.txtBackupDir.Text:= TPath.Combine(TPath.GetDocumentsPath, 'GitHub Backups');
  end;

  if Self.txtAccessToken.Text = '' then begin
    Self.Pages.ActivePageIndex:= 0;
    Self.txtAccessToken.SetFocus;
  end else begin
    Self.Pages.ActivePageIndex:= 1;
    Self.txtBackupDir.SetFocus;
  end;
end;

function TfrmSetup.GetBackupDir: String;
begin
  Result:= txtBackupDir.Text;
end;

function TfrmSetup.GetToken: String;
begin
  Result:= txtAccessToken.Text;
end;

function TfrmSetup.GetUser: String;
begin
  Result:= txtUser.Text;
end;

function TfrmSetup.GetUserType: Integer;
begin
  Result:= cboUserType.ItemIndex;
end;

procedure TfrmSetup.LoadFromConfig;
begin
  txtAccessToken.Text:= DM.Config.S['token'];
  txtUser.Text:= DM.Config.S['user'];
  cboUserType.ItemIndex:= DM.Config.I['userType'];
  txtBackupDir.Text:= DM.Config.S['dir'];

end;

procedure TfrmSetup.SaveToConfig;
begin
  DM.Config.S['token']:= txtAccessToken.Text;
  DM.Config.S['user']:= txtUser.Text;
  DM.Config.I['userType']:= cboUserType.ItemIndex;
  DM.Config.S['dir']:= txtBackupDir.Text;

end;

procedure TfrmSetup.btnBrowseDirClick(Sender: TObject);
begin
  {$WARN SYMBOL_PLATFORM OFF}
  dlgBrowseDir.DefaultFolder:= txtBackupDir.Text;
  if dlgBrowseDir.Execute then begin
    txtBackupDir.Text:= dlgBrowseDir.FileName;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;


end.
