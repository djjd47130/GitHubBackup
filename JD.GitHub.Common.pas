unit JD.GitHub.Common;

interface

uses
  System.Classes, System.SysUtils,
  XSuperObject;

function MakeFilenameValid(const Path: String): String;
function DataSizeStr(Bytes: Int64): string;

implementation

uses
  System.IOUtils, System.DateUtils, Soap.XSBuiltIns, System.Math;

function MakeFilenameValid(const Path: String): String;
begin
  Result:= Path;
  //Per Microsoft Windows documentation, these are the illegal characters...
  Result:= StringReplace(Result, '\', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '/', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '?', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '%', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '*', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, ':', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '|', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '"', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '<', '_', [rfReplaceAll]);
  Result:= StringReplace(Result, '>', '_', [rfReplaceAll]);
  //TODO: Add support to keep filename within max limit...
end;

function DataSizeStr(Bytes: Int64): string;
const
  Description: Array [0 .. 8] of string = ('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
var
  i: Integer;
begin
  i := 0;
  while Bytes > Power(1024, i + 1) do
    Inc(i);
  Result := FormatFloat('###0.##', Bytes / IntPower(1024, i)) + ' ' + Description[i];
end;

end.
