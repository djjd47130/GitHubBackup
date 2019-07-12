unit uAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Winapi.ShellApi;

type
  TfrmAbout = class(TForm)
    Label1: TLabel;
    lblVersion: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Label4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

function FileVersion(const FileName: TFileName): String;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
          Result := Format('v%d.%d.%d build %d', [
            HiWord(dwFileVersionMS), //Major
            LoWord(dwFileVersionMS), //Minor
            HiWord(dwFileVersionLS), //Release
            LoWord(dwFileVersionLS)]); //Build
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  lblVersion.Caption:= FileVersion(Application.ExeName);
end;

procedure TfrmAbout.Label4Click(Sender: TObject);
var
  URL: string;
begin
  URL := 'https://github.com/djjd47130/GitHubBackup';
  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

end.
