unit uSetup;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes,
  System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  uDM,
  JD.GitHub,
  JD.GitHub.Common,
  XSuperObject;

type
  TGitHubProfile = class;
  TGitHubProfiles = class;



  TGitHubProfile = class(TObject)
  private
    FOwner: TGitHubProfiles;
    FAccountType: TGitHubAccountType;
    FAccountName: String;
    FTitle: String;
    FDownloadDir: String;
    procedure SetAccountName(const Value: String);
    procedure SetAccountType(const Value: TGitHubAccountType);
    procedure SetDownloadDir(const Value: String);
    procedure SetTitle(const Value: String);
  public
    constructor Create(AOwner: TGitHubProfiles);
    property AccountName: String read FAccountName write SetAccountName;
    property AccountType: TGitHubAccountType read FAccountType write SetAccountType;
    property DownloadDir: String read FDownloadDir write SetDownloadDir;
    property Title: String read FTitle write SetTitle;
  end;

  TGitHubProfiles = class(TObject)
  private
    FItems: TObjectList<TGitHubProfile>;
    function GetItem(const Index: Integer): TGitHubProfile;
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    function Add(const AccountName: String = '';
      const AccountType: TGitHubAccountType = gaUser): TGitHubProfile;
    procedure Delete(const Index: Integer);
    procedure Clear;
    property Items[const Index: Integer]: TGitHubProfile read GetItem; default;
  end;



  {$WARN SYMBOL_PLATFORM OFF}
  TfrmSetup = class(TForm)
    Pages: TPageControl;
    tabAccounts: TTabSheet;
    tabProfiles: TTabSheet;
    tabView: TTabSheet;
    gbAccountAccess: TGroupBox;
    Label4: TLabel;
    lblAccessToken: TLabel;
    txtAccessToken: TEdit;
    dlgBrowseDir: TFileOpenDialog;
    GroupBox1: TGroupBox;
    txtPageSize: TEdit;
    Label1: TLabel;
    pBottom: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    GroupBox3: TGroupBox;
    lstProfiles: TListView;
    Panel1: TPanel;
    pProfile: TPanel;
    txtUser: TEdit;
    cboUserType: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    txtProfileTitle: TEdit;
    Label5: TLabel;
    txtBackupDir: TEdit;
    btnBrowseDir: TBitBtn;
    Label6: TLabel;
    Panel2: TPanel;
    btnAddProfile: TBitBtn;
    btnDeleteProfile: TBitBtn;
    btnCancelProfile: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseDirClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ProfileControlsChanged(Sender: TObject);
    procedure lstProfilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnAddProfileClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDeleteProfileClick(Sender: TObject);
  private
    FLoading: Boolean;
    FProfileInvalidated: Boolean;
    FProfiles: TGitHubProfiles;
    FProfileIndex: Integer;
    function GetBackupDir: String;
    function GetToken: String;
    function GetUser: String;
    function GetUserType: TGitHubAccountType;
    procedure LoadProfiles;
    procedure SaveProfiles;
    procedure SetProfileIndex(const Value: Integer);
    function UserTypeStr(const AType: TGitHubAccountType): String;
    function GetTitle: String;
  public
    procedure LoadFromConfig;
    procedure SaveToConfig;
    function AdjustTime(const AValue: TDateTime): TDateTime;
    function FormatTime(const AValue: TDateTime): String;
  public
    property ProfileIndex: Integer read FProfileIndex write SetProfileIndex;
    property Token: String read GetToken;
    property User: String read GetUser;
    property Title: String read GetTitle;
    property UserType: TGitHubAccountType read GetUserType;
    property BackupDir: String read GetBackupDir;
    property Profiles: TGitHubProfiles read FProfiles;
    function CurProfile: TGitHubProfile;
  end;
  {$WARN SYMBOL_PLATFORM ON}

var
  frmSetup: TfrmSetup;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  uMain;

{ TGitHubProfile }

constructor TGitHubProfile.Create(AOwner: TGitHubProfiles);
begin
  FOwner:= AOwner;

end;

procedure TGitHubProfile.SetAccountName(const Value: String);
begin
  FAccountName := Value;
end;

procedure TGitHubProfile.SetAccountType(const Value: TGitHubAccountType);
begin
  FAccountType := Value;
end;

procedure TGitHubProfile.SetDownloadDir(const Value: String);
begin
  FDownloadDir := Value;
end;

procedure TGitHubProfile.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

{ TGitHubProfiles }

constructor TGitHubProfiles.Create;
begin
  FItems:= TObjectList<TGitHubProfile>.Create(True);
end;

destructor TGitHubProfiles.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TGitHubProfiles.GetItem(const Index: Integer): TGitHubProfile;
begin
  Result:= FItems[Index];
end;

function TGitHubProfiles.Add(const AccountName: String;
  const AccountType: TGitHubAccountType): TGitHubProfile;
begin
  Result:= TGitHubProfile.Create(Self);
  Result.FAccountName:= AccountName;
  Result.FAccountType:= AccountType;
  FItems.Add(Result);
end;

procedure TGitHubProfiles.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

function TGitHubProfiles.Count: Integer;
begin
  Result:= FItems.Count;
end;

procedure TGitHubProfiles.Delete(const Index: Integer);
begin
  FItems.Delete(Index);
end;

{ TfrmSetup }

procedure TfrmSetup.btnSaveClick(Sender: TObject);
begin

  {
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
    try
      txtBackupDir.SetFocus;
    except
    end;
    txtBackupDir.SelectAll;
    Exit;
  end;

  if Trim(txtUser.Text) = '' then begin
    Pages.ActivePageIndex:= 1;
    MessageDlg('Invalid user account!', mtError, [mbOK], 0);
    try
      txtUser.SetFocus;
    except
    end;
    txtUser.SelectAll;
    Exit;
  end;
  }

  {
  #29 - Remove requirement of personal access token
  if Trim(txtAccessToken.Text) = '' then begin
    Pages.ActivePageIndex:= 0;
    MessageDlg('Invalid access token!', mtError, [mbOK], 0);
    txtAccessToken.SetFocus;
    txtAccessToken.SelectAll;
    Exit;
  end;
  }

  ModalResult:= mrOK;
end;

function TfrmSetup.UserTypeStr(const AType: TGitHubAccountType): String;
begin
  case AType of
    gaUser: Result:= 'User';
    gaOrganization: Result:= 'Organization';
  end;
end;

procedure TfrmSetup.ProfileControlsChanged(Sender: TObject);
var
  P: TGitHubProfile;
  I: TListItem;
begin
  if not FLoading then begin
    FProfileInvalidated:= True;
    //lstProfiles.Enabled:= False;

    I:= lstProfiles.Selected;
    P:= TGitHubProfile(I.Data);

    P.Title:= txtProfileTitle.Text;
    P.AccountName:= txtUser.Text;
    P.AccountType:= TGitHubAccountType(cboUserType.ItemIndex);
    P.DownloadDir:= txtBackupDir.Text;

    I.Caption:= P.Title;
    I.SubItems[0]:= UserTypeStr(P.FAccountType);

  end;
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  FProfiles:= TGitHubProfiles.Create;

  Pages.Align:= alClient;
end;

procedure TfrmSetup.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProfiles);
end;

procedure TfrmSetup.FormShow(Sender: TObject);
begin
  FLoading:= True;
  try

    if Self.txtAccessToken.Text = '' then begin
      //Self.Pages.ActivePageIndex:= 0;
      try
        //Self.txtAccessToken.SetFocus;
      except
      end;
    end else begin
      //Self.Pages.ActivePageIndex:= 1;
      try
        //Self.txtBackupDir.SetFocus;
      except
      end;
    end;

  finally
    FLoading:= False;
  end;
end;

function TfrmSetup.CurProfile: TGitHubProfile;
begin
  if FProfileIndex >= 0 then
    Result:= FProfiles[FProfileIndex]
  else
    Result:= nil;
end;

function TfrmSetup.GetBackupDir: String;
begin
  if FProfileIndex >= 0 then
    Result:= CurProfile.DownloadDir
  else
    Result:= '';
end;

function TfrmSetup.GetTitle: String;
begin
  if FProfileIndex >= 0 then
    Result:= CurProfile.Title
  else
    Result:= '';
end;

function TfrmSetup.GetToken: String;
begin
  Result:= txtAccessToken.Text;
end;

function TfrmSetup.GetUser: String;
begin
  if FProfileIndex >= 0 then
    Result:= CurProfile.AccountName
  else
    Result:= '';
end;

function TfrmSetup.GetUserType: TGitHubAccountType;
begin
  if FProfileIndex >= 0 then
    Result:= CurProfile.AccountType
  else
    Result:= TGitHubAccountType.gaUser;
end;

procedure TfrmSetup.LoadProfiles;
var
  A: ISuperArray;
  O: ISuperObject;
  P: TGitHubProfile;
  X: Integer;
  I: TListItem;
begin
  lstProfiles.Items.Clear;
  FProfiles.Clear;

  A:= DM.Config.A['profiles'];
  if Assigned(A) then begin
    for X := 0 to A.Length-1 do begin
      O:= A.O[X];
      if Assigned(O) then begin
        P:= FProfiles.Add;
        P.AccountName:= O.S['user'];
        P.AccountType:= TGitHubAccountType(O.I['userType']);
        P.DownloadDir:= O.S['dir'];
        P.Title:= O.S['title'];
      end;
    end;
  end;

  if FProfiles.Count = 0 then begin
    P:= FProfiles.Add;
    if DM.Config.S['user'] = '' then begin
      P.Title:= 'Jerry Dodge';
      P.AccountName:= 'djjd47130';
      P.AccountType:= gaUser;
      P.DownloadDir:= TPath.Combine(TPath.GetDocumentsPath, 'GitHub Backups');
    end else begin
      P.Title:= 'Default';
      P.AccountName:= DM.Config.S['user'];
      P.AccountType:= TGitHubAccountType(DM.Config.I['userType']);
      P.DownloadDir:= DM.Config.S['dir'];
    end;
  end;

  for X := 0 to FProfiles.Count-1 do begin
    P:= FProfiles[X];
    I:= lstProfiles.Items.Add;
    I.Data:= P;
    I.Caption:= P.Title;
    I.Subitems.Add(UserTypeStr(P.AccountType));
  end;

  lstProfiles.ItemIndex:= FProfileIndex;
  lstProfilesSelectItem(lstProfiles, lstProfiles.Selected, True);

end;

procedure TfrmSetup.LoadFromConfig;
begin
  FLoading:= True;
  try
    txtAccessToken.Text:= DM.Config.S['token'];
    FProfileIndex:= DM.Config.I['profileIndex'];
    LoadProfiles;
  finally
    FLoading:= False;
  end;
end;

procedure TfrmSetup.lstProfilesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  P: TGitHubProfile;
begin
  pProfile.Visible:= Selected;
  btnDeleteProfile.Enabled:= Selected;
  if Selected then begin
    P:= TGitHubProfile(Item.Data);
    if Assigned(P) then begin
      FLoading:= True;
      try
        Self.txtUser.Text:= P.AccountName;
        Self.cboUserType.ItemIndex:= Integer(P.AccountType);
        Self.txtProfileTitle.Text:= P.Title;
        Self.txtBackupDir.Text:= P.DownloadDir;
      finally
        FLoading:= False;
      end;
    end;
  end else begin

  end;
end;

procedure TfrmSetup.SaveProfiles;
var
  A: ISuperArray;
  O: ISuperObject;
  P: TGitHubProfile;
  X: Integer;
begin
  A:= SA([]);
  try
    for X := 0 to FProfiles.Count-1 do begin
      O:= SO;
      try
        P:= FProfiles[X];
        O.S['title']:= P.Title;
        O.S['user']:= P.AccountName;
        O.I['userType']:= Integer(P.AccountType);
        O.S['dir']:= P.DownloadDir;
      finally
        A.Add(O);
      end;
    end;
  finally
    DM.Config.A['profiles']:= A;
  end;
end;

procedure TfrmSetup.SaveToConfig;
begin
  DM.Config.S['token']:= txtAccessToken.Text;
  DM.Config.I['profileIndex']:= FProfileIndex;
  SaveProfiles;
end;

function TfrmSetup.AdjustTime(const AValue: TDateTime): TDateTime;
begin
  //TODO: Make user option whether to use local time...
  //Result:= LocalDateTimeFromUTCDateTime(AValue);
  //Result:= UnivDateTime2LocalDateTime(AValue);
  //Result:= DateTime2UnivDateTime(AValue);
  Result:= AValue;
end;

function TfrmSetup.FormatTime(const AValue: TDateTime): String;
begin
  Result:= FormatDateTime('yyyy-mm-dd hh:nn ampm', AdjustTime(AValue));
end;

procedure TfrmSetup.SetProfileIndex(const Value: Integer);
begin
  FProfileIndex := Value;
end;

procedure TfrmSetup.btnAddProfileClick(Sender: TObject);
var
  I: TListItem;
  P: TGitHubProfile;
begin
  FProfileInvalidated:= True;
  pProfile.Visible:= True;

  FLoading:= True;
  try
    P:= FProfiles.Add;
    P.Title:= 'New Profile';
    P.DownloadDir:= TPath.Combine(TPath.GetDocumentsPath, 'GitHub Backups');

    I:= lstProfiles.Items.Add;
    I.Data:= P;
    I.Caption:= P.Title;
    I.SubItems.Add(UserTypeStr(P.FAccountType));

    lstProfiles.ItemIndex:= I.Index;

  finally
    FLoading:= False;
  end;

  //lstProfiles.Enabled:= False;

end;

procedure TfrmSetup.btnBrowseDirClick(Sender: TObject);
begin
  {$WARN SYMBOL_PLATFORM OFF}
  dlgBrowseDir.DefaultFolder:= txtBackupDir.Text;
  if dlgBrowseDir.Execute then begin
    txtBackupDir.Text:= dlgBrowseDir.FileName;
    ProfileControlsChanged(txtBackupDir);
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;


procedure TfrmSetup.btnDeleteProfileClick(Sender: TObject);
var
  Idx: Integer;
begin
  if FProfiles.Count = 1 then begin
    MessageDlg('You need to keep at least one profile. You can edit this one to your needs.', mtError, [mbOK], 0);
  end else begin
    if MessageDlg('Are you sure you want to delete selected profile?', mtWarning, [mbYes,mbNo], 0) = mrYes then
    begin
      Idx:= lstProfiles.ItemIndex;
      lstProfiles.Items.Delete(Idx);
      FProfiles.Delete(Idx);
      if FProfileIndex >= Idx then begin
        FProfileIndex:= FProfileIndex - 1;
      end;
      if Idx > 0 then
        Idx:= Idx - 1;
      lstProfiles.ItemIndex:= Idx;
    end;
  end;
end;

end.
