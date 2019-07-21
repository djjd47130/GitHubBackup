unit JD.Config;

(*
  Application configuration storage solution

  Centralizes application settings by saving JSON file in the
  user's home directory (app data).

  Usage:
  - Create a single global instance of object for a given config file
    - Do not create more than 1 instance for the same file
    - Different instances can be created for different files
  - Assign a value to "Path" property for subdirectories
    - For example, "My Company Name\My App Name"
    - This is important, by default uses subdirectory "My App"
  - Assign a value to "Name" property for filename
    - For example, "AppSettings"
    - Default value is "Config" which saves to "Config.json"
    - Do not include extension - automatically adds ".json"
  - Read and write properties via single letter properties
  - Use Load and Save functions to either load from file or save to file
  - Use XSuperObject library to read/write nested objects and arrays

  Hint:
  This object can be inherited into your own object and given specific
  app-related properties which read/write the actual values, rather than
  using the single-letter properties. For example, a string property "BackupDir"
  which reads and writes S['backupDir'].

*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  XSuperObject;

type
  TJDConfig = class(TObject)
  private
    FConfig: ISuperObject;
    FPath: String;
    FName: String;
    procedure SetPath(const Value: String);
    procedure SetName(const Value: String);
    function GetB(const N: String): Boolean;
    function GetF(const N: String): Double;
    function GetI(const N: String): Int64;
    function GetO(const N: String): ISuperObject;
    function GetS(const N: String): String;
    function GetA(const N: String): ISuperArray;
    procedure SetB(const N: String; const Value: Boolean);
    procedure SetF(const N: String; const Value: Double);
    procedure SetI(const N: String; const Value: Int64);
    procedure SetO(const N: String; const Value: ISuperObject);
    procedure SetS(const N, Value: String);
    procedure SetA(const N: String; const Value: ISuperArray);
  public
    constructor Create;
    destructor Destroy; override;
    function Filename: String;
    function Load: Boolean;
    function Save: Boolean;
  public
    property Path: String read FPath write SetPath;
    property Name: String read FName write SetName;

    property S[const N: String]: String read GetS write SetS;
    property I[const N: String]: Int64 read GetI write SetI;
    property B[const N: String]: Boolean read GetB write SetB;
    property F[const N: String]: Double read GetF write SetF;
    property O[const N: String]: ISuperObject read GetO write SetO;
    property A[const N: String]: ISuperArray read GetA write SetA;
  end;

implementation

uses
  System.IOUtils;

{ TJDConfig }

constructor TJDConfig.Create;
begin
  FConfig:= SO; //Initialize empty JSON object
  FPath:= 'My App';
  FName:= 'Config';
end;

destructor TJDConfig.Destroy;
begin

  inherited;
end;

function TJDConfig.Filename: String;
begin
  Result:= TPath.GetHomePath;
  Result:= TPath.Combine(Result, FPath);
  Result:= TPath.Combine(Result, Name+'.json');
end;

function TJDConfig.Load: Boolean;
var
  L: TStringList;
  O: ISuperObject;
begin
  Result:= False;
  L:= TStringList.Create;
  try
    if FileExists(Filename) then begin
      L.LoadFromFile(Filename);
      O:= SO(L.Text);
      if Assigned(O) then begin
        FConfig:= O;
        Result:= True;
      end;
    end;
  finally
    L.Free;
  end;
end;

function TJDConfig.Save: Boolean;
var
  L: TStringList;
begin
  L:= TStringList.Create;
  try
    L.Text:= FConfig.AsJSON(True);
    ForceDirectories(ExtractFilePath(Filename));
    L.SaveToFile(Filename);
    Result:= True;
  finally
    L.Free;
  end;
end;

function TJDConfig.GetA(const N: String): ISuperArray;
begin
  Result:= FConfig.A[N];
end;

function TJDConfig.GetB(const N: String): Boolean;
begin
  Result:= FConfig.B[N];
end;

function TJDConfig.GetF(const N: String): Double;
begin
  Result:= FConfig.F[N];
end;

function TJDConfig.GetI(const N: String): Int64;
begin
  Result:= FConfig.I[N];
end;

function TJDConfig.GetO(const N: String): ISuperObject;
begin
  Result:= FConfig.O[N];
end;

function TJDConfig.GetS(const N: String): String;
begin
  Result:= FConfig.S[N];
end;

procedure TJDConfig.SetA(const N: String; const Value: ISuperArray);
begin
  FConfig.A[N]:= Value;
end;

procedure TJDConfig.SetB(const N: String; const Value: Boolean);
begin
  FConfig.B[N]:= Value;
end;

procedure TJDConfig.SetF(const N: String; const Value: Double);
begin
  FConfig.F[N]:= Value;
end;

procedure TJDConfig.SetI(const N: String; const Value: Int64);
begin
  FConfig.I[N]:= Value;
end;

procedure TJDConfig.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TJDConfig.SetO(const N: String; const Value: ISuperObject);
begin
  FConfig.O[N]:= Value;
end;

procedure TJDConfig.SetPath(const Value: String);
begin
  FPath := Value;
end;

procedure TJDConfig.SetS(const N, Value: String);
begin
  FConfig.S[N]:= Value;
end;

end.
