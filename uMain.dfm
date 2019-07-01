object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'GitHub Repository Backup'
  ClientHeight = 473
  ClientWidth = 990
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Stat: TStatusBar
    Left = 0
    Top = 454
    Width = 990
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
    ExplicitTop = 470
    ExplicitWidth = 1012
  end
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 990
    Height = 394
    ActivePage = tabRepositories
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabHeight = 24
    TabOrder = 1
    OnChanging = PagesChanging
    ExplicitWidth = 1029
    ExplicitHeight = 481
    object tabSetup: TTabSheet
      Caption = '   Setup   '
      ExplicitWidth = 1004
      ExplicitHeight = 383
      object Panel2: TPanel
        Left = 3
        Top = 16
        Width = 382
        Height = 193
        TabOrder = 0
        DesignSize = (
          382
          193)
        object Label1: TLabel
          Left = 8
          Top = 1
          Width = 81
          Height = 14
          Caption = 'Account Name'
        end
        object Label2: TLabel
          Left = 8
          Top = 57
          Width = 76
          Height = 14
          Caption = 'Access Token'
        end
        object Label3: TLabel
          Left = 8
          Top = 113
          Width = 92
          Height = 14
          Caption = 'Backup Directory'
        end
        object txtUser: TEdit
          Left = 8
          Top = 20
          Width = 258
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object txtToken: TEdit
          Left = 8
          Top = 76
          Width = 362
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
        object cboUserType: TComboBox
          Left = 272
          Top = 20
          Width = 98
          Height = 22
          Cursor = crHandPoint
          Style = csDropDownList
          Anchors = [akTop, akRight]
          ItemIndex = 0
          TabOrder = 1
          Text = 'User'
          Items.Strings = (
            'User'
            'Organization')
        end
        object txtBackupDir: TEdit
          Left = 8
          Top = 132
          Width = 335
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
        end
        object btnBrowseDir: TBitBtn
          Left = 349
          Top = 132
          Width = 26
          Height = 21
          Cursor = crHandPoint
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 4
          OnClick = btnBrowseDirClick
        end
      end
    end
    object tabRepositories: TTabSheet
      Caption = '   Repositories   '
      ImageIndex = 1
      ExplicitWidth = 1021
      ExplicitHeight = 384
      DesignSize = (
        982
        360)
      object spErrorLog: TSplitter
        Left = 0
        Top = 228
        Width = 982
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ExplicitTop = 317
        ExplicitWidth = 1021
      end
      object pRepoTop: TPanel
        Left = 0
        Top = 0
        Width = 982
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 1004
        object Prog: TProgressBar
          AlignWithMargins = True
          Left = 557
          Top = 3
          Width = 391
          Height = 23
          Align = alClient
          TabOrder = 4
          Visible = False
          ExplicitWidth = 413
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
          Width = 93
          Height = 23
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'List Repos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 16754011
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          StyleElements = [seClient, seBorder]
          OnClick = btnListReposClick
        end
        object btnDownload: TButton
          AlignWithMargins = True
          Left = 311
          Top = 3
          Width = 159
          Height = 23
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'Download'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clLime
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          StyleElements = [seClient, seBorder]
          OnClick = btnDownloadClick
        end
        object btnCancel: TButton
          AlignWithMargins = True
          Left = 476
          Top = 3
          Width = 75
          Height = 23
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'Cancel'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          StyleElements = [seClient, seBorder]
          OnClick = btnCancelClick
        end
        object btnCols: TButton
          AlignWithMargins = True
          Left = 954
          Top = 3
          Width = 25
          Height = 23
          Cursor = crHandPoint
          Align = alRight
          Caption = '...'
          Enabled = False
          TabOrder = 5
          Visible = False
          OnClick = btnColsClick
          ExplicitLeft = 976
        end
      end
      object lstRepos: TListView
        Left = 0
        Top = 29
        Width = 982
        Height = 204
        Align = alTop
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = '      Repository Name'
            Width = 200
          end
          item
            Caption = 'Default Branch'
            Width = 100
          end
          item
            Caption = 'Visibility'
            Width = 55
          end
          item
            Caption = 'Language'
            Width = 70
          end
          item
            Caption = 'Size'
            Width = 80
          end
          item
            Caption = 'Last Push'
            Width = 146
          end
          item
            Caption = 'Description'
            Width = 300
          end>
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnClick = lstReposClick
        OnItemChecked = lstReposItemChecked
        ExplicitWidth = 1021
      end
      object chkCheckAll: TCheckBox
        Left = 3
        Top = 33
        Width = 16
        Height = 17
        Cursor = crHandPoint
        TabOrder = 2
        OnClick = chkCheckAllClick
      end
      object pCols: TPanel
        Left = 843
        Top = 32
        Width = 136
        Height = 198
        Anchors = [akTop, akRight]
        TabOrder = 3
        Visible = False
        ExplicitLeft = 835
        object Label5: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 13
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Columns'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 56
          ExplicitTop = 56
          ExplicitWidth = 31
        end
        object lstCols: TCheckListBox
          AlignWithMargins = True
          Left = 4
          Top = 23
          Width = 128
          Height = 143
          Margins.Bottom = 0
          OnClickCheck = lstColsClickCheck
          Align = alClient
          ItemHeight = 14
          Items.Strings = (
            'Repository Name'
            'Default Branch'
            'Visibility'
            'Language'
            'Size'
            'Last Push'
            'Description')
          TabOrder = 0
          ExplicitHeight = 218
        end
        object btnColsDone: TButton
          AlignWithMargins = True
          Left = 4
          Top = 169
          Width = 128
          Height = 25
          Align = alBottom
          Caption = 'Done'
          TabOrder = 1
          OnClick = btnColsDoneClick
          ExplicitTop = 244
        end
      end
      object pErrorLog: TPanel
        Left = 0
        Top = 233
        Width = 982
        Height = 127
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 4
        ExplicitTop = 320
        ExplicitWidth = 1021
        object pErrorLogTitle: TPanel
          Left = 0
          Top = 0
          Width = 982
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 1
          ExplicitWidth = 1019
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
            Left = 957
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
            ExplicitLeft = 992
            ExplicitTop = 3
            ExplicitHeight = 16
          end
        end
        object txtErrorLog: TMemo
          Left = 0
          Top = 42
          Width = 982
          Height = 85
          Align = alBottom
          BorderStyle = bsNone
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 1
          WordWrap = False
          ExplicitLeft = 1
          ExplicitTop = 80
          ExplicitWidth = 1019
        end
      end
    end
    object tabListGridTest: TTabSheet
      Caption = 'List Grid Test'
      ImageIndex = 3
      ExplicitWidth = 1004
      ExplicitHeight = 383
    end
  end
  object tmrDisplay: TTimer
    Interval = 200
    OnTimer = tmrDisplayTimer
    Left = 100
    Top = 400
  end
  object Taskbar: TTaskbar
    TaskBarButtons = <>
    TabProperties = []
    ToolTip = 'GitHub Backup'
    Left = 172
    Top = 398
  end
  object dlgBrowseDir: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 36
    Top = 398
  end
end
