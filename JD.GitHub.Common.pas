unit JD.GitHub.Common;

interface

uses
  System.Classes, System.SysUtils,
  XSuperObject;

type
  TRepo = class(TObject)
  private
    FObj: ISuperObject;
    function GetB(const N: String): Boolean;
    function GetF(const N: String): Double;
    function GetI(const N: String): Int64;
    function GetS(const N: String): String;
    function GetO(const N: String): ISuperObject;
    function GetCreated: TDateTime;
    function GetDefaultBranch: String;
    function GetDescription: String;
    function GetFullName: String;
    function GetIsPrivate: Boolean;
    function GetLanguage: String;
    function GetName: String;
    function GetPushed: TDateTime;
    function GetSize: Int64;
    function GetUpdated: TDateTime;
  public
    constructor Create(AObj: ISuperObject);
    destructor Destroy; override;
  public
    property S[const N: String]: String read GetS;
    property I[const N: String]: Int64 read GetI;
    property B[const N: String]: Boolean read GetB;
    property F[const N: String]: Double read GetF;
    property O[const N: String]: ISuperObject read GetO;
  public
    property Name: String read GetName;
    property FullName: String read GetFullName;
    property Created: TDateTime read GetCreated;
    property Updated: TDateTime read GetUpdated;
    property Pushed: TDateTime read GetPushed;
    property Language: String read GetLanguage;
    property DefaultBranch: String read GetDefaultBranch;
    property IsPrivate: Boolean read GetIsPrivate;
    property Size: Int64 read GetSize;
    property Description: String read GetDescription;
  end;


implementation

uses
  System.IOUtils, System.DateUtils, Soap.XSBuiltIns, System.Math;

{ TRepo }

constructor TRepo.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FObj._AddRef;
end;

destructor TRepo.Destroy;
begin
  FObj._Release;
  FObj:= nil;
  inherited;
end;

function TRepo.GetO(const N: String): ISuperObject;
begin
  Result:= FObj.O[N];
end;

function TRepo.GetS(const N: String): String;
begin
  Result:= FObj.S[N];
end;

function TRepo.GetB(const N: String): Boolean;
begin
  Result:= FObj.B[N];
end;

function TRepo.GetF(const N: String): Double;
begin
  Result:= FObj.F[N];
end;

function TRepo.GetI(const N: String): Int64;
begin
  Result:= FObj.I[N];
end;

function TRepo.GetCreated: TDateTime;
begin
  with TXSDateTime.Create do
    try
      XSToNative(S['created_at']);
      Result:= AsDateTime;
    finally
      Free;
    end;
end;

function TRepo.GetDefaultBranch: String;
begin
  Result:= S['default_branch'];
end;

function TRepo.GetDescription: String;
begin
  Result:= S['description'];
end;

function TRepo.GetFullName: String;
begin
  Result:= S['full_name'];
end;

function TRepo.GetIsPrivate: Boolean;
begin
  Result:= B['private'];
end;

function TRepo.GetLanguage: String;
begin
  Result:= S['language'];
end;

function TRepo.GetName: String;
begin
  Result:= S['name'];
end;

function TRepo.GetPushed: TDateTime;
begin
  with TXSDateTime.Create do
    try
      XSToNative(S['pushed_at']);
      Result:= AsDateTime;
    finally
      Free;
    end;
end;

function TRepo.GetSize: Int64;
begin
  Result:= I['size'];
end;

function TRepo.GetUpdated: TDateTime;
begin
  with TXSDateTime.Create do
    try
      XSToNative(S['updated_at']);
      Result:= AsDateTime;
    finally
      Free;
    end;
end;

end.
