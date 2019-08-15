unit JD.DownloadThread;

interface

uses
  Winapi.Windows,
  System.Classes, System.SysUtils, System.Generics.Collections,
  JD.IndyUtils,
  IdException;

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
    FUsername: String;
    FPassword: String;
    procedure SetToken(const Value: String);
    procedure DoDownload(AFile: TDownloadFile);
    procedure WebWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure SetPassword(const Value: String);
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

    property Username: String read FUsername write SetToken;
    property Password: String read FPassword write SetPassword;

    property OnDownloadBegin: TNotifyEvent read FOnDownloadBegin write FOnDownloadBegin;
    property OnDownloadDone: TNotifyEvent read FOnDownloadDone write FOnDownloadDone;
    property OnProgress: TDownloadThreadProgressEvent read FOnProgress write FOnProgress;
    property OnException: TDownloadExceptionEvent read FOnException write FOnException;
  end;


implementation

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
      FWeb.Request.Username:= FUsername;
      FWeb.Request.Password:= FPassword;
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
            //TODO: Why did I comment this out???
            //FSYNC_CurFile.FException:= E;
            //Synchronize(SYNC_OnException);
          end;
        end;
      end;
    finally
      FreeAndNil(FWeb);
    end;
  finally
    Synchronize(SYNC_OnDownloadDone);
  end;
  Terminate;
end;

procedure TDownloadThread.DoDownload(AFile: TDownloadFile);
var
  S: TFileStream;
  EM: String;
  EC: DWORD;
  TmpFile: String;
begin
  AFile.FStatus:= dsProgress;
  EM:= '';

  //TODO: Don't immediately overwrite the file - download to temp file
  //  first and then overwrite original when finished
  TmpFile:= AFile.Filename + '.JDTMP';
  try
    S:= TFileStream.Create(TmpFile, fmCreate);
    try
      try

        // -------- ACTUAL DOWNLOAD --------
        FWeb.Get(AFile.URL, S);

        AFile.FStatus:= dsComplete;
      except
        on E: EIdConnClosedGracefully do begin
          EM:= 'The server aborted the download: '+E.Message;
        end;
        on E: Exception do begin
          EM:= E.Message;
        end;
      end;
      if FCancel or Terminated then begin
        EM:= 'Download was cancelled by user!';
      end;
    finally
      FreeAndNil(S);
    end;
  except
    on E: Exception do begin
      EM:= 'Exception creating file stream: ' + E.Message;;
    end;
  end;

  //If new file exists and no error...
  if (EM = '') and (FileExists(TmpFile)) then begin
    //Copy file to final location, replace if needed...
    if CopyFile(PChar(TmpFile), PChar(AFile.Filename), False) then begin
      //Delete temp file...
      if not DeleteFile(TmpFile) then begin
        EC:= GetLastError;
        EM:= 'Failed to delete temporary file: Error code '+IntToStr(EC);
      end;
    end else begin
      //Error replacing original file with new download...
      EC:= GetLastError;
      EM:= 'Failed to replace old file with new file: Error code '+IntToStr(EC);
    end;
  end else
  if EM = '' then begin
    //New temp file does not exist?!
    EM:= 'Downloaded temp file does not exist!';
  end;


  if (EM <> '') then begin
    AFile.FError:= EM;
    AFile.FStatus:= dsException;
    if not DeleteFile(TmpFile) then begin
      //TODO: Why won't this work?
      EC:= GetLastError;
      EM:= 'Failed to delete temporary file: Error code '+IntToStr(EC);
    end;
    Synchronize(SYNC_OnException);
  end;
end;

procedure TDownloadThread.SetPassword(const Value: String);
begin
  FPassword := Value;
end;

procedure TDownloadThread.SetToken(const Value: String);
begin
  FUsername := Value;
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
