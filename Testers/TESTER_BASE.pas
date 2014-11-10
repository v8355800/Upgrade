{******************************************************************************}
{                            БАЗОВЫЙ КЛАСС ТЕСТЕРА                             }
{                                                                              }
{                ЗАО НТЦ Схемотехники и Интегральных Технологий                }
{                                     2014                                     }
{******************************************************************************}

unit Tester_BASE;

interface

uses
  System.Classes,
  {PaxRunner,} PaxProgram, PaxCompiler;

const
	{ Режим теста }
  MADC     = 1;                                                                  // АЦП
  MHALT    = 2;                                                                  // Остановка на тесте
  MLOOP    = 4;                                                                  // Зациклить тест
  MSINCH   = 8;                                                                  // Синхронизация
  MSTAT    = 16;                                                                 // Статистика

	MAXPOINT = 100;

type
  { Собития }
  TOnPusk            = procedure of object;
  TOnProgramEndEvent = procedure(Sender: TObject; GroupN: Byte; Defect: Boolean) of object;           // Рабочая программа закончилась
  TOnLogEvent        = procedure(Sender: TObject; const LogMsg: string) of object;                    // Отладочное сообщение
  TOnErrorEvent      = procedure(Sender: TObject; ErrorCode: Cardinal;  ErrorMsg: string) of object;  // Ошибка
  TOnCommmandEvent   = procedure(Sender: TObject; CommandName: String) of object;                     // Комманда

  TFeathers = record
    ADC  : Boolean;
    HALT : Boolean;
    LOOP : Boolean;
  end;

  TConditions = array[1..MAXPOINT] of Integer;
  TCounters = array[1 .. 15, 0 .. 18] of Cardinal;

type
  { Класс для запуска PAX скрипта в отдельном потоке }
  TPaxProgrammThread = class(TThread)
  private
    fPaxProgram: TPaxProgram;
  protected
    procedure Execute; override;
  public
    constructor Create(PaxProgram: TPaxProgram; EndEvent: TNotifyEvent);
  end;

type
  TCustomTester = class(TComponent)
  private
    fCaption : string;
    fWP      : string;  //TStrings;
    fNorms   : string;  //TStrings;

    { SCRIPT ENGINE }
    fMeasureThread     : TThread;
    fPaxCompiler       : TPaxCompiler;
    fPaxPascalLanguage : TPaxPascalLanguage;
    fPaxProgram        : TPaxProgram;

    { События }
    FOnPuskEvent       : TOnPusk;
    FOnProgramEndEvent : TOnProgramEndEvent;
    FOnLogEvent        : TOnLogEvent;
    FOnErrorEvent      : TOnErrorEvent;
    FOnCommandEvent    : TOnCommmandEvent;
    FOnScriptEndEvent  : TNotifyEvent;
  protected
  	fFeathers           : TFeathers;
    fConditions         : TConditions;
    fTesterCaption      : string;
    fTesterShortCaption : string;
    fTesterSignature    : string;
    fCompiled           : Boolean;
    fCounters           : TCounters;                                                    { СЧЕТЧИКИ ПО ПЛАНАМ КЛАССИФИКАЦИИ }
    fUseFileNorm        : Boolean;
    fIgnoreBRAK         : Boolean;                                                      { ИГНОРИРОВАТЬ ВЫХОД ПО FAIL }

//    function GetDemoMode: Boolean; virtual; abstract;

    procedure DoPusk;
    procedure DoProgramEnd( GroupN: Byte; Defect: Boolean);
    procedure DoLog(const LogMsg: string);
    procedure DoError(ErrorCode: cardinal; ErrorMsg: string);
    procedure DoCommand(CommandName: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitScriptEngine(P: Pointer); virtual; abstract;
    procedure SetCondition(TestN: Integer; Condition: Integer);
    procedure ClearCondition(TestN: Integer; Condition: Integer);
    procedure ClearConditions;

    property OnPusk       : TOnPusk            read FOnPuskEvent       write FOnPuskEvent;
    property OnProgramEnd : TOnProgramEndEvent read FOnProgramEndEvent write FOnProgramEndEvent;
    property OnLog        : TOnLogEvent        read FOnLogEvent        write FOnLogEvent;
    property OnError      : TOnErrorEvent      read FOnErrorEvent      write FOnErrorEvent;
    property OnCommand    : TOnCommmandEvent   read FOnCommandEvent    write FOnCommandEvent;
    property OnScriptEnd  : TNotifyEvent       read FOnScriptEndEvent  write FOnScriptEndEvent;

    property TesterCaption: string read fTesterCaption;
    property TesterShortCaption: string read fTesterShortCaption;
    property TesterSignature: string read fTesterSignature;
		property IgnoreBrak: Boolean read FIgnoreBrak write FIgnoreBrak;
//    property DemoMode: Boolean read GetDemoMode;

    { Рабочая программа }
//      property Caption: string read fCaption;
      procedure GetWPFromFile(const FileName: String);
      procedure GetWPFromString(const Text: String);
      function CompileWP: Boolean;
      property WP: String read fWP;// write SetWP;
      procedure GetNormsFromFile(const FileName: String);
      procedure GetNormsFromString(const Text: String); virtual;
      property Norms: String read fNorms;// write SetWP;
      property UseFileNorm: Boolean read fUseFileNorm;

    property Counters: TCounters read fCounters;
    property Feathers: TFeathers read fFeathers;

    procedure ResetTester; virtual; abstract;
    procedure Measure(ResetOnEnd: Boolean = True); virtual;

    procedure ClearCounters;
  end;

var
  NLOOP                         : WORD;                                          { ЧИСЛО ПОВТОРОВ ТЕСТА }

implementation

uses
  System.SysUtils,
  System.IOUtils,
  Vcl.Dialogs;

{ TCustomTester }

function TCustomTester.CompileWP: Boolean;
var
  i: Integer;
begin
  if Trim(fWP) = EmptyStr then
    Exit(False);

  fPaxCompiler.Reset;
  fPaxCompiler.RegisterLanguage(fPaxPascalLanguage);

  fPaxCompiler.AddModule('1', fPaxPascalLanguage.LanguageName);
  fPaxCompiler.AddCode('1', fWP);

  fCompiled := fPaxCompiler.Compile(fPaxProgram);
  if not fCompiled then
    for I := 0 to fPaxCompiler.ErrorCount - 1 do
      DoError(21, '[Line: '+ IntToStr(fPaxCompiler.ErrorLineNumber[I]+1) + '] - ' +fPaxCompiler.ErrorMessage[I]);

  Result := fCompiled;
end;

constructor TCustomTester.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FormatSettings.DecimalSeparator := '.';

	NLOOP := 0;
  fFeathers.ADC       := False;
  fFeathers.HALT      := False;
  fFeathers.LOOP      := False;
  fCaption            := '';
  fTesterCaption      := '';
  fTesterShortCaption := '';
  fTesterSignature    := '';
  fCompiled           := False;
  fIgnoreBRAK         := True;
  fUseFileNorm        := False;
//  fWP                 := TStringList.Create;
//  fNorms              := TStringList.Create;

  ClearCounters;

  fPaxCompiler       := TPaxCompiler.Create(nil);
  fPaxPascalLanguage := TPaxPascalLanguage.Create(nil);
  fPaxProgram        := TPaxProgram.Create(nil);
end;

destructor TCustomTester.Destroy;
begin
//  fWP.Free;
//  fNorms.Free;

  fPaxProgram.Free;
  fPaxPascalLanguage.Free;
  fPaxCompiler.Free;

  inherited;
end;

{ TCustomTester - События }

procedure TCustomTester.DoCommand(CommandName: String);
begin
  if Assigned(FOnCommandEvent) then
    FOnCommandEvent(Self, CommandName);
end;

procedure TCustomTester.DoError(ErrorCode: cardinal; ErrorMsg: string);
begin
  if Assigned(FOnErrorEvent) then
    FOnErrorEvent(Self, ErrorCode, ErrorMsg)
  else
  begin
    {$IFDEF CONSOLE}
      Writeln('ERROR: ', ErrorMsg);
    {$ELSE}
      MessageDlg(Format('ERROR: "%s"', [ErrorMsg]), mtError, [mbOk], 0);
    {$ENDIF}
  end;
end;

procedure TCustomTester.DoLog(const LogMsg: string);
begin
  if Assigned(FOnLogEvent) then
    FOnLogEvent(Self, LogMsg);
end;

procedure TCustomTester.DoProgramEnd(GroupN: Byte; Defect: Boolean);
begin
  if Assigned(FOnProgramEndEvent) then
    FOnProgramEndEvent(Self, GroupN, Defect);
end;

procedure TCustomTester.DoPusk;
begin
  if Assigned(FOnPuskEvent) then
    FOnPuskEvent;
end;

procedure TCustomTester.GetNormsFromFile(const FileName: String);
begin
  fUseFileNorm := FileExists(FileName);
  if not fUseFileNorm then
    Exit;

  GetNormsFromString(TFile.ReadAllText(FileName));
end;

procedure TCustomTester.GetNormsFromString(const Text: String);
begin
	fNorms := Text;
end;

procedure TCustomTester.GetWPFromFile(const FileName: String);
begin
  if not FileExists(FileName) then
    Exit;

  GetWPFromString(TFile.ReadAllText(FileName));
end;

procedure TCustomTester.GetWPFromString(const Text: String);
begin
  fWP := Text;
end;

procedure TCustomTester.Measure(ResetOnEnd: Boolean);
begin
  if not fCompiled then
    Exit;

  fMeasureThread := TPaxProgrammThread.Create(fPaxProgram, OnScriptEnd);
  fMeasureThread.WaitFor;
  fMeasureThread.Free;

  if ResetOnEnd then
    ResetTester;
end;

procedure TCustomTester.ClearCounters;
var
  i, j: Cardinal;
begin
  for i := 1 to 15 do
    for j := 0 to 18 do
      fCounters[i, j] := 0;
end;


procedure TCustomTester.SetCondition(TestN: Integer; Condition: Integer);
begin
  if (fCONDITIONS[TestN] AND Condition) = 0 then
    fConditions[TestN] := fConditions[TestN] + Condition;
end;

procedure TCustomTester.ClearCondition(TestN: Integer; Condition: Integer);
begin
  if (fCONDITIONS[TestN] AND Condition) <> 0 then
    fConditions[TestN] := fConditions[TestN] - Condition;
end;

procedure TCustomTester.ClearConditions;
//var
//  i: Integer;
begin
  FillChar(fCONDITIONS, SizeOf(fCONDITIONS), 0);
//  FOR i := 1 TO MAXPOINT DO
//    fCONDITIONS[i] := 0;{MADC;}
end;


{ TPaxProgrammThread }
constructor TPaxProgrammThread.Create(PaxProgram: TPaxProgram; EndEvent: TNotifyEvent);
begin
  inherited Create(True);
  fPaxProgram := PaxProgram;
  Priority    := tpTimeCritical;
//  FreeOnTerminate := True;
//  OnTerminate := EndEvent;
  Resume;
end;

procedure TPaxProgrammThread.Execute;
begin
  Synchronize(fPaxProgram.Run);
//  fPaxProgram.Free;
end;

end.
