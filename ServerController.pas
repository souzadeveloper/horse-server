unit ServerController;

interface

uses
  System.JSON, System.SysUtils,
  Horse,
  ServerAuth,
  LibUtils,
  ServerConsts;

procedure Registry(App: THorse);
procedure Version(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ServerTime(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry(App: THorse);
begin
  App.Get('/version', Version);
  App.Get('/serverTime', ServerTime);
end;

procedure Version(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONObject>(StrToJSONObject('Version', API_VERSION));
end;

procedure ServerTime(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONObject>(StrToJSONObject('ServerTime', FormatDateTime('dd/mm/yyyy hh:nn:ss', Now)));
end;

end.
