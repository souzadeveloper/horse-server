unit LibUtils;

interface

uses
  System.JSON, System.SysUtils;

function StrToJSON(AKey, AValue: string): string;
function GetJSONValue(AJSON, AKey: string): string;
function StrToJSONObject(AKey, AValue: string): TJSONObject;

implementation

function StrToJSON(AKey, AValue: string): string;
var
  JSONObject: TJSONObject;
begin
  JSONObject := TJSONObject.Create;
  try
    JSONObject.AddPair(AKey, AValue);
    Result := JSONObject.ToJSON;
  finally
    FreeAndNil(JSONObject);
  end;
end;

function StrToJSONObject(AKey, AValue: string): TJSONObject;
var
  JSONObject: TJSONObject;
begin
  JSONObject := TJSONObject.Create;
  JSONObject.AddPair(AKey, AValue);
  Result := JSONObject;
end;

function GetJSONValue(AJSON, AKey: string): string;
var
  JSONValue : TJSONValue;
begin
  try
    JSONValue := TJSONObject.ParseJSONValue(AJSON);
    Result := JSONValue.GetValue<string>(AKey);
  finally
    FreeAndNil(JSONValue);
  end;
end;

end.
