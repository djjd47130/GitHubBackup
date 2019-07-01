unit JD.GitHub;

(*
  JD.GitHub.pas
  Core unit to implement all GitHub related integration

  IMPORTANT NOTE

  This project is in active development, and is in a re-write phsae.
  A new set of units is being written, mainly JD.GitHub.Intf.pas and
  JD.GitHub.Impl.pas. These will become the new replacement units.
  Currently, this unit retains code necessary for current working version,
  as well as new code which is not yet implemented. This new code will
  eventually replace the current working code.

  Main Component: TGitHubAPI

  This component encapsulates all integration with the GitHub API.
  It is a component which you can drop into your project in design-time
  and use its properties to set it up the way you need it to work.



*)

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  XSuperObject,
  JD.IndyUtils
{$IFDEF V2}
  , JD.GitHub.Intf, JD.GitHub.Impl
{$ENDIF}
  ;


{$IFDEF V2}
type
  TGitHubAPI = class;
  TGitHubAPIRepos = class;



  TGitHubAPIRepos = class(TPersistent)
  private
    FOwner: TGitHubAPI;
    FPageSize: Integer;
    procedure SetPageSize(const Value: Integer);
  public
    constructor Create(AOwner: TGitHubAPI);
    destructor Destroy; override;
  public
    function GetMyRepos(const AName: String; const APage: Integer = 1): IGitHubRepos;
    function GetUserRepos(const AName: String; const APage: Integer = 1): IGitHubRepos;
    function GetOrgRepos(const AName: String; const APage: Integer = 1): IGitHubRepos;
  published
    property PageSize: Integer read FPageSize write SetPageSize;
  end;

  TGitHubAPI = class(TComponent)
  private
    FWeb: TIndyHttpTransport;
    FToken: String;
    procedure SetToken(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Token: String read FToken write SetToken;

  end;

{$ENDIF}





{ ---------------------------- Original Code ------------------------------ }

type
  TDownloadStatus = (dsPending, dsProgress, dsComplete, dsException);

  TDownloadFile = class(TObject)
  private
    FURL: String;
    FFilename: String;
    FStatus: TDownloadStatus;
    FError: String;
  public
    constructor Create;
    destructor Destroy; override;
    function Name: String;
    property URL: String read FURL write FURL;
    property Filename: String read FFilename write FFilename;
    property Status: TDownloadStatus read FStatus write FStatus;
    property Error: String read FError write FError;
  end;

  TDownloadThreadProgressEvent = procedure(Sender: TObject; const Cur: Integer;
    const Max: Integer; const CurFile: TDownloadFile) of object;

  TDownloadExceptionEvent = procedure(Sender: TObject;
    const CurFile: TDownloadFile) of object;

  TThreadCancelEvent = procedure of object;

  TDownloadThread = class(TThread)
  private
    FFiles: TObjectList<TDownloadFile>;
    FWeb: TIndyHttpTransport;
    FWorking: Boolean;
    FCancel: Boolean;
    FOnDownloadBegin: TNotifyEvent;
    FOnDownloadDone: TNotifyEvent;
    FOnProgress: TDownloadThreadProgressEvent;
    FOnException: TDownloadExceptionEvent;
    FSYNC_Cur: Integer;
    FSYNC_Max: Integer;
    FSYNC_CurFile: TDownloadFile;
    FToken: String;
    procedure SetToken(const Value: String);
    procedure DoDownload(AFile: TDownloadFile);
    procedure WebWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
  protected
    procedure Execute; override;
    procedure SYNC_OnDownloadBegin;
    procedure SYNC_OnDownloadDone;
    procedure SYNC_OnProgress;
    procedure SYNC_OnException;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function AddFile(const URL: String; const Filename: String): TDownloadFile;

    procedure Cancel;

    property Token: String read FToken write SetToken;

    property OnDownloadBegin: TNotifyEvent read FOnDownloadBegin write FOnDownloadBegin;
    property OnDownloadDone: TNotifyEvent read FOnDownloadDone write FOnDownloadDone;
    property OnProgress: TDownloadThreadProgressEvent read FOnProgress write FOnProgress;
    property OnException: TDownloadExceptionEvent read FOnException write FOnException;
  end;



function MakeFilenameValid(const Path: String): String;
function ConvertBytes(Bytes: Int64): string;

implementation

uses
  System.IOUtils, System.Math;

function MakeFilenameValid(const Path: String): String;
begin
  Result:= Path;
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
end;

function ConvertBytes(Bytes: Int64): string;
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

{$IFDEF V2}

{ TGitHubAPI }

constructor TGitHubAPI.Create(AOwner: TComponent);
begin
  inherited;
  FWeb:= TIndyHttpTransport.Create;
end;

destructor TGitHubAPI.Destroy;
begin
  FreeAndNil(FWeb);
  inherited;
end;

procedure TGitHubAPI.SetToken(const Value: String);
begin
  FToken := Value;
end;

{ TGitHubAPIRepos }

constructor TGitHubAPIRepos.Create(AOwner: TGitHubAPI);
begin
  FOwner:= AOwner;

end;

destructor TGitHubAPIRepos.Destroy;
begin

  inherited;
end;

procedure TGitHubAPIRepos.SetPageSize(const Value: Integer);
begin
  FPageSize := Value;
  if FPageSize > 100 then
    FPageSize:= 100;
  if FPageSize < 1 then
    FPageSize:= 1;
end;

function TGitHubAPIRepos.GetMyRepos(const AName: String;
  const APage: Integer): IGitHubRepos;
begin

end;

function TGitHubAPIRepos.GetUserRepos(const AName: String;
  const APage: Integer): IGitHubRepos;
begin

end;

function TGitHubAPIRepos.GetOrgRepos(const AName: String;
  const APage: Integer): IGitHubRepos;
begin

end;

{$ENDIF}





{ TDownloadFile }

constructor TDownloadFile.Create;
begin

end;

destructor TDownloadFile.Destroy;
begin

  inherited;
end;

function TDownloadFile.Name: String;
begin
  Result:= ExtractFileName(FFilename);
end;

{ TDownloadThread }

procedure TDownloadThread.Cancel;
begin
  FCancel:= True;

end;

constructor TDownloadThread.Create;
begin
  inherited Create(True);
  FWorking:= False;
  FCancel:= False;
  FFiles:= TObjectList<TDownloadFile>.Create(True);
end;

destructor TDownloadThread.Destroy;
begin
  FreeAndNil(FFiles);
  inherited;
end;

function TDownloadThread.AddFile(const URL, Filename: String): TDownloadFile;
begin
  if FWorking then
    raise Exception.Create('Cannot add file - thread is already working!');
  Result:= TDownloadFile.Create;
  Result.FURL:= URL;
  Result.FFilename:= Filename;
  Result.FStatus:= dsPending;
  Result.FError:= '';
  FFiles.Add(Result);
end;

procedure TDownloadThread.WebWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if FCancel or Terminated then
    FWeb.Disconnect;
end;

procedure TDownloadThread.Execute;
var
  X: Integer;
begin
  FWorking:= True;
  Synchronize(SYNC_OnDownloadBegin);
  try
    FSYNC_Max:= FFiles.Count;
    FWeb:= TIndyHttpTransport.Create;
    try
      FWeb.OnWork:= WebWork;
      FWeb.Request.Username:= FToken;

      for X := 0 to FFiles.Count-1 do begin
        if FCancel or Terminated then
          Break;

        FSYNC_Cur:= X+1;
        FSYNC_CurFile:= FFiles[X];
        try
          Synchronize(SYNC_OnProgress);

          DoDownload(FSYNC_CurFile);

        except
          on E: Exception do begin
            //FSYNC_CurFile.FException:= E;
            //Synchronize(SYNC_OnException);
          end;
        end;
      end;

    finally
      FWeb.Free;
    end;
  finally
    Synchronize(SYNC_OnDownloadDone);
  end;
  Terminate;
end;

procedure TDownloadThread.DoDownload(AFile: TDownloadFile);
var
  //Exists: Boolean;
  S: TFileStream;
  EM: String;
begin
  AFile.FStatus:= dsProgress;
  EM:= '';
  //Exists:= FileExists(AFile.Filename);
  S:= TFileStream.Create(AFile.Filename, fmCreate);
  try
    try

      // -------- ACTUAL DOWNLOAD --------
      FWeb.Get(AFile.URL, S);

      AFile.FStatus:= dsComplete;
    except
      on E: Exception do begin
        EM:= E.Message;
      end;
    end;
    if FCancel or Terminated then begin
      EM:= 'Download was cancelled by user!';
    end;
  finally
    S.Free;
  end;
  if (EM <> '') then begin
    AFile.FError:= EM;
    AFile.FStatus:= dsException;
    //Only delete the created file if it didn't already exist...
    //  TODO: Actually, if it already existed, then by this point
    //  it's already been overwritten...
    //if not Exists then
      DeleteFile(AFile.Filename);
    Synchronize(SYNC_OnException);
  end;
end;

procedure TDownloadThread.SetToken(const Value: String);
begin
  FToken := Value;
end;

procedure TDownloadThread.SYNC_OnDownloadBegin;
begin
  if Assigned(FOnDownloadBegin) then
    FOnDownloadBegin(Self);
end;

procedure TDownloadThread.SYNC_OnDownloadDone;
begin
  if Assigned(FOnDownloadDone) then
    FOnDownloadDone(Self);
end;

procedure TDownloadThread.SYNC_OnProgress;
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self, FSYNC_Cur, FSYNC_Max, FSYNC_CurFile);
end;

procedure TDownloadThread.SYNC_OnException;
begin
  if Assigned(FOnException) then
    FOnException(Self, FSYNC_CurFile);
end;

end.
