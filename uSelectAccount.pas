unit uSelectAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSelectAccount = class(TForm)
    Label1: TLabel;
    txtAccountName: TEdit;
    txtAccountType: TComboBox;
    Label4: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectAccount: TfrmSelectAccount;

implementation

{$R *.dfm}

end.
