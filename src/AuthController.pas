unit AuthController;

interface

uses
  Horse,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
  System.JSON,
  System.SysUtils,
  ServerAuth,
  ServerConsts;

procedure Registry;
procedure GetToken(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry;
begin
  THorse.Get('/token', BasicAuthorization, GetToken);
end;

procedure GetToken(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Token: TJWT;
begin
  Token := TJWT.Create;
  try
    Token.Claims.Issuer     := 'Horse';
    Token.Claims.Subject    := 'Marcelo Souza';
    Token.Claims.Expiration := Now + 1;
    Token.Claims.JWTId      := 'msouza';
    Res.Send(TJSONObject.Create(TJSONPair.Create('token', TJOSE.SHA256CompactToken(JWT_SECRET, Token))));
  finally
    Token.Free;
  end;
end;

end.
