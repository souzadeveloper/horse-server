unit ServerAuth;

interface

uses
  Horse, Horse.JWT, Horse.BasicAuthentication, ServerConsts;

Type
  TSession = class
    Fjti: string;
  end;

function Authorization: THorseCallback;
function BasicAuthorization: THorseCallback;

implementation

function ValidateUser(const Username, Password: string): Boolean;
begin
  Result := (Username = 'msouza') and (Password = '891063');
end;

function Authorization: THorseCallback;
begin
  Result := HorseJWT(JWT_SECRET, TSession);
end;

function BasicAuthorization: THorseCallback;
begin
  Result := HorseBasicAuthentication(ValidateUser);
end;



end.
