unit uMain;

(*
  JD GitHub Backup Main Form

  Fundamental usage of this form is to display a list of repositories,
  allow the user to check which ones they wish to back up, and
  download all of them in one go. Additional tools are provided to
  assist user in filtering, sorting, and deciding which ones they want.
*)

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, System.Generics.Defaults,
  System.UITypes, System.Win.TaskbarCore, System.Actions,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Taskbar, Vcl.CheckLst,
  Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnList, Vcl.ActnMan, System.ImageList, Vcl.ImgList,
{$IFDEF USE_VCL_STYLE_UTILS}
  //Recommended to use vcl-styles-utils to fix issues in Windows dialogs
  //  If you don't have this, remove the conditional from the project's
  //  main compiler settings.
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
{$IFDEF V2}
  JD.ListGrid,
{$ENDIF}
  //Relies on our own copy of X-SuperObject
  XSuperObject,
  JD.GitHub,
  JD.IndyUtils,
  JD.GitHub.Common,
  uSetup,
  uRepoDetail;

type
  {$WARN SYMBOL_PLATFORM OFF}
  TfrmMain = class(TForm)
    Stat: TStatusBar;
    Pages: TPageControl;
    tabRepositories: TTabSheet;
    pRepoTop: TPanel;
    lstRepos: TListView;
    Prog: TProgressBar;
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
    btnSortDir: TButton;
    Label4: TLabel;
    tabListGridTest: TTabSheet;
    pErrorLog: TPanel;
    pErrorLogTitle: TPanel;
    lblErrorLogTitle: TLabel;
    btnCloseErrorLog: TButton;
    spErrorLog: TSplitter;
    txtErrorLog: TMemo;
    MM: TMainMenu;
    mRepositories: TMenuItem;
    mOptions: TMenuItem;
    mView: TMenuItem;
    mHelp: TMenuItem;
    mSetup: TMenuItem;
    mRefresh: TMenuItem;
    N1: TMenuItem;
    mColumns: TMenuItem;
    mColumnsConfig: TMenuItem;
    N2: TMenuItem;
    Acts: TActionManager;
    CheckAll1: TMenuItem;
    CheckNone1: TMenuItem;
    CheckSelected1: TMenuItem;
    N4: TMenuItem;
    DownloadCheckedRepos1: TMenuItem;
    N5: TMenuItem;
    Exit1: TMenuItem;
    Img16: TImageList;
    actSetup: TAction;
    actRefresh: TAction;
    actConfigCols: TAction;
    actCheckAll: TAction;
    actCheckNone: TAction;
    actCheckSelected: TAction;
    actDownloadRepos: TAction;
    actExit: TAction;
    actCancelDownload: TAction;
    N6: TMenuItem;
    ConfigureColumns1: TMenuItem;
    actSortAZ: TAction;
    Sort1: TMenuItem;
    SortAscending1: TMenuItem;
    SortDescending1: TMenuItem;
    N7: TMenuItem;
    Cancel1: TMenuItem;
    procedure actRefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDownloadReposExecute(Sender: TObject);
    procedure lstReposClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkCheckAllClick(Sender: TObject);
    procedure tmrDisplayTimer(Sender: TObject);
    procedure actCancelDownloadExecute(Sender: TObject);
    procedure btnSortDirClick(Sender: TObject);
    procedure cboSortClick(Sender: TObject);
    procedure lstReposItemChecked(Sender: TObject; Item: TListItem);
    procedure btnCloseErrorLogClick(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actCheckAllExecute(Sender: TObject);
    procedure actCheckNoneExecute(Sender: TObject);
    procedure actCheckSelectedExecute(Sender: TObject);
    procedure actConfigColsExecute(Sender: TObject);
    procedure actSetupExecute(Sender: TObject);
    procedure ActsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lstReposDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private                    
    FEnabled: Boolean;
    FRepos: TObjectList<TRepo>;
    FWeb: TIndyHttpTransport;
    FCurFile: TDownloadFile;
    FCurPos: Integer;
    FCurMax: Integer;
    FThreadCancel: TThreadCancelEvent;
    {$IFDEF V2}
    FListGrid: TListGrid;
    {$ENDIF}
    function GetJSON(const URL: String): ISuperObject;
    function GetRepos(const PageNum: Integer): ISuperArray;
    procedure GetPage(const PageNum: Integer);
    function CheckedCount: Integer;
    procedure UpdateDownloadAction;
    procedure SetEnabledState(const Enabled: Boolean);
    procedure ThreadBegin(Sender: TObject);
    procedure ThreadDone(Sender: TObject);
    procedure ThreadException(Sender: TObject; const CurFile: TDownloadFile);
    procedure ThreadProgress(Sender: TObject; const Cur, Max: Integer;
      const CurFile: TDownloadFile);
    function CreateDownloadThread: TDownloadThread;
    function RepoSort: Integer;
    function RepoType: String;
    function RepoVisibility: String;
    procedure UpdateCheckAll;
    procedure SortRepos;
    procedure DisplayRepos;
    procedure ShowErrorLog(const AShow: Boolean = True);
    {$IFDEF V2}
    procedure SetupListGrid;
    procedure PopulateListGrid;
    procedure ListGridGetText(AListGrid: TListGrid; AItem: TListGridItem;
      ACol: TListGridColumn; var AText: String);
    {$ENDIF}
  public
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

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
{$IFNDEF V2}
var
  X: Integer;
{$ENDIF}
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

  {$IFDEF V2}
  //Temporary test of the list grid concept
  FListGrid:= TListGrid.Create(tabListGridTest);
  FListGrid.Parent:= tabListGridTest;
  FListGrid.Align:= alClient;
  FListGrid.Show;
  SetupListGrid;
  {$ELSE}
  for X := 0 to Pages.PageCount-1 do
    Pages.Pages[X].TabVisible:= False;
  {$ENDIF}

  Pages.ActivePageIndex:= 0;


end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FWeb);
  FreeAndNil(FRepos);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

  frmSetup.LoadFromConfig;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmSetup.SaveToConfig;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not FEnabled then begin
    CanClose:= False;
    MessageDlg('Cannot close while download is in progress.', mtError, [mbOK], 0);
  end;
end;

{$IFDEF V2}
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

{$IFDEF V2}
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

{$IFDEF V2}
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
  //Root function for all interaction with GitHub API
  //Returns JSON objects via Super Object
  Result:= nil;
  FWeb.Request.Username:= frmSetup.Token;
  R:= FWeb.Get('https://api.github.com'+URL);
  Result:= SO(R);
end;

function TfrmMain.RepoVisibility: String;
begin
  //Filter
  case cboVisibility.ItemIndex of
    0: Result:= 'all';
    1: Result:= 'public';
    2: Result:= 'private';
  end;
end;

function TfrmMain.RepoType: String;
begin
  //Filter
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
  case frmSetup.UserType of
    0: Result:= GetJSON('/users/'+frmSetup.User+'/repos?page='+IntToStr(PageNum)+Q).AsArray;
    1: Result:= GetJSON('/orgs/'+frmSetup.User+'/repos?page='+IntToStr(PageNum)+Q).AsArray;
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
  //Fetches a single page of repositories
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
  //TODO: Support virtually any column...
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
  //Populates list view with repository items
  lstRepos.Items.BeginUpdate;
  try
    lstRepos.Items.Clear;
    for X := 0 to FRepos.Count-1 do begin
      O:= FRepos[X];
      I:= lstRepos.Items.Add;
      I.Data:= O;
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
  {$IFDEF V2}
  PopulateListGrid;
  {$ENDIF}
end;

procedure TfrmMain.actRefreshExecute(Sender: TObject);
begin
  //Performs actual refresh of repository list
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
  UpdateDownloadAction;
  UpdateCheckAll;
end;

procedure TfrmMain.btnSortDirClick(Sender: TObject);
begin
  //Change between ascending and descending
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

procedure TfrmMain.UpdateDownloadAction;
var
  C: Integer;
begin
  //Change download option depending on selection
  C:= CheckedCount;
  if C > 0 then begin
    actDownloadRepos.Caption:= 'Download '+IntToStr(C)+' Checked';
    actDownloadRepos.Enabled:= FEnabled;
  end else begin
    actDownloadRepos.Caption:= 'Download';
    actDownloadRepos.Enabled:= False;
  end;
end;

procedure TfrmMain.UpdateCheckAll;
var
  C: Integer;
begin
  //Change check all option depending on selection
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

procedure TfrmMain.lstReposClick(Sender: TObject);
begin
  if FEnabled then begin
    UpdateDownloadAction;
    UpdateCheckAll;
  end;
end;

procedure TfrmMain.lstReposDblClick(Sender: TObject);
var
  I: TListItem;
  R: TRepo;
  F: TfrmRepoDetail;
begin
  //Open details of repository
  I:= lstRepos.Selected;
  if Assigned(I) then begin
    R:= TRepo(I.Data);
    F:= TfrmRepoDetail.Create(nil);
    try
      F.LoadRepo(R);
      F.ShowModal;
    finally
      F.Free;
    end;
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
      UpdateDownloadAction;
      UpdateCheckAll;
    end;
  end;
end;

function TfrmMain.DestDir: String;
begin
  Result:= frmSetup.BackupDir;
end;

procedure TfrmMain.actCheckAllExecute(Sender: TObject);
begin
  //Check All...
  Self.chkCheckAll.Checked:= True;
end;

procedure TfrmMain.actCheckNoneExecute(Sender: TObject);
begin
  //Check None...
  Self.chkCheckAll.Checked:= False;
end;

procedure TfrmMain.actCheckSelectedExecute(Sender: TObject);
begin
  //Check Selected...
  if Self.lstRepos.ItemIndex >= 0 then begin
    lstRepos.Selected.Checked:= not lstRepos.Selected.Checked;
  end;
end;

procedure TfrmMain.actSetupExecute(Sender: TObject);
begin
  //Setup App...
  frmSetup.LoadFromConfig;
  if frmSetup.ShowModal = mrOK then begin
    frmSetup.SaveToConfig;

  end;
end;

procedure TfrmMain.actConfigColsExecute(Sender: TObject);
begin
  //Configure Columns...

end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

function TfrmMain.CheckedCount: Integer;
var
  X: Integer;
begin
  //Returns number of checked repos
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
  //User clicked on check all checkbox at top of list
  if chkCheckAll.Tag = 0 then begin
    lstRepos.OnItemChecked:= nil;
    try
      for X := 0 to lstRepos.Items.Count-1 do
        lstRepos.Items[X].Checked:= chkCheckAll.Checked;
      UpdateDownloadAction;
    finally
      lstRepos.OnItemChecked:= lstReposItemChecked;
    end;
  end;
end;

procedure TfrmMain.ActsUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  //TODO: Adjust actions based on current state of application...

  SetEnabledState(FEnabled); //TODO: This is just temporary!

end;

procedure TfrmMain.SetEnabledState(const Enabled: Boolean);
begin
  //Set UI enabled controls based on current state
  FEnabled:= Enabled;
  actRefresh.Enabled:= Enabled;
  chkCheckAll.Enabled:= Enabled;
  actCheckAll.Enabled:= Enabled;
  actCheckNone.Enabled:= Enabled;
  actCheckSelected.Enabled:= Enabled;
  cboVisibility.Enabled:= Enabled;
  cboType.Enabled:= Enabled;
  cboSort.Enabled:= Enabled;
  btnSortDir.Enabled:= Enabled;
  UpdateDownloadAction;
end;

procedure TfrmMain.ThreadBegin(Sender: TObject);
begin
  //Triggered when download thread begins work
  SetEnabledState(False);
  txtErrorLog.Lines.Clear;
  ShowErrorLog(False);
  actCancelDownload.Enabled:= True;
  Stat.Panels[1].Text:= 'Downloading...';
  Prog.Visible:= True;
  Prog.Position:= 0;
  UpdateDownloadAction;
  lstRepos.Tag:= 1;
end;

procedure TfrmMain.ThreadDone(Sender: TObject);
begin
  //Triggered when download thread is done with all work
  FCurFile:= nil;
  FThreadCancel:= nil;
  actCancelDownload.Enabled:= False;
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
  UpdateDownloadAction;
end;

procedure TfrmMain.ThreadProgress(Sender: TObject; const Cur: Integer;
  const Max: Integer; const CurFile: TDownloadFile);
begin
  //Triggered when download thread makes progress
  FCurFile:= CurFile;
  FCurPos:= Cur;
  FCurMax:= Max;
end;

procedure TfrmMain.tmrDisplayTimer(Sender: TObject);
begin
  //Displays UI status/progress
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
  //Error occurred in download thread
  txtErrorLog.Lines.Append('EXCEPTION on file '+CurFile.Name+': '+CurFile.Error);
end;

function TfrmMain.CreateDownloadThread: TDownloadThread;
begin
  //Create a new instance of download thread
  Result:= TDownloadThread.Create;
  Result.Token:= frmSetup.Token;
  Result.OnDownloadBegin:= ThreadBegin;
  Result.OnDownloadDone:= ThreadDone;
  Result.OnProgress:= ThreadProgress;
  Result.OnException:= ThreadException;
  Result.FreeOnTerminate:= True;
  FThreadCancel:= Result.Cancel;
end;

procedure TfrmMain.actCancelDownloadExecute(Sender: TObject);
begin
  //User wants to cancel download
  if MessageDlg('Are you sure you want to cancel download?',
    mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    if Assigned(FThreadCancel) then
      FThreadCancel;
  end;
end;

procedure TfrmMain.btnCloseErrorLogClick(Sender: TObject);
begin
  //User is closing error log
  ShowErrorLog(False);
end;

procedure TfrmMain.ShowErrorLog(const AShow: Boolean = True);
begin
  //Either show or hide error log
  pErrorLog.Visible:= AShow;
  spErrorLog.Visible:= AShow;
  if AShow then
    spErrorLog.Top:= pErrorLog.Top - 10;
end;

procedure TfrmMain.actDownloadReposExecute(Sender: TObject);
var
  C: Integer;
  O: TRepo;
  X: Integer;
  T: TDownloadThread;
begin
  //Actual downloading of checked repos
  try
    //Attempt to create destination directory, if not already...
    ForceDirectories(DestDir);
  except
    on E: Exception do begin
      if not DirectoryExists(DestDir) then begin
        MessageDlg('Invalid destination directory!', mtError, [mbOK], 0);
        Application.ProcessMessages;
        actSetup.Execute;
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
