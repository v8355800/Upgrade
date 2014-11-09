{******************************************************************************}
{                                    "ИНЕЙ"                                    }
{                           УСТРОЙСТВА СОГЛАСОВАНИЯ                            }
{                                                                              }
{                ЗАО НТЦ Схемотехники и Интегральных Технологий                }
{                                     2014                                     }
{******************************************************************************}

unit TESTER_INEJ_IO;

interface

uses
  System.Classes,
  nrComm,
  BDaqOcxLib_TLB;

const
  DefaultTimeOut = 100;
  StrobeTime     = 0;
  CheckStr       = 'INEJ';

type
  TRequestType = (RequestA{, RequestB});
  ControlPin   = (PC1, PC2, PC3, PC4);
  ControlPin2  = (WriteData, PC00, ReadData, PC01);

  { Базовый класс Ввода/Вывода }
  TInejBaseIO = class abstract(TObject)
  private
    FDemoMode: Boolean;
    function GetTRA: Boolean;

    function Read(var Data: Word; const TimeOut: Cardinal = DefaultTimeOut): Boolean; virtual; abstract;
    procedure Write(const Data: Word); virtual; abstract;
    function Request(const RequestType: TRequestType): Boolean; virtual; abstract;
    procedure Control(const Pin: ControlPin; TurnOn: Boolean); overload; virtual; abstract;
    procedure Control(const Pin: ControlPin2; TurnOn: Boolean); overload;
    procedure ControlStrobe(const Pin: ControlPin; T: Cardinal = StrobeTime); overload;
  public
    procedure readat(var Data: Word);
    procedure wridat(const Data: Word);
		procedure writrele(a: word); virtual; abstract;
    function WaitResult(const TimeOut: Cardinal = DefaultTimeOut): Boolean;
    procedure ControlStrobe(const Pin: ControlPin2; T: Cardinal = StrobeTime); overload;

    constructor Create;
//  published
    property DemoMode: Boolean read FDemoMode write FDemoMode;
    property TRA: Boolean read GetTRA;
  end;

{      STM32F4-Discovery      }
{ Виртуальный COM порт на USB }
type
  TCommIO = class(TInejBaseIO)
  private
    FComm: TnrComm;
    function CheckBoard: Boolean;

    procedure Write(const Data: Word); override;
    function Read(var Data: Word; const TimeOut: Cardinal = DefaultTimeOut): Boolean; override;
    function Request(const RequestType: TRequestType): Boolean; override;
    procedure Control(const Pin: ControlPin; TurnOn: Boolean); overload; override;
  public
 		procedure writrele(a: word); override;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  JCLLogic;

{===================================TBaseIO====================================}

constructor TInejBaseIO.Create;
begin
  FDemoMode := False;
end;

function TInejBaseIO.GetTRA: Boolean;
begin
  Result := Request(RequestA);
end;

procedure TInejBaseIO.Control(const Pin: ControlPin2; TurnOn: Boolean);
begin
  Control(ControlPin(Ord(Pin)), TurnOn);
end;

procedure TInejBaseIO.ControlStrobe(const Pin: ControlPin; T: Cardinal);
begin
  Control(Pin, True);
  Sleep(T);
  Control(Pin, False);
end;

procedure TInejBaseIO.ControlStrobe(const Pin: ControlPin2; T: Cardinal);
begin
  Control(Pin, True);
  Sleep(T);
  Control(Pin, False);
end;

function TInejBaseIO.WaitResult(const TimeOut: Cardinal): Boolean;
var
  i: Cardinal;
  r: Boolean;
begin
  if DemoMode then
    Exit(True);

  Result := False;
  i := 0;
  repeat
    r := Request(RequestA);
    Sleep(1);
    Inc(i);
  until (r) or (i > TimeOut);

  Result := r;
end;

procedure TInejBaseIO.readat(var Data: Word);
begin
  Control(ReadData, True);
  Read(Data);
  Control(ReadData, False);
end;

procedure TInejBaseIO.wridat(const Data: Word);
begin
  Write(Data);
  ControlStrobe(WriteData);
end;

{===================================TCommIO====================================}

constructor TCommIO.Create(AOwner: TComponent);
begin
  inherited Create;

  FComm := TnrComm.Create(AOwner);
  FComm.BaudRate     := 115200;
  FComm.TimeoutRead  := 5000;
  FComm.TimeoutWrite := 500;

  FDemoMode := CheckBoard;
end;

destructor TCommIO.Destroy;
begin
  FComm.Free;
  inherited;
end;

//------------------------------------------------------------------------------
// Проверка подключена плата или нет
//------------------------------------------------------------------------------
function TCommIO.CheckBoard: Boolean;
var
  i: Integer;
  S: string;
begin
  Result := True;
{
  FComm.DeviceListLoad;
  for i := 0 to FComm.DeviceCount-1 do
  begin
    if FComm.Device[i] <> nil then
      if not FComm.Device[i].NamePDO.Contains('USBSER') then
        Continue;

    FComm.SetDeviceIndex(i);
    try
      FComm.InitDeviceConnect;
    except
      Continue;
    end;
    Fcomm.Active := True;
    FComm.SendChar('?');
    if FComm.WaitForBytes(Length(CheckStr), DefaultTimeOut) then
    begin
      S := FComm.ReadString;
      if UpperCase(S) = CheckStr then
      begin
        Result := False;
        Break;
      end;
    end
    else
      Fcomm.Active := False;
  end;
}
  FComm.ComPortNo := 3;
  try
	  FComm.Active := True;
  except
		;
  end;
  Result := not FComm.Active;
end;

//------------------------------------------------------------------------------
// Чтение СЛОВА из Тестера
//------------------------------------------------------------------------------
function TCommIO.Read(var Data: Word; const TimeOut: Cardinal): Boolean;
var
  DataBuf: array[0..1] of Byte;
begin
  FComm.SendChar('R');
  if FComm.WaitForBytes(2, TimeOut) then
  begin
    FComm.Read(PAnsiChar(@DataBuf[0]), Length(DataBuf));
    Data := PWord(@DataBuf)^;
    Result := True;
  end
  else
    Result := False;
end;

//------------------------------------------------------------------------------
// Запись СЛОВА в Тестер
//------------------------------------------------------------------------------
procedure TCommIO.Write(const Data: Word);
var
  DataBuf: array[0..2] of Byte;
begin
  DataBuf[0] := Ord( 'W' );
  DataBuf[1] := Byte(Data shr 8);
  DataBuf[2] := Byte(Data);

  FComm.SendData(PAnsiChar(@DataBuf[0]), Length(DataBuf));
end;

procedure TCommIO.writrele(a: word);
begin
//
end;

//------------------------------------------------------------------------------
// Сигнал Требование А
//------------------------------------------------------------------------------
function TCommIO.Request(const RequestType: TRequestType): Boolean;
var
  DataBuf: Byte;
begin
  case RequestType of
    RequestA:
      FComm.SendString('T');
  end;

  if FComm.WaitForBytes(1, DefaultTimeOut) then
  begin
    FComm.Read(@DataBuf, 1);
    Result := DataBuf <> 0;
//    if DataBuf <> 0 then
//      Result := True
//    else
//      Result := False;
  end
  else
    Result := False;
end;

//------------------------------------------------------------------------------
// Сигналы управления
//------------------------------------------------------------------------------
procedure TCommIO.Control(const Pin: ControlPin; TurnOn: Boolean);
var
  DataBuf: array[0..1] of Byte;
begin
  DataBuf[0] := Ord( 'C' );
  DataBuf[1] := Ord(Pin) + 1;
  if TurnOn then
      DataBuf[1] := SetBit(DataBuf[1], 3);

    FComm.SendData(PAnsiChar(@DataBuf[0]), Length(DataBuf));
end;

end.
