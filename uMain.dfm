object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'GitHub Repository Backup'
  ClientHeight = 416
  ClientWidth = 981
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MM
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object spErrorLog: TSplitter
    Left = 0
    Top = 392
    Width = 981
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsUpdate
    ExplicitTop = 317
    ExplicitWidth = 1021
  end
  object Stat: TStatusBar
    Left = 0
    Top = 397
    Width = 981
    Height = 19
    Panels = <
      item
        Text = '0 Repositories'
        Width = 120
      end
      item
        Text = 'Ready'
        Width = 150
      end
      item
        Width = 50
      end>
    ExplicitTop = 573
    ExplicitWidth = 1114
  end
  object pRepoTop: TPanel
    Left = 0
    Top = 0
    Width = 981
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 16
    ExplicitTop = -5
    ExplicitWidth = 1114
    object Prog: TProgressBar
      AlignWithMargins = True
      Left = 540
      Top = 3
      Width = 438
      Height = 23
      Align = alClient
      TabOrder = 4
      Visible = False
      ExplicitWidth = 563
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 209
      Height = 29
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 31
        Height = 23
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Sort:'
        Layout = tlCenter
        ExplicitLeft = 167
        ExplicitTop = 0
      end
      object cboVisibility: TComboBox
        AlignWithMargins = True
        Left = 202
        Top = 3
        Width = 86
        Height = 22
        Cursor = crHandPoint
        Align = alLeft
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'All Visibility'
        Visible = False
        Items.Strings = (
          'All Visibility'
          'Public'
          'Private')
      end
      object cboType: TComboBox
        AlignWithMargins = True
        Left = 294
        Top = 3
        Width = 86
        Height = 22
        Cursor = crHandPoint
        Align = alLeft
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'All Types'
        Visible = False
        Items.Strings = (
          'All Types'
          'Owner'
          'Public'
          'Private'
          'Member')
      end
      object cboSort: TComboBox
        AlignWithMargins = True
        Left = 40
        Top = 3
        Width = 121
        Height = 22
        Cursor = crHandPoint
        Align = alLeft
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'Sort Name'
        OnClick = cboSortClick
        Items.Strings = (
          'Sort Name'
          'Sort Created'
          'Sort Updated'
          'Sort Pushed')
      end
      object btnSortDir: TButton
        AlignWithMargins = True
        Left = 164
        Top = 2
        Width = 32
        Height = 23
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 2
        Margins.Bottom = 4
        Align = alLeft
        Caption = 'A..Z'
        TabOrder = 3
        OnClick = btnSortDirClick
      end
    end
    object btnListRepos: TButton
      AlignWithMargins = True
      Left = 212
      Top = 3
      Width = 76
      Height = 23
      Cursor = crHandPoint
      Action = actRefresh
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16754011
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      StyleElements = [seClient, seBorder]
    end
    object btnDownload: TButton
      AlignWithMargins = True
      Left = 294
      Top = 3
      Width = 159
      Height = 23
      Cursor = crHandPoint
      Action = actDownloadRepos
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      StyleElements = [seClient, seBorder]
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 459
      Top = 3
      Width = 75
      Height = 23
      Cursor = crHandPoint
      Action = actCancelDownload
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      StyleElements = [seClient, seBorder]
    end
  end
  object lstRepos: TListView
    Left = 0
    Top = 29
    Width = 981
    Height = 84
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
    HotTrackStyles = [htHandPoint, htUnderlineHot]
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnClick = lstReposClick
    OnDblClick = lstReposDblClick
    OnItemChecked = lstReposItemChecked
    ExplicitWidth = 1010
  end
  object pErrorLog: TPanel
    Left = 0
    Top = 259
    Width = 981
    Height = 133
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 312
    ExplicitWidth = 1037
    object pErrorLogTitle: TPanel
      Left = 0
      Top = 0
      Width = 981
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 1106
      object lblErrorLogTitle: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 317
        Height = 18
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
        Left = 956
        Top = 2
        Width = 23
        Height = 20
        Cursor = crHandPoint
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        Caption = 'X'
        TabOrder = 0
        OnClick = btnCloseErrorLogClick
        ExplicitLeft = 1081
      end
    end
    object txtErrorLog: TMemo
      Left = 0
      Top = 56
      Width = 981
      Height = 77
      Align = alBottom
      BorderStyle = bsNone
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      WordWrap = False
      ExplicitWidth = 1037
    end
  end
  object chkCheckAll: TCheckBox
    Left = 3
    Top = 33
    Width = 16
    Height = 17
    Cursor = crHandPoint
    TabOrder = 4
    OnClick = chkCheckAllClick
  end
  object tmrDisplay: TTimer
    Interval = 200
    OnTimer = tmrDisplayTimer
    Left = 36
    Top = 126
  end
  object Taskbar: TTaskbar
    TaskBarButtons = <>
    TabProperties = []
    ToolTip = 'GitHub Backup'
    Left = 100
    Top = 126
  end
  object MM: TMainMenu
    Left = 144
    Top = 126
    object mRepositories: TMenuItem
      Caption = 'Repositories'
      object CheckAll1: TMenuItem
        Action = actCheckAll
      end
      object CheckNone1: TMenuItem
        Action = actCheckNone
      end
      object CheckSelected1: TMenuItem
        Action = actCheckSelected
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object DownloadCheckedRepos1: TMenuItem
        Action = actDownloadRepos
      end
      object Cancel1: TMenuItem
        Action = actCancelDownload
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actExit
      end
    end
    object mOptions: TMenuItem
      Caption = 'Options'
      object mSetup: TMenuItem
        Action = actSetup
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ConfigureColumns1: TMenuItem
        Action = actConfigCols
      end
    end
    object mView: TMenuItem
      Caption = 'View'
      object mRefresh: TMenuItem
        Action = actRefresh
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mSort: TMenuItem
        Caption = 'Sort'
        object mSortAsc: TMenuItem
          AutoCheck = True
          Caption = 'Sort Ascending'
          Checked = True
          RadioItem = True
          OnClick = mSortAscOrDescClick
        end
        object mSortDesc: TMenuItem
          AutoCheck = True
          Caption = 'Sort Descending'
          RadioItem = True
          OnClick = mSortAscOrDescClick
        end
        object N7: TMenuItem
          Caption = '-'
        end
      end
      object mColumns: TMenuItem
        Caption = 'Columns'
        Enabled = False
        object mColumnsConfig: TMenuItem
          Action = actConfigCols
        end
        object N2: TMenuItem
          Caption = '-'
        end
      end
    end
    object mHelp: TMenuItem
      Caption = 'Help'
    end
  end
  object Acts: TActionManager
    Images = Img16
    OnUpdate = ActsUpdate
    Left = 184
    Top = 126
    StyleName = 'Platform Default'
    object actSetup: TAction
      Category = 'Options'
      Caption = 'Setup'
      ShortCut = 16467
      OnExecute = actSetupExecute
    end
    object actRefresh: TAction
      Category = 'View'
      Caption = 'Refresh'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actConfigCols: TAction
      Category = 'View'
      Caption = 'Configure Columns'
      Enabled = False
      ShortCut = 16451
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
      OnExecute = actCancelDownloadExecute
    end
    object actSortAZ: TAction
      Category = 'View'
      Caption = 'A..Z'
      Hint = 'Sort Ascending'
    end
  end
  object Img16: TImageList
    Left = 256
    Top = 128
  end
end
