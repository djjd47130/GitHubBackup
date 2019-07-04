unit uSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  {$WARN SYMBOL_PLATFORM OFF}
  TfrmSetup = class(TForm)
    Pages: TPageControl;
    tabAccount: TTabSheet;
    tabRepositories: TTabSheet;
    tabView: TTabSheet;
    gbAccountAccess: TGroupBox;
    Label4: TLabel;
    gbBackupDir: TGroupBox;
    txtBackupDir: TEdit;
    btnBrowseDir: TBitBtn;
    lblAccessToken: TLabel;
    txtAccessToken: TEdit;
    dlgBrowseDir: TFileOpenDialog;
    GroupBox1: TGroupBox;
    txtPageSize: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    txtUser: TEdit;
    cboUserType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnBrowseDirClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;
  {$WARN SYMBOL_PLATFORM ON}

var
  frmSetup: TfrmSetup;

implementation

{$R *.dfm}

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
  Pages.Align:= alClient;
end;

procedure TfrmSetup.btnBrowseDirClick(Sender: TObject);
begin
  {$WARN SYMBOL_PLATFORM OFF}
  dlgBrowseDir.DefaultFolder:= txtBackupDir.Text;
  if dlgBrowseDir.Execute then begin
    txtBackupDir.Text:= dlgBrowseDir.FileName;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;


end.
