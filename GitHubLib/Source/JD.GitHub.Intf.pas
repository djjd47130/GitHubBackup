unit JD.GitHub.Intf;

interface

type
  IStringArray = interface;
  IGitHubUser = interface;
  IGitHubLicense = interface;
  IGitHubPermissions = interface;
  IGitHubRepo = interface;
  IGitHubRepos = interface;

  //Done
  IStringArray = interface
    ['{4BFD3E22-EF0E-49F5-9599-0C26852B3A76}']
    procedure Add(const Value: String);
    procedure Delete(const Index: Integer);
    procedure Clear;
    function Count: Integer;
    function GetItem(const Index: Integer): String;
    procedure SetItem(const Index: Integer; const Value: String);
  end;

  //Done
  IGitHubUser = interface
    ['{D40786A7-71A5-4C85-A4F6-75B257D6F890}']
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
  IGitHubLicense = interface
    ['{FA0D620F-EF4E-45D7-8EB6-2AD0A299B9BC}']
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
  IGitHubPermissions = interface
    ['{345D518B-67A5-4F68-82FE-F499F40E7CE3}']
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
  IGitHubRepo = interface
    ['{8FE1EB11-14F8-45BA-8D40-1B482DE6F67D}']
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
  IGitHubRepos = interface
    ['{2394A869-B12C-43F7-8F3F-8BB45670E467}']
    function Count: Integer;
    procedure Clear;
    procedure Add(ARepo: IGitHubRepo);
    procedure Delete(const Index: Integer);
    function GetRepo(const Index: Integer): IGitHubRepo;
    procedure SetRepo(const Index: Integer; ARepo: IGitHubRepo);
    property Repos[const Index: Integer]: IGitHubRepo read GetRepo write SetRepo;
  end;


implementation

end.
