object frmRepoDetail: TfrmRepoDetail
  Left = 0
  Top = 0
  Caption = 'Repository Detail'
  ClientHeight = 379
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblRepoName: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 574
    Height = 28
    Align = alTop
    AutoSize = False
    Caption = 'Repository Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 751
  end
  object lblRepoOwner: TLabel
    AlignWithMargins = True
    Left = 11
    Top = 34
    Width = 566
    Height = 24
    Margins.Left = 11
    Align = alTop
    AutoSize = False
    Caption = 'Repository Owner'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 37
    ExplicitWidth = 743
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 50
    Top = 166
    Width = 480
    Height = 105
    Margins.Left = 50
    Margins.Top = 50
    Margins.Right = 50
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'DISCLAIMER: This screen is not yet implemented. This will eventu' +
      'ally allow you to view extended details of any given repository.' +
      ' For now, it'#39's only primitive and not supported. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 45
    ExplicitTop = 190
  end
  object Panel1: TPanel
    Left = 0
    Top = 58
    Width = 580
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 46
      Height = 26
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Branch:'
      Layout = tlCenter
    end
    object cboBranch: TComboBox
      AlignWithMargins = True
      Left = 55
      Top = 3
      Width = 251
      Height = 21
      Align = alLeft
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'default'
      OnClick = cboBranchClick
      Items.Strings = (
        'default')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 87
    Width = 580
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 46
      Height = 26
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Commit:'
      Layout = tlCenter
    end
    object cboCommit: TComboBox
      AlignWithMargins = True
      Left = 55
      Top = 3
      Width = 251
      Height = 21
      Align = alLeft
      Style = csDropDownList
      TabOrder = 0
    end
  end
end
