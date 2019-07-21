unit JD.GitHub.Impl;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  JD.GitHub.Intf;

type
  TStringArray = class;
  TGitHubUser = class;
  TGitHubLicense = class;
  TGitHubPermissions = class;
  TGitHubRepo = class;
  TGitHubRepos = class;

  //Done
  TStringArray = class(TInterfacedObject, IStringArray)
  private
    FItems: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure Add(const Value: String);
    procedure Delete(const Index: Integer);
    procedure Clear;
    function Count: Integer;
    function GetItem(const Index: Integer): String;
    procedure SetItem(const Index: Integer; const Value: String);
  end;

  //Done
  TGitHubUser = class(TInterfacedObject, IGitHubUser)
  private
    FLogin: String;
    FID: Integer;
    FNodeID: String;
    FAvatarURL: String;
    FGravatarID: String;
    FURL: String;
    FHtmlURL: String;
    FFollowersURL: String;
    FFollowingURL: String;
    FGistsURL: String;
    FStarredURL: String;
    FSubscriptionsURL: String;
    FOrganizationsURL: String;
    FReposURL: String;
    FEventsURL: String;
    FReceivedEventsURL: String;
    FUserType: String;
    FSiteAdmin: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetLogin: String;
    procedure SetLogin(const Value: String);
    function GetID: Integer;
    procedure SetID(const Value: Integer);
    function GetNodeID: String;
    procedure SetNodeID(const Value: String);
    function GetAvatarURL: String;
    procedure SetAvatarURL(const Value: String);
    function GetGravatarID: String;
    procedure SetGravatarID(const Value: String);
    function GetURL: String;
    procedure SetURL(const Value: String);
    function GetHtmlURL: String;
    procedure SetHtmlURL(const Value: String);
    function GetFollowersURL: String;
    procedure SetFollowersURL(const Value: String);
    function GetFollowingURL: String;
    procedure SetFollowingURL(const Value: String);
    function GetGistsURL: String;
    procedure SetGistsURL(const Value: String);
    function GetStarredURL: String;
    procedure SetStarredURL(const Value: String);
    function GetSubscriptionsURL: String;
    procedure SetSubscriptionsURL(const Value: String);
    function GetOrganizationsURL: String;
    procedure SetOrganizationsURL(const Value: String);
    function GetReposURL: String;
    procedure SetReposURL(const Value: String);
    function GetEventsURL: String;
    procedure SetEventsURL(const Value: String);
    function GetReceivedEventsURL: String;
    procedure SetReceivedEventsURL(const Value: String);
    function GetUserType: String;
    procedure SetUserType(const Value: String);
    function GetSiteAdmin: Boolean;
    procedure SetSiteAdmin(const Value: Boolean);

    property Login: String read GetLogin write SetLogin;
    property ID: Integer read GetID write SetID;
    property NodeID: String read GetNodeID write SetNodeID;
    property AvatarURL: String read GetAvatarURL write SetAvatarURL;
    property GravatarID: String read GetGravatarID write SetGravatarID;
    property URL: String read GetURL write SetURL;
    property HtmlURL: String read GetHtmlURL write SetHtmlURL;
    property FollowersURL: String read GetFollowersURL write SetFollowersURL;
    property FollowingURL: String read GetFollowingURL write SetFollowingURL;
    property GistsURL: String read GetGistsURL write SetGistsURL;
    property StarredURL: String read GetStarredURL write SetStarredURL;
    property SubscriptionsURL: String read GetSubscriptionsURL write SetSubscriptionsURL;
    property OrganizationsURL: String read GetOrganizationsURL write SetOrganizationsURL;
    property ReposURL: String read GetReposURL write SetReposURL;
    property EventsURL: String read GetEventsURL write SetEventsURL;
    property ReceivedEventsURL: String read GetReceivedEventsURL write SetReceivedEventsURL;
    property UserType: String read GetUserType write SetUserType;
    property SiteAdmin: Boolean read GetSiteAdmin write SetSiteAdmin;
  end;

  //Done
  TGitHubLicense = class(TInterfacedObject, IGitHubLicense)
  private
    FKey: String;
    FName: String;
    FSpdxID: String;
    FURL: String;
    FNodeID: String;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetKey: String;
    procedure SetKey(const Value: String);
    function GetName: String;
    procedure SetName(const Value: String);
    function GetSpdxID: String;
    procedure SetSpdxID(const Value: String);
    function GetURL: String;
    procedure SetURL(const Value: String);
    function GetNodeID: String;
    procedure SetNodeID(const Value: String);

    property Key: String read GetKey write SetKey;
    property Name: String read GetName write SetName;
    property SpdxID: String read GetSpdxID write SetSpdxID;
    property URL: String read GetURL write SetURL;
    property NodeID: String read GetNodeID write SetNodeID;
  end;

  //Done
  TGitHubPermissions = class(TInterfacedObject, IGitHubPermissions)
  private
    FAdmin: Boolean;
    FPush: Boolean;
    FPull: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetAdmin: Boolean;
    procedure SetAdmin(const Value: Boolean);
    function GetPush: Boolean;
    procedure SetPush(const Value: Boolean);
    function GetPull: Boolean;
    procedure SetPull(const Value: Boolean);

    property Admin: Boolean read GetAdmin write SetAdmin;
    property Push: Boolean read GetPush write SetPush;
    property Pull: Boolean read GetPull write SetPull;
  end;

  //Done
  TGitHubRepo = class(TInterfacedObject, IGitHubRepo)
  private
    FID: Integer;
    FNodeID: String;
    FName: String;
    FFullName: String;
    FOwner: IGitHubUser;
    FPrivate: Boolean;
    FHtmlURL: String;
    FDescription: String;
    FFork: Boolean;
    FURL: String;
    FArchiveURL: String;
    FAssigneesURL: String;
    FBlobsURL: String;
    FBranchesURL: String;
    FCollaboratorsURL: String;
    FCommentsURL: String;
    FCommitsURL: String;
    FCompareURL: String;
    FContentsURL: String;
    FContributorsURL: String;
    FDeploymentsURL: String;
    FDownloadsURL: String;
    FEventsURL: String;
    FForksURL: String;
    FGitCommitsURL: String;
    FGitRefsURL: String;
    FGitTagsURL: String;
    FGitURL: String;
    FIssueCommentURL: String;
    FIssueEventsURL: String;
    FIssuesURL: String;
    FKeysURL: String;
    FLabelsURL: String;
    FLanguagesURL: String;
    FMergesURL: String;
    FMilestonesURL: String;
    FNotificationsURL: String;
    FPullsURL: String;
    FReleasesURL: String;
    FSshURL: String;
    FStargazersURL: String;
    FStatusesURL: String;
    FSubscribersURL: String;
    FSubscriptionURL: String;
    FTagsURL: String;
    FTeamsURL: String;
    FTreesURL: String;
    FCloneURL: String;
    FMirrorURL: String;
    FHooksURL: String;
    FSvnURL: String;
    FHomepageURL: String;
    FLanguage: String;
    FForksCount: Integer;
    FStargazersCount: Integer;
    FWatchersCount: Integer;
    FSize: Int64;
    FDefaultBranch: String;
    FOpenIssuesCount: Integer;
    FTopics: IStringArray;
    FHasIssues: Boolean;
    FHasProjects: Boolean;
    FHasWiki: Boolean;
    FHasPages: Boolean;
    FHasDownloads: Boolean;
    FArchived: Boolean;
    FDisabled: Boolean;
    FPushedAt: TDateTime;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
    FPermissions: IGitHubPermissions;
    FSubscribersCount: Integer;
    FNetworkCount: Integer;
    FLicense: IGitHubLicense;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function GetID: Integer;
    procedure SetID(const Value: Integer);
    function GetNodeID: String;
    procedure SetNodeID(const Value: String);
    function GetName: String;
    procedure SetName(const Value: String);
    function GetFullName: String;
    procedure SetFullName(const Value: String);
    function GetOwner: IGitHubUser;
    procedure SetOwner(const Value: IGitHubUser);
    function GetPrivate: Boolean;
    procedure SetPrivate(const Value: Boolean);
    function GetHtmlURL: String;
    procedure SetHtmlURL(const Value: String);
    function GetDescription: String;
    procedure SetDescription(const Value: String);
    function GetFork: Boolean;
    procedure SetFork(const Value: Boolean);
    function GetURL: String;
    procedure SetURL(const Value: String);
    function GetArchiveURL: String;
    procedure SetArchiveURL(const Value: String);
    function GetAssigneesURL: String;
    procedure SetAssigneesURL(const Value: String);
    function GetBlobsURL: String;
    procedure SetBlobsURL(const Value: String);
    function GetBranchesURL: String;
    procedure SetBranchesURL(const Value: String);
    function GetCollaboratorsURL: String;
    procedure SetCollaboratorsURL(const Value: String);
    function GetCommentsURL: String;
    procedure SetCommentsURL(const Value: String);
    function GetCommitsURL: String;
    procedure SetCommitsURL(const Value: String);
    function GetCompareURL: String;
    procedure SetCompareURL(const Value: String);
    function GetContentsURL: String;
    procedure SetContentsURL(const Value: String);
    function GetContributorsURL: String;
    procedure SetContributorsURL(const Value: String);
    function GetDepoymentsURL: String;
    procedure SetDepoymentsURL(const Value: String);
    function GetDownloadsURL: String;
    procedure SetDownloadsURL(const Value: String);
    function GetEventsURL: String;
    procedure SetEventsURL(const Value: String);
    function GetForksURL: String;
    procedure SetForksURL(const Value: String);
    function GetGitCommitsURL: String;
    procedure SetGitCommitsURL(const Value: String);
    function GetGitRefsURL: String;
    procedure SetGitRefsURL(const Value: String);
    function GetGitTagsURL: String;
    procedure SetGitTagsURL(const Value: String);
    function GetGitURL: String;
    procedure SetGitURL(const Value: String);
    function GetIssueCommentURL: String;
    procedure SetIssueCommentURL(const Value: String);
    function GetIssueEventsURL: String;
    procedure SetIssueEventsURL(const Value: String);
    function GetIssuesURL: String;
    procedure SetIssuesURL(const Value: String);
    function GetKeysURL: String;
    procedure SetKeysURL(const Value: String);
    function GetLabelsURL: String;
    procedure SetLabelsURL(const Value: String);
    function GetLanguagesURL: String;
    procedure SetLanguagesURL(const Value: String);
    function GetMergesURL: String;
    procedure SetMergesURL(const Value: String);
    function GetMilestonesURL: String;
    procedure SetMilestonesURL(const Value: String);
    function GetNotificationsURL: String;
    procedure SetNotificationsURL(const Value: String);
    function GetPullsURL: String;
    procedure SetPullsURL(const Value: String);
    function GetReleasesURL: String;
    procedure SetReleasesURL(const Value: String);
    function GetSshURL: String;
    procedure SetSshURL(const Value: String);
    function GetStargazersURL: String;
    procedure SetStargazersURL(const Value: String);
    function GetStatusesURL: String;
    procedure SetStatusesURL(const Value: String);
    function GetSubscribersURL: String;
    procedure SetSubscribersURL(const Value: String);
    function GetSubscriptionURL: String;
    procedure SetSubscriptionURL(const Value: String);
    function GetTagsURL: String;
    procedure SetTagsURL(const Value: String);
    function GetTeamsURL: String;
    procedure SetTeamsURL(const Value: String);
    function GetTreesURL: String;
    procedure SetTreesURL(const Value: String);
    function GetCloneURL: String;
    procedure SetCloneURL(const Value: String);
    function GetMirrorURL: String;
    procedure SetMirrorURL(const Value: String);
    function GetHooksURL: String;
    procedure SetHooksURL(const Value: String);
    function GetSvnURL: String;
    procedure SetSvnURL(const Value: String);
    function GetHomepageURL: String;
    procedure SetHomepageURL(const Value: String);
    function GetLanguage: String;
    procedure SetLanguage(const Value: String);
    function GetForksCount: Integer;
    procedure SetForksCount(const Value: Integer);
    function GetStargazersCount: Integer;
    procedure SetStargazersCount(const Value: Integer);
    function GetWatchersCount: Integer;
    procedure SetWatchersCount(const Value: Integer);
    function GetSize: Int64;
    procedure SetSize(const Value: Int64);
    function GetDefaultBranch: String;
    procedure SetDefaultBranch(const Value: String);
    function GetOpenIssuesCount: Integer;
    procedure SetOpenIssuesCount(const Value: Integer);
    function GetTopics: IStringArray;
    procedure SetTopics(const Value: IStringArray);
    function GetHasIssues: Boolean;
    procedure SetHasIssues(const Value: Boolean);
    function GetHasProjects: Boolean;
    procedure SetHasProjects(const Value: Boolean);
    function GetHasWiki: Boolean;
    procedure SetHasWiki(const Value: Boolean);
    function GetHasPages: Boolean;
    procedure SetHasPages(const Value: Boolean);
    function GetHasDownloads: Boolean;
    procedure SetHasDownloads(const Value: Boolean);
    function GetArchived: Boolean;
    procedure SetArchived(const Value: Boolean);
    function GetDisabled: Boolean;
    procedure SetDisabled(const Value: Boolean);
    function GetPushedAt: TDateTime;
    procedure SetPushedAt(const Value: TDateTime);
    function GetCreatedAt: TDateTime;
    procedure SetCreatedAt(const Value: TDateTime);
    function GetUpdatedAt: TDateTime;
    procedure SetUpdatedAt(const Value: TDateTime);
    function GetPermissions: IGitHubPermissions;
    procedure SetPermissions(const Value: IGitHubPermissions);
    function GetSubscribersCount: Integer;
    procedure SetSubscribersCount(const Value: Integer);
    function GetNetworkCount: Integer;
    procedure SetNetworkCount(const Value: Integer);
    function GetLicense: IGitHubLicense;
    procedure SetLicense(const Value: IGitHubLicense);

    property ID: Integer read GetID write SetID;
    property NodeID: String read GetNodeID write SetNodeID;
    property Name: String read GetName write SetName;
    property FullName: String read GetFullName write SetFullName;
    property Owner: IGitHubUser read GetOwner write SetOwner;
    property &Private: Boolean read GetPrivate write SetPrivate;
    property HtmlURL: String read GetHtmlURL write SetHtmlURL;
    property Description: String read GetDescription write SetDescription;
    property Fork: Boolean read GetFork write SetFork;
    property URL: String read GetURL write SetURL;
    property ArchiveURL: String read GetArchiveURL write SetArchiveURL;
    property AssigneesURL: String read GetAssigneesURL write SetAssigneesURL;
    property BlobsURL: String read GetBlobsURL write SetBlobsURL;
    property BranchesURL: String read GetBranchesURL write SetBranchesURL;
    property CollaboratorsURL: String read GetCollaboratorsURL write SetCollaboratorsURL;
    property CommentsURL: String read GetCommentsURL write SetCommentsURL;
    property CommitsURL: String read GetCommitsURL write SetCommitsURL;
    property CompareURL: String read GetCompareURL write SetCompareURL;
    property ContentsURL: String read GetContentsURL write SetContentsURL;
    property ContributorsURL: String read GetContributorsURL write SetContributorsURL;
    property DepoymentsURL: String read GetDepoymentsURL write SetDepoymentsURL;
    property DownloadsURL: String read GetDownloadsURL write SetDownloadsURL;
    property EventsURL: String read GetEventsURL write SetEventsURL;
    property ForksURL: String read GetForksURL write SetForksURL;
    property GitCommitsURL: String read GetGitCommitsURL write SetGitCommitsURL;
    property GitRefsURL: String read GetGitRefsURL write SetGitRefsURL;
    property GitTagsURL: String read GetGitTagsURL write SetGitTagsURL;
    property GitURL: String read GetGitURL write SetGitURL;
    property IssueCommentURL: String read GetIssueCommentURL write SetIssueCommentURL;
    property IssueEventsURL: String read GetIssueEventsURL write SetIssueEventsURL;
    property IssuesURL: String read GetIssuesURL write SetIssuesURL;
    property KeysURL: String read GetKeysURL write SetKeysURL;
    property LabelsURL: String read GetLabelsURL write SetLabelsURL;
    property LanguagesURL: String read GetLanguagesURL write SetLanguagesURL;
    property MergesURL: String read GetMergesURL write SetMergesURL;
    property MilestonesURL: String read GetMilestonesURL write SetMilestonesURL;
    property NotificationsURL: String read GetNotificationsURL write SetNotificationsURL;
    property PullsURL: String read GetPullsURL write SetPullsURL;
    property ReleasesURL: String read GetReleasesURL write SetReleasesURL;
    property SshURL: String read GetSshURL write SetSshURL;
    property StargazersURL: String read GetStargazersURL write SetStargazersURL;
    property StatusesURL: String read GetStatusesURL write SetStatusesURL;
    property SubscribersURL: String read GetSubscribersURL write SetSubscribersURL;
    property SubscriptionURL: String read GetSubscriptionURL write SetSubscriptionURL;
    property TagsURL: String read GetTagsURL write SetTagsURL;
    property TeamsURL: String read GetTeamsURL write SetTeamsURL;
    property TreesURL: String read GetTreesURL write SetTreesURL;
    property CloneURL: String read GetCloneURL write SetCloneURL;
    property MirrorURL: String read GetMirrorURL write SetMirrorURL;
    property HooksURL: String read GetHooksURL write SetHooksURL;
    property SvnURL: String read GetSvnURL write SetSvnURL;
    property HomepageURL: String read GetHomepageURL write SetHomepageURL;
    property Language: String read GetLanguage write SetLanguage;
    property ForksCount: Integer read GetForksCount write SetForksCount;
    property StargazersCount: Integer read GetStargazersCount write SetStargazersCount;
    property WatchersCount: Integer read GetWatchersCount write SetWatchersCount;
    property Size: Int64 read GetSize write SetSize;
    property DefaultBranch: String read GetDefaultBranch write SetDefaultBranch;
    property OpenIssuesCount: Integer read GetOpenIssuesCount write SetOpenIssuesCount;
    property Topics: IStringArray read GetTopics write SetTopics;
    property HasIssues: Boolean read GetHasIssues write SetHasIssues;
    property HasProjects: Boolean read GetHasProjects write SetHasProjects;
    property HasWiki: Boolean read GetHasWiki write SetHasWiki;
    property HasPages: Boolean read GetHasPages write SetHasPages;
    property HasDownloads: Boolean read GetHasDownloads write SetHasDownloads;
    property Archived: Boolean read GetArchived write SetArchived;
    property Disabled: Boolean read GetDisabled write SetDisabled;
    property PushedAt: TDateTime read GetPushedAt write SetPushedAt;
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
    property UpdatedAt: TDateTime read GetUpdatedAt write SetUpdatedAt;
    property Permissions: IGitHubPermissions read GetPermissions write SetPermissions;
    property SubscribersCount: Integer read GetSubscribersCount write SetSubscribersCount;
    property NetworkCount: Integer read GetNetworkCount write SetNetworkCount;
    property License: IGitHubLicense read GetLicense write SetLicense;
  end;

  //Done
  TGitHubRepos = class(TInterfacedObject, IGitHubRepos)
  private
    FItems: TList<IGitHubRepo>;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function Count: Integer;
    procedure Clear;
    procedure Add(ARepo: IGitHubRepo);
    procedure Delete(const Index: Integer);
    function GetRepo(const Index: Integer): IGitHubRepo;
    procedure SetRepo(const Index: Integer; ARepo: IGitHubRepo);
    property Repos[const Index: Integer]: IGitHubRepo read GetRepo write SetRepo;
  end;



implementation

{ TStringArray }

constructor TStringArray.Create;
begin
  FItems:= TStringList.Create;
end;

destructor TStringArray.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure TStringArray.Add(const Value: String);
begin
  FItems.Add(Value);
end;

procedure TStringArray.Clear;
begin
  FItems.Clear;
end;

function TStringArray.Count: Integer;
begin
  Result:= FItems.Count;
end;

procedure TStringArray.Delete(const Index: Integer);
begin
  FItems.Delete(Index);
end;

function TStringArray.GetItem(const Index: Integer): String;
begin
  Result:= FItems[Index];
end;

procedure TStringArray.SetItem(const Index: Integer; const Value: String);
begin
  FItems[Index]:= Value;
end;

{ TGitHubUser }

constructor TGitHubUser.Create;
begin

end;

destructor TGitHubUser.Destroy;
begin

  inherited;
end;

function TGitHubUser.GetAvatarURL: String;
begin
  Result:= FAvatarURL;
end;

function TGitHubUser.GetEventsURL: String;
begin
  Result:= FEventsURL;
end;

function TGitHubUser.GetFollowersURL: String;
begin
  Result:= FFollowersURL;
end;

function TGitHubUser.GetFollowingURL: String;
begin
  Result:= FFollowingURL;
end;

function TGitHubUser.GetGistsURL: String;
begin
  Result:= FGistsURL;
end;

function TGitHubUser.GetGravatarID: String;
begin
  Result:= FGravatarID;
end;

function TGitHubUser.GetHtmlURL: String;
begin
  Result:= HtmlURL;
end;

function TGitHubUser.GetID: Integer;
begin
  Result:= FID;
end;

function TGitHubUser.GetLogin: String;
begin
  Result:= FLogin;
end;

function TGitHubUser.GetNodeID: String;
begin
  Result:= FNodeID;
end;

function TGitHubUser.GetOrganizationsURL: String;
begin
  Result:= FOrganizationsURL;
end;

function TGitHubUser.GetReceivedEventsURL: String;
begin
  Result:= FReceivedEventsURL;
end;

function TGitHubUser.GetReposURL: String;
begin
  Result:= FReposURL;
end;

function TGitHubUser.GetSiteAdmin: Boolean;
begin
  Result:= FSiteAdmin;
end;

function TGitHubUser.GetStarredURL: String;
begin
  Result:= FStarredURL;
end;

function TGitHubUser.GetSubscriptionsURL: String;
begin
  Result:= FSubscriptionsURL;
end;

function TGitHubUser.GetURL: String;
begin
  Result:= FURL;
end;

function TGitHubUser.GetUserType: String;
begin
  Result:= FUserType;
end;

procedure TGitHubUser.SetAvatarURL(const Value: String);
begin
  FAvatarURL:= Value;
end;

procedure TGitHubUser.SetEventsURL(const Value: String);
begin
  FEventsURL:= Value;
end;

procedure TGitHubUser.SetFollowersURL(const Value: String);
begin
  FFollowersURL:= Value;
end;

procedure TGitHubUser.SetFollowingURL(const Value: String);
begin
  FFollowingURL:= Value;
end;

procedure TGitHubUser.SetGistsURL(const Value: String);
begin
  FGistsURL:= Value;
end;

procedure TGitHubUser.SetGravatarID(const Value: String);
begin
  FGravatarID:= Value;
end;

procedure TGitHubUser.SetHtmlURL(const Value: String);
begin
  FHtmlURL:= Value;
end;

procedure TGitHubUser.SetID(const Value: Integer);
begin
  FID:= Value;
end;

procedure TGitHubUser.SetLogin(const Value: String);
begin
  FLogin:= Value;
end;

procedure TGitHubUser.SetNodeID(const Value: String);
begin
  FNodeID:= Value;
end;

procedure TGitHubUser.SetOrganizationsURL(const Value: String);
begin
  FOrganizationsURL:= Value;
end;

procedure TGitHubUser.SetReceivedEventsURL(const Value: String);
begin
  FReceivedEventsURL:= Value;
end;

procedure TGitHubUser.SetReposURL(const Value: String);
begin
  FReposURL:= Value;
end;

procedure TGitHubUser.SetSiteAdmin(const Value: Boolean);
begin
  FSiteAdmin:= Value;
end;

procedure TGitHubUser.SetStarredURL(const Value: String);
begin
  FStarredURL:= Value;
end;

procedure TGitHubUser.SetSubscriptionsURL(const Value: String);
begin
  FSubscriptionsURL:= Value;
end;

procedure TGitHubUser.SetURL(const Value: String);
begin
  FURL:= Value;
end;

procedure TGitHubUser.SetUserType(const Value: String);
begin
  FUserType:= Value;
end;

{ TGitHubLicense }

constructor TGitHubLicense.Create;
begin

end;

destructor TGitHubLicense.Destroy;
begin

  inherited;
end;

function TGitHubLicense.GetKey: String;
begin
  Result:= FKey;
end;

function TGitHubLicense.GetName: String;
begin
  Result:= FName;
end;

function TGitHubLicense.GetNodeID: String;
begin
  Result:= FNodeID;
end;

function TGitHubLicense.GetSpdxID: String;
begin
  Result:= FSpdxID;
end;

function TGitHubLicense.GetURL: String;
begin
  Result:= FURL;
end;

procedure TGitHubLicense.SetKey(const Value: String);
begin
  FKey:= Value;
end;

procedure TGitHubLicense.SetName(const Value: String);
begin
  FName:= Value;
end;

procedure TGitHubLicense.SetNodeID(const Value: String);
begin
  FNodeID:= Value;
end;

procedure TGitHubLicense.SetSpdxID(const Value: String);
begin
  FSpdxID:= Value;
end;

procedure TGitHubLicense.SetURL(const Value: String);
begin
  FURL:= Value;
end;

{ TGitHubPermissions }

constructor TGitHubPermissions.Create;
begin

end;

destructor TGitHubPermissions.Destroy;
begin

  inherited;
end;

function TGitHubPermissions.GetAdmin: Boolean;
begin
  Result:= FAdmin;
end;

function TGitHubPermissions.GetPull: Boolean;
begin
  Result:= FPull;
end;

function TGitHubPermissions.GetPush: Boolean;
begin
  Result:= FPush;
end;

procedure TGitHubPermissions.SetAdmin(const Value: Boolean);
begin
  FAdmin:= Value;
end;

procedure TGitHubPermissions.SetPull(const Value: Boolean);
begin
  FPull:= Value;
end;

procedure TGitHubPermissions.SetPush(const Value: Boolean);
begin
  FPush:= Value;
end;

{ TGitHubRepo }

constructor TGitHubRepo.Create;
begin
  FOwner:= TGitHubUser.Create;
  FOwner._AddRef;

  FPermissions:= TGitHubPermissions.Create;
  FPermissions._AddRef;

  FTopics:= TStringArray.Create;
  FTopics._AddRef;

  FLicense:= TGitHubLicense.Create;
  FLicense._AddRef;
end;

destructor TGitHubRepo.Destroy;
begin
  FLicense._Release;
  FLicense:= nil;

  FTopics._Release;
  FTopics:= nil;

  FPermissions._Release;
  FPermissions:= nil;

  FOwner._Release;
  FOwner:= nil;

  inherited;
end;

function TGitHubRepo.GetArchived: Boolean;
begin
  Result:= FArchived;
end;

function TGitHubRepo.GetArchiveURL: String;
begin
  Result:= FArchiveURL;
end;

function TGitHubRepo.GetAssigneesURL: String;
begin
  Result:= FAssigneesURL;
end;

function TGitHubRepo.GetBlobsURL: String;
begin
  Result:= FBlobsURL;
end;

function TGitHubRepo.GetBranchesURL: String;
begin
  Result:= FBranchesURL;
end;

function TGitHubRepo.GetCloneURL: String;
begin
  Result:= FCloneURL;
end;

function TGitHubRepo.GetCollaboratorsURL: String;
begin
  Result:= FCollaboratorsURL;
end;

function TGitHubRepo.GetCommentsURL: String;
begin
  Result:= FCommentsURL;
end;

function TGitHubRepo.GetCommitsURL: String;
begin
  Result:= FCommitsURL;
end;

function TGitHubRepo.GetCompareURL: String;
begin
  Result:= FCompareURL;
end;

function TGitHubRepo.GetContentsURL: String;
begin
  Result:= FContentsURL;
end;

function TGitHubRepo.GetContributorsURL: String;
begin
  Result:= FContributorsURL;
end;

function TGitHubRepo.GetCreatedAt: TDateTime;
begin
  Result:= FCreatedAt;
end;

function TGitHubRepo.GetDefaultBranch: String;
begin
  Result:= FDefaultBranch;
end;

function TGitHubRepo.GetDepoymentsURL: String;
begin
  Result:= FDeploymentsURL;
end;

function TGitHubRepo.GetDescription: String;
begin
  Result:= FDescription;
end;

function TGitHubRepo.GetDisabled: Boolean;
begin
  Result:= FDisabled;
end;

function TGitHubRepo.GetDownloadsURL: String;
begin
  Result:= FDownloadsURL;
end;

function TGitHubRepo.GetEventsURL: String;
begin
  Result:= FEventsURL;
end;

function TGitHubRepo.GetFork: Boolean;
begin
  Result:= FFork;
end;

function TGitHubRepo.GetForksCount: Integer;
begin
  Result:= FForksCount;
end;

function TGitHubRepo.GetForksURL: String;
begin
  Result:= FForksURL;
end;

function TGitHubRepo.GetFullName: String;
begin
  Result:= FFullName;
end;

function TGitHubRepo.GetGitCommitsURL: String;
begin
  Result:= FGitCommitsURL;
end;

function TGitHubRepo.GetGitRefsURL: String;
begin
  Result:= FGitRefsURL;
end;

function TGitHubRepo.GetGitTagsURL: String;
begin
  Result:= FGitTagsURL;
end;

function TGitHubRepo.GetGitURL: String;
begin
  Result:= FGitURL;
end;

function TGitHubRepo.GetHasDownloads: Boolean;
begin
  Result:= FHasDownloads;
end;

function TGitHubRepo.GetHasIssues: Boolean;
begin
  Result:= FHasIssues;
end;

function TGitHubRepo.GetHasPages: Boolean;
begin
  Result:= FHasPages;
end;

function TGitHubRepo.GetHasProjects: Boolean;
begin
  Result:= FHasProjects;
end;

function TGitHubRepo.GetHasWiki: Boolean;
begin
  Result:= FHasWiki;
end;

function TGitHubRepo.GetHomepageURL: String;
begin
  Result:= FHomepageURL;
end;

function TGitHubRepo.GetHooksURL: String;
begin
  Result:= FHooksURL;
end;

function TGitHubRepo.GetHtmlURL: String;
begin
  Result:= FHtmlURL;
end;

function TGitHubRepo.GetID: Integer;
begin
  Result:= FID;
end;

function TGitHubRepo.GetIssueCommentURL: String;
begin
  Result:= FIssueCommentURL;
end;

function TGitHubRepo.GetIssueEventsURL: String;
begin
  Result:= FIssueEventsURL;
end;

function TGitHubRepo.GetIssuesURL: String;
begin
  Result:= FIssuesURL;
end;

function TGitHubRepo.GetKeysURL: String;
begin
  Result:= FKeysURL;
end;

function TGitHubRepo.GetLabelsURL: String;
begin
  Result:= FLabelsURL;
end;

function TGitHubRepo.GetLanguage: String;
begin
  Result:= FLanguage;
end;

function TGitHubRepo.GetLanguagesURL: String;
begin
  Result:= FLanguagesURL;
end;

function TGitHubRepo.GetLicense: IGitHubLicense;
begin
  Result:= FLicense;
end;

function TGitHubRepo.GetMergesURL: String;
begin
  Result:= FMergesURL;
end;

function TGitHubRepo.GetMilestonesURL: String;
begin
  Result:= FMilestonesURL;
end;

function TGitHubRepo.GetMirrorURL: String;
begin
  Result:= FMirrorURL;
end;

function TGitHubRepo.GetName: String;
begin
  Result:= FName;
end;

function TGitHubRepo.GetNetworkCount: Integer;
begin
  Result:= FNetworkCount;
end;

function TGitHubRepo.GetNodeID: String;
begin
  Result:= FNodeID;
end;

function TGitHubRepo.GetNotificationsURL: String;
begin
  Result:= FNotificationsURL;
end;

function TGitHubRepo.GetOpenIssuesCount: Integer;
begin
  Result:= FOpenIssuesCount;
end;

function TGitHubRepo.GetOwner: IGitHubUser;
begin
  Result:= FOwner;
end;

function TGitHubRepo.GetPermissions: IGitHubPermissions;
begin
  Result:= FPermissions;
end;

function TGitHubRepo.GetPrivate: Boolean;
begin
  Result:= FPrivate;
end;

function TGitHubRepo.GetPullsURL: String;
begin
  Result:= FPullsURL;
end;

function TGitHubRepo.GetPushedAt: TDateTime;
begin
  Result:= FPushedAt;
end;

function TGitHubRepo.GetReleasesURL: String;
begin
  Result:= FReleasesURL;
end;

function TGitHubRepo.GetSize: Int64;
begin
  Result:= FSize;
end;

function TGitHubRepo.GetSshURL: String;
begin
  Result:= FSshURL;
end;

function TGitHubRepo.GetStargazersCount: Integer;
begin
  Result:= FStargazersCount;
end;

function TGitHubRepo.GetStargazersURL: String;
begin
  Result:= FStargazersURL;
end;

function TGitHubRepo.GetStatusesURL: String;
begin
  Result:= FStatusesURL;
end;

function TGitHubRepo.GetSubscribersCount: Integer;
begin
  Result:= FSubscribersCount;
end;

function TGitHubRepo.GetSubscribersURL: String;
begin
  Result:= FSubscribersURL;
end;

function TGitHubRepo.GetSubscriptionURL: String;
begin
  Result:= FSubscriptionURL;
end;

function TGitHubRepo.GetSvnURL: String;
begin
  Result:= FSvnURL;
end;

function TGitHubRepo.GetTagsURL: String;
begin
  Result:= FTagsURL;
end;

function TGitHubRepo.GetTeamsURL: String;
begin
  Result:= FTeamsURL;
end;

function TGitHubRepo.GetTopics: IStringArray;
begin
  Result:= FTopics;
end;

function TGitHubRepo.GetTreesURL: String;
begin
  Result:= FTreesURL;
end;

function TGitHubRepo.GetUpdatedAt: TDateTime;
begin
  Result:= FUpdatedAt;
end;

function TGitHubRepo.GetURL: String;
begin
  Result:= FURL;
end;

function TGitHubRepo.GetWatchersCount: Integer;
begin
  Result:= FWatchersCount;
end;

procedure TGitHubRepo.SetArchived(const Value: Boolean);
begin
  FArchived:= Value;
end;

procedure TGitHubRepo.SetArchiveURL(const Value: String);
begin
  FArchiveURL:= Value;
end;

procedure TGitHubRepo.SetAssigneesURL(const Value: String);
begin
  FAssigneesURL:= Value;
end;

procedure TGitHubRepo.SetBlobsURL(const Value: String);
begin
  FBlobsURL:= Value;
end;

procedure TGitHubRepo.SetBranchesURL(const Value: String);
begin
  FBranchesURL:= Value;
end;

procedure TGitHubRepo.SetCloneURL(const Value: String);
begin
  FCloneURL:= Value;
end;

procedure TGitHubRepo.SetCollaboratorsURL(const Value: String);
begin
  FCollaboratorsURL:= Value;
end;

procedure TGitHubRepo.SetCommentsURL(const Value: String);
begin
  FCommentsURL:= Value;
end;

procedure TGitHubRepo.SetCommitsURL(const Value: String);
begin
  FCommitsURL:= Value;
end;

procedure TGitHubRepo.SetCompareURL(const Value: String);
begin
  FCompareURL:= Value;
end;

procedure TGitHubRepo.SetContentsURL(const Value: String);
begin
  FContentsURL:= Value;
end;

procedure TGitHubRepo.SetContributorsURL(const Value: String);
begin
  FContributorsURL:= Value;
end;

procedure TGitHubRepo.SetCreatedAt(const Value: TDateTime);
begin
  FCreatedAt:= Value;
end;

procedure TGitHubRepo.SetDefaultBranch(const Value: String);
begin
  FDefaultBranch:= Value;
end;

procedure TGitHubRepo.SetDepoymentsURL(const Value: String);
begin
  FDeploymentsURL:= Value;
end;

procedure TGitHubRepo.SetDescription(const Value: String);
begin
  FDescription:= Value;
end;

procedure TGitHubRepo.SetDisabled(const Value: Boolean);
begin
  FDisabled:= Value;
end;

procedure TGitHubRepo.SetDownloadsURL(const Value: String);
begin
  FDownloadsURL:= Value;
end;

procedure TGitHubRepo.SetEventsURL(const Value: String);
begin
  FEventsURL:= Value;
end;

procedure TGitHubRepo.SetFork(const Value: Boolean);
begin
  FFork:= Value;
end;

procedure TGitHubRepo.SetForksCount(const Value: Integer);
begin
  FForksCount:= Value;
end;

procedure TGitHubRepo.SetForksURL(const Value: String);
begin
  FForksURL:= Value;
end;

procedure TGitHubRepo.SetFullName(const Value: String);
begin
  FFullName:= Value;
end;

procedure TGitHubRepo.SetGitCommitsURL(const Value: String);
begin
  FCommitsURL:= Value;
end;

procedure TGitHubRepo.SetGitRefsURL(const Value: String);
begin
  FGitRefsURL:= Value;
end;

procedure TGitHubRepo.SetGitTagsURL(const Value: String);
begin
  FGitTagsURL:= Value;
end;

procedure TGitHubRepo.SetGitURL(const Value: String);
begin
  FGitURL:= Value;
end;

procedure TGitHubRepo.SetHasDownloads(const Value: Boolean);
begin
  FHasDownloads:= Value;
end;

procedure TGitHubRepo.SetHasIssues(const Value: Boolean);
begin
  FHasIssues:= Value;
end;

procedure TGitHubRepo.SetHasPages(const Value: Boolean);
begin
  FHasPages:= Value;
end;

procedure TGitHubRepo.SetHasProjects(const Value: Boolean);
begin
  FHasProjects:= Value;
end;

procedure TGitHubRepo.SetHasWiki(const Value: Boolean);
begin
  FHasWiki:= Value;
end;

procedure TGitHubRepo.SetHomepageURL(const Value: String);
begin
  FHomepageURL:= Value;
end;

procedure TGitHubRepo.SetHooksURL(const Value: String);
begin
  FHooksURL:= Value;
end;

procedure TGitHubRepo.SetHtmlURL(const Value: String);
begin
  FHtmlURL:= Value;
end;

procedure TGitHubRepo.SetID(const Value: Integer);
begin
  FID:= Value;
end;

procedure TGitHubRepo.SetIssueCommentURL(const Value: String);
begin
  FIssueCommentURL:= Value;
end;

procedure TGitHubRepo.SetIssueEventsURL(const Value: String);
begin
  FIssueEventsURL:= Value;
end;

procedure TGitHubRepo.SetIssuesURL(const Value: String);
begin
  FIssuesURL:= Value;
end;

procedure TGitHubRepo.SetKeysURL(const Value: String);
begin
  FKeysURL:= Value;
end;

procedure TGitHubRepo.SetLabelsURL(const Value: String);
begin
  FLabelsURL:= Value;
end;

procedure TGitHubRepo.SetLanguage(const Value: String);
begin
  FLanguage:= Value;
end;

procedure TGitHubRepo.SetLanguagesURL(const Value: String);
begin
  FLanguagesURL:= Value;
end;

procedure TGitHubRepo.SetLicense(const Value: IGitHubLicense);
begin
  FLicense:= Value;
end;

procedure TGitHubRepo.SetMergesURL(const Value: String);
begin
  FMergesURL:= Value;
end;

procedure TGitHubRepo.SetMilestonesURL(const Value: String);
begin
  FMilestonesURL:= Value;
end;

procedure TGitHubRepo.SetMirrorURL(const Value: String);
begin
  FMirrorURL:= Value;
end;

procedure TGitHubRepo.SetName(const Value: String);
begin
  FName:= Value;
end;

procedure TGitHubRepo.SetNetworkCount(const Value: Integer);
begin
  FNetworkCount:= Value;
end;

procedure TGitHubRepo.SetNodeID(const Value: String);
begin
  FNodeID:= Value;
end;

procedure TGitHubRepo.SetNotificationsURL(const Value: String);
begin
  FNotificationsURL:= Value;
end;

procedure TGitHubRepo.SetOpenIssuesCount(const Value: Integer);
begin
  FOpenIssuesCount:= Value;
end;

procedure TGitHubRepo.SetOwner(const Value: IGitHubUser);
begin
  FOwner:= Value;
end;

procedure TGitHubRepo.SetPermissions(const Value: IGitHubPermissions);
begin
  FPermissions:= Value;
end;

procedure TGitHubRepo.SetPrivate(const Value: Boolean);
begin
  FPrivate:= Value;
end;

procedure TGitHubRepo.SetPullsURL(const Value: String);
begin
  FPullsURL:= Value;
end;

procedure TGitHubRepo.SetPushedAt(const Value: TDateTime);
begin
  FPushedAt:= Value;
end;

procedure TGitHubRepo.SetReleasesURL(const Value: String);
begin
  FReleasesURL:= Value;
end;

procedure TGitHubRepo.SetSize(const Value: Int64);
begin
  FSize:= Value;
end;

procedure TGitHubRepo.SetSshURL(const Value: String);
begin
  FSshURL:= Value;
end;

procedure TGitHubRepo.SetStargazersCount(const Value: Integer);
begin
  FStargazersCount:= Value;
end;

procedure TGitHubRepo.SetStargazersURL(const Value: String);
begin
  FStargazersURL:= Value;
end;

procedure TGitHubRepo.SetStatusesURL(const Value: String);
begin
  FStatusesURL:= Value;
end;

procedure TGitHubRepo.SetSubscribersCount(const Value: Integer);
begin
  FSubscribersCount:= Value;
end;

procedure TGitHubRepo.SetSubscribersURL(const Value: String);
begin
  FSubscribersURL:= Value;
end;

procedure TGitHubRepo.SetSubscriptionURL(const Value: String);
begin
  FSubscriptionURL:= Value;
end;

procedure TGitHubRepo.SetSvnURL(const Value: String);
begin
  FSvnURL:= Value;
end;

procedure TGitHubRepo.SetTagsURL(const Value: String);
begin
  FTagsURL:= Value;
end;

procedure TGitHubRepo.SetTeamsURL(const Value: String);
begin
  FTeamsURL:= Value;
end;

procedure TGitHubRepo.SetTopics(const Value: IStringArray);
begin
  FTopics:= Value;
end;

procedure TGitHubRepo.SetTreesURL(const Value: String);
begin
  FTreesURL:= Value;
end;

procedure TGitHubRepo.SetUpdatedAt(const Value: TDateTime);
begin
  FUpdatedAt:= Value;
end;

procedure TGitHubRepo.SetURL(const Value: String);
begin
  FURL:= Value;
end;

procedure TGitHubRepo.SetWatchersCount(const Value: Integer);
begin
  FWatchersCount:= Value;
end;

{ TGitHubRepos }

constructor TGitHubRepos.Create;
begin
  FItems:= TList<IGitHubRepo>.Create;
end;

destructor TGitHubRepos.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

procedure TGitHubRepos.Add(ARepo: IGitHubRepo);
begin
  ARepo._AddRef;
  FItems.Add(ARepo);
end;

procedure TGitHubRepos.Clear;
begin
  while FItems.Count > 0 do
    Delete(0);
end;

function TGitHubRepos.Count: Integer;
begin
  Result:= FItems.Count;
end;

procedure TGitHubRepos.Delete(const Index: Integer);
begin
  IGitHubRepo(FItems[Index])._Release;
  FItems.Delete(Index);
end;

function TGitHubRepos.GetRepo(const Index: Integer): IGitHubRepo;
begin
  Result:= IGitHubRepo(FItems[Index]);
end;

procedure TGitHubRepos.SetRepo(const Index: Integer; ARepo: IGitHubRepo);
begin
  FItems[Index]:= ARepo;
end;

end.
