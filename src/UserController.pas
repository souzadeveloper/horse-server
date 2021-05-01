unit UserController;

interface

uses
  System.SysUtils,
  Horse,
  System.JSON,
  ServerAuth,
  DataSetConverter4D,
  DataSetConverter4D.Impl,
  DataSetConverter4D.Helper,
  DataSetConverter4D.Util,
  Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetById(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Registry;
begin
  THorse.Get('/users', Authorization, Get);
  THorse.Get('/users/:id', Authorization, GetById);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDConn: TFDConnection;
  FDQuery: TFDQuery;
  Usuario: String;
begin
  FDConn := TFDConnection.Create(nil);
  FDQuery := TFDQuery.Create(nil);

  Usuario := Req.Session<TSession>.Fjti;

  try
    FDConn.DriverName  := 'PG';
    FDConn.LoginPrompt := False;
    FDConn.Params.Clear;
    FDConn.Params.Values['DriverID']  := 'PG';
    FDConn.Params.Values['Server']    := '192.168.56.1';
    FDConn.Params.Values['Port']      := '5432';
    FDConn.Params.Values['Database']  := 'marmitafit';
    FDConn.Params.Values['User_Name'] := 'postgres';
    FDConn.Params.Values['Password']  := '891063';

    FDQuery.Connection := FDConn;
    FDQuery.Open('select * from users');

    Res.Send<TJSONArray>(FDQuery.AsJSONArray);
  finally
    FDQuery.Free;
    FDConn.Free;
  end;
end;

procedure GetById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FDConn: TFDConnection;
  FDQuery: TFDQuery;
begin
  FDConn := TFDConnection.Create(nil);
  FDQuery := TFDQuery.Create(nil);

  try
    FDConn.DriverName  := 'PG';
    FDConn.LoginPrompt := False;
    FDConn.Params.Clear;
    FDConn.Params.Values['DriverID']  := 'PG';
    FDConn.Params.Values['Server']    := '192.168.56.1';
    FDConn.Params.Values['Port']      := '5432';
    FDConn.Params.Values['Database']  := 'marmitafit';
    FDConn.Params.Values['User_Name'] := 'postgres';
    FDConn.Params.Values['Password']  := '891063';

    FDQuery.Connection := FDConn;
    FDQuery.SQL.Text := 'select * from users where id = :id';
    FDQuery.Params.ParamByName('id').AsInteger := Req.Params.Items['id'].ToInteger;
    FDQuery.Open;

    Res.Send<TJSONObject>(FDQuery.AsJSONObject);
  finally
    FDQuery.Free;
    FDConn.Free;
  end;
end;

end.
