unit JD.GitHub;

(*
  JD.GitHub.pas
  Core unit to implement all GitHub related integration

  NOTE: This unit is temporary, and will be re-written as a part of
  a much larger GitHub API wrapper library.

  Main Component: TGitHub

  Usage:
  - Create an instance of TGitHubAPI
  - Assign value to Token (GitHub Personal Access Token - Optional)
    - Ommitting a token will provide public visibility
  - Use "Get" functions to fetch various information from API



  Repository Fields

  id
  node_id
  name
  full_name
  owner
    login
    id
    node_id
    avatar_url
    gravatar_id
    url
    [urls]
    type
    site_admin
  private
  html_url
  description
  fork
  url
  [urls]
  language
  forks_count
  stargazers_count
  watchers_count
  size
  default_branch
  open_issues_count
  is_template
  topics[]
  has_issues
  has_projects
  has_wiki
  has_pages
  has_downloads
  archived
  disabled
  pushed_at
  created_at
  updated_at
  permissions
    admin
    push
    pull
  template_repository
  subscribers_count
  network_count
  license
    key
    name
    spdx_id
    url
    node_id






*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  XSuperObject,
  JD.IndyUtils,
  JD.GitHub.Common;

const
  //TODO: These are temporary and related to UI - migrate to better location
  REPO_FLD_NAME = 0;
  REPO_FLD_FULLNAME = 1;
  REPO_FLD_CREATED = 2;
  REPO_FLD_UPDATED = 3;
  REPO_FLD_PUSHED = 4;
  REPO_FLD_LANGUAGE = 5;
  REPO_FLD_DEFAULT_BRANCH = 6;
  REPO_FLD_SIZE = 7;
  REPO_FLD_DESCRIPTION = 8;

type
  TGitHubAPI = class;
  TGitHub = class;
  TGitHubRepo = class;
  TGitHubRepos = class;
  TGitHubBranch = class;
  TGitHubBranches = class;
  TGitHubCommit = class;
  TGitHubCommits = class;
  TGitHubAccount = class;
  TGitHubAccounts = class;

  TGitHubRepoList = class;

  TGitHubAccountType = (gaUser, gaOrganization);

  TGitHubAPI = class(TObject)
  private
    FWeb: TIndyHttpTransport;
    FToken: String;
    procedure SetToken(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Token: String read FToken write SetToken;
    function GetJSON(const URL: String): ISuperObject;
    function GetMyRepos(const PageNum: Integer): ISuperArray;
    function GetUserRepos(const User: String; const PageNum: Integer): ISuperArray;
    function GetOrgRepos(const Org: String; const PageNum: Integer): ISuperArray;
    function GetBranches(const Owner, Repo: String; const PageNum: Integer = 1): ISuperArray;
    function GetCommits(const Owner, Repo, Branch: String; const PageNum: Integer = 1): ISuperArray;
    function GetTree(const Owner, Repo, Sha: String; const PageNum: Integer = 1;
      const Recursive: Boolean = False): ISuperArray;
  end;

  //Encapsulates simple JSON object via Super Object
  TGitHubJsonObject = class(TObject)
  private
    FObj: ISuperObject;
    function GetB(const N: String): Boolean;
    function GetF(const N: String): Double;
    function GetI(const N: String): Int64;
    function GetS(const N: String): String;
    function GetO(const N: String): ISuperObject;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;
    property S[const N: String]: String read GetS;
    property I[const N: String]: Int64 read GetI;
    property B[const N: String]: Boolean read GetB;
    property F[const N: String]: Double read GetF;
    property O[const N: String]: ISuperObject read GetO;
  end;

  TGitHubRepo = class(TGitHubJsonObject)
  private
    FChecked: Boolean;
    FData: Pointer;
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
    function GetOwner: String;
    procedure SetChecked(const Value: Boolean);
    procedure SetData(const Value: Pointer);
  public
    property Name: String read GetName;
    property Owner: String read GetOwner;
    property FullName: String read GetFullName;
    property Created: TDateTime read GetCreated;
    property Updated: TDateTime read GetUpdated;
    property Pushed: TDateTime read GetPushed;
    property Language: String read GetLanguage;
    property DefaultBranch: String read GetDefaultBranch;
    property IsPrivate: Boolean read GetIsPrivate;
    property Size: Int64 read GetSize;
    property Description: String read GetDescription;

    //TODO: This should not be on this level, and should consider
    //  changing to a "Data: Pointer" property instead.
    property Checked: Boolean read FChecked write SetChecked;
    property Data: Pointer read FData write SetData;
  end;

  TGitHubRepos = class(TObjectList<TGitHubRepo>)
  private

  public

  end;

  TGitHubBranch = class(TGitHubJsonObject)
  private
    function GetName: String;
    function GetProtected: Boolean;
    function GetSha: String;
    function GetUrl: String;
  public
    property Name: String read GetName;
    property Sha: String read GetSha;
    property Protected: Boolean read GetProtected;
    property Url: String read GetUrl;
  end;

  TGitHubBranches = class(TObjectList<TGitHubBranch>)
  private

  public

  end;

  TGitHubCommit = class(TGitHubJsonObject)
  private
    function GetCommitter: String;
    function GetMessage: String;
    function GetTimestamp: TDateTime;
    function GetTreeSha: String;
  public
    property Timestamp: TDateTime read GetTimestamp;
    property Message: String read GetMessage;
    property Committer: String read GetCommitter;
    property TreeSha: String read GetTreeSha;
  end;

  TGitHubCommits = class(TObjectList<TGitHubCommit>)
  private

  public

  end;





  TGitHubAccount = class(TCollectionItem)
  private
    FToken: String;
    FName: String;
    procedure SetToken(const Value: String);
    procedure SetName(const Value: String);
  public
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
  published
    property Name: String read FName write SetName;
    property Token: String read FToken write SetToken;
  end;

  TGitHubAccounts = class(TOwnedCollection)
  private

  public

  end;






  /// <summary>
  ///   Encapsulates the entire GitHub API and is the base for providing
  ///   credentials to further components such as TGitHubRepoList.
  /// </summary>
  TGitHub = class(TComponent)
  private
    FApi: TGitHubAPI;
    function GetToken: String;
    procedure SetToken(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetUserRepos(const User: String; const PageNum: Integer = 0): TGitHubRepos;
    function GetOrgRepos(const Org: String; const PageNum: Integer = 0): TGitHubRepos;
    function GetBranches(const Owner, Repo: String; const PageNum: Integer = 0): TGitHubBranches;
    function GetCommits(const Owner, Repo, Branch: String; const PageNum: Integer = 0): TGitHubCommits;
  published
    property Token: String read GetToken write SetToken;
  end;


  TGitHubRepoEvent = procedure(Sender: TObject; Repo: TGitHubRepo) of object;

  /// <summary>
  ///   Encapsulates a list of repositories which is event triggered
  ///   to allow for dynamically adding/editing/removing items
  ///   from any UI list view which is currently in place.
  /// </summary>
  TGitHubRepoList = class(TComponent)
  private
    FGitHub: TGitHub;
    FItems: TObjectList<TGitHubRepo>;
    FPageSize: Integer;
    FCurPage: Integer;
    FAccountType: TGitHubAccountType;
    FAccountName: String;
    FOnRepoAdd: TGitHubRepoEvent;
    FOnRepoEdit: TGitHubRepoEvent;
    FOnRepoDelete: TGitHubRepoEvent;
    FAutoPages: Boolean;
    procedure SetPageSize(const Value: Integer);
    procedure SetGitHub(const Value: TGitHub);
    procedure SetAccountName(const Value: String);
    procedure SetAccountType(const Value: TGitHubAccountType);
    procedure SetAutoPages(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    procedure GetNextPage;
  published
    property AccountType: TGitHubAccountType read FAccountType write SetAccountType;
    property AccountName: String read FAccountName write SetAccountName;
    property AutoPages: Boolean read FAutoPages write SetAutoPages;
    property GitHub: TGitHub read FGitHub write SetGitHub;
    property PageSize: Integer read FPageSize write SetPageSize;

    property OnRepoAdd: TGitHubRepoEvent read FOnRepoAdd write FOnRepoAdd;
    property OnRepoEdit: TGitHubRepoEvent read FOnRepoEdit write FOnRepoEdit;
    property OnRepoDelete: TGitHubRepoEvent read FOnRepoDelete write FOnRepoDelete;
  end;

  /// <summary>
  ///   Encapsulates a list of repositories which is event triggered
  ///   to allow for dynamically adding/editing/removing items
  ///   from any UI list view which is currently in place.
  /// </summary>
  TGitHubRepoSearch = class(TComponent)
  //TODO: A component to perform arbitrary repository searches...
  private

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published

  end;


procedure ListRepoFields(AStrings: TStrings);

implementation

uses
  System.IOUtils, System.Math, System.StrUtils;

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

{ TGitHubAPI }

constructor TGitHubAPI.Create;
begin
  FWeb:= TIndyHttpTransport.Create;
end;

destructor TGitHubAPI.Destroy;
begin
  FreeAndNil(FWeb);
  inherited;
end;

procedure TGitHubAPI.SetToken(const Value: String);
begin
  FToken := Value;
end;

function TGitHubAPI.GetJSON(const URL: String): ISuperObject;
var
  R: String;
begin
  //Root function for all interaction with GitHub API
  //Returns JSON objects via Super Object
  Result:= nil;

  //Clear authentication and provide new credentials
  if Assigned(FWeb.Request.Authentication) then begin
    FWeb.Request.Authentication.Free;
    FWeb.Request.Authentication:=nil;
  end;
  FWeb.Request.Username:= FToken;

  R:= FWeb.Get('https://api.github.com'+URL); //ACTUAL HTTP GET

  Result:= SO(R);
end;

function TGitHubAPI.GetMyRepos(const PageNum: Integer): ISuperArray;
begin
  Result:= GetJSON('/user/repos?page='+IntToStr(PageNum)).AsArray;
end;

function TGitHubAPI.GetOrgRepos(const Org: String; const PageNum: Integer): ISuperArray;
begin
  Result:= GetJSON('/orgs/'+Org+'/repos?page='+IntToStr(PageNum)).AsArray;
end;

function TGitHubAPI.GetUserRepos(const User: String; const PageNum: Integer): ISuperArray;
begin
  Result:= GetJSON('/users/'+User+'/repos?page='+IntToStr(PageNum)).AsArray;
end;

function TGitHubAPI.GetBranches(const Owner, Repo: String; const PageNum: Integer = 1): ISuperArray;
begin
  Result:= GetJSON('/repos/'+Owner+'/'+Repo+'/branches?page='+IntToStr(PageNum)).AsArray;
end;

function TGitHubAPI.GetCommits(const Owner, Repo, Branch: String; const PageNum: Integer = 1): ISuperArray;
begin
  Result:= GetJSON('/repos/'+Owner+'/'+Repo+'/commits?sha='+Branch+'&page='+IntToStr(PageNum)).AsArray;
end;

function TGitHubAPI.GetTree(const Owner, Repo, Sha: String;
  const PageNum: Integer; const Recursive: Boolean): ISuperArray;
begin
  Result:= GetJSON('/repos/'+Owner+'/'+Repo+'/git/trees/'+Sha+
    '?page='+IntToStr(PageNum)+'&recursive='+IfThen(Recursive, 'true', 'false')).AsArray;
end;

{ TGitHubObject }

constructor TGitHubJsonObject.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FObj._AddRef;
end;

destructor TGitHubJsonObject.Destroy;
begin
  FObj._Release;
  FObj:= nil;
  inherited;
end;

function TGitHubJsonObject.GetO(const N: String): ISuperObject;
begin
  Result:= FObj.O[N];
end;

function TGitHubJsonObject.GetS(const N: String): String;
begin
  Result:= FObj.S[N];
end;

function TGitHubJsonObject.GetB(const N: String): Boolean;
begin
  Result:= FObj.B[N];
end;

function TGitHubJsonObject.GetF(const N: String): Double;
begin
  Result:= FObj.F[N];
end;

function TGitHubJsonObject.GetI(const N: String): Int64;
begin
  Result:= FObj.I[N];
end;

{ TGitHubRepo }

function TGitHubRepo.GetCreated: TDateTime;
begin
  Result:= ISOToDateTime(S['created_at']);
end;

function TGitHubRepo.GetDefaultBranch: String;
begin
  Result:= S['default_branch'];
end;

function TGitHubRepo.GetDescription: String;
begin
  Result:= S['description'];
end;

function TGitHubRepo.GetFullName: String;
begin
  Result:= S['full_name'];
end;

function TGitHubRepo.GetIsPrivate: Boolean;
begin
  Result:= B['private'];
end;

function TGitHubRepo.GetLanguage: String;
begin
  Result:= S['language'];
end;

function TGitHubRepo.GetName: String;
begin
  Result:= S['name'];
end;

function TGitHubRepo.GetOwner: String;
begin
  Result:= O['owner'].S['login'];
end;

function TGitHubRepo.GetPushed: TDateTime;
begin
  Result:= ISOToDateTime(S['pushed_at']);
end;

function TGitHubRepo.GetSize: Int64;
begin
  Result:= I['size'];
end;

function TGitHubRepo.GetUpdated: TDateTime;
begin
  Result:= ISOToDateTime(S['updated_at']);
end;

procedure TGitHubRepo.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
end;

procedure TGitHubRepo.SetData(const Value: Pointer);
begin
  FData := Value;
end;

{ TGitHubBranch }

function TGitHubBranch.GetName: String;
begin
  Result:= S['name'];
end;

function TGitHubBranch.GetProtected: Boolean;
begin
  Result:= B['protected'];
end;

function TGitHubBranch.GetSha: String;
begin
  Result:= O['commit'].S['sha'];
end;

function TGitHubBranch.GetUrl: String;
begin
  Result:= O['commit'].S['url'];
end;

{ TGitHubCommit }

function TGitHubCommit.GetCommitter: String;
begin
  Result:= O['commit'].O['committer'].S['name'];
end;

function TGitHubCommit.GetMessage: String;
begin
  Result:= O['commit'].S['message'];
end;

function TGitHubCommit.GetTimestamp: TDateTime;
begin
  Result:= ISOToDateTime(O['commit'].O['committer'].S['date']);
end;

function TGitHubCommit.GetTreeSha: String;
begin
  Result:= O['commit'].O['tree'].S['sha'];
end;

{ TGitHubAccount }

constructor TGitHubAccount.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);

end;

destructor TGitHubAccount.Destroy;
begin

  inherited;
end;

procedure TGitHubAccount.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TGitHubAccount.SetToken(const Value: String);
begin
  FToken := Value;
end;

{ TGitHub }

constructor TGitHub.Create(AOwner: TComponent);
begin
  inherited;
  FApi:= TGitHubAPI.Create;
end;

destructor TGitHub.Destroy;
begin
  FreeAndNil(FApi);
  inherited;
end;

function TGitHub.GetToken: String;
begin
  Result:= FApi.Token;
end;

function TGitHub.GetUserRepos(const User: String;
  const PageNum: Integer): TGitHubRepos;
var
  Res: ISuperArray;
  O: ISuperObject;
  X: Integer;
  R: TGitHubRepo;
begin
  Result:= TGitHubRepos.Create(False);
  try
    Res:= FApi.GetUserRepos(User, PageNum);
    if Assigned(Res) then begin
      for X := 0 to Res.Length-1 do begin
        O:= Res.O[X];
        R:= TGitHubRepo.Create(O);
        Result.Add(R);
      end;
    end;
  except
    on E: Exception do begin
      FreeAndNil(Result);
      raise E;
    end;
  end;
end;

function TGitHub.GetOrgRepos(const Org: String;
  const PageNum: Integer): TGitHubRepos;
var
  Res: ISuperArray;
  O: ISuperObject;
  X: Integer;
  R: TGitHubRepo;
begin
  Result:= TGitHubRepos.Create(False);
  try
    Res:= FApi.GetOrgRepos(Org, PageNum);
    if Assigned(Res) then begin
      for X := 0 to Res.Length-1 do begin
        O:= Res.O[X];
        R:= TGitHubRepo.Create(O);
        Result.Add(R);
      end;
    end;
  except
    on E: Exception do begin
      FreeAndNil(Result);
      raise E;
    end;
  end;
end;

function TGitHub.GetBranches(const Owner, Repo: String;
  const PageNum: Integer): TGitHubBranches;
var
  Res: ISuperArray;
  O: ISuperObject;
  X: Integer;
  B: TGitHubBranch;
begin
  Result:= TGitHubBranches.Create(False);
  try
    Res:= FApi.GetBranches(Owner, Repo, PageNum);
    if Assigned(Res) then begin
      for X := 0 to Res.Length-1 do begin
        O:= Res.O[X];
        B:= TGitHubBranch.Create(O);
        Result.Add(B);
      end;
    end;
  except
    on E: Exception do begin
      FreeAndNil(Result);
      raise E;
    end;
  end;
end;

function TGitHub.GetCommits(const Owner, Repo, Branch: String;
  const PageNum: Integer): TGitHubCommits;
var
  Res: ISuperArray;
  O: ISuperObject;
  X: Integer;
  C: TGitHubCommit;
begin
  Result:= TGitHubCommits.Create(False);
  try
    Res:= FApi.GetCommits(Owner, Repo, Branch, PageNum);
    if Assigned(Res) then begin
      for X := 0 to Res.Length-1 do begin
        O:= Res.O[X];
        C:= TGitHubCommit.Create(O);
        Result.Add(C);
      end;
    end;
  except
    on E: Exception do begin
      FreeAndNil(Result);
      raise E;
    end;
  end;
end;

procedure TGitHub.SetToken(const Value: String);
begin
  FApi.Token:= Value;
end;

{ TGitHubRepoList }

constructor TGitHubRepoList.Create(AOwner: TComponent);
begin
  inherited;
  FItems:= TObjectList<TGitHubRepo>.Create(True);

end;

destructor TGitHubRepoList.Destroy;
begin

  FreeAndNil(FItems);
  inherited;
end;

procedure TGitHubRepoList.Clear;
begin
  FItems.Clear;
  FCurPage:= 0;
end;

procedure TGitHubRepoList.GetNextPage;
begin

end;

procedure TGitHubRepoList.SetAccountName(const Value: String);
begin
  FAccountName := Value;
end;

procedure TGitHubRepoList.SetAccountType(const Value: TGitHubAccountType);
begin
  FAccountType := Value;
end;

procedure TGitHubRepoList.SetAutoPages(const Value: Boolean);
begin
  FAutoPages := Value;
end;

procedure TGitHubRepoList.SetGitHub(const Value: TGitHub);
begin
  FGitHub := Value;
end;

procedure TGitHubRepoList.SetPageSize(const Value: Integer);
begin
  FPageSize := Value;
end;

{ TGitHubRepoSearch }

constructor TGitHubRepoSearch.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGitHubRepoSearch.Destroy;
begin

  inherited;
end;

end.
