object frmSetup: TfrmSetup
  Left = 0
  Top = 0
  HelpContext = 1001
  BorderStyle = bsDialog
  Caption = 'Setup'
  ClientHeight = 350
  ClientWidth = 548
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 548
    Height = 257
    HelpContext = 1001
    ActivePage = tabAccount
    Align = alTop
    TabHeight = 24
    TabOrder = 0
    ExplicitWidth = 531
    object tabAccount: TTabSheet
      HelpContext = 1002
      Caption = '   Account   '
      ExplicitWidth = 523
      object gbAccountAccess: TGroupBox
        Left = 0
        Top = 0
        Width = 540
        Height = 145
        HelpContext = 1002
        Align = alTop
        Caption = 'Account Access'
        TabOrder = 0
        ExplicitWidth = 523
        object Label4: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 18
          Width = 516
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
          Width = 530
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
          Width = 530
          Height = 21
          HelpContext = 1002
          Align = alTop
          TabOrder = 0
          ExplicitTop = 92
          ExplicitWidth = 513
        end
      end
    end
    object tabRepositories: TTabSheet
      HelpContext = 1003
      Caption = '   Repositories   '
      ImageIndex = 1
      ExplicitWidth = 523
      object gbBackupDir: TGroupBox
        Left = 0
        Top = 0
        Width = 540
        Height = 49
        HelpContext = 1003
        Align = alTop
        Caption = 'Backup Directory'
        TabOrder = 0
        ExplicitWidth = 523
        object txtBackupDir: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 498
          Height = 21
          Hint = 'Directory where the downloaded ZIP files are to be saved'
          HelpContext = 1003
          Margins.Bottom = 8
          Align = alClient
          TabOrder = 0
          OnDblClick = btnBrowseDirClick
          ExplicitWidth = 481
        end
        object btnBrowseDir: TBitBtn
          AlignWithMargins = True
          Left = 509
          Top = 18
          Width = 26
          Height = 21
          Cursor = crHandPoint
          Hint = 'Browse Backup Directory...'
          HelpContext = 1003
          Margins.Bottom = 8
          Align = alRight
          Caption = '...'
          TabOrder = 1
          OnClick = btnBrowseDirClick
          ExplicitLeft = 492
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 98
        Width = 540
        Height = 48
        HelpContext = 1003
        Align = alTop
        Caption = 'Pagination'
        TabOrder = 1
        Visible = False
        ExplicitWidth = 523
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
      object GroupBox2: TGroupBox
        Left = 0
        Top = 49
        Width = 540
        Height = 49
        HelpContext = 1003
        Align = alTop
        Caption = 'Account to List'
        TabOrder = 2
        ExplicitWidth = 523
        object txtUser: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 426
          Height = 21
          Hint = 'Unique account name of user or organization'
          HelpContext = 1003
          Margins.Bottom = 8
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 409
        end
        object cboUserType: TComboBox
          AlignWithMargins = True
          Left = 437
          Top = 18
          Width = 98
          Height = 21
          Cursor = crHandPoint
          Hint = 'Whether account is a user or organization'
          HelpContext = 1003
          Align = alRight
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'User'
          Items.Strings = (
            'User'
            'Organization')
          ExplicitLeft = 420
        end
      end
    end
    object tabView: TTabSheet
      Caption = '   View   '
      ImageIndex = 2
      TabVisible = False
      ExplicitWidth = 523
    end
  end
  object pBottom: TPanel
    Left = 0
    Top = 315
    Width = 548
    Height = 35
    HelpContext = 1001
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 531
    object btnSave: TBitBtn
      AlignWithMargins = True
      Left = 469
      Top = 4
      Width = 75
      Height = 27
      Cursor = crHandPoint
      Hint = 'Save Configuration'
      HelpContext = 1001
      Align = alRight
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
      ExplicitLeft = 452
    end
    object btnCancel: TBitBtn
      AlignWithMargins = True
      Left = 388
      Top = 4
      Width = 75
      Height = 27
      Cursor = crHandPoint
      Hint = 'Cancel Changes'
      HelpContext = 1001
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 371
    end
  end
  object dlgBrowseDir: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 20
    Top = 261
  end
end
