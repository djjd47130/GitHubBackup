object frmSetup: TfrmSetup
  Left = 0
  Top = 0
  HelpContext = 1001
  BorderStyle = bsDialog
  Caption = 'Setup'
  ClientHeight = 399
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 609
    Height = 340
    HelpContext = 1001
    ActivePage = tabProfiles
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabHeight = 24
    TabOrder = 0
    object tabAccounts: TTabSheet
      HelpContext = 1002
      Caption = '   Accounts   '
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbAccountAccess: TGroupBox
        Left = 0
        Top = 0
        Width = 601
        Height = 137
        HelpContext = 1002
        Align = alTop
        Caption = 'Account Access'
        TabOrder = 0
        object Label4: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 18
          Width = 577
          Height = 71
          Margins.Left = 10
          Margins.Right = 10
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 
            'You must generate a "Personal Access Token" on your GitHub accou' +
            'nt'#39's developer settings in order to access private repos.  Enter' +
            ' that unique token into the "Access Token" field below. This app' +
            'lication will provide access to any repositories which your acco' +
            'unt is authorized access to.  No token will give you public acce' +
            'ss.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          ExplicitWidth = 499
        end
        object lblAccessToken: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 92
          Width = 591
          Height = 13
          Align = alTop
          AutoSize = False
          Caption = 'Access Token'
          ExplicitLeft = 35
          ExplicitTop = 134
          ExplicitWidth = 608
        end
        object txtAccessToken: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 108
          Width = 591
          Height = 21
          HelpContext = 1002
          Align = alTop
          TabOrder = 0
        end
      end
    end
    object tabProfiles: TTabSheet
      HelpContext = 1003
      Caption = '   Profiles   '
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 258
        Width = 601
        Height = 48
        HelpContext = 1003
        Align = alBottom
        Caption = 'Pagination'
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 52
          Height = 20
          Margins.Bottom = 8
          Align = alLeft
          AutoSize = False
          Caption = 'Page Size:'
          Layout = tlCenter
          ExplicitTop = 20
        end
        object txtPageSize: TEdit
          AlignWithMargins = True
          Left = 63
          Top = 18
          Width = 42
          Height = 20
          Hint = 'Number of pages to fetch at a time when refreshing'
          HelpContext = 1003
          Margins.Bottom = 8
          Align = alLeft
          Enabled = False
          TabOrder = 0
          Text = '100'
          ExplicitHeight = 21
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 601
        Height = 258
        Align = alClient
        Caption = 'Setup Repository Profiles'
        TabOrder = 1
        object lstProfiles: TListView
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 217
          Height = 235
          Align = alLeft
          BorderStyle = bsNone
          Columns = <
            item
              Caption = 'Title'
              Width = 100
            end
            item
              Caption = 'Type'
              Width = 85
            end>
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnSelectItem = lstProfilesSelectItem
        end
        object Panel1: TPanel
          Left = 225
          Top = 15
          Width = 374
          Height = 241
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object pProfile: TPanel
            Left = 0
            Top = 32
            Width = 374
            Height = 209
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            Visible = False
            DesignSize = (
              374
              209)
            object Label2: TLabel
              Left = 11
              Top = 60
              Width = 69
              Height = 13
              Caption = 'Account Name'
            end
            object Label3: TLabel
              Left = 265
              Top = 60
              Width = 66
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Account Type'
              ExplicitLeft = 200
            end
            object Label5: TLabel
              Left = 11
              Top = 12
              Width = 20
              Height = 13
              Caption = 'Title'
            end
            object Label6: TLabel
              Left = 11
              Top = 113
              Width = 94
              Height = 13
              Caption = 'Download Directory'
            end
            object txtUser: TEdit
              AlignWithMargins = True
              Left = 11
              Top = 76
              Width = 248
              Height = 21
              Hint = 'Unique account name of user or organization'
              HelpContext = 1003
              Margins.Bottom = 8
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
              OnChange = ProfileControlsChanged
            end
            object cboUserType: TComboBox
              AlignWithMargins = True
              Left = 265
              Top = 76
              Width = 97
              Height = 21
              Cursor = crHandPoint
              Hint = 'Whether account is a user or organization'
              HelpContext = 1003
              Style = csDropDownList
              Anchors = [akTop, akRight]
              ItemIndex = 1
              TabOrder = 2
              Text = 'Organization'
              OnClick = ProfileControlsChanged
              Items.Strings = (
                'User'
                'Organization')
            end
            object txtProfileTitle: TEdit
              AlignWithMargins = True
              Left = 11
              Top = 28
              Width = 351
              Height = 21
              Hint = 'Unique account name of user or organization'
              HelpContext = 1003
              Margins.Bottom = 8
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = ProfileControlsChanged
            end
            object txtBackupDir: TEdit
              AlignWithMargins = True
              Left = 11
              Top = 129
              Width = 325
              Height = 21
              Hint = 'Directory where the downloaded ZIP files are to be saved'
              HelpContext = 1003
              Margins.Bottom = 8
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
              OnChange = ProfileControlsChanged
              OnDblClick = btnBrowseDirClick
            end
            object btnBrowseDir: TBitBtn
              AlignWithMargins = True
              Left = 336
              Top = 129
              Width = 26
              Height = 21
              Cursor = crHandPoint
              Hint = 'Browse Backup Directory...'
              HelpContext = 1003
              Margins.Bottom = 8
              Anchors = [akTop, akRight]
              Caption = '...'
              TabOrder = 4
              OnClick = btnBrowseDirClick
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 374
            Height = 32
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object btnAddProfile: TBitBtn
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 75
              Height = 26
              Align = alLeft
              Caption = 'Add'
              TabOrder = 0
              OnClick = btnAddProfileClick
            end
            object btnDeleteProfile: TBitBtn
              AlignWithMargins = True
              Left = 84
              Top = 3
              Width = 75
              Height = 26
              Align = alLeft
              Caption = 'Delete'
              Enabled = False
              TabOrder = 1
              OnClick = btnDeleteProfileClick
            end
            object btnCancelProfile: TBitBtn
              AlignWithMargins = True
              Left = 165
              Top = 3
              Width = 75
              Height = 26
              Align = alLeft
              Caption = 'Cancel'
              Enabled = False
              TabOrder = 2
              Visible = False
            end
          end
        end
      end
    end
    object tabView: TTabSheet
      Caption = '   View   '
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object pBottom: TPanel
    Left = 0
    Top = 364
    Width = 609
    Height = 35
    HelpContext = 1001
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnSave: TBitBtn
      AlignWithMargins = True
      Left = 531
      Top = 3
      Width = 75
      Height = 29
      Cursor = crHandPoint
      Hint = 'Save Configuration'
      HelpContext = 1001
      Align = alRight
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TBitBtn
      AlignWithMargins = True
      Left = 450
      Top = 3
      Width = 75
      Height = 29
      Cursor = crHandPoint
      Hint = 'Cancel Changes'
      HelpContext = 1001
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dlgBrowseDir: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 180
    Top = 5
  end
end
