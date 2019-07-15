object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About JD GitHub Backup'
  ClientHeight = 261
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 263
    Height = 35
    Caption = 'JD GitHub Backup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVersion: TLabel
    Left = 32
    Top = 48
    Width = 121
    Height = 25
    Caption = 'Version 0.2.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 104
    Width = 225
    Height = 19
    Caption = 'Copyright (c) 2019 Jerry Dodge'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 129
    Width = 263
    Height = 19
    Caption = 'MIT License - OpenSource on GitHub'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 154
    Width = 317
    Height = 19
    Cursor = crHandPoint
    Caption = 'https://github.com/djjd47130/GitHubBackup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 16744576
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    StyleElements = [seClient, seBorder]
    OnClick = Label4Click
  end
end
