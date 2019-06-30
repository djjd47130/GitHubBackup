unit JD.ListGrid;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.Styles, Vcl.Themes;

type
  TListGridColumn = class;
  TListGridColumns = class;
  TListGridItem = class;
  TListGridItems = class;
  TListGrid = class;

  TGridCracker = class(TStringGrid);

  TListGridColumn = class(TObject)
  private
    FOwner: TListGridColumns;
    FWidth: Integer;
    FFieldName: String;
    FVisible: Boolean;
    FCaption: String;
    procedure SetCaption(const Value: String);
    procedure SetFieldName(const Value: String);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    function GetCaption: String;
  public
    constructor Create(AOwner: TListGridColumns);
    destructor Destroy; override;
    property Owner: TListGridColumns read FOwner;
    property FieldName: String read FFieldName write SetFieldName;
    property Caption: String read GetCaption write SetCaption;
    property Width: Integer read FWidth write SetWidth;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TListGridColumns = class(TObject)
  private
    FOwner: TListGrid;
    FItems: TObjectList<TListGridColumn>;
    function GetItem(const Index: Integer): TListGridColumn;
  public
    constructor Create(AOwner: TListGrid);
    destructor Destroy; override;
    function Add(const AFieldName, ACaption: String; const AWidth: Integer = 120;
      const AVisible: Boolean = True): TListGridColumn;
    procedure Delete(const Index: Integer);
    function Count: Integer;
    function VisibleCount: Integer;
    procedure Clear;
    property Items[const Index: Integer]: TListGridColumn read GetItem; default;
  end;

  TListGridItem = class(TObject)
  private
    FOwner: TListGridItems;
    FObj: TObject;
    //FChecked: Boolean;
  public
    constructor Create(AOwner: TListGridItems; AObj: TObject);
    destructor Destroy; override;
    property Obj: TObject read FObj;
  end;

  TListGridItems = class(TObject)
  private
    FOwner: TListGrid;
    FItems: TObjectList<TListGridItem>;
    function GetItem(const Index: Integer): TListGridItem;
  public
    constructor Create(AOwner: TListGrid);
    destructor Destroy; override;
    function Add(const AObj: TObject): TListGridItem;
    procedure Delete(const Index: Integer);
    function Count: Integer;
    procedure Clear;
    property Items[const Index: Integer]: TListGridItem read GetItem; default;
  end;

  TListGridGetTextEvent = procedure(AListGrid: TListGrid; AItem: TListGridItem;
    ACol: TListGridColumn; var AText: String) of object;

  TListGrid = class(TForm)
    Grid: TStringGrid;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    FColumns: TListGridColumns;
    FItems: TListGridItems;
    FOnGetText: TListGridGetTextEvent;
  protected
    procedure DoGetText(AItem: TListGridItem; ACol: TListGridColumn; var AText: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshColumns;
    procedure RefreshItems;
  public
    property Columns: TListGridColumns read FColumns;
    property Items: TListGridItems read FItems;

    property OnGetText: TListGridGetTextEvent read FOnGetText write FOnGetText;
  end;

var
  ListGrid: TListGrid;

implementation

{$R *.dfm}

{ TListGridColumn }

constructor TListGridColumn.Create(AOwner: TListGridColumns);
begin
  FOwner:= AOwner;

end;

destructor TListGridColumn.Destroy;
begin

  inherited;
end;

function TListGridColumn.GetCaption: String;
begin
  if FCaption <> '' then
    Result:= FCaption
  else
    Result:= FFieldName;
end;

procedure TListGridColumn.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

procedure TListGridColumn.SetFieldName(const Value: String);
begin
  FFieldName := Value;
end;

procedure TListGridColumn.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

procedure TListGridColumn.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

{ TListGridColumns }

constructor TListGridColumns.Create(AOwner: TListGrid);
begin
  FOwner:= AOwner;
  FItems:= TObjectList<TListGridColumn>.Create(True);

end;

destructor TListGridColumns.Destroy;
begin

  FreeAndNil(FItems);
  inherited;
end;

function TListGridColumns.GetItem(const Index: Integer): TListGridColumn;
begin
  Result:= FItems[Index];
end;

function TListGridColumns.VisibleCount: Integer;
var
  X: Integer;
begin
  Result:= 0;
  for X := 0 to FItems.Count-1 do begin
    if FItems[X].Visible then
      Inc(Result);
  end;
end;

function TListGridColumns.Add(const AFieldName, ACaption: String;
  const AWidth: Integer; const AVisible: Boolean): TListGridColumn;
begin
  Result:= TListGridColumn.Create(Self);
  Result.FFieldName:= AFieldName;
  Result.FCaption:= ACaption;
  Result.FWidth:= AWidth;
  Result.FVisible:= AVisible;
  FItems.Add(Result);
  FOwner.RefreshColumns;
end;

procedure TListGridColumns.Delete(const Index: Integer);
begin
  FItems.Delete(Index);
  FOwner.RefreshColumns;
end;

procedure TListGridColumns.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

function TListGridColumns.Count: Integer;
begin
  Result:= FItems.Count;
end;

{ TListGridItem }

constructor TListGridItem.Create(AOwner: TListGridItems; AObj: TObject);
begin
  FOwner:= AOwner;
  FObj:= AObj;
end;

destructor TListGridItem.Destroy;
begin

  inherited;
end;

{ TListGrid }

constructor TListGrid.Create(AOwner: TComponent);
begin
  inherited;
  FColumns:= TListGridColumns.Create(Self);
  FItems:= TListGridItems.Create(Self);
  Grid.Align:= alClient;

end;

destructor TListGrid.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FColumns);
  inherited;
end;

procedure TListGrid.DoGetText(AItem: TListGridItem; ACol: TListGridColumn;
  var AText: String);
begin
  if Assigned(FOnGetText) then
    FOnGetText(Self, AItem, ACol, AText)
  else
    AText:= '';
end;

procedure TListGrid.RefreshColumns;
var
  X, I: Integer;
  C: TListGridColumn;
begin
  if FColumns.VisibleCount > 0 then begin
    Grid.ColCount:= FColumns.VisibleCount;
    I:= 0;
    for X := 0 to FColumns.Count-1 do begin
      C:= FColumns[X];
      if C.Visible then begin
        Grid.Cells[I,0]:= C.Caption;
        Grid.ColWidths[I]:= C.Width;
        Inc(I);
      end;
    end;
  end else begin
    //No columns
    Grid.ColCount:= 1;
    Grid.Cells[0,0]:= '';
  end;
  RefreshItems;
end;

procedure TListGrid.RefreshItems;
var
  X: Integer;
begin
  if FItems.Count > 1 then begin
    Grid.RowCount:= FItems.Count + 1;
  end else begin
    Grid.RowCount:= 2;
  end;
  Grid.Rows[1].Clear;
  for X := 0 to FItems.Count-1 do begin
    Grid.Objects[0,X+1]:= FItems[X];
  end;
end;

{ TListGridItems }

constructor TListGridItems.Create(AOwner: TListGrid);
begin
  FOwner:= AOwner;
  FItems:= TObjectList<TListGridItem>.Create(True);

end;

destructor TListGridItems.Destroy;
begin

  FreeAndNil(FItems);
  inherited;
end;

function TListGridItems.Add(const AObj: TObject): TListGridItem;
begin
  Result:= TListGridItem.Create(Self, AObj);
  FItems.Add(Result);
  FOwner.RefreshItems;
end;

procedure TListGridItems.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

function TListGridItems.Count: Integer;
begin
  Result:= FItems.Count;
end;

procedure TListGridItems.Delete(const Index: Integer);
begin
  FItems.Delete(Index);
  FOwner.RefreshItems;
end;

function TListGridItems.GetItem(const Index: Integer): TListGridItem;
begin
  Result:= FItems[Index];
end;

procedure TListGrid.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  T: String;
  I: TListGridItem;
  C: TListGridColumn;
  RFill, RText: TRect;
begin
  C:= FColumns[ACol]; //TODO: Account for hidden columns!!!
  RFill:= Rect;
  RFill.Left:= RFill.Left - 3 - Grid.GridLineWidth;
  RFill.Bottom:= RFill.Bottom + Grid.GridLineWidth;

  RText:= Rect;
  RText.Left:= RText.Left + 2;


  if ARow = 0 then begin
    //Column headers...
    Grid.Canvas.Pen.Style:= psSolid;
    Grid.Canvas.Pen.Color:= StyleServices.GetStyleColor(TStyleColor.scBorder); // clGray;
    Grid.Canvas.Brush.Style:= bsSolid;
    Grid.Canvas.Brush.Color:= StyleServices.GetStyleColor(TStyleColor.scGenericBackground); // clDkGray;
    Grid.Canvas.FillRect(RFill);
    Grid.Canvas.Font.Color:= StyleServices.GetStyleFontColor(TStyleFont.sfGridItemFixedNormal);
    T:= C.Caption;
    DrawText(Grid.Canvas.Handle, PChar(T), Length(T), RText, DT_LEFT);

  end else begin
    //Data rows...
    if FItems.Count > 0 then begin
      I:= FItems[ARow-1];
      try
        DoGetText(I, C, T);
      except
        on E: Exception do begin
          T:= '';
        end;
      end;

      Grid.Canvas.Pen.Style:= psClear;
      if ARow = Grid.Row then begin
        Grid.Canvas.Brush.Color:= clNavy;
        Grid.Canvas.FillRect(RFill);
      end else begin
        Grid.Canvas.Brush.Color:= StyleServices.GetStyleColor(TStyleColor.scGrid); // clBlack;
        Grid.Canvas.FillRect(RFill);
      end;

      Grid.Canvas.Font.Color:= StyleServices.GetStyleFontColor(TStyleFont.sfGridItemNormal);
      DrawText(Grid.Canvas.Handle, PChar(T), Length(T), RText, DT_LEFT);

    end else begin
      //Empty data row...
      Grid.Canvas.Brush.Color:= StyleServices.GetStyleColor(TStyleColor.scGrid); // clBlack;
      Grid.Canvas.FillRect(RFill);
    end;
  end;
end;

procedure TListGrid.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  With TGridCracker( Sender As TStringgrid ) Do Begin
    InvalidateRow( Row );
    InvalidateRow( aRow );
  End;
end;

end.
