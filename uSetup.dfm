object frmSetup: TfrmSetup
  Left = 0
  Top = 0
  Caption = 'Setup'
  ClientHeight = 347
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 521
    Height = 257
    ActivePage = tabRepositories
    Align = alTop
    TabOrder = 0
    object tabAccount: TTabSheet
      Caption = 'Account'
      ExplicitLeft = 8
      ExplicitTop = 28
      ExplicitWidth = 614
      ExplicitHeight = 309
      object gbAccountAccess: TGroupBox
        Left = 0
        Top = 0
        Width = 513
        Height = 145
        Align = alTop
        Caption = 'Account Access'
        TabOrder = 0
        ExplicitWidth = 554
        object Label4: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 18
          Width = 489
          Height = 55
          Margins.Left = 10
          Margins.Right = 10
          Align = alTop
          AutoSize = False
          Caption = 
            'You must generate a "Personal Access Token" on your GitHub accou' +
            'nt'#39's developer settings in order to use this application.  Enter' +
            ' that unique token into the "Access Token" field below. This app' +
            'lication will provide access to any repositories which your acco' +
            'unt is authorized access to. '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          ExplicitWidth = 530
        end
        object lblAccessToken: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 79
          Width = 503
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
          Top = 98
          Width = 503
          Height = 21
          Align = alTop
          TabOrder = 0
          ExplicitLeft = 12
          ExplicitTop = 235
          ExplicitWidth = 608
        end
      end
    end
    object tabRepositories: TTabSheet
      Caption = 'Repositories'
      ImageIndex = 1
      ExplicitWidth = 633
      ExplicitHeight = 205
      object gbBackupDir: TGroupBox
        Left = 0
        Top = 0
        Width = 513
        Height = 49
        Align = alTop
        Caption = 'Backup Directory'
        TabOrder = 0
        ExplicitWidth = 591
        object txtBackupDir: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 471
          Height = 21
          Margins.Bottom = 8
          Align = alClient
          TabOrder = 0
          OnDblClick = btnBrowseDirClick
          ExplicitTop = 17
          ExplicitWidth = 549
        end
        object btnBrowseDir: TBitBtn
          AlignWithMargins = True
          Left = 482
          Top = 18
          Width = 26
          Height = 21
          Cursor = crHandPoint
          Margins.Bottom = 8
          Align = alRight
          Caption = '...'
          TabOrder = 1
          OnClick = btnBrowseDirClick
          ExplicitLeft = 665
          ExplicitTop = 12
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 98
        Width = 513
        Height = 48
        Align = alTop
        Caption = 'Pagination'
        TabOrder = 1
        ExplicitTop = 49
        ExplicitWidth = 591
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
          Margins.Bottom = 8
          Align = alLeft
          TabOrder = 0
          Text = '100'
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 49
        Width = 513
        Height = 49
        Align = alTop
        Caption = 'Account to List'
        TabOrder = 2
        ExplicitLeft = 16
        ExplicitTop = 18
        object txtUser: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 399
          Height = 21
          Margins.Bottom = 8
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 20
          ExplicitWidth = 258
          ExplicitHeight = 22
        end
        object cboUserType: TComboBox
          AlignWithMargins = True
          Left = 410
          Top = 18
          Width = 98
          Height = 21
          Cursor = crHandPoint
          Align = alRight
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'User'
          Items.Strings = (
            'User'
            'Organization')
          ExplicitLeft = 304
          ExplicitTop = 20
        end
      end
    end
    object tabView: TTabSheet
      Caption = 'View'
      ImageIndex = 2
      ExplicitWidth = 633
      ExplicitHeight = 205
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 312
    Width = 521
    Height = 35
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      AlignWithMargins = True
      Left = 442
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = 'Save'
      TabOrder = 0
      ExplicitLeft = 344
      ExplicitTop = 16
      ExplicitHeight = 25
    end
    object BitBtn2: TBitBtn
      AlignWithMargins = True
      Left = 361
      Top = 4
      Width = 75
      Height = 27
      Align = alRight
      Caption = 'Cancel'
      TabOrder = 1
      ExplicitLeft = 344
      ExplicitTop = 16
      ExplicitHeight = 25
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
