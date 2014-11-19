{******************************************************************************}
{                                   "»—“»Õ¿"                                   }
{                                                                              }
{                «¿Œ Õ“÷ —ıÂÏÓÚÂıÌËÍË Ë »ÌÚÂ„‡Î¸Ì˚ı “ÂıÌÓÎÓ„ËÈ                }
{                                     2014                                     }
{******************************************************************************}

unit TESTER_ISTINA;

interface

uses
  System.Classes,
  TESTER_BASE,
  TESTER_ISTINA_IO,
  TESTER_ISTINA_GLOBAL;

type
  TIstinaResult = record
	  TestNo            : Cardinal;
    TestName          : String;
    PinNo             : Byte;
    LNorm, HNorm, Val : Double;
    Units             : String;
  end;

  TOnMeasureResulTIstinaEvent = procedure(Sender: TObject; Defect: Boolean; MResult: TIstinaResult) of object;  // œÓÎÛ˜ÂÌ ÂÁÛÎ¸Ú‡Ú Á‡ÏÂ‡

type
  TIstina = class(TCustomTester)
  private
    fIO: TIstinaBaseIO;
    FOnMeasureResultEvent : TOnMeasureResulTIstinaEvent;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitScriptEngine(P: Pointer); override;

		procedure DoMeasureResult(Defect: Boolean; MResult: TIstinaResult);
    procedure ResetTester; override;
    procedure Measure(ResetOnEnd: Boolean = True); override;
    procedure GetNormsFromString(const Text: String); override;
  published
    property OnMeasureResult : TOnMeasureResulTIstinaEvent read FOnMeasureResultEvent write FOnMeasureResultEvent;
		property IO : TIstinaBaseIO read fIO write fIO;
//		property IgnoreBrak: Boolean read FIgnoreBrak write FIgnoreBrak;

  { ‘”Õ ÷»» }
	private
    fMeasureResults : array [1 .. maxtest] of Real;
    fPerv: Byte;

    function MASK(N:PINS):WORD;
    function STEP(K:WORD):WORD;
    function CURRENT(M: PINS; I: REAL; RANG: INTEGER; SETD: BOOLEAN): WORD;
    function RANGCURRENT(I: REAL; UNITS: EDIZM): INTEGER;
    function RANGVOLTAGE(U: REAL): INTEGER;
    function SETOI(M: PINS): INTEGER;
    function VOLTAGE(M: PINS; U: REAL; RANG: INTEGER; SETD: BOOLEAN): WORD;
    procedure ERRORI(ErrCode:INTEGER);
    procedure GETRES(M: PINS; NLOOP: INTEGER);
    procedure IDELAY(VAR M: PINS);
    procedure OUTRES;
    procedure PLANPULT(VAR PLAN,PULT:byte);
    procedure SELECT(M: PINS);
    procedure STARTR(REG: WORD);
    procedure TESTEND;
		PRocedure WAITFLAG(FLAG: TRequestType);

		PROCEDURE TESTCONDITIONS(M:PINS);
  public
    function ADC(M: PINS; RNG: REAL; UN: EDIZM): REAL;
    function LESS(M: PINS; DOWN: REAL; E: EDIZM): BOOLEAN;
    function MORE(M: PINS; UP: REAL; E: EDIZM): BOOLEAN;
    function OUTSIDE(M: PINS; DOWN, UP: REAL; E: EDIZM): BOOLEAN;
    function RESVOLT(I: INTEGER; D: SCALE): REAL;
    procedure compare;
    procedure DELAYCOMM(OPT: SELECTOR);
    procedure DELAYMEAS(M: PINS; TON, TOFF: REAL; UN: EDIZM);
    procedure DYNLOAD(M: PINS);
    procedure ENDPROGRAM;
    procedure ENDTEST;
    procedure GROUP(G: INTEGER; E: ITOGO);
    procedure LOAD(M: PINS);
    procedure normlim(M, NUM: INTEGER; r: REAL);
    procedure normlimZ(M, NUM: INTEGER; r: REAL);
    procedure PINOFF(M: PINS);
    procedure PROGRAMMA;
    procedure SETCOMPS(M: PINS; LOWC, HIGHC: REAL; UN: EDIZM);
    procedure SMALL(OPT: SELECTOR);
    procedure SOURCE(M: PINS; FRC: REAL; UF: EDIZM; CLMP: REAL; UC: EDIZM);
    procedure START(M: PINS);
    procedure TEST(N: INTEGER; NAME, UNITS: IMYA);
    procedure TestInc;
    procedure TESTLEN(LEN: REAL; UNITS: EDIZM);
    procedure TestNo(No: INTEGER);

//    function GetDemoMode: Boolean; override;

    property Perv : Byte read fPerv write fPerv;
    property Conditions: TConditions read fConditions write fConditions;
  end;

//var
//  Tester: TIstina;
//  Tester: TCustomTester;

implementation

uses
  Windows,
	System.SysUtils,
  System.TypInfo,
	System.UITypes,
  JclStrings,
  TESTER_ISTINA_REG,
  uTestConditions,
  IMPORT_ISTINA;

{ TIstina }

constructor TIstina.Create(AOwner: TComponent);
var
	i: Byte;
begin
  inherited;

  with fFeathers do
  begin
    ADC  := True;
    HALT := True;
    LOOP := True;
  end;

  fTesterCaption := '“ÂÒÚÂ ÍÓÌÚÓÎˇ ÒÚ‡ÚË˜ÂÒÍËı'#13#10'Ô‡‡ÏÂÚÓ‚ ÷»—'#13#10' ¬ .—»÷.›';
  fTesterShortCaption := '»—“»Õ¿';
  fTesterSignature    := 'ISTINA';
  fPerv := 0;

  fIO := TCommIO.Create(nil); // USB
  if fIO.DemoMode then
  begin
    fIO.Free;
    fIO := nil;
  end;
  if not Assigned(fIO) then
    fIO := TPCIIO.Create(nil);  // PCI-1751
end;

destructor TIstina.Destroy;
begin
  fIO.Free;
  inherited;
end;

procedure TIstina.InitScriptEngine(P: Pointer);
begin
  Register_Istina(fPaxCompiler, P);
end;

procedure TIstina.Measure(ResetOnEnd: Boolean);
begin
  izm_   := 1;
  curgrp := 1;
  lastpl := 0;
  PLAN   := 1;
  PLANK  := 1; { 1-… œÀ¿Õ }

  TOTALADC := True;

  fIO.wPort(REG002, 0);
  fIO.wPort(REG000, OPEN);

  if (not fIO.isChanelOK) and (not fIO.DemoMode) then
  begin
    ERRORI(20);
    Exit;
  end;

  {$IFDEF CONSOLE}
    if not fIO.DemoMode then
    begin
      writeln('Press PUSK...');
      REPEAT
        Sleep(100);
      UNTIL fIO.TRA;
    end;
  {$ENDIF}

  curgrp := 1;
  if fIO.DemoMode then
  begin
    PLAN := 1;
    PULT := 1;
  end
  else
    PLANPULT(PLAN, PULT);

  { TESTER }
  PLANK := PLAN;
  lastpl := PLANK;

  // Start Measure Thread
  inherited Measure(ResetOnEnd);
end;

//function TIstina.GetDemoMode: Boolean;
//begin
//	Result := fIO.DemoMode;
//end;

procedure TIstina.GetNormsFromString(const Text: String);

  procedure ClearNorms;
  var
    i, z: Integer;
  begin
    for z := 1 to maxgroup do
      for i := 1 to maxtest do
        if z < maxgroup then
        begin
          limx[z, i, 1] := 0;
          limx[z, i, 2] := 0;
        end
        else
        begin
          limx[maxgroup, i, 1] := 9999999;
          limx[maxgroup, i, 2] := -9999999;
        end;
  end;

var
  FileText: TStringList;
  Line: string;
  SplitLine: TArray<String>;
  num: Integer;
  i,z: Integer;
begin
  if Trim(Text) = '' then
  begin
    fUseFileNorm := False;
    Exit;
  end;

  maxgrp := 0;
  maxtst := 0;
  fUseFileNorm := True;
  ClearNorms;

  FileText := TStringList.Create;
  try
    FileText.Text := StringReplace(Text, ',', '.', [rfReplaceAll]);

    { Œ·‡·‡Ú˚‚‡ÂÏ ÔÂ‚Û˛ ÒÚÓÍÛ }
    Line := FileText[0];
    SplitLine := Line.Split([#9]);
    for i := 1 to ( (Length(SplitLine) - 4) div 2 ) do
      grpmsg[i] := SplitLine[4+((i-1)*2)];
    maxgrp := (Length(SplitLine) - 4) div 2 + 1;

    FileText.Delete(0);

    { ¬ÒÂ ÓÒÚ‡Î¸Ì˚Â }
    for Line in FileText do
    begin
      SplitLine  := Line.Split([#9]);
      num        := SplitLine[0].ToInteger();                                    { ÕÓÏÂ ÚÂÒÚ‡ }
      tsnam[num] := SplitLine[1];                                                { »Ïˇ ÚÂÒÚ‡ }
      tsun[num]  := SplitLine[2];                                                { ≈‰ËÌËˆ‡ ËÁÏÂÂÌËˇ }
      pnno[num]  := SplitLine[3].ToInteger();                                    { ÕÓÏÂ ËÁÏÂˇÂÏÓ„Ó ‚˚‚Ó‰‡ }

      try
        for i := 1 to maxgrp do //( (Length(SplitLine) - 4) div 2 ) do
        begin
          limx[i, num, 1] := SplitLine[4+((i-1)*2)].ToDouble;
          limx[i, num, 2] := SplitLine[4+((i-1)*2) + 1].ToDouble;
        end;
      except
        DoError(0, 'Œ¯Ë·Í‡ ‚ Ù‡ÈÎÂ ÌÓÏ Ì‡ ÚÂÒÚÂ π' + num.ToString);
      end;
    end;
    maxtst := num;
  finally
    FileText.Free;
  end;

{$IFDEF CONSOLE}
  writeln('ÍÓÎË˜ÂÒÚ‚Ó „ÛÔÔ ', maxgrp:3);
{$ENDIF}

  { 10-‡ˇ „ÛÔÔ‡ Á‡ÔÓÎÌˇÂÚÒˇ ÁÌ‡˜ÂÌËˇÏË:
    ÕËÊÌˇˇ ÌÓÏ‡ - ÏËÌËÏ‡Î¸Ì‡ˇ ÒÂ‰Ë ‚ÒÂı „ÛÔÔ;
    ¬ÂıÌˇˇ ÌÓÏ‡ - Ï‡ÍÒËÏ‡Î¸Ì‡ˇ ÒÂ‰Ë ‚ÒÂı „ÛÔÔ  }
  for i := 1 to maxgrp do
  begin
{$IFDEF CONSOLE}
    writeln(grpmsg[i]);
{$ENDIF}
    for z := 1 to maxtst do
    begin
      if limx[maxgroup, z, 1] > limx[i, z, 1] then
        limx[maxgroup, z, 1] := limx[i, z, 1];

      if limx[maxgroup, z, 2] < limx[i, z, 2] then
        limx[maxgroup, z, 2] := limx[i, z, 2];
    end;
  end;

  inherited;
end;

procedure TIstina.DoMeasureResult(Defect: Boolean; MResult: TIstinaResult);
begin
  if Assigned(FOnMeasureResultEvent) then
    FOnMeasureResultEvent(Self, Defect, MResult);
end;


PROCEDURE TIstina.TESTCONDITIONS(M: PINS);
var
  D: TInputData;
  i: Integer;
  R: Integer;
  Brak: Boolean;
BEGIN
	Brak := False;
	FillChar(D, SizeOf(D), 0);
  D.M := M;
  D.ADCB := ADCB;
  D.TestCaption := TESTNAM;
  D.TestNumber := TestNum;
  D.TestUnits := TESTUN;

	for i := 1 to 16 do
  begin
  	if (OFFPIN and STEP(i)) <> 0 then
    	D.Pins[i].N := D.Pins[i].N + '-';
    D.Pins[i].N := D.Pins[i].N + PINNO[i].ToString.PadLeft(2);
    if (DLOADPIN and STEP(i)) <> 0 then
    	D.Pins[i].N := D.Pins[i].N + 'ƒ'
		else
    	if (LOADPIN and STEP(i)) <> 0 then
	    	D.Pins[i].N := D.Pins[i].N + 'Õ';

  	d.Pins[i].PinOn        := (OFFPIN and STEP(i)) <> 0;
    d.Pins[i].Force        := FORCE[i];
    d.Pins[i].Clamp        := CLAMP[i];
    d.Pins[i].TimeOn       := TIMEON[i];
    d.Pins[i].TimeOff      := TIMEOFF[i];
    d.Pins[i].ForceUnits   := GetEnumName(TypeInfo(EDIZM), Integer(UNITF[i]));
    d.Pins[i].ClampUnits   := GetEnumName(TypeInfo(EDIZM), Integer(UNITC[i]));
    d.Pins[i].TimeOnUnits  := GetEnumName(TypeInfo(EDIZM), Integer(UNITONOFF[i]));
    d.Pins[i].TimeOffUnits := GetEnumName(TypeInfo(EDIZM), Integer(UNITONOFF[i]));

    if i in M then
    begin
	    d.Pins[i].DownLimit := DOWNLIMIT[i];
	    d.Pins[i].DownLimitUnits := GetEnumName(TypeInfo(EDIZM), Integer(UNITCOMP[i]));
	    d.Pins[i].UpLimit := UPLIMIT[i];
	    d.Pins[i].UpLimitUnits := GetEnumName(TypeInfo(EDIZM), Integer(UNITCOMP[i]));
      if ADCB then
      begin
        d.Pins[i].ADC := RES_ADC[i];
        d.Pins[i].ADCUnits := GetEnumName(TypeInfo(EDIZM), Integer(UNITCOMP[i]));
      end;

			if LOW then
			begin
        if (NOT RESLOW and STEP(i)) <> 0 then
        	D.Pins[i].K1 := '1'
        else
        	D.Pins[i].K1 := '0';
				if (RESLOW and STEP(i)) <> 0 THEN
				BEGIN
					D.Pins[i].K1 := D.Pins[i].K1 + '*';
					BRAK := TRUE
				END
			end;

			if HIGH then
			begin
        if (RESHIGH and STEP(i)) <> 0 then
        	D.Pins[i].K2:= '1'
        else
        	D.Pins[i].K2:= '0';
				if (RESHIGH and STEP(i)) <> 0 THEN
				BEGIN
					D.Pins[i].K2 := D.Pins[i].K2 + '*';
					BRAK := TRUE
				END
			end;
    end;
  end;
  D.Brak := Brak;
  D.LenTest := LENTEST;
  D.LenTestUntis := GetEnumName(TypeInfo(EDIZM), Integer(UNITLEN));
  D.Del3 := DEL3;
  D.SmallI := SMALLI;

  R := TfTestConditions.Execute(D);
  case R of
  	mrRetry    : STARTR(REG110);
    mrContinue : HALTB := FALSE;
    mrAbort    :
    begin
	    ENDPROGRAM;
      SKIP := TRUE;
      HALTB := FALSE;
    end;
  end;
END;



//------------------------------------------------------------------------------
// 2^(K-1)
//------------------------------------------------------------------------------
FUNCTION TIstina.STEP(K:WORD):WORD;
VAR
	I,S : WORD;
BEGIN
  S:=1;
  FOR I := 1 TO K - 1 DO
		S := S + S;
	STEP := S;
END;

//------------------------------------------------------------------------------
// ¬€◊»—À»“‹ Ã¿— ” œŒ N
//------------------------------------------------------------------------------
FUNCTION TIstina.MASK(N: PINS): WORD;
VAR
	I,M:WORD;
BEGIN
  M:=0;
  for I IN N do
		M := M OR STEP(I);
	MASK := M;
END;

//------------------------------------------------------------------------------
// ÕŒÃ≈– œÀ¿Õ¿ » œ”À‹“¿
//------------------------------------------------------------------------------
procedure TIstina.PLANPULT(var PLAN, PULT: byte);
VAR
	PLPT: WORD;
BEGIN
	PLPT := fIO.rPort(REG104);
  PULT:=PLPT AND $f;
  PLAN:=(PLPT SHR 4) AND $f;
  if not (PLAN in [1..15]) then
    ERRORI(11);
  if not (PULT in [1..5]) then
    ERRORI(12);
END;

//------------------------------------------------------------------------------
// —·ÓÒ ÚÂÒÚÂ‡
//------------------------------------------------------------------------------
procedure TIstina.ResetTester;
begin
	fIO.wPort(REG020, 0);
	fIO.wPort(REG102, 0);
	fIO.wPort(REG114, 0);
end;

{ Œ∆»ƒ¿Õ»≈ “–.¿ ËÎË “–.¡ }
PROCEDURE TIstina.WAITFLAG(FLAG: TRequestType);
VAR
  i:Cardinal;
BEGIN
  i:=0;

  if not fIO.DemoMode then
  begin
    WHILE (not fIO.Request(FLAG)) DO
    BEGIN
      i:=i+1;
      IF i>100000 THEN
      BEGIN
      	case FLAG of
          RequestA: ERRORI(15);
          RequestB: ERRORI(16);
        end;
      END;
		END;
	end;
END;

{ √ÂÌÂ‡ˆËˇ ËÒÍÎ˛˜ÂÌËˇ ÔË Ó¯Ë·ÍÂ }
PROCEDURE TIstina.ERRORI(ErrCode: INTEGER);
VAR
	ErrorStr: String;
BEGIN
  ResetTester;
	ErrorStr := '“≈—“ π' + IntToStr(TestNum) + ' : ';

  case ErrCode of
    1  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ Õ¿œ–ﬂ∆≈Õ»ﬂ';
    2  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ “Œ ¿';
    3  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ ≈ƒ»Õ»÷€ »«Ã≈–≈Õ»ﬂ Õ¿œ–ﬂ∆≈Õ»ﬂ » “Œ ¿';
    4  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ ≈ƒ»Õ»÷€ »«Ã≈–≈Õ»ﬂ œ–» «¿ƒ¿Õ»» √–¿Õ»÷';
    5  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ «¿ƒ≈–∆ » ¬ À./¬€ À.';
    6  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ »À» ≈ƒ»Õ»÷€ »«Ã≈–≈Õ»ﬂ «¿ƒ≈–∆ » ¬ À./¬€ À.';
    7  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ ƒÀ»“≈À‹ÕŒ—“» “≈—“¿';
    8  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ ≈ƒ»Õ»÷€ »«Ã≈–≈Õ»ﬂ ƒÀ»“≈À‹ÕŒ—“» “≈—“¿';
    9  : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ √–”œœ€';
    10 : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ ÕŒÃ≈–¿ “≈—“¿';
    11 : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ ÕŒÃ≈–¿ œÀ¿Õ¿';
    12 : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ ÕŒÃ≈–¿ œ”À‹“¿';
    14 : ErrorStr := ErrorStr + '—¡Œ… “≈—“≈–¿';
    15 : ErrorStr := ErrorStr + '—À»ÿ ŒÃ ƒŒÀ√Œ Õ≈“ √Œ“Œ¬ÕŒ—“» “≈—“≈–¿';
    16 : ErrorStr := ErrorStr + '—À»ÿ ŒÃ ƒŒÀ√Œ Õ≈“ –≈«”À‹“¿“¿';
    17 : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ «Õ¿◊≈Õ»≈ ƒÀ»“≈À‹ÕŒ—“» “≈—“¿';
    18 : ErrorStr := ErrorStr + 'œ–Œ¬≈–‹ Õ≈ “¿ ¬≈–—»ﬂ';
  end;

  case ErrCode of
    20: ErrorStr := ErrorStr + '“ÂÒÚÂ ‚˚ÍÎ˛˜ÂÌ ËÎË ÔÓ·ÎÂÏ˚ Ò Í‡Ì‡ÎÓÏ ÔÂÂ‰‡˜Ë ‰‡ÌÌ˚ı';
    21: ErrorStr := ErrorStr + '–‡·ÓÚ‡ ‚Â‰ÂÚÒˇ ‚ ÂÊËÏÂ ËÏËÚ‡ˆËË';
  end;

  DoError(ErrCode, ErrorStr + '!');
//  fPaxProgram.GetProgPtr.Pause;
//  fPaxProgram. //GettProgPtr.Reset;
//  raise Exception.Create(ErrorStr);
END;

PROCEDURE TIstina.STARTR(REG:WORD);
VAR
	PL, PT:byte;
BEGIN
  fIO.wPort(REG402,COMU[1] ); fIO.wPort(REG422,COMU[2] ); fIO.wPort(REG442,COMU[3] );
  fIO.wPort(REG462,COMU[4] ); fIO.wPort(REG502,COMU[5] ); fIO.wPort(REG522,COMU[6] );
  fIO.wPort(REG542,COMU[7] ); fIO.wPort(REG562,COMU[8] ); fIO.wPort(REG602,COMU[9] );
  fIO.wPort(REG622,COMU[10]); fIO.wPort(REG642,COMU[11]); fIO.wPort(REG662,COMU[12]);
  fIO.wPort(REG702,COMU[13]); fIO.wPort(REG722,COMU[14]); fIO.wPort(REG742,COMU[15]);
  fIO.wPort(REG762,COMU[16]);
  fIO.wPort(REG,0);
  WAITFLAG(RequestB);

  if fIO.DemoMode then
  begin
    PL := PLAN;
    PT := PULT;
  end
  else
    PLANPULT(PL,PT);
  IF (PL<>PLAN)OR(PT<>PULT) THEN
  	ERRORI(14);
END;

//------------------------------------------------------------------------------
//  ¿ »≈ »—“Œ◊Õ» » œ–Œ√–¿ÃÃ»–Œ¬¿“‹
//------------------------------------------------------------------------------
PROCEDURE TIstina.SELECT(M: PINS);
BEGIN
	fIO.wPort(REG340, MASK(M))
END;

//------------------------------------------------------------------------------
// ¬Œ«¬– ƒ»¿œ¿«ŒÕ Õ¿œ–ﬂ∆≈Õ»ﬂ
//------------------------------------------------------------------------------
FUNCTION TIstina.RANGVOLTAGE(U:REAL):INTEGER;
BEGIN
  IF      ABS(U)<=2  THEN RANGVOLTAGE:=1
  ELSE IF ABS(U)<=8  THEN RANGVOLTAGE:=2
  ELSE IF ABS(U)<=20 THEN RANGVOLTAGE:=3
  ELSE ERRORI(1);
END;

//------------------------------------------------------------------------------
// ¬Œ«¬– ƒ»¿œ¿«ŒÕ “Œ ¿
//------------------------------------------------------------------------------
FUNCTION TIstina.RANGCURRENT(I:REAL; UNITS:EDIZM):INTEGER;
BEGIN
  IF ABS(I)<=8 THEN
  BEGIN
  	case UNITS of
    	NA  : RANGCURRENT := 0;
      MKA : RANGCURRENT := 2;
      MA  : RANGCURRENT := 5;
    end;
  END
  ELSE
    IF ABS(I)<=80 THEN
    BEGIN
      case UNITS of
        NA  : RANGCURRENT := 0;
        MKA : RANGCURRENT := 3;
        MA  : RANGCURRENT := 6;
      end;
    END
    ELSE
      IF ABS(I)<=800 THEN
      BEGIN
        case UNITS of
          NA  : RANGCURRENT := 1;
          MKA : RANGCURRENT := 4;
          MA  : RANGCURRENT := 7;
        end;
      END
      ELSE
      	ERRORI(2);
END;

//------------------------------------------------------------------------------
// ¬Œ«¬–. Ã¿— ” ”–Œ¬Õﬂ Õ¿œ–ﬂ∆≈Õ»ﬂ » —Œ’–¿Õﬂ≈“ ƒ»— –≈“ÕŒ—“‹ ¿÷œ
// SETD - ‘À¿√ —Œ’–¿Õ≈Õ»ﬂ ƒ»— –≈“ÕŒ—“» ¿÷œ
//------------------------------------------------------------------------------
FUNCTION TIstina.VOLTAGE(M: PINS; U: Real; RANG: INTEGER; SETD: Boolean): WORD;
VAR
	DISCRET : Real;
	K       : NUMBER;
	MASKA   : WORD;
BEGIN
	case RANG of
    1 : BEGIN DISCRET := 0.5E-3; MASKA := $1000; END;
    2 : BEGIN DISCRET := 2E-3  ; MASKA := $2000; END;
    3 : BEGIN	DISCRET := 5E-3  ; MASKA := $3000; END;
  end;

	MASKA := MASKA OR (ROUND(ABS(U) / DISCRET));
	IF U < 0 THEN
		MASKA := MASKA OR $8000;
	IF SETD THEN
		FOR K IN M DO
			DISCRADC[K] := DISCRET;

  VOLTAGE := MASKA;
END;

//------------------------------------------------------------------------------
// ¬Œ«¬–. Ã¿— ” ”–Œ¬Õﬂ “Œ ¿ » —Œ’–¿Õﬂ≈“ ƒ»— –≈“ÕŒ—“‹ ¿÷œ
//------------------------------------------------------------------------------
FUNCTION TIstina.CURRENT(M:PINS; I:REAL; RANG:INTEGER; SETD:BOOLEAN):WORD;
VAR
	DISCRET : REAL;
	K       : NUMBER;
	MASKA   : WORD;
BEGIN
	case RANG of
    0 : BEGIN DISCRET := 0.02  ; MASKA := $0000; END;
    1 : BEGIN DISCRET := 0.2   ; MASKA := $1000; END;
    2 : BEGIN DISCRET := 2E-3  ; MASKA := $2000; END;
    3 : BEGIN DISCRET := 20E-3 ; MASKA := $3000; END;
    4 : BEGIN DISCRET := 200E-3; MASKA := $4000; END;
		5 : BEGIN DISCRET := 2E-3  ; MASKA := $5000; END;
    6 : BEGIN DISCRET := 20E-3 ; MASKA := $6000; END;
    7 : BEGIN DISCRET := 200E-3; MASKA := $7000; END;
  end;

  MASKA := MASKA OR (ROUND(ABS(I)/DISCRET));
  IF I<0 THEN
  	MASKA:=MASKA OR $8000;
  IF SETD THEN
  	FOR K IN M do
    	DISCRADC[K]:=DISCRET;

  CURRENT:=MASKA;
END;

PROCEDURE TIstina.IDELAY(VAR M:PINS);
VAR
	K       : NUMBER;
  DISCRET : REAL;
	MASKA   : WORD;
BEGIN
 IF M<>[] THEN BEGIN

   IF CHANGEDELAYRANG THEN BEGIN
     TIMERANG:=0;
     FOR K:=1 TO 16 DO
       IF (TIMEOFF[K]>1.5)OR(TIMEON[K]>1.5) THEN TIMERANG:=1;
     M:=[1..16]
   END{IF};

   IF TIMERANG=0 THEN	 BEGIN DISCRET:=0.1; COM116:=COM116 AND $fdff END
   ELSE { TIMERANG=1 } BEGIN DISCRET:=1  ; COM116:=COM116 OR	$200   END;
   FOR K:=1 TO 16 DO IF K IN M THEN BEGIN
     MASKA:=ROUND(TIMEOFF[K]/DISCRET)*16;
     MASKA:=MASKA OR (ROUND(TIMEON[K]/DISCRET));
     COM376[K]:=COM376[K] AND $ff00 OR MASKA;
     fIO.wPort(REG340, STEP(K)); fIO.wPort(REG376,COM376[K]);
   END{FOR};
   M:=[];
 END{IF}
END;

FUNCTION TIstina.SETOI(M:PINS):INTEGER;
VAR
	K : NUMBER;
BEGIN
  FOR K IN M DO
  	SETOI := K;
END;

PROCEDURE TIstina.GETRES(M:PINS; NLOOP:INTEGER);
VAR
	K         : NUMBER;
	VALUE     : INTEGER;
	VAL,MASKA : WORD;
BEGIN
  REPEAT
    IF ADCSTAT THEN BEGIN { «¿œŒÃÕ»“‹ –≈«. ¿÷œ }
      K:=SETOI(M); VAL:=fIO.rPort(REG044);
      IF (VAL AND $8000)=0 THEN VALUE:=VAL ELSE VALUE:=-(VAL AND $7fff);
      RES_ADC[K]:=VALUE*DISCRADC[K];
      EDIZMRES[K]:=UNITCOMP[K]
    END{IF};

    MASKA:=MASK(M); {LOW}upCOMP:=fIO.rPort(REG040); {UP}lowCOMP:=fIO.rPort(REG042);
    { —Õﬂ“‹ –≈«”À‹“¿“  ŒÃœ¿–¿“Œ–Œ¬ }
    IF LOW AND HIGH THEN
    BEGIN
      RESHIGH:={LOW}upCOMP AND MASKA;
      RESLOW :=NOT {UP}lowCOMP AND MASKA;
      RESCOM:=RESLOW OR RESHIGH;
    END{IF}
    ELSE IF HIGH THEN
    BEGIN
      RESHIGH:={LOW}upCOMP AND MASKA;
      RESLOW:=0; RESCOM:=RESHIGH;
    END{ELSE}
    ELSE { LOW }
    BEGIN
      RESLOW:=NOT {LOW}upCOMP AND MASKA;
      RESHIGH:=0; RESCOM:=RESLOW;
    END{ELSE};

    IF STOP THEN
    BEGIN
      IF HALTB THEN
      	TESTCONDITIONS(M)
      ELSE
      	IF LOOP THEN
        BEGIN
					NLOOP:=NLOOP-1;
					IF NLOOP>0 THEN
          	STARTR(REG110)
          ELSE
          	LOOP:=FALSE
      	END{ELSE}
    END{IF}
  UNTIL NOT HALTB AND NOT LOOP;
END;

PROCEDURE TIstina.TESTEND;
BEGIN
  IF STOP THEN
    fIO.wPort(REG112,0);

  WAITFLAG(RequestA);

  DoCommand('TESTEND');
END;

{ œ≈◊¿“‹ –≈«-“¿ }
procedure TIstina.OUTRES;
VAR
  I: NUMBER;
  ResRecord: TIstinaResult;
BEGIN
//  FOR I := 1 TO 16 DO
//    IF I IN N THEN
  for I in N do
  BEGIN
    if not fUseFileNorm then
    begin
//      if wrfile > 1 then
//        if testnum > maxtst then
//          maxtst := testnum;
      if not((lim[testnum, 1] = -999) and (lim[testnum, 2] = -999)) then
        fMeasureResults[testnum] := RES_ADC[I];
      ResRecord.LNorm := lim[testnum, 1];
      ResRecord.HNorm := lim[testnum, 2];
    end
    else
    begin
      if not((limx[1, testnum, 1] = -999) and (limx[1, testnum, 2] = -999))  then
        fMeasureResults[testnum] := RES_ADC[I];
      ResRecord.LNorm := limx[1, testnum, 1];
      ResRecord.HNorm := limx[1, testnum, 2];
    end;

    ResRecord.TestNo := testnum;
    ResRecord.TestName := TESTNAM;
    ResRecord.PinNo := PINNO[I];
    ResRecord.Val := RES_ADC[I];
    ResRecord.Units := testun;
    DoMeasureResult(Grief, ResRecord);
  END;
END;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

{ Œ“ Àﬁ◊≈Õ»≈ ¬€¬ŒƒŒ¬ }
procedure TIstina.PINOFF(M: PINS);
BEGIN
  IF SKIP THEN
    EXIT;
  OFFPIN := MASK(M);
  fIO.wPort(REG022, OFFPIN);
END;

{ œŒƒ Àﬁ◊≈Õ»≈ Õ¿√–”« » }
procedure TIstina.LOAD(M: PINS);
BEGIN
  IF SKIP THEN
    EXIT;
  LOADPIN := MASK(M);
  fIO.wPort(REG030, LOADPIN);
END;

{ œŒƒ Àﬁ◊≈Õ»≈ ƒ»Õ Õ¿√–”« » }
procedure TIstina.DYNLOAD(M: PINS);
BEGIN
  IF SKIP THEN
    EXIT;
  DLOADPIN := MASK(M);
END;

{ ¬ Àﬁ◊≈Õ»≈ «¿ƒ≈–∆ » Õ¿  ŒÃÃ”“¿÷»ﬁ }
procedure TIstina.DELAYCOMM(OPT: SELECTOR);
BEGIN
  IF SKIP THEN
    EXIT;

  case OPT of
		sON  : begin COM116 := COM116 OR   $400; DEL3 := TRUE;  end;
    sOFF : begin COM116 := COM116 AND $fbff; DEL3 := FALSE; end;
  end;
END;

{ ¬ Àﬁ◊≈Õ»≈ –≈∆»Ã¿ Ã¿À€’ “Œ Œ¬ }
procedure TIstina.SMALL(OPT:SELECTOR);
BEGIN
  IF SKIP THEN
  	EXIT;

	case OPT of
		sON  : BEGIN COM116 := COM116 OR   $800; SMALLI := True;  END;
    sOFF : BEGIN COM116 := COM116 AND $f7ff; SMALLI := FALSE; END;
  end;
END;

{ «¿ƒ¿Õ»≈ ƒÀ»“≈À‹ÕŒ—“» “≈—“¿ }
procedure TIstina.TESTLEN(LEN:REAL; UNITS:EDIZM);
VAR
	RANG   :INTEGER;
	DISCRET:REAL;
BEGIN
  IF (UNITS<>MS)AND(UNITS<>S) THEN
  	ERRORI(8);
  IF LEN<0 THEN
  	ERRORI(7);
  IF SKIP THEN
  	EXIT;

  CHANGELENGTH:=TRUE;
  IF UNITS=MS THEN
  BEGIN
    IF      LEN< 0.5  THEN ERRORI(7)
    ELSE IF LEN<=12.7 THEN RANG:=0
    ELSE IF LEN<=127  THEN RANG:=1
    ELSE BEGIN UNITS:=S; LEN:=LEN/1000 END
  END;

  IF UNITS=S THEN
  BEGIN
    IF      LEN<=1.27 THEN RANG:=2
    ELSE IF LEN<=12.7 THEN RANG:=3
    ELSE ERRORI(7)
  END;

  LENTEST:=LEN; UNITLEN:=UNITS; { —Œ’–¿Õ»“‹ œ¿–¿Ã≈“–€ }
  COM116:=COM116 AND $fe00;
  case RANG of
  	0 : DISCRET := 0.1;
    1 : BEGIN DISCRET := 1	 ; COM116 := COM116 OR  $80; END;
    2 : BEGIN DISCRET := 0.01; COM116 := COM116 OR $100; END;
  else
		BEGIN DISCRET:=0.1 ; COM116:=COM116 OR  $180 END;
  end;
  COM116:=COM116 OR (ROUND(LEN/DISCRET));
END;

//------------------------------------------------------------------------------
// œŒ√–¿ÃÃ»–Œ¬¿Õ»≈ »—“Œ◊Õ» Œ¬ + ”—“¿ÕŒ¬ ¿ COM376
//------------------------------------------------------------------------------
procedure TIstina.SOURCE(M:PINS; FRC :REAL; UF:EDIZM; CLMP:REAL; UC:EDIZM);
VAR
	K     : NUMBER;
	RANG  : INTEGER;
	UTEMP : WORD;
	MODE  : TYPMODE;
BEGIN
  IF SKIP THEN
  	EXIT;

  SELECT(M);
  NEWMODE := NEWMODE+M;                                                          { Œ¡ÕŒ¬»À» }

  case UF of
    V           : MODE := U;
    NA, MKA, MA : MODE := I;
  else
		ERRORI(3);
  end;

	case MODE of
		U:
			begin
				IF (UC <> NA) AND (UC <> MKA) AND (UC <> MA) THEN
					ERRORI(3);
				UTEMP := VOLTAGE(M, FRC, RANGVOLTAGE(FRC), FALSE);
				RANG  := RANGCURRENT(CLMP, UC);
        fIO.wPort(REG364, CURRENT(M, CLMP, RANG, TRUE));
			end;
		I:
			begin
				IF UC <> V THEN
					ERRORI(3);
				fIO.wPort(REG364, CURRENT(M, FRC, RANGCURRENT(FRC, UF), FALSE));
				UTEMP := VOLTAGE(M, CLMP, RANGVOLTAGE(CLMP), FALSE);
			end;
	end;

  for K in M do
		BEGIN
			FORCE[K]  := FRC;
			UNITF[K]  := UF;
			CLAMP[K]  := CLMP;
			UNITC[K]  := UC;                                                           { —Œ’–¿Õ»“‹ œ¿–¿Ã≈“–€ }
			COMU[K]   := UTEMP;                                                        { COMI[K]:=ITEMP; }
			MOD376[K] := MODE;

      case MODE of
        U:
          BEGIN
            COM376[K] := COM376[K] AND $FEFF;                                    { «¿œŒÃÕ»“‹ –≈∆»Ã »—“Œ◊Õ» Œ¬ }
            CLAMPRANGE[K] := RANG;                                               { «¿œŒÃÕ»“‹ ƒ»¿œ¿«ŒÕ CLMPI ƒÀﬂ «¿ƒ¿Õ»ﬂ ƒ»¿œ¿«ŒÕ¿  ŒÃœ¿–¿“Œ–Œ¬ }
          END;
        I: COM376[K] := COM376[K] OR $100;
      end;
		END;
END;

//------------------------------------------------------------------------------
// «¿ƒ¿Õ»≈ √–¿Õ»÷ –¿«¡–¿ Œ¬ »
//------------------------------------------------------------------------------
procedure TIstina.SETCOMPS(M: PINS; LOWC, HIGHC: REAL; UN: EDIZM);
VAR
	K, INDEX: NUMBER;
	RANG: INTEGER;
	MODE: TYPMODE;
BEGIN
	IF SKIP THEN
		EXIT;

	LOW  := TRUE;
	HIGH := TRUE;

  case UN of
    V           : MODE := I;
    NA, MKA, MA : MODE := U;
  else
		ERRORI(4);
  end;

  for K in M do
  BEGIN
    IF CMPCHK AND (MODE <> MOD376[K]) THEN
      ERRORI(4);
    INDEX        := K;
    DOWNLIMIT[K] := LOWC;
    UPLIMIT[K]   := HIGHC;
    UNITCOMP[K]  := UN
  END;

	SELECT(M);

  case MODE of
    U:
    	BEGIN
				{ ¬ –≈∆»Ã≈ U ƒ»¿œ  ŒÃœ¿–¿“Œ–Œ¬ ”—“¿Õ¿¬À»¬¿≈“—ﬂ œŒ ƒ»¿œ CLAMPI }
				fIO.wPort(REG366, CURRENT(M, HIGHC, CLAMPRANGE[INDEX], FALSE));
				fIO.wPort(REG370, CURRENT(M, LOWC, CLAMPRANGE[INDEX], FALSE))
			END;
    I:
      BEGIN
        RANG := RANGVOLTAGE(HIGHC);
        fIO.wPort(REG366, VOLTAGE(M, HIGHC, RANG, TRUE));
        fIO.wPort(REG370, VOLTAGE(M, LOWC, RANG, FALSE))
      END;
  end;
END;

{ «¿ƒ¿Õ»≈ «¿ƒ≈–∆ » ¬ À/¬€ À }
{ ”—“¿Õ¿¬À»¬¿≈“ Ã¿— » COM376 » COM116 }
procedure TIstina.DELAYMEAS(M:PINS; TON,TOFF:REAL; UN:EDIZM);
VAR     RANG:INTEGER;
	K:NUMBER;

 function RANGTIME(TIME:REAL):INTEGER;
 BEGIN
   IF      TIME<=1.5 THEN RANGTIME:=0
   ELSE IF TIME<=15  THEN RANGTIME:=1
   ELSE ERRORI(5)
 END;

BEGIN
  IF UN<>MS THEN
  	ERRORI(6);
  IF (TON<0)OR(TOFF<0) THEN
  	ERRORI(5);
  IF SKIP THEN
  	EXIT;

  NEWMODE:=NEWMODE+M; { Œ¡ÕŒ¬»À» }

  IF TON>TOFF THEN RANG:=RANGTIME(TON)
  ELSE             RANG:=RANGTIME(TOFF);

  IF RANG<>TIMERANG THEN
  	CHANGEDELAYRANG:=TRUE;

  FOR K IN M do
  BEGIN
    TIMEON[K]    := TON;
    TIMEOFF[K]   := TOFF;
    UNITONOFF[K] := UN;   { —Œ’–¿Õ»“‹ œ¿–¿Ã≈“–€ }
  END;
END;

//------------------------------------------------------------------------------
//  ŒÕ≈÷ œ–Œ√–¿ÃÃ€
//------------------------------------------------------------------------------
procedure TIstina.ENDPROGRAM;
BEGIN
  IF SKIP THEN
    EXIT;

  endpr := true;

  IF TOTALBRAK THEN
  begin
    GROUP(7, FAIL);
    DoProgramEnd(7, True);
  end
  else if (curgrp <> 0) then
  begin
    DoProgramEnd(curgrp, False);
    GROUP(curgrp, PASS);
  end;

  IF TOTALBRAK THEN
    Inc(fCounters[PLAN, 17])
  ELSE
    Inc(fCounters[PLAN, 16]);

//{$IFDEF CONSOLE}
//  IF PLAN = PLANK THEN
//  BEGIN
//    IF TOTALADC THEN
//    BEGIN
//      WRITELN;
//      IF TOTALBRAK THEN
//      begin
//        textcolor(12);
//        WRITELN('***  FAIL  ***');
//        textcolor(15);
//      end
//      ELSE
//      begin
//        textcolor(11);
//        WRITE('<<< PASS >>>');
//        { textcolor(10); }
//        if maxgrp > 1 then
//          WRITELN('   √ÛÔÔ‡:', grpmsg[curgrp])
//        else
//          WRITELN;
//      end;
//    END;
//    textcolor(14);
//    WRITE(' ”ƒ¿? (<œ”— > ; <Ã≈Õﬁ  "¿">=<¬ > ; <Ã≈Õﬁ  "¡">=1) > ');
//  END;
//{$ENDIF}

  DoCommand('ENDPROGRAM');
END;

{ Õ¿◊¿ÀŒ œ–Œ√–¿ÃÃ€ »—œ€“¿Õ»… }
procedure TIstina.PROGRAMMA;
VAR
  K: NUMBER;
  i: byte;
BEGIN
  LOOP      := FALSE;
  SINCH     := FALSE;
  STAT      := FALSE;
  endpr     := FALSE;
  ADCB      := FALSE;
  HALTB     := FALSE;
  TOTALBRAK := FALSE;
  SKIP      := FALSE;

  FOR K := 1 TO 16 DO
  BEGIN
    PINNO[K] := K;
    RES_ADC[K] := 0;
  END;

  PINOFF([]);
  LOAD([]);
  NEWMODE := [];
  TIMERANG := 0;
  DLOADPIN := 0;
  TESTLEN(0.5, MS);
  DELAYCOMM(sOFF);
  SMALL(sOFF);
  N := [1 .. 16];
  SOURCE(N, 0, V, 0, MA);
  SETCOMPS(N, 0, 0, MA);
  DELAYMEAS(N, 0, 0, MS);

  Inc(fCounters[PLAN, 18]); { ¬—≈√Œ }

//{$IFDEF CONSOLE}
//  COUNT := 0;
//{$ENDIF}

//  countf := 0;
  testnum := 0;
//  FIRST := TRUE;
//  IF ST.SAVE < ST.LEN THEN
//    ST.SAVE := ST.LEN;
//  ST.LEN := 0;
  PLN := PLAN;
//  if wrfile > 1 then
  for i := 1 to maxtest do
    fMeasureResults[i] := 0;
  if {(wrfile = 0) and }(not fUseFileNorm) then
    IF ((fCounters[PLAN, 18] = 1) or (lastpl <> PLAN)) then
    begin
      for i := 1 to 100 do
      begin
//        pars[i]   := '';
        lim[i, 1] := 0;
        lim[i, 2] := 0;
      end;
      maxtst := 0;
      // noprs:=0;
    end;
  numtst := 0;
//  if (wrfile > 0) or onz then
//    USETT := ADCTT;
  { if usett=adctt then write('other') else write('adctt');{ }
  DoCommand('PROGRAMMA');
END; { programma }

{ Õ¿◊¿ÀŒ “≈—“¿ }
procedure TIstina.TEST(N: INTEGER; NAME, UNITS: IMYA);
BEGIN
	IF N > MAXPOINT THEN
		ERRORI(10);
	IF SKIP THEN
		EXIT;

	CHANGEDELAYRANG := FALSE;
	CHANGELENGTH    := FALSE;
	COM116          := COM116 AND $FFF;
	GRIEF           := FALSE;
	numtst          := numtst + 1;
	RESCOM          := 0;
	RESHIGH         := 0;
	RESLOW          := 0;
	TESTNAM         := NAME;
	testnum         := N;
	TESTUN          := UNITS;

  DoCommand('TEST');
END;

{  ŒÕ≈÷ “≈—“¿ }
procedure TIstina.ENDTEST;
//var 	s,s1,s2:string;
//	re:real;
//  iii: Integer;
//	aa:integer;
//	I:NUMBER;
//	xx,yy:byte;
BEGIN
  IF SKIP THEN
    EXIT;

  IF ADCB and ((fCONDITIONS[TESTNum] AND MHALT) = 0) THEN
    OUTRES;

  DoCommand('ENDTEST');

//  iii := 1;
//  IF (fCounters[PLAN, 18] = 2) and (not filenrm) THEN
//  begin { Á‡ÔËÒ¸ ËÏÂÌË ÚÂÒÚ‡ Ë ÌÓÏ ‚ ÍÓÌˆÂ Í‡Ê‰Ó„Ó ÚÂÒÚ‡ Ì‡ ÔÂ‚ÓÈ ÒıÂÏÂ }
//    FOR I := 1 TO 16 DO
//      IF I IN N THEN
//      begin
//        aa := PINNO[I];
//        lim[iii, 2] := uplimit[I];
//        lim[iii, 1] := downlimit[I];
//      end;
//    str(aa, s1);
//    pars[iii] := testnam + '_' + s1 + '_(' + testun + ')';
//    while Pos(' ', pars[iii]) > 0 do
//      pars[iii][Pos(' ', pars[iii])] := '_';
//    if not high then
//    begin
//      lim[iii, 1] := lim[iii, 2];
//      lim[iii, 2] := 99999;
//    end;
//    if not low then
//      lim[iii, 1] := -99999;
//    maxtst := iii;
//    if lim[iii, 1] > lim[iii, 2] then
//    begin
//      re := lim[iii, 1];
//      lim[iii, 1] := lim[iii, 2];
//      lim[iii, 2] := re;
		// end;
		// iii := iii + 1;
		// end;
	END;

//------------------------------------------------------------------------------
// œŒƒ—¬≈“ √–”œœ€  À¿——»‘» ¿÷»»
//------------------------------------------------------------------------------
procedure TIstina.GROUP(G: INTEGER; E: ITOGO);
BEGIN
  IF (G > 15) OR (G < 0) THEN
    ERRORI(9);
  IF SKIP THEN
    EXIT;

  IF E = PASS THEN
  begin
    Grief := FALSE;
    curgrp := G;
  end
  ELSE { E=FAIL }
  BEGIN
    GRIEF := TRUE;
    // if not endpr and not totalbrak then fpr[numtst]:=fpr[numtst]+1;
    TOTALBRAK := TRUE
  END;

  IF NOT((E = PASS) AND TOTALBRAK) and endpr THEN
  BEGIN
    fIO.wPort(REG036, G);
    Inc(fCounters[PLAN, G]);
  END;
//  IF PLAN = PLANK THEN
    // IF USETT=OTHER THEN BEGIN
    // WRITECOUNT(PLAN,G);{ œ≈◊¿“¿“‹ —◊≈“◊» » }
    // DIRECT(CHR(36+G),':');
    // IF E=FAIL THEN WRITE(TESTNAM)
    // ELSE WRITE('√ŒƒÕ')
    // END{IF};
  IF (NOT fIgnoreBRAK) and (E = fail) and not endpr THEN
  BEGIN
    ENDTEST;
    ENDPROGRAM;
    SKIP := TRUE;
  END;
END;

//{ œŒƒ—¬≈“ √–”œœ€  À¿——»‘» ¿÷»» }
//procedure TIstina.GROUP2(G:INTEGER; E:ITOGO);
//BEGIN
//  IF (G>15)OR(G<0) THEN ERRORI(9); { ¬ ÃŒÕ»“Œ– }
//  IF SKIP THEN EXIT;
//  IF E=PASS THEN begin GRIEF:=FALSE; curgrp:=g; end
//  ELSE { E=FAIL }
//    BEGIN
//      GRIEF:=TRUE;
////      if not endpr and not totalbrak then fpr[numtst]:=fpr[numtst]+1;
//      TOTALBRAK:=TRUE
//    END;
//  IF NOT((E=PASS)AND TOTALBRAK) and endpr  THEN BEGIN
//    fIO.wPort(REG036,G);
//    COUNTERS[PLAN,G]:=COUNTERS[PLAN,G]+1
//  END{IF};
//  IF PLAN=PLANK THEN
////    IF USETT=OTHER THEN BEGIN
////      WRITECOUNT(PLAN,G);{ œ≈◊¿“¿“‹ —◊≈“◊» » }
////      DIRECT(CHR(36+G),':');
////      IF E=FAIL THEN WRITE(TESTNAM)
////      ELSE WRITE('√ŒƒÕ')
////    END{IF};
//  IF (NOT IGNORE) and (e=fail) and not endpr THEN BEGIN  ENDPROGRAM; SKIP:=TRUE; END;
//END;

procedure TIstina.START(M:PINS);
VAR
	K:NUMBER;
BEGIN
  IF SKIP THEN
  	EXIT;

  { œ–Œ¬≈–»“‹ —ŒŒ“¬≈“—“¬»≈ «¿ƒ≈–∆≈  }
  IF CHANGELENGTH THEN
    IF UNITLEN=MS THEN
      FOR K:=1 TO 16 DO
				IF TIMEON[K]>LENTEST THEN
        	ERRORI(17);

  N:=M; IDELAY(NEWMODE);
  IF PLAN=PLANK THEN
  BEGIN
    ADCB  := (fCONDITIONS[testnum] AND MADC  )<>0;
    STAT  := (fCONDITIONS[testnum] AND MSTAT )<>0;
    HALTB := (fCONDITIONS[testnum] AND MHALT )<>0;
    LOOP  := (fCONDITIONS[testnum] AND MLOOP )<>0;
    SINCH := (fCONDITIONS[testnum] AND MSINCH)<>0;
  END;
  ADCB    := ADCB OR HALTB;
  STOP    := HALTB OR LOOP;                                                      { —“Œœ “≈—“ }
  ADCSTAT := ADCB OR STAT;                                                       { «¿Ã≈– ¿÷œ }
  IF ADCSTAT THEN COM116:=COM116 OR $1000;
  IF STOP    THEN COM116:=COM116 OR $2000;
  IF SINCH   THEN fIO.wPort(REG106,0);
  fIO.wPort(REG116,COM116);                                                      { Œ¡. ”—À. Õ¿ “≈—“≈ }
  IF N<>[] THEN
  BEGIN
    IF ADCSTAT THEN
    	fIO.wPort(REG046,SETOI(N)-1);
    fIO.wPort(REG030,LOADPIN OR DLOADPIN);
    STARTR(REG100);                                                              { Õ¿◊¿“‹ »—œ€“¿Õ»ﬂ }
    fIO.wPort(REG030,LOADPIN);
    GETRES(N,NLOOP);
    TESTEND;
  END;
END;

function TIstina.MORE(M:PINS; UP:REAL; E:EDIZM):BOOLEAN;
VAR
	K:INTEGER;
BEGIN
  IF SKIP THEN
  	EXIT;

  SETCOMPS(M,0,UP,E);
  LOW:=FALSE;
  START(M);
  IF ADCSTAT THEN
  BEGIN
    K:=SETOI(M);
    IF UP>0 THEN
    	MORE:=RES_ADC[k]>UP
    ELSE
    	MORE:=RES_ADC[k]<UP;
//    lasti:=k;
  END
  ELSE
  	MORE:=RESCOM<>0;
END;

function TIstina.LESS(M:PINS; DOWN:REAL; E:EDIZM):BOOLEAN;
VAR
	K:INTEGER;
BEGIN
  IF SKIP THEN
  	EXIT;

  SETCOMPS(M,0,DOWN,E);
  HIGH:=FALSE;
  START(M);
  IF ADCSTAT THEN
  BEGIN
    K:=SETOI(M);
    IF DOWN>0 THEN
    	LESS:=RES_ADC[k]<DOWN
    ELSE
    	LESS:=RES_ADC[k]>DOWN;
//    lasti:=k;
  END
  ELSE
  	LESS:=RESCOM<>0;
END;


function TIstina.OUTSIDE(M:PINS; DOWN,UP:REAL; E:EDIZM):BOOLEAN;
VAR
	K:INTEGER;
BEGIN
  IF SKIP THEN
  	EXIT;

  SETCOMPS(M,DOWN,UP,E);
  START(M);
  IF ADCSTAT THEN
  BEGIN
    K:=SETOI(M);
    IF DOWN<UP THEN
	 		OUTSIDE:=(RES_ADC[K]<DOWN)OR(RES_ADC[K]>UP)
    ELSE
  		OUTSIDE:=(RES_ADC[K]<UP)OR(RES_ADC[K]>DOWN);
//    lasti:=k;
  END
  ELSE
  	OUTSIDE:=RESCOM<>0;
END;

function TIstina.ADC(M:PINS; RNG:REAL; UN:EDIZM):REAL;
VAR
	K           : NUMBER;
	VALUE       : INTEGER;
	VAL, DWNVAL : REAL;
	UNT         : EDIZM;
	CHG         : BOOLEAN;
BEGIN
  IF SKIP THEN
  	EXIT;

  ADCB:=TRUE; K:=SETOI(M); CHG:=FALSE;
  IF UN=V THEN BEGIN
    IF (RNG<>UPLIMIT[K])OR(UN<>UNITCOMP[K]) THEN BEGIN
      VAL:=UPLIMIT[K]; DWNVAL:=DOWNLIMIT[K]; UNT:=UNITCOMP[K];
      CHG:=TRUE; CMPCHK:=FALSE; SETCOMPS(M,0,RNG,UN)
    END
  END
  ELSE IF (RNG<>CLAMP[K])OR(UN<>UNITC[K]) THEN BEGIN
    VAL:=CLAMP[K]; UNT:=UNITC[K];
    SOURCE(M,FORCE[K],UNITF[K],RNG,UN); CHG:=TRUE
  END;

  fIO.wPort(REG116,COM116 OR $1000); { Œ¡. ”—À. Õ¿ “≈—“≈ }
  fIO.wPort(REG046,K-1);
  fIO.wPort(REG030,LOADPIN);
  STARTR(REG100);
  VALUE:=fIO.rPort(REG044);
  TESTEND;
  IF VALUE<0 THEN VALUE:=-(VALUE AND $7fff);
  ADC:=VALUE*DISCRADC[K];
  IF CHG THEN
    IF UN=V THEN BEGIN
      IF NOT((VAL=0)AND(UNT=MA)) THEN SETCOMPS(M,DWNVAL,VAL,UNT);
      CMPCHK:=TRUE;
    END
    ELSE SOURCE(M,FORCE[K],UNITF[K],VAL,UNT);
  IF HALTB THEN
  	TESTCONDITIONS(M);
END;

//------------------------------------------------------------------------------
// –‡·ÓÚ‡ Ò Ù‡ÈÎÓÏ ÌÓÏ
//------------------------------------------------------------------------------
procedure TIstina.TestNo(No:integer);
begin
  TEST(No,tsnam[No],tsun[No]);
end;

procedure TIstina.TestInc;
begin
  TestNum:=TestNum+1;
  test(TestNum,tsnam[TestNum],tsun[TestNum]);
end;

procedure TIstina.normlim(m, NUM: INTEGER; r: real);
VAR
	DONE: BOOLEAN;
begin
	IF SKIP THEN
		EXIT;
	smenagr := false;
	if izm_ = 1 then
	begin
  	case StrIndex(tsun[NUM], ['nA', 'mA', 'mkA', 'V']) of
    	0: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r,	NA);
      1: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r,	MA);
      2: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r, MKA);
      3: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r,	V);
    end;
	end;

	if (r <> 0) then
		RES_ADC[m] := RES_ADC[m] + r;

	DONE := false;
	{ if TOTALBRAK then curgrp:=1; }
	WHILE NOT DONE DO
	BEGIN
		IF (RES_ADC[m] < limx[CURGRP, NUM, 1]) or
			(RES_ADC[m] > limx[CURGRP, NUM, 2]) THEN
			IF (CURGRP < MAXGRP) and not TOTALBRAK THEN
			BEGIN
				INC(CURGRP);
				smenagr := true;
			END
			ELSE
			BEGIN
				GRIEF := true;
				// if not totalbrak then fpr[numtst]:=fpr[numtst]+1;
				TOTALBRAK := true;
				smenagr := false;
				DONE := true;
				IF (NOT fIgnoreBRAK) THEN
				BEGIN
					ENDTEST;
					ENDPROGRAM;
					SKIP := true;
				END;
			END
		ELSE
		begin
			DONE := true;
			{ if curgrp>1 then group(curgrp+1,pass); }
		end;
	END;

end; { normlim }

procedure TIstina.normlimZ(m,NUM:INTEGER;r:real);
VAR
    DONE:BOOLEAN;
begin
  IF SKIP THEN
  	EXIT;

  if izm_ = 1 then
	begin
  	case StrIndex(tsun[NUM], ['nA', 'mA', 'mkA', 'V']) of
    	0: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r,	NA);
      1: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r,	MA);
      2: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r, MKA);
      3: OUTSIDE([m], limx[maxgroup, NUM, 1] - r, limx[maxgroup, NUM, 2] - r,	V);
    end;
	end;

  if r <> 0 then
    RES_ADC[M] := RES_ADC[M] + r;
end;

procedure TIstina.compare; {Ò‡‚ÌÂÌËÂ Ò ÌÓÏ‡ÏË}
VAR
    DONE:BOOLEAN;
//    i,
	m:integer;
begin
  IF SKIP THEN EXIT;
  smenagr:=false;
  m:=pnno[TestNum];
  if izm_=1 then {‚˚ÔÓÎÌˇÂÚÒˇ ÚÓÎ¸ÍÓ ‚ ÒÎÛ˜‡Â ÍÓ„‰‡ ÌÛÊÂÌ Á‡ÔÛÒÍ ËÁÏÂÂÌËˇ}
  begin
   if (tsun[TestNum]='NA') or (tsun[TestNum]='na') or (tsun[TestNum]='nA') then
    if (outside([m],limx[maxgroup,TestNum,1]+shiftres,limx[maxgroup,TestNum,2]+shiftres,na)) then ;
   if (tsun[TestNum]='MA') or (tsun[TestNum]='ma') or (tsun[TestNum]='mA') then
    if (outside([m],limx[maxgroup,TestNum,1]+shiftres,limx[maxgroup,TestNum,2]+shiftres,ma)) then ;
   if (tsun[TestNum]='MKA') or (tsun[TestNum]='mka') or (tsun[TestNum]='mkA') then
    if (outside([m],limx[maxgroup,TestNum,1]+shiftres,limx[maxgroup,TestNum,2]+shiftres,mka)) then ;
   if (tsun[TestNum]='V') or (tsun[TestNum]='v') then
    begin
     if (outside([m],limx[maxgroup,TestNum,1]+shiftres,limx[maxgroup,TestNum,2]+shiftres,v)) then ;
    end;
  end;  {if izm_=1}
   if shiftres<>0 then RES_ADC[m]:=RES_ADC[m]-shiftres;
   DONE:=FALSE;
  WHILE NOT DONE DO BEGIN
    IF (RES_ADC[M]<LIMX[CURGRP,TestNum,1]) or (RES_ADC[M]>LIMX[CURGRP,TestNum,2]) THEN
      IF (CURGRP < MAXGRP) and not TOTALBRAK THEN BEGIN
	INC(CURGRP);
	smenagr:=true;
      END
      ELSE
       BEGIN
	    GRIEF:=TRUE;
//	    if not totalbrak then fpr[numtst]:=fpr[numtst]+1;
	    TOTALBRAK:=TRUE;
	    smenagr:=false;
	    DONE:=TRUE;
	    IF (NOT fIgnoreBRAK) THEN BEGIN ENDTEST; ENDPROGRAM; SKIP:=TRUE; END;
       END
    ELSE
     begin
      DONE:=TRUE;
     end;
  END;

end; {compare}

//------------------------------------------------------------------------------
// —ÌˇÚËÂ ÂÁÛÎ¸Ú‡Ú‡ Ò ‚ÓÎ¸ÚÏÂÚ‡ ¬7-34
//   I - ÕÓÏÂ ‚˚‚Ó‰‡
//   D - ƒË‡Ô‡ÁÓÌ (S0V1, S1V, S10V, S100V, S1000V)
//------------------------------------------------------------------------------
function TIstina.RESVOLT(I:INTEGER; D:SCALE):REAL;
  function CNV(REG:WORD):REAL;
  VAR
  	TEMP:INTEGER;
  BEGIN
    TEMP:=fIO.rPort(REG) AND $f;
    CNV:=((fIO.rPort(REG)-TEMP) AND $ff)/16*10+TEMP;
  END;

VAR
	POINT:REAL;
BEGIN
  if fIO.DemoMode then
    Exit;

  IF SKIP THEN
  	EXIT;

  I:=I-1;
  case D of
    S0V1   : BEGIN fIO.wPort(REG054,I OR $e400); POINT:=1E6 END;
    S1V    : BEGIN fIO.wPort(REG054,I OR $d400); POINT:=1E5 END;
    S10V   : BEGIN fIO.wPort(REG054,I OR $c400); POINT:=1E4 END;
    S100V  : BEGIN fIO.wPort(REG054,I OR $b400); POINT:=1E3 END;
    S1000V : BEGIN fIO.wPort(REG054,I OR $a400); POINT:=1E2 END;
  else
    POINT := 0;
  end;

  WHILE (fIO.rPort(REG066) AND $80)=0 DO { ∆ƒ¿“‹ "1" } ;
  WHILE (fIO.rPort(REG066) AND $80)<>0 DO { ∆ƒ¿“‹ –≈«”À‹“¿“ } ;
  RESVOLT:=(CNV(REG066)*10000+CNV(REG064)*100+CNV(REG062))/POINT;
END;

end.