object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 332
  Width = 498
  object GitHub: TGitHub
    Left = 202
    Top = 96
  end
  object Repos: TGitHubRepoList
    AccountType = gaUser
    AutoPages = False
    GitHub = GitHub
    PageSize = 100
    Left = 258
    Top = 96
  end
end
