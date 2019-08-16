unit JD.GitHub.Common;

interface

uses
  Winapi.Windows,
  System.Classes, System.SysUtils,
  XSuperObject;

function MakeFilenameValid(const Path: String): String;
function DataSizeStr(Bytes: Int64): string;

function ISOToDateTime(const AISODateTime: string): TDateTime;
function LocalTimeToUTCTime(lpTimeZoneInformation: PTimeZoneInformation; var lpLocalTime, lpUniversalTime: TSystemTime): BOOL; stdcall;
function UTCTimeToLocalTime(lpTimeZoneInformation: PTimeZoneInformation; var lpUniversalTime,lpLocalTime: TSystemTime): BOOL; stdcall;

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

function ISOToDateTime(const AISODateTime: string): TDateTime;
var
  VDate, VTime: TDateTime;
  VFormatSettings: TFormatSettings;
begin
  // ISO format: 2009-07-06T01:53:23Z
  VFormatSettings.DateSeparator := '-';
  VFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  VFormatSettings.TimeSeparator := ':';
  VFormatSettings.ShortTimeFormat := 'hh:mm:ss';
  VDate := StrToDate(Copy(AISODateTime, 1, Pos('T', AISODateTime) - 1), VFormatSettings);
  VTime := StrToTime(Copy(AISODateTime, Pos('T', AISODateTime) + 1, 8), VFormatSettings);
  Result := Trunc(VDate) + Frac(VTime);
end;

function LocalTimeToUTCTime; external kernel32 name 'TzSpecificLocalTimeToSystemTime';
function UTCTimeToLocalTime; external kernel32 name 'SystemTimeToTzSpecificLocalTime';

function DateTime2UnivDateTime(d:TDateTime):TDateTime;
var
 TZI:TTimeZoneInformation;
 LocalTime, UniversalTime:TSystemTime;
begin
  GetTimeZoneInformation(tzi);
  DateTimeToSystemTime(d,LocalTime);
  LocalTimeToUTCTime(@tzi,LocalTime,UniversalTime);
  Result := SystemTimeToDateTime(UniversalTime);
end;

function UnivDateTime2LocalDateTime(d:TDateTime):TDateTime;
var
 TZI:TTimeZoneInformation;
 LocalTime, UniversalTime:TSystemTime;
begin
  GetTimeZoneInformation(tzi);
  DateTimeToSystemTime(d,UniversalTime);
  UTCTimeToLocalTime(@tzi,UniversalTime,LocalTime);
  Result := SystemTimeToDateTime(LocalTime);
end;

end.
