program HorseServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  UserController in 'src\UserController.pas',
  ServerConsts in 'src\ServerConsts.pas',
  ServerAuth in 'src\ServerAuth.pas',
  AuthController in 'src\AuthController.pas',
  ServerController in 'src\ServerController.pas',
  LibUtils in 'src\LibUtils.pas';

begin
  THorse.Use(Jhonson);
  THorse.Use(CORS);

  AuthController.Registry;
  ServerController.Registry;
  UserController.Registry;

  THorse.Listen(9000,
    procedure(Horse: THorse)
    begin
      Writeln('Server is runing on port ' + THorse.Port.ToString);
      Write('Press return to stop...');
      ReadLn;
      THorse.StopListen;
    end);
end.
