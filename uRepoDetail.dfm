object frmRepoDetail: TfrmRepoDetail
  Left = 0
  Top = 0
  Caption = 'Repository Detail'
  ClientHeight = 524
  ClientWidth = 757
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblRepoName: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 751
    Height = 30
    Align = alTop
    AutoSize = False
    Caption = 'Repository Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblRepoOwner: TLabel
    AlignWithMargins = True
    Left = 11
    Top = 39
    Width = 743
    Height = 26
    Margins.Left = 11
    Align = alTop
    AutoSize = False
    Caption = 'Repository Owner'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 3
    ExplicitWidth = 751
  end
end
