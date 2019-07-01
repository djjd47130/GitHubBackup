unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, System.Generics.Defaults,
  System.UITypes, System.Win.TaskbarCore,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Taskbar, Vcl.CheckLst,
{$IFDEF USE_VCL_STYLE_UTILS}
  Vcl.Styles, Vcl.Themes,
  Vcl.Styles.FontAwesome,
  Vcl.Styles.Fixes,
  Vcl.Styles.Utils.Menus,
  Vcl.Styles.Utils.Forms,
  Vcl.Styles.Utils.StdCtrls,
  Vcl.Styles.Utils.ComCtrls,
  Vcl.Styles.Utils.ScreenTips,
  Vcl.Styles.Utils.SysControls,
  Vcl.Styles.Utils.SysStyleHook,
{$ENDIF}
{$IFDEF LISTGRID}
  JD.ListGrid,
{$ENDIF}
  XSuperObject,
  JD.GitHub,
  JD.IndyUtils;

type
  TRepo = class(TObject)
  private
    FObj: ISuperObject;
    function GetB(const N: String): Boolean;
    function GetF(const N: String): Double;
    function GetI(const N: String): Int64;
    function GetS(const N: String): String;
    function GetO(const N: String): ISuperObject;
    function GetCreated: TDateTime;
    function GetDefaultBranch: String;
    function GetDescription: String;
    function GetFullName: String;
    function GetIsPrivate: Boolean;
    function GetLanguage: String;
    function GetName: String;
    function GetPushed: TDateTime;
    function GetSize: Int64;
    function GetUpdated: TDateTime;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;
  public
    property S[const N: String]: String read GetS;
    property I[const N: String]: Int64 read GetI;
    property B[const N: String]: Boolean read GetB;
    property F[const N: String]: Double read GetF;
    property O[const N: String]: ISuperObject read GetO;
  public
    property Name: String read GetName;
    property FullName: String read GetFullName;
    property Created: TDateTime read GetCreated;
    property Updated: TDateTime read GetUpdated;
    property Pushed: TDateTime read GetPushed;
    property Language: String read GetLanguage;
    property DefaultBranch: String read GetDefaultBranch;
    property IsPrivate: Boolean read GetIsPrivate;
    property Size: Int64 read GetSize;
    property Description: String read GetDescription;
  end;

  {$WARN SYMBOL_PLATFORM OFF}
  TfrmMain = class(TForm)
    Stat: TStatusBar;
    Pages: TPageControl;
    tabSetup: TTabSheet;
    tabRepositories: TTabSheet;
    Panel2: TPanel;
    txtUser: TEdit;
    Label1: TLabel;
    txtToken: TEdit;
    Label2: TLabel;
    pRepoTop: TPanel;
    lstRepos: TListView;
    cboUserType: TComboBox;
    Prog: TProgressBar;
    Label3: TLabel;
    txtBackupDir: TEdit;
    btnBrowseDir: TBitBtn;
    Panel4: TPanel;
    cboVisibility: TComboBox;
    cboType: TComboBox;
    cboSort: TComboBox;
    chkCheckAll: TCheckBox;
    tmrDisplay: TTimer;
    btnListRepos: TButton;
    btnDownload: TButton;
    btnCancel: TButton;
    Taskbar: TTaskbar;
    dlgBrowseDir: TFileOpenDialog;
    btnSortDir: TButton;
    Label4: TLabel;
    pCols: TPanel;
    lstCols: TCheckListBox;
    Label5: TLabel;
    btnColsDone: TButton;
    btnCols: TButton;
    tabListGridTest: TTabSheet;
    pErrorLog: TPanel;
    pErrorLogTitle: TPanel;
    lblErrorLogTitle: TLabel;
    btnCloseErrorLog: TButton;
    spErrorLog: TSplitter;
    txtErrorLog: TMemo;
    procedure btnListReposClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure lstReposClick(Sender: TObject);
    procedure PagesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnBrowseDirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkCheckAllClick(Sender: TObject);
    procedure tmrDisplayTimer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSortDirClick(Sender: TObject);
    procedure cboSortClick(Sender: TObject);
    procedure lstColsClickCheck(Sender: TObject);
    procedure btnColsDoneClick(Sender: TObject);
    procedure btnColsClick(Sender: TObject);
    procedure lstReposItemChecked(Sender: TObject; Item: TListItem);
    procedure btnCloseErrorLogClick(Sender: TObject);
  private                    
    FEnabled: Boolean;
    FRepos: TObjectList<TRepo>;
    FWeb: TIndyHttpTransport;
    FCurFile: TDownloadFile;
    FCurPos: Integer;
    FCurMax: Integer;
    FThreadCancel: TThreadCancelEvent;
    {$IFDEF LISTGRID}
    FListGrid: TListGrid;
    {$ENDIF}
    function GetJSON(const URL: String): ISuperObject;
    function GetRepos(const PageNum: Integer): ISuperArray;
    procedure GetPage(const PageNum: Integer);
    function CheckedCount: Integer;
    procedure UpdateDownloadButton;
    procedure SetEnabledState(const Enabled: Boolean);
    procedure ThreadBegin(Sender: TObject);
    procedure ThreadDone(Sender: TObject);
    procedure ThreadException(Sender: TObject; const CurFile: TDownloadFile);
    procedure ThreadProgress(Sender: TObject; const Cur, Max: Integer;
      const CurFile: TDownloadFile);
    function CreateDownloadThread: TDownloadThread;
    function ConfigFilename: String;
    function RepoSort: Integer;
    function RepoType: String;
    function RepoVisibility: String;
    procedure UpdateCheckAll;
    procedure SortRepos;
    procedure DisplayRepos;
    procedure ShowErrorLog(const AShow: Boolean = True);
    {$IFDEF LISTGRID}
    procedure SetupListGrid;
    procedure PopulateListGrid;
    procedure ListGridGetText(AListGrid: TListGrid; AItem: TListGridItem;
      ACol: TListGridColumn; var AText: String);
    {$ENDIF}
  public
    function LoadConfig: Boolean;
    procedure SaveConfig;
    function DestDir: String;
  end;
  {$WARN SYMBOL_PLATFORM ON}

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.DateUtils, Soap.XSBuiltIns, System.Math;

const
  REPO_FLD_NAME = 0;
  REPO_FLD_FULLNAME = 1;
  REPO_FLD_CREATED = 2;
  REPO_FLD_UPDATED = 3;
  REPO_FLD_PUSHED = 4;
  REPO_FLD_LANGUAGE = 5;
  REPO_FLD_DEFAULT_BRANCH = 6;
  REPO_FLD_SIZE = 7;
  REPO_FLD_DESCRIPTION = 8;

procedure ListRepoFields(AStrings: TStrings);
begin
  AStrings.Add('Name');
  AStrings.Add('Full Name');
  AStrings.Add('Created');
  AStrings.Add('Updated');
  AStrings.Add('Pushed');
  AStrings.Add('Language');
  AStrings.Add('Default Branch');
  AStrings.Add('Size');
  AStrings.Add('Description');
end;

{ TRepo }

constructor TRepo.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FObj._AddRef;
end;

destructor TRepo.Destroy;
begin
  FObj._Release;
  FObj:= nil;
  inherited;
end;

function TRepo.GetO(const N: String): ISuperObject;
begin
  Result:= FObj.O[N];
end;

function TRepo.GetS(const N: String): String;
begin
  Result:= FObj.S[N];
end;

function TRepo.GetB(const N: String): Boolean;
begin
  Result:= FObj.B[N];
end;

function TRepo.GetF(const N: String): Double;
begin
  Result:= FObj.F[N];
end;

function TRepo.GetI(const N: String): Int64;
begin
  Result:= FObj.I[N];
end;

function TRepo.GetCreated: TDateTime;
begin
  with TXSDateTime.Create do
    try
      XSToNative(S['created_at']);
      Result:= AsDateTime;
    finally
      Free;
    end;
end;

function TRepo.GetDefaultBranch: String;
begin
  Result:= S['default_branch'];
end;

function TRepo.GetDescription: String;
begin
  Result:= S['description'];
end;

function TRepo.GetFullName: String;
begin
  Result:= S['full_name'];
end;

function TRepo.GetIsPrivate: Boolean;
begin
  Result:= B['private'];
end;

function TRepo.GetLanguage: String;
begin
  Result:= S['language'];
end;

function TRepo.GetName: String;
begin
  Result:= S['name'];
end;

function TRepo.GetPushed: TDateTime;
begin
  with TXSDateTime.Create do
    try
      XSToNative(S['pushed_at']);
      Result:= AsDateTime;
    finally
      Free;
    end;
end;

function TRepo.GetSize: Int64;
begin
  Result:= I['size'];
end;

function TRepo.GetUpdated: TDateTime;
begin
  with TXSDateTime.Create do
    try
      XSToNative(S['updated_at']);
      Result:= AsDateTime;
    finally
      Free;
    end;
end;

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= True;
  {$ENDIF}

  FRepos:= TObjectList<TRepo>.Create(True);
  FWeb:= TIndyHttpTransport.Create;

  Pages.Align:= alClient;
  lstRepos.Align:= alClient;
  txtErrorLog.Align:= alClient;

  SetEnabledState(True);
  ShowErrorLog(False);

  cboSort.Items.Clear;
  ListRepoFields(cboSort.Items);
  cboSort.ItemIndex:= 0;

  {$IFDEF LISTGRID}
  FListGrid:= TListGrid.Create(tabListGridTest);
  FListGrid.Parent:= tabListGridTest;
  FListGrid.Align:= alClient;
  FListGrid.Show;
  SetupListGrid;
  {$ELSE}
  tabListGridTest.TabVisible:= False;
  {$ENDIF}

  if LoadConfig then
    Pages.ActivePageIndex:= 1
  else
    Pages.ActivePageIndex:= 0;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FWeb);
  FreeAndNil(FRepos);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveConfig;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not FEnabled then begin
    CanClose:= False;
    MessageDlg('Cannot close while download is in progress.', mtError, [mbOK], 0);
  end;
end;

function TfrmMain.ConfigFilename: String;
begin
  Result:= TPath.GetHomePath;
  Result:= TPath.Combine(Result, 'RM Innovation');
  Result:= TPath.Combine(Result, 'GitHub Backup');
  Result:= TPath.Combine(Result, 'Config.json');
end;

function TfrmMain.LoadConfig: Boolean;
var
  L: TStringList;
  O: ISuperObject;
begin
  Result:= False;
  L:= TStringList.Create;
  try
    if FileExists(ConfigFilename) then begin
      L.LoadFromFile(ConfigFilename);
      O:= SO(L.Text);
      if Assigned(O) then begin
        txtUser.Text:= O.S['user'];
        cboUserType.ItemIndex:= O.I['userType'];
        txtToken.Text:= O.S['token'];
        txtBackupDir.Text:= O.S['dir'];
        cboVisibility.ItemIndex:= O.I['visibility'];
        cboType.ItemIndex:= O.I['type'];
        cboSort.ItemIndex:= O.I['sort'];
        btnSortDir.Tag:= O.I['sort_dir'];
        if btnSortDir.Tag = 0 then begin
          btnSortDir.Caption:= 'A..Z';
        end else begin
          btnSortDir.Caption:= 'Z..A';
        end;
        Result:= True;
      end;
    end;
  finally
    L.Free;
  end;
end;

procedure TfrmMain.SaveConfig;
var
  L: TStringList;
  O: ISuperObject;
begin
  L:= TStringList.Create;
  try
    O:= SO;
    O.S['user']:= txtUser.Text;
    O.I['userType']:= cboUserType.ItemIndex;
    O.S['token']:= txtToken.Text;
    O.S['dir']:= txtBackupDir.Text;
    O.I['visibility']:= cboVisibility.ItemIndex;
    O.I['type']:= cboType.ItemIndex;
    O.I['sort']:= cboSort.ItemIndex;
    O.I['sort_dir']:= btnSortDir.Tag;
    L.Text:= O.AsJSON(True);
    ForceDirectories(ExtractFilePath(ConfigFilename));
    L.SaveToFile(ConfigFilename);
  finally
    L.Free;
  end;
end;

{$IFDEF LISTGRID}
procedure TfrmMain.SetupListGrid;
  procedure AC(const Fld, Cap: String; const Wid: Integer; const Vis: Boolean = True);
  begin
    FListGrid.Columns.Add(Fld, Cap, Wid, Vis);
  end;
begin
  FListGrid.OnGetText:= ListGridGetText;
  FListGrid.Columns.Clear;

  AC('name',            'Repository Name',  150);
  AC('default_branch',  'Default Branch',   100);
  AC('visibility',      'Visibility',       80);
  AC('language',        'Language',         80);
  AC('size',            'Size',             70);
  AC('pushed',          'Last Pushed',      100);
  AC('description',     'Description',      300);
end;
{$ENDIF}

{$IFDEF LISTGRID}
procedure TfrmMain.PopulateListGrid;
  procedure AI(const AObj: TObject);
  begin
    FListGrid.Items.Add(AObj);
  end;
var
  X: Integer;
begin
  FListGrid.Items.Clear;
  for X := 0 to FRepos.Count-1 do begin
    AI(FRepos[X]);
  end;
end;
{$ENDIF}

{$IFDEF LISTGRID}
procedure TfrmMain.ListGridGetText(AListGrid: TListGrid; AItem: TListGridItem;
  ACol: TListGridColumn; var AText: String);
var
  R: TRepo;
  function IsCol(const AFld: String): Boolean;
  begin
    Result:= SameText(AFld, ACol.FieldName);
  end;
begin
  R:= TRepo(AItem.Obj);
  if IsCol('name') then begin
    AText:= R.Name;
  end else
  if IsCol('default_branch') then begin
    AText:= R.DefaultBranch;
  end else
  if IsCol('visibility') then begin
    if R.IsPrivate then
      AText:= 'Private'
    else
      AText:= 'Public';
  end else
  if IsCol('language') then begin
    AText:= R.Language;
  end else
  if IsCol('size') then begin
    AText:= IntToStr(R.Size); //TODO
  end else
  if IsCol('pushed') then begin
    AText:= FormatDateTime('m/d/yy h:nn ampm', R.Pushed);
  end else
  if IsCol('description') then begin
    AText:= R.Description;
  end else begin
    AText:= 'Testing!'; //TODO
  end;
end;
{$ENDIF}

function TfrmMain.GetJSON(const URL: String): ISuperObject;
var
  R: String;
begin
  Result:= nil;
  FWeb.Request.Username:= txtToken.Text;
  R:= FWeb.Get('https://api.github.com'+URL);
  Result:= SO(R);
end;

function TfrmMain.RepoVisibility: String;
begin
  case cboVisibility.ItemIndex of
    0: Result:= 'all';
    1: Result:= 'public';
    2: Result:= 'private';
  end;
end;

function TfrmMain.RepoType: String;
begin
  case cboType.ItemIndex of
    0: Result:= 'all';
    1: Result:= 'owner';
    2: Result:= 'public';
    3: Result:= 'private';
    4: Result:= 'member';
  end;
end;

function TfrmMain.RepoSort: Integer;
begin
  Result:= cboSort.ItemIndex;
end;

function TfrmMain.GetRepos(const PageNum: Integer): ISuperArray;
var
  Q: String;
begin
  Q:= '&visibility='+RepoVisibility+'&type='+RepoType;
  case cboUserType.ItemIndex of
    0: Result:= GetJSON('/users/'+txtUser.Text+'/repos?page='+IntToStr(PageNum)+Q).AsArray;
    1: Result:= GetJSON('/orgs/'+txtUser.Text+'/repos?page='+IntToStr(PageNum)+Q).AsArray;
  end;
end;

procedure TfrmMain.GetPage(const PageNum: Integer);
var
  A: ISuperArray;
  O: ISuperObject;
  X: Integer;
  C: Boolean;
  R: TRepo;
begin
  Application.ProcessMessages;

  try
    A:= GetRepos(PageNum);
    for X := 0 to A.Length-1 do begin
      O:= A.O[X];
      R:= TRepo.Create(O);
      FRepos.Add(R); //O);
    end;
    C:= True;
  except
    on E: Exception do begin
      case MessageDlg('Failed to get page '+IntToStr(PageNum)+': '+E.Message+sLineBreak+
        'Would you like to continue anyway?', mtError, [mbYes,mbNo], 0)
      of
        mrYes: C:= True;
        else   C:= False;
      end;
    end;
  end;

  //If we got any results this time, then try to get next page...
  if C then begin
    if A.Length > 0 then
      GetPage(PageNum+1);
  end;
end;

procedure TfrmMain.SortRepos;
begin
  FRepos.Sort(TComparer<TRepo>.Construct(
    function (const L, R: TRepo): Integer
    var
      Dir: Integer;
    begin
      //Asc = 1, Desc = -1
      if btnSortDir.Tag = 0 then
        Dir:= 1
      else
        Dir:= -1;

      case RepoSort of
        REPO_FLD_NAME: begin
          Result:= CompareText(L.Name, R.Name) * Dir;
        end;
        REPO_FLD_FULLNAME: begin
          Result:= CompareText(L.FullName, R.FullName) * Dir;
        end;
        REPO_FLD_CREATED: begin
          Result:= CompareDate(L.Created, R.Created) * Dir;
        end;
        REPO_FLD_UPDATED: begin
          Result:= CompareDate(L.Updated, R.Updated) * Dir;
        end;
        REPO_FLD_PUSHED: begin
          Result:= CompareDate(L.Pushed, R.Pushed) * Dir;
        end;
        REPO_FLD_LANGUAGE: begin
          Result:= CompareText(L.Language, R.Language) * Dir;
        end;
        REPO_FLD_DEFAULT_BRANCH: begin
          Result:= CompareText(L.DefaultBranch, R.DefaultBranch) * Dir;
        end;
        REPO_FLD_SIZE: begin
          Result:= CompareValue(L.Size, R.Size) * Dir;
        end;
        REPO_FLD_DESCRIPTION: begin
          Result:= CompareText(L.Description, R.Description) * Dir;
        end;
        else begin
          Result:= 0;
        end;
      end;
    end
  ));
  DisplayRepos;
end;

procedure TfrmMain.DisplayRepos;
var
  X: Integer;
  O: TRepo;
  I: TListItem;
begin
  lstRepos.Items.BeginUpdate;
  try
    lstRepos.Items.Clear;
    for X := 0 to FRepos.Count-1 do begin
      O:= FRepos[X];
      I:= lstRepos.Items.Add;
      I.Caption:= O.Name;
      I.SubItems.Add(O.DefaultBranch);
      if O.IsPrivate = True then
        I.SubItems.Add('Private')
      else
        I.SubItems.Add('Public');
      I.SubItems.Add(O.Language);
      I.SubItems.Add(ConvertBytes(O.Size * 1024)); //TODO: NOT RELIABLE!!!
      I.SubItems.Add(FormatDateTime('yyyy-mm-dd h:nn ampm', O.Pushed));
      I.SubItems.Add(O.Description);
    end;
  finally
    lstRepos.Items.EndUpdate;
  end;
  {$IFDEF LISTGRID}
  PopulateListGrid;
  {$ENDIF}
end;

procedure TfrmMain.btnListReposClick(Sender: TObject);
begin
  Screen.Cursor:= crHourglass;
  try
    SetEnabledState(False);
    try
      Stat.Panels[1].Text:= 'Listing Repos...';
      try
        FRepos.Clear;
        //Start with page 1, will automatically traverse to all pages...
        GetPage(1);
        Stat.Panels[0].Text:= IntToStr(FRepos.Count)+' Repositories';
        Application.ProcessMessages;
        SortRepos;
      finally
        Stat.Panels[1].Text:= 'Ready';
      end;
    finally
      SetEnabledState(True);
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
  UpdateDownloadButton;
  UpdateCheckAll;
end;

procedure TfrmMain.btnSortDirClick(Sender: TObject);
begin
  case btnSortDir.Tag of
    0: begin
      btnSortDir.Tag:= 1;
      btnSortDir.Caption:= 'Z..A';
    end;
    1: begin
      btnSortDir.Tag:= 0;
      btnSortDir.Caption:= 'A..Z';
    end;
  end;
  SortRepos;
end;

procedure TfrmMain.cboSortClick(Sender: TObject);
begin
  SortRepos;
end;

procedure TfrmMain.UpdateDownloadButton;
var
  C: Integer;
begin
  C:= CheckedCount;
  if C > 0 then begin
    btnDownload.Caption:= 'Download '+IntToStr(C)+' Checked';
    btnDownload.Enabled:= FEnabled;
  end else begin
    btnDownload.Caption:= 'Download';
    btnDownload.Enabled:= False;
  end;
end;

procedure TfrmMain.UpdateCheckAll;
var
  C: Integer;
begin
  chkCheckAll.Tag:= 1;
  try
    C:= CheckedCount;
    if C = 0 then begin
      chkCheckAll.State:= TCheckBoxState.cbUnchecked;
    end else
    if C = lstRepos.Items.Count then begin
      chkCheckAll.State:= TCheckBoxState.cbChecked;
    end else begin
      chkCheckAll.State:= TCheckBoxState.cbGrayed;
    end;
  finally
    chkCheckAll.Tag:= 0;
  end;
end;

procedure TfrmMain.lstColsClickCheck(Sender: TObject);
var
  X: Integer;
  //C: TListColumn;
  //TC: Integer;
begin
  //User checked/unchecked a column to show/hide...
  //TC:= 0;
  for X := 0 to lstCols.Count-1 do begin
    //if lstCols.Checked[X] then
      //Inc(TC);
  end;
  for X := lstRepos.Columns.Count-1 downto 0 do begin
    //C:= lstRepos.Columns[X];
    //TODO...???

  end;
end;

procedure TfrmMain.lstReposClick(Sender: TObject);
begin
  if FEnabled then begin
    UpdateDownloadButton;
    UpdateCheckAll;
  end;
end;

procedure TfrmMain.lstReposItemChecked(Sender: TObject; Item: TListItem);
begin
  if lstRepos.Tag <> 0 then begin
    //Revert back to prior state
    lstRepos.OnItemChecked:= nil;
    try
      Item.Checked:= not Item.Checked;
    finally
      lstRepos.OnItemChecked:= lstReposItemChecked;
    end;
  end else begin
    if FEnabled then begin
      UpdateDownloadButton;
      UpdateCheckAll;
    end;
  end;
end;

procedure TfrmMain.PagesChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange:= FEnabled;
  if AllowChange then begin
    case Pages.ActivePageIndex of
      0: begin
        //Setup page - Validate setup first...
        if not DirectoryExists(txtBackupDir.Text) then begin
          MessageDlg('Invalid backup directory!', mtError, [mbOK], 0);
          AllowChange:= False;
          txtBackupDir.SetFocus;
          txtBackupDir.SelectAll;
          Exit;
        end;
        if Trim(txtUser.Text) = '' then begin
          MessageDlg('Invalid user account!', mtError, [mbOK], 0);
          AllowChange:= False;
          txtUser.SetFocus;
          txtUser.SelectAll;
          Exit;
        end;
        if Trim(txtToken.Text) = '' then begin
          MessageDlg('Invalid access token!', mtError, [mbOK], 0);
          AllowChange:= False;
          txtToken.SetFocus;
          txtToken.SelectAll;
          Exit;
        end;
        SaveConfig;
      end;
      1: begin
        //Repository page...

      end;
      2: begin
        //List grid test page...

      end;
    end;
  end;
end;

function TfrmMain.DestDir: String;
begin
  Result:= txtBackupDir.Text;
end;

procedure TfrmMain.btnBrowseDirClick(Sender: TObject);
begin
  {$WARN SYMBOL_PLATFORM OFF}
  dlgBrowseDir.FileName:= txtBackupDir.Text;
  if dlgBrowseDir.Execute then begin
    txtBackupDir.Text:= dlgBrowseDir.FileName;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;

function TfrmMain.CheckedCount: Integer;
var
  X: Integer;
begin
  Result:= 0;
  for X := 0 to lstRepos.Items.Count-1 do begin
    if lstRepos.Items[X].Checked then
      Inc(Result);
  end;
end;

procedure TfrmMain.chkCheckAllClick(Sender: TObject);
var
  X: Integer;
begin
  if chkCheckAll.Tag = 0 then begin
    lstRepos.OnItemChecked:= nil;
    try
      for X := 0 to lstRepos.Items.Count-1 do
        lstRepos.Items[X].Checked:= chkCheckAll.Checked;
      UpdateDownloadButton;
    finally
      lstRepos.OnItemChecked:= lstReposItemChecked;
    end;
  end;
end;

procedure TfrmMain.SetEnabledState(const Enabled: Boolean);
begin
  FEnabled:= Enabled;
  btnListRepos.Enabled:= Enabled;
  chkCheckAll.Enabled:= Enabled;
  cboVisibility.Enabled:= Enabled;
  cboType.Enabled:= Enabled;
  cboSort.Enabled:= Enabled;
  btnSortDir.Enabled:= Enabled;
  btnCols.Enabled:= Enabled;
  UpdateDownloadButton;
end;

procedure TfrmMain.ThreadBegin(Sender: TObject);
begin
  SetEnabledState(False);
  txtErrorLog.Lines.Clear;
  ShowErrorLog(False);
  btnCancel.Enabled:= True;
  Stat.Panels[1].Text:= 'Downloading...';
  Prog.Visible:= True;
  Prog.Position:= 0;
  UpdateDownloadButton;
  lstRepos.Tag:= 1;
end;

procedure TfrmMain.ThreadDone(Sender: TObject);
begin
  FCurFile:= nil;
  FThreadCancel:= nil;
  btnCancel.Enabled:= False;
  lstRepos.Tag:= 0;
  SetEnabledState(True);
  Stat.Panels[1].Text:= 'Ready';
  Prog.Visible:= False;
  Stat.Panels[2].Text:= '';
  //If any errors, show...
  if txtErrorLog.Lines.Text <> '' then begin
    ShowErrorLog(True);
    MessageDlg('Download completed with errors.', mtWarning, [mbOK], 0);
  end else begin
    MessageDlg('Download completed successfully.', mtInformation, [mbOK], 0);
  end;
  UpdateDownloadButton;
end;

procedure TfrmMain.ThreadProgress(Sender: TObject; const Cur: Integer;
  const Max: Integer; const CurFile: TDownloadFile);
begin
  FCurFile:= CurFile;
  FCurPos:= Cur;
  FCurMax:= Max;
end;

procedure TfrmMain.tmrDisplayTimer(Sender: TObject);
begin
  if Assigned(FCurFile) then begin
    Taskbar.ProgressState:= TTaskbarProgressState.Normal;
    Prog.Max:= FCurMax;
    Prog.Position:= FCurPos;
    Taskbar.ProgressMaxValue:= FCurMax;
    Taskbar.ProgressValue:= FCurPos;
    Stat.Panels[1].Text:= 'Downloading '+IntToStr(FCurPos)+' of '+IntToStr(FCurMax)+'...';
    Stat.Panels[2].Text:= FCurFile.Name;
  end else begin
    Taskbar.ProgressState:= TTaskbarProgressState.None;
  end;
end;

procedure TfrmMain.ThreadException(Sender: TObject;
  const CurFile: TDownloadFile);
begin
  txtErrorLog.Lines.Append('EXCEPTION on file '+CurFile.Name+': '+CurFile.Error);
end;

function TfrmMain.CreateDownloadThread: TDownloadThread;
begin
  Result:= TDownloadThread.Create;
  Result.Token:= txtToken.Text;
  Result.OnDownloadBegin:= ThreadBegin;
  Result.OnDownloadDone:= ThreadDone;
  Result.OnProgress:= ThreadProgress;
  Result.OnException:= ThreadException;
  Result.FreeOnTerminate:= True;
  FThreadCancel:= Result.Cancel;
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to cancel download?',
    mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    if Assigned(FThreadCancel) then
      FThreadCancel;
  end;
end;

procedure TfrmMain.btnCloseErrorLogClick(Sender: TObject);
begin
  ShowErrorLog(False);
end;

procedure TfrmMain.ShowErrorLog(const AShow: Boolean = True);
begin
  pErrorLog.Visible:= AShow;
  spErrorLog.Visible:= AShow;
  if AShow then
    spErrorLog.Top:= pErrorLog.Top - 10;
end;

procedure TfrmMain.btnColsClick(Sender: TObject);
begin
  pCols.Visible:= not pCols.Visible;
  if pCols.Visible then begin
    pCols.Left:= ClientWidth - pCols.Width - 8;
    pCols.Top:= lstRepos.Top;
  end;
end;

procedure TfrmMain.btnColsDoneClick(Sender: TObject);
begin
  pCols.Hide;
end;

procedure TfrmMain.btnDownloadClick(Sender: TObject);
var
  C: Integer;
  O: TRepo;
  X: Integer;
  T: TDownloadThread;
begin
  try
    //Attempt to create destination directory, if not already...
    ForceDirectories(DestDir);
  except
    on E: Exception do begin
      if not DirectoryExists(DestDir) then begin
        MessageDlg('Invalid destination directory!', mtError, [mbOK], 0);
        Pages.ActivePageIndex:= 0;
        Application.ProcessMessages;
        txtBackupDir.SetFocus;
        txtBackupDir.SelectAll;
        Exit;
      end;
    end;
  end;
  C:= CheckedCount;
  if C > 0 then begin
    //Download all checked repos...
    T:= CreateDownloadThread;
    for X := 0 to FRepos.Count-1 do begin
      if lstRepos.Items[X].Checked then begin
        O:= FRepos[X];
        T.AddFile(O.S['html_url']+'/archive/'+O.S['default_branch']+'.zip',
          TPath.Combine(DestDir, MakeFilenameValid(O.S['name']+'-'+O.S['default_branch']+'.zip')));
      end;
    end;
    T.Start;
    //DO NOT REFER TO T AFTER THIS!
  end else begin
    //Nothing selected, nothing to download, shouldn't be possible...
    MessageDlg('Nothing is selected to download!', mtError, [mbOK], 0);
  end;
end;

initialization
  UseLatestCommonDialogs:= True;
{$IFDEF USE_VCL_STYLE_UTILS}
  TStyleManager.Engine.RegisterStyleHook(TButton, TButtonStyleHookFix);
{$endif}
end.
