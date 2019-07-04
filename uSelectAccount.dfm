object frmSelectAccount: TfrmSelectAccount
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select Account'
  ClientHeight = 119
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    405
    119)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 49
    Width = 69
    Height = 13
    Caption = 'Account Name'
  end
  object Label4: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 3
    Width = 385
    Height = 40
    Margins.Left = 10
    Margins.Right = 10
    Align = alTop
    AutoSize = False
    Caption = 
      'Enter either a user account name or an organization account name' +
      ', and choose the account type accordingly to the right. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object txtAccountName: TEdit
    Left = 8
    Top = 68
    Width = 280
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object txtAccountType: TComboBox
    Left = 294
    Top = 68
    Width = 98
    Height = 21
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
end
