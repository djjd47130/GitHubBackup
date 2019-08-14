object frmMain: TfrmMain
  AlignWithMargins = True
  Left = 0
  Top = 0
  HelpContext = 1000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'JD GitHub Repository Backup'
  ClientHeight = 457
  ClientWidth = 974
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object spErrorLog: TSplitter
    Left = 0
    Top = 289
    Width = 974
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    ResizeStyle = rsUpdate
    ExplicitLeft = -8
    ExplicitTop = 284
    ExplicitWidth = 976
  end
  object Prog: TProgressBar
    Left = 0
    Top = 266
    Width = 974
    Height = 23
    HelpContext = 1008
    Align = alBottom
    TabOrder = 5
    Visible = False
  end
  object lstRepos: TListView
    Left = 0
    Top = 29
    Width = 974
    Height = 100
    HelpContext = 1006
    Align = alTop
    BorderStyle = bsNone
    Checkboxes = True
    Columns = <
      item
        Caption = '    Repository Name'
        Width = 180
      end
      item
        Caption = 'Default Branch'
        Width = 100
      end
      item
        Caption = 'Visibility'
        Width = 66
      end
      item
        Caption = 'Language'
        Width = 76
      end
      item
        Caption = 'Size'
        Width = 80
      end
      item
        Caption = 'Last Pushed'
        Width = 150
      end
      item
        Caption = 'Description'
        Width = 300
      end>
    HideSelection = False
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lstReposClick
    OnColumnClick = lstReposColumnClick
    OnDblClick = lstReposDblClick
    OnItemChecked = lstReposItemChecked
  end
  object Stat: TStatusBar
    Left = 0
    Top = 435
    Width = 974
    Height = 22
    Panels = <
      item
        Text = '0 Repositories'
        Width = 140
      end
      item
        Text = 'Ready'
        Width = 150
      end
      item
        Width = 50
      end>
    StyleElements = [seClient, seBorder]
  end
  object pRepoTop: TPanel
    Left = 0
    Top = 0
    Width = 974
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnListRepos: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 76
      Height = 23
      Cursor = crHandPoint
      Hint = 'Fetch list of repositories from GitHub'
      HelpContext = 1006
      Action = actRefresh
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16762519
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      StyleElements = [seClient, seBorder]
    end
    object btnDownload: TButton
      AlignWithMargins = True
      Left = 85
      Top = 3
      Width = 159
      Height = 23
      Cursor = crHandPoint
      Hint = 'Initiate bulk download'
      HelpContext = 1008
      Action = actDownloadRepos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      StyleElements = [seClient, seBorder]
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 250
      Top = 3
      Width = 75
      Height = 23
      Cursor = crHandPoint
      Hint = 'Cancel the download'
      HelpContext = 1008
      Action = actCancelDownload
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      StyleElements = [seClient, seBorder]
    end
    object Panel1: TPanel
      Left = 328
      Top = 0
      Width = 217
      Height = 29
      BevelOuter = bvNone
      TabOrder = 3
      object btnClearFilter: TButton
        AlignWithMargins = True
        Left = 189
        Top = 4
        Width = 25
        Height = 21
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 4
        Margins.Bottom = 4
        Action = actClearFilter
        Align = alRight
        ImageAlignment = iaCenter
        Images = DM.Img16
        TabOrder = 0
      end
      object txtFilter: TEdit
        AlignWithMargins = True
        Left = 49
        Top = 4
        Width = 140
        Height = 21
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alClient
        TabOrder = 1
        OnChange = txtFilterChange
        ExplicitHeight = 22
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 40
        Height = 23
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Filter'
        TabOrder = 2
      end
    end
    object pSort: TPanel
      Left = 781
      Top = 0
      Width = 193
      Height = 29
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 4
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 31
        Height = 26
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Sort:'
        Layout = tlCenter
        ExplicitLeft = 11
        ExplicitTop = 6
        ExplicitHeight = 23
      end
      object btnSortDir: TButton
        AlignWithMargins = True
        Left = 158
        Top = 2
        Width = 32
        Height = 23
        Cursor = crHandPoint
        Hint = 'Toggle sort between ascending / descending'
        HelpContext = 1006
        Margins.Left = 0
        Margins.Top = 2
        Margins.Bottom = 4
        Align = alRight
        Caption = 'A..Z'
        TabOrder = 0
        OnClick = btnSortDirClick
      end
      object cboSort: TComboBox
        AlignWithMargins = True
        Left = 40
        Top = 3
        Width = 115
        Height = 22
        Cursor = crHandPoint
        Hint = 'Change which column to sort by'
        HelpContext = 1006
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'Sort Name'
        OnClick = cboSortClick
        Items.Strings = (
          'Sort Name'
          'Sort Created'
          'Sort Updated'
          'Sort Pushed')
      end
    end
  end
  object pErrorLog: TPanel
    Left = 0
    Top = 294
    Width = 974
    Height = 141
    HelpContext = 1008
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pErrorLogTitle: TPanel
      Left = 0
      Top = 0
      Width = 974
      Height = 24
      HelpContext = 1008
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblErrorLogTitle: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 317
        Height = 21
        HelpContext = 1008
        Align = alLeft
        AutoSize = False
        Caption = 'Error Log'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitHeight = 16
      end
      object btnCloseErrorLog: TButton
        AlignWithMargins = True
        Left = 949
        Top = 2
        Width = 23
        Height = 20
        Cursor = crHandPoint
        Hint = 'Close error log'
        HelpContext = 1008
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        Caption = 'X'
        TabOrder = 0
        OnClick = btnCloseErrorLogClick
      end
    end
    object txtErrorLog: TMemo
      Left = 0
      Top = 42
      Width = 974
      Height = 99
      HelpContext = 1008
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
  end
  object chkCheckAll: TCheckBox
    Left = 3
    Top = 33
    Width = 16
    Height = 17
    Cursor = crHandPoint
    TabOrder = 3
    OnClick = chkCheckAllClick
  end
  object tmrDisplay: TTimer
    Interval = 200
    OnTimer = tmrDisplayTimer
    Left = 20
    Top = 142
  end
  object Acts: TActionManager
    LargeImages = DM.Img32
    Images = DM.Img24
    OnUpdate = ActsUpdate
    Left = 72
    Top = 142
    StyleName = 'Platform Default'
    object actSetup: TAction
      Category = 'Options'
      Caption = 'Setup'
      ImageIndex = 0
      ShortCut = 16467
      OnExecute = actSetupExecute
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = 'Refresh'
      ImageIndex = 1
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actConfigCols: TAction
      Category = 'View'
      Caption = 'Configure Columns'
      Enabled = False
      ImageIndex = 2
      OnExecute = actConfigColsExecute
    end
    object actCheckAll: TAction
      Category = 'Repositories'
      Caption = 'Check All'
      ShortCut = 16449
      OnExecute = actCheckAllExecute
    end
    object actCheckNone: TAction
      Category = 'Repositories'
      Caption = 'Check None'
      ShortCut = 16462
      OnExecute = actCheckNoneExecute
    end
    object actCheckSelected: TAction
      Category = 'Repositories'
      Caption = 'Check Selected'
      ShortCut = 16460
      OnExecute = actCheckSelectedExecute
    end
    object actDownloadRepos: TAction
      Category = 'Repositories'
      Caption = 'Download'
      Enabled = False
      ImageIndex = 6
      ShortCut = 16452
      OnExecute = actDownloadReposExecute
    end
    object actExit: TAction
      Category = 'Repositories'
      Caption = 'Exit'
      OnExecute = actExitExecute
    end
    object actCancelDownload: TAction
      Category = 'Repositories'
      Caption = 'Cancel'
      Enabled = False
      ImageIndex = 7
      ShortCut = 27
      OnExecute = actCancelDownloadExecute
    end
    object actSortAZ: TAction
      Category = 'View'
      Caption = 'A..Z'
      Hint = 'Sort Ascending'
    end
    object actAbout: TAction
      Category = 'Help'
      Caption = 'About'
      ImageIndex = 11
      ShortCut = 16450
      OnExecute = actAboutExecute
    end
    object actHelpContents: TAction
      Category = 'Help'
      Caption = 'Contents'
      ImageIndex = 8
      OnExecute = actHelpContentsExecute
    end
    object actMenuRepos: TAction
      Category = 'Menus'
      Caption = 'Repositories'
      ShortCut = 32850
      OnExecute = MenuReposClick
    end
    object actMenuOptions: TAction
      Category = 'Menus'
      Caption = 'Options'
      ShortCut = 32847
      OnExecute = MenuOptionsClick
    end
    object actMenuView: TAction
      Category = 'Menus'
      Caption = 'View'
      ShortCut = 32854
      OnExecute = MenuViewClick
    end
    object actMenuHelp: TAction
      Category = 'Menus'
      Caption = 'Help'
      ShortCut = 32840
      OnExecute = MenuHelpClick
    end
    object actFind: TAction
      Category = 'Repositories'
      Caption = 'Find'
      Hint = 'Filter Repositories'
      ImageIndex = 9
      ShortCut = 16454
      OnExecute = actFindExecute
    end
    object actClearFilter: TAction
      Category = 'Repositories'
      Hint = 'Clear Filter'
      ImageIndex = 10
      OnExecute = actClearFilterExecute
    end
    object actSetupProfiles: TAction
      Category = 'Options'
      Caption = 'Setup Profiles...'
      ImageIndex = 12
      OnExecute = actSetupProfilesExecute
    end
  end
  object AppEvents: TApplicationEvents
    OnHelp = AppEventsHelp
    Left = 120
    Top = 142
  end
  object mRepos: TPopupMenu
    Images = DM.Img24
    MenuAnimation = [maTopToBottom]
    Left = 240
    Top = 144
    object CheckAll3: TMenuItem
      Action = actCheckAll
    end
    object CheckNone3: TMenuItem
      Action = actCheckNone
    end
    object CheckSelected3: TMenuItem
      Action = actCheckSelected
    end
    object MenuItem17: TMenuItem
      Caption = '-'
    end
    object MenuItem18: TMenuItem
      Action = actDownloadRepos
    end
    object Cancel3: TMenuItem
      Action = actCancelDownload
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Exit3: TMenuItem
      Action = actExit
    end
  end
  object mOptions: TPopupMenu
    Images = DM.Img24
    MenuAnimation = [maTopToBottom]
    Left = 288
    Top = 144
    object mProfiles: TMenuItem
      Caption = 'Profiles'
      object Setup1: TMenuItem
        Action = actSetupProfiles
      end
      object N2: TMenuItem
        Caption = '-'
      end
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MenuItem20: TMenuItem
      Action = actSetup
    end
    object ConfigureColumns1: TMenuItem
      Action = actConfigCols
    end
  end
  object mView: TPopupMenu
    Images = DM.Img24
    MenuAnimation = [maTopToBottom]
    Left = 336
    Top = 144
    object MenuItem38: TMenuItem
      Action = actRefresh
    end
    object mSort: TMenuItem
      Caption = 'Sort'
      object mSortAsc: TMenuItem
        AutoCheck = True
        Caption = 'Ascending'
        Checked = True
        RadioItem = True
        OnClick = mSortAscOrDescClick
      end
      object mSortDesc: TMenuItem
        AutoCheck = True
        Caption = 'Descending'
        RadioItem = True
        OnClick = mSortAscOrDescClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
    end
  end
  object mHelp: TPopupMenu
    Images = DM.Img24
    MenuAnimation = [maTopToBottom]
    Left = 384
    Top = 144
    object MenuItem56: TMenuItem
      Action = actHelpContents
    end
    object About1: TMenuItem
      Action = actAbout
    end
  end
  object tmrFilter: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrFilterTimer
    Left = 240
    Top = 200
  end
end
