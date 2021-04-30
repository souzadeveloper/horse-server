program HorseServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  UserController in 'UserController.pas',
  ServerConsts in 'ServerConsts.pas',
  ServerAuth in 'ServerAuth.pas',
  AuthController in 'AuthController.pas',
  ServerController in 'ServerController.pas',
  LibUtils in 'LibUtils.pas';

var
  App: THorse;

begin
  App := THorse.Create(9000);
  App.Use(Jhonson);
  App.Use(CORS);

  AuthController.Registry(App);
  ServerController.Registry(App);
  UserController.Registry(App);

  App.Start;
end.
