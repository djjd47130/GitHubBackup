unit JD.IndyUtils;

interface

uses
  IdURI, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdGlobal;

type

  TWorkMode = IdComponent.TWorkMode;

  TIndyHttpTransport = class(TIdCustomHTTP)
  public
    constructor Create;
  end;


implementation

{ TIndyHttpTransport }

constructor TIndyHttpTransport.Create;
var
  SSLIO: TIdSSLIOHandlerSocketOpenSSL;
begin
  inherited Create;

  //TODO: Use conditionals to use feature only if available in current Indy version
  HTTPOptions := HTTPOptions + [hoNoProtocolErrorException, hoWantProtocolErrorContent];

  SSLIO := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  SSLIO.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  SSLIO.SSLOptions.Mode        := sslmClient;
  SSLIO.SSLOptions.VerifyMode  := [];
  SSLIO.SSLOptions.VerifyDepth := 0;

  Self.IOHandler := SSLIO;

  Self.Request.BasicAuthentication:= True;
  Self.Request.Connection:= 'Keep-alive';
  Self.HandleRedirects:= True;

  Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:57.0) Gecko/20100101 Firefox/57.0';

end;

end.
