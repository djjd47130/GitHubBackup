object ListGrid: TListGrid
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'ListGrid'
  ClientHeight = 481
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TStringGrid
    Left = 0
    Top = 0
    Width = 641
    Height = 409
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    ColCount = 1
    DefaultColWidth = 100
    DefaultRowHeight = 18
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 2
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goColSizing, goThumbTracking]
    TabOrder = 0
    OnDrawCell = GridDrawCell
    OnSelectCell = GridSelectCell
    ColWidths = (
      100)
    RowHeights = (
      18
      18)
  end
end
