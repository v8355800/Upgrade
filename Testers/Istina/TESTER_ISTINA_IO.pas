{******************************************************************************}
{                                   "ИСТИНА"                                   }
{                           УСТРОЙСТВА СОГЛАСОВАНИЯ                            }
{                                                                              }
{                ЗАО НТЦ Схемотехники и Интегральных Технологий                }
{                                     2014                                     }
{******************************************************************************}

unit TESTER_ISTINA_IO;

interface

uses
  System.Classes,
  nrComm,
  BDaqOcxLib_TLB;

const
  DefaultTimeOut = 1000;
  CheckStr       = 'ISTINA';

type
  TRequestType = (RequestA, RequestB);

  { Базовый класс Ввода/Вывода }
  TIstinaBaseIO = class(TObject)
  private
    FDemoMode: Boolean;
    function GetTRA: Boolean;
    function GetTRB: Boolean;
  public
    function rPort(Reg: Word): Word; virtual; abstract;
    procedure wPort(Reg: Word; Val: Word); virtual; abstract;
    function Request(const RequestType: TRequestType): Boolean; virtual; abstract;
    function isChanelOK: Boolean;

    constructor Create;
//  published
    property DemoMode: Boolean read FDemoMode write FDemoMode;
    property TRA: Boolean read GetTRA;
    property TRB: Boolean read GetTRB;
  end;


{ STM32F4-Discovery }
{ Виртуальный COM порт на USB }
type
  TCommIO = class(TIstinaBaseIO)
  private
    FComm: TnrComm;

    function CheckBoard: Boolean;
  public
    function rPort(Reg: Word): Word; override;
    procedure wPort(Reg: Word; Val: Word); override;
    function Request(const RequestType: TRequestType): Boolean; override;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

{ Advantech PCI-1751 }
const
  {Port`s}
  PortA0 = 0;
  PortB0 = 1;
  PortC0 = 2;
  PortA1 = 3;
  PortB1 = 4;
  PortC1 = 5;

type
  { Port directions }
  PortDirection = record
  const
    Input   = $00;
    LoutHin = $0F;
    LinHout = $F0;
    Output  = $FF;
  end;

  TPCIIO = class(TIstinaBaseIO)
  private
    fDIO: TInstantDoCtrl;
    function ReadPort(const Port: Integer): Byte;
    procedure WritePort(const Port: Integer; Data: Byte);

    function CheckBoard: Boolean;
    procedure SetReadMode;
    procedure SetWriteMode;
  public
    function rPort(Reg: Word): Word; override;
    procedure wPort(Reg: Word; Val: Word); override;
    function Request(const RequestType: TRequestType): Boolean; override;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs,
  Windows,
	JCLLogic,
  System.Variants,
  TESTER_ISTINA_REG;

procedure PerformanceDelay;
var
  hrRes, hrT1, hrT2, dif: Int64;
begin
  if QueryPerformanceFrequency(hrRes) then
  begin
    QueryPerformanceCounter(hrT1);
    repeat
      QueryPerformanceCounter(hrT2);
      dif := (hrT2 - hrT1) * 10000000 div hrRes;
    until dif > 2;
  end;
end;

{ TCommIO }

function TCommIO.CheckBoard: Boolean;
const
  TimeOut = 100;
var
  i: Integer;
  S: string;
begin
  Result := True;

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
    if FComm.WaitForBytes(Length(CheckStr), TimeOut) then
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
end;

constructor TCommIO.Create(AOwner: TComponent); //; CommPortNumber: Word);
begin
  inherited Create;

  FComm := TnrComm.Create(AOwner);
  FComm.BaudRate := 115200;
  FComm.TimeoutRead := 5000;
  FComm.TimeoutWrite := 500;

  FDemoMode := CheckBoard;
end;

destructor TCommIO.Destroy;
begin
  FComm.Free;

  inherited;
end;

function TCommIO.Request(const RequestType: TRequestType): Boolean;
var
  DataBuf: Byte;
begin
  case RequestType of
    RequestA:
      FComm.SendString('TA');
    RequestB:
      FComm.SendString('TB');
  end;

  if FComm.WaitForBytes(1, DefaultTimeOut) then
  begin
    FComm.Read(@DataBuf, 1);
    if DataBuf = Ord('0') then
      Result := True
    else
      Result := False;
  end
  else
    Result := False;
end;

function TCommIO.rPort(Reg: Word): Word;
var
  OutBuf: array [0 .. 2] of Byte;
  InBuf: array [0 .. 1] of Byte;
begin
  if FDemoMode then
    Exit(0);

  if not Assigned(FComm) then
    Exit(0);

  OutBuf[0] := Ord('R');
  OutBuf[1] := Hi(Reg);
  OutBuf[2] := Lo(Reg);
  FComm.SendData(PAnsiChar(@OutBuf[0]), Length(OutBuf));

  if FComm.WaitForBytes(2, DefaultTimeOut) then
  begin
    FComm.Read(PAnsiChar(@InBuf[0]), Length(InBuf));
    Result := PWord(@InBuf)^;
  end
  else
  begin
    raise EReadError.Create('IO.rPort: Плата не вернула 2 байта данных');
    // ERRORI(50);
    Result := 0;
  end;
end;

procedure TCommIO.wPort(Reg, Val: Word);
var
  DataBuf: array [0 .. 4] of Byte;
  I: Byte;
begin
  if FDemoMode then
    Exit;

  if not Assigned(FComm) then
    Exit;

  DataBuf[0] := Ord('W');
  DataBuf[1] := Hi(Reg);
  DataBuf[2] := Lo(Reg);
  Val := not Val;
  DataBuf[3] := Hi(Val);
  DataBuf[4] := Lo(Val);

  FComm.SendData(PAnsiChar(@DataBuf[0]), Length(DataBuf));

  for I := 0 to 10 do
    PerformanceDelay;
//  Sleep(1);
end;

{ TBaseIO }

constructor TIstinaBaseIO.Create;
begin
  FDemoMode := False;
end;

function TIstinaBaseIO.GetTRA: Boolean;
begin
  Result := Request(RequestA);
end;

function TIstinaBaseIO.GetTRB: Boolean;
begin
  Result := Request(RequestB);
end;

// ------------------------------------------------------------------------------
// Проверка канала передачи данных между ТЕСТЕРОМ и ПК
// ------------------------------------------------------------------------------
function TIstinaBaseIO.isChanelOK: Boolean;
var
  i: Byte;
  DataOut, DataIn: Word;
begin
  Result := True;

  for i := 0 to 15 do
  begin
    DataOut := 1 shl i;
    wPort(REG050, DataOut);
    DataIn := rPort(REG052);
    if DataIn <> DataOut then
    begin
      Result := False;
      Break;
    end;
  end;
end;

{ TPCIIO }

function TPCIIO.ReadPort(const Port: Integer): Byte;
begin
  fDIO.ReadPort(Port, Result);
end;

procedure TPCIIO.WritePort(const Port: Integer; Data: Byte);
begin
  fDIO.WritePort(Port, Data);
end;

function TPCIIO.CheckBoard: Boolean;
type
  PDeviceTreeNode = ^DeviceTreeNode;

var
  sptDevices: OleVariant;
  PElem: PDeviceTreeNode;
  DevicesCount: Integer;

//  devN        : Integer;
//  devDesc     : WideString;
//  devMode     : TOleEnum;
//  devModIndex : Integer;
//
//  devTra: OleVariant;
//  devInfo: DeviceInformation;
//
//  portDirs : array of IPortDirection;
begin
  Result := False;

  sptDevices := fDIO.SupportedDevices;
  PElem := VarArrayLock(sptDevices);
  try
    DevicesCount := VarArrayHighBound(sptDevices, 1) - VarArrayLowBound(sptDevices, 1) + 1;
    try
      if DevicesCount = 0 then
        raise Exception.Create('В системе не установлена плата для связи с тестером!');

//      if DevicesCount > 1 then
//        raise Exception.Create('В системе установлено более одной платы!');

      fDIO.setSelectedDevice(OleVariant(PElem^.DeviceDescription), ModeWrite, 0);
//      fDI.setSelectedDevice(OleVariant(PElem^.DeviceDescription), ModeWrite, 0);
//      if (not fDO.Initialized) and (not fDI.Initialized) then
      if (not fDIO.Initialized) then
        raise Exception.Create('Не удается инициализировать плату: "'+ PElem^.DeviceDescription + '"!');

      if fDIO.Features.PortCount < 6 then
        raise Exception.Create('В плате: "'+ PElem^.DeviceDescription + '" недостаточно портов ввода-вывода!');

//      fDIO.PortDirection[PortC0].Direction := Portdirection.Input;
      SetReadMode;
    except
      on E: Exception do
      begin
        {$IFDEF CONSOLE}
          writeln(E.Message);
        {$ELSE}
          MessageDlg(E.Message, mtError, [mbOk], 0);
        {$ENDIF}

//        ShowMessage(E.Message);
        Result := True;
      end;
    end;
  finally
    VarArrayUnlock(sptDevices);
  end;
end;

constructor TPCIIO.Create(AOwner: TComponent);
begin
  inherited Create;

  try
	  fDIO := TInstantDoCtrl.Create(AOwner);
//  fDI := TInstantDiCtrl.Create(AOwner);
	  FDemoMode := CheckBoard;
	except
		DemoMode := True;
  end;
end;

destructor TPCIIO.Destroy;
begin
  fDIO.Free;
//  fDI.Free;
  inherited;
end;

function TPCIIO.Request(const RequestType: TRequestType): Boolean;
var
  Data: Byte;
begin
	if FDemoMode then
  	Exit(False);

  Data := ReadPort(PortC0);
  case RequestType of
    RequestA:
    	Result := TestBit(Data, 5) = False;
    RequestB:
    	Result := TestBit(Data, 6) = False;
  end;
end;

function TPCIIO.rPort(Reg: Word): Word;
var
//  OutBuf: array [0 .. 2] of Byte;
  InBuf: array [0 .. 1] of Byte;
begin
  if FDemoMode then
    Exit(0);

  SetReadMode;

  { Address }
  fDIO.WritePort(PortA0, Lo(Reg));
  fDIO.WritePort(PortA1, Hi(Reg));

  WritePort(PortC0, ClearBit(ReadPort(PortC0), 0));  // PC1 = 0
  { Data }
  fDIO.ReadPort(PortB0, InBuf[0]);
  fDIO.ReadPort(PortB1, InBuf[1]);
  WritePort(PortC0, SetBit(ReadPort(PortC0), 0));    // PC1 = 1

  { Invert }
  InBuf[0] := not InBuf[0];
  InBuf[1] := not InBuf[1];

  Result := PWord(@InBuf)^;
end;

procedure TPCIIO.wPort(Reg, Val: Word);
var
  i: integer;
begin
  if FDemoMode then
    Exit;

  SetWriteMode;

  { Address }
  fDIO.WritePort(PortA0, Lo(Reg));
  fDIO.WritePort(PortA1, Hi(Reg));

  { Data }
  fDIO.WritePort(PortB0, Lo(not Val));
  fDIO.WritePort(PortB1, Hi(not Val));

  { Strob PC0 }
  WritePort(PortC0, ClearBit(ReadPort(PortC0), 0));  // PC1 = 0
  WritePort(PortC0, SetBit(ReadPort(PortC0), 0));    // PC1 = 1

//  for I := 0 to 4 do
//    PerformanceDelay;
end;

procedure TPCIIO.SetReadMode;
//var
//  portDirs : array of IPortDirection;
begin
  fDIO.PortDirection[PortB0].Direction := Portdirection.Input;
  fDIO.PortDirection[PortB1].Direction := Portdirection.Input;

  { PC17=0 - Read }
  WritePort(PortC1, ClearBit(ReadPort(PortC1), 7));
end;

procedure TPCIIO.SetWriteMode;
begin
  { PC17=1 - Write }
  WritePort(PortC1, SetBit(ReadPort(PortC1), 7));

  fDIO.PortDirection[PortB0].Direction := Portdirection.Output;
  fDIO.PortDirection[PortB1].Direction := Portdirection.Output;
end;

end.
