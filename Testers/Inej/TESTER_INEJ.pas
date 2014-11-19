{******************************************************************************}
{                                    "ИНЕЙ"                                    }
{                                                                              }
{                ЗАО НТЦ Схемотехники и Интегральных Технологий                }
{                                     2014                                     }
{******************************************************************************}

unit TESTER_INEJ;

interface

uses
  System.Classes,
  TESTER_BASE,
  TESTER_INEJ_IO,
  TESTER_INEJ_GLOBAL;

type
  TInejResult = record
	  TestNo            : Cardinal;
    TestName          : String;
    LNorm, HNorm, Val : Double;
    Units             : String;
  end;

  TOnMeasureResultInejEvent = procedure(Sender: TObject; Defect: Boolean; MResult: TInejResult) of object;  // Получен результат замера

type
  TInej = class(TCustomTester)
  private
    fIO: TInejBaseIO;

    FOnMeasureResultEvent : TOnMeasureResultInejEvent;

    procedure GetNormsFromString(const Text: String); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitScriptEngine(P: Pointer); override;

		procedure DoMeasureResult(Defect: Boolean; MResult: TInejResult);
    procedure ResetTester; override;
    procedure Measure(ResetOnEnd: Boolean = True); override;

  published
    property OnMeasureResult : TOnMeasureResultInejEvent read FOnMeasureResultEvent write FOnMeasureResultEvent;
		property IO : TInejBaseIO read fIO write fIO;
//		property IgnoreBrak: Boolean read FIgnoreBrak write FIgnoreBrak;

  private
		procedure givedata(const Data: TArray<Word>);
    procedure getres;
    procedure teststop;
    procedure outres;

  protected
    procedure ERRORI(ErrCode: INTEGER);
    procedure PLANPULT;
    procedure GROUP(G: INTEGER; E: ITOGO);

  public
  	{ Функции доступные при программирование РП }
      procedure PROGRAMMA;
      procedure TEST(NAME, UNITS: String{IMYA});
      procedure TestInc;
      procedure RELE(a: relays);
      procedure INPDATA(p: parameter; c: conductivity; r: Rbe; D: Range; IA: Real;
        unitA: UNITS; IB: Real; unitB: UNITS; U: Real; unitU: UNITS; Tm: word;
        Ts: word);
      function MORE(UP: Real): Boolean;
      function LESS(DOWN: Real): Boolean;
      function OUTSIDE(DOWN, UP: Real): Boolean;
      procedure NORMLIM;
      procedure ENDTEST;
      procedure ENDPROGRAM;
  end;

//var
//  Tester: TInej;

implementation

uses
  Windows,
	System.SysUtils,
  IMPORT_Inej;
//	Vcl.Dialogs;

{ TInej }

constructor TInej.Create(AOwner: TComponent);
begin
  inherited;

  with fFeathers do
  begin
    ADC  := False;
    HALT := True;
    LOOP := False;
  end;

  fTesterCaption := 'Тестер контроля статических'#13#10'параметров транзисторов'#13#10'УВК.ТПЭ-100';
  fTesterShortCaption := 'ИНЕЙ';
  fTesterSignature    := 'INEJ';
  fIO := TCommIO.Create(AOwner);
end;

destructor TInej.Destroy;
begin
  fIO.Free;
  inherited;
end;

procedure TInej.InitScriptEngine(P: Pointer);
begin
  Register_Inej(fPaxCompiler, P);
end;

procedure TInej.Measure(ResetOnEnd: Boolean);
begin
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
    PLANPULT;

  { TESTER }
  PLANK := PLAN;

  // Start Measure Thread
  inherited Measure(ResetOnEnd);
end;

procedure TInej.ResetTester;
begin
  fIO.ControlStrobe(PC00);
  fIO.ControlStrobe(PC01);
end;


//------------------------------------------------------------------------------
// Генерация исключения при ошибке
//------------------------------------------------------------------------------
PROCEDURE TInej.ERRORI(ErrCode: INTEGER);
VAR
  ErrorStr: String;
BEGIN
	ResetTester;
  ErrorStr := 'ТЕСТ №' + IntToStr(TESTNO) + ' : ';

  case ErrCode of
    1  : ErrorStr := ErrorStr + 'GETRES. Долго нет результата';
    2  : ErrorStr := ErrorStr + 'GETRES. Ошибка учета положения запятой';
    3  : ErrorStr := ErrorStr + 'GETRES. Ошибка учета единицы измерения';

    4  : ErrorStr := ErrorStr + 'PLANPULT. Ошибка считывания плана или перегрузка';
    5  : ErrorStr := ErrorStr + 'PLANPULT. Ошибка считывания пульта или перегрузка';

    6  : ErrorStr := ErrorStr + 'GROUP. Неверный номер группы';

    7  : ErrorStr := ErrorStr + 'OUTSIDE.Нижняя норма больше верхней';
    8  : ErrorStr := ErrorStr + 'OUTSIDE.нижняя норма равна верхней';

    9  : ErrorStr := ErrorStr + 'NORMLIM.Нижняя норма больше верхней';
    10 : ErrorStr := ErrorStr + 'NORMLIM.нижняя норма равна верхней';
  end;

  case ErrCode of
    20 : ErrorStr := ErrorStr + 'Тестер выключен или проблемы с каналом передачи данных';
    21 : ErrorStr := ErrorStr + 'Работа ведется в режиме имитации';
  end;

  DoError(ErrCode, ErrorStr + '!');
END;

procedure TInej.GetNormsFromString(const Text: String);

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
  Line: String;
  SplitLine: TArray<String>;
  num: Integer;
  i,z: Integer;
begin

  if Trim(Text) = '' then
  begin
    fUseFileNorm := False;
    Exit;
  end;

  TESTER_INEJ_GLOBAL.maxgrp := 0;
  TESTER_INEJ_GLOBAL.maxtst := 0;
  fUseFileNorm := True;
  ClearNorms;

  FileText := TStringList.Create;
  try
    FileText.Text := StringReplace(Text, ',', '.', [rfReplaceAll]);

    { Обрабатываем первую строку }
    Line := FileText[0];
    SplitLine := Line.Split([#9]);
    maxgrp := (Length(SplitLine) - 4) div 2 + 1;
    for i := 1 to maxgrp do
      grpmsg[i] := SplitLine[3+((i-1)*2)];

    FileText.Delete(0);

    { Все остальные }
    for Line in FileText do
    begin
      SplitLine  := Line.Split([#9]);
      num        := SplitLine[0].ToInteger();                                    { Номер теста }
      tsnam[num] := SplitLine[1];                                                { Имя теста }
      tsun[num]  := SplitLine[2];                                                { Единица измерения }
//      pnno[num]  := SplitLine[3].ToInteger();                                    { Номер измеряемого вывода }

      try
        for i := 1 to maxgrp do //( (Length(SplitLine) - 4) div 2 ) do
        begin
          limx[i, num, 1] := SplitLine[3+((i-1)*2)].ToDouble;
          limx[i, num, 2] := SplitLine[3+((i-1)*2) + 1].ToDouble;
        end;
      except
        DoError(0, 'Ошибка в файле норм на тесте №' + num.ToString);
      end;
    end;
    TESTER_INEJ_GLOBAL.maxtst := num;
  finally
    FileText.Free;
  end;

{$IFDEF CONSOLE}
  writeln('количество групп ', maxgrp:3);
{$ENDIF}

  { 10-ая группа заполняется значениями:
    Нижняя норма - минимальная среди всех групп;
    Верхняя норма - максимальная среди всех групп  }
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

//------------------------------------------------------------------------------
// НОМЕР ПЛАНА И ПУЛЬТА
//------------------------------------------------------------------------------
procedure TInej.PLANPULT;
VAR
  PLPT: word;
BEGIN
  fIO.readat(PLPT);
  PLAN    := (PLPT and $0F00) div 256;
  PULT    := (PLPT and $00F0) div 16;
  TESTER_INEJ_GLOBAL.MEASURE := (PLPT and 2) <> 0;
  PRINT   := (PLPT and 4) <> 0;

  IF (PLAN < 1) OR (PLAN > 15) THEN
    ERRORI(4);
  IF (PULT < 1) OR (PULT > 9) THEN
    ERRORI(5);
END;

//------------------------------------------------------------------------------
// КОНЕЦ ПРОГРАММЫ
//------------------------------------------------------------------------------
procedure TInej.ENDPROGRAM;
//VAR
//  i: INTEGER;
BEGIN
  IF SKIP THEN
    Exit;

  endpr := True;
  if (not TOTALBRAK) and not brakgroup and (curgrp <> 0) then
  begin
    GROUP(curgrp, pass);
    DoProgramEnd(curgrp, False);
  end;
  IF TOTALBRAK or brakgroup THEN
  begin
    GROUP(curgrp, fail);
    DoProgramEnd(curgrp, True);
  end;
  IF TOTALBRAK THEN
    fCounters[PLAN, 17] := fCounters[PLAN, 17] + 1
  ELSE
    fCounters[PLAN, 16] := fCounters[PLAN, 16] + 1;
  IF brakgroup THEN
    fCounters[PLAN, 17] := fCounters[PLAN, 17] + 1;

  TESTNO := TESTNO - 1;
  if (fCounters[PLAN, 18] = 1) and (maxgrp = 0) then
    TESTER_INEJ_GLOBAL.maxtst := TESTNO;
  rele([]);

  DoCommand('ENDPROGRAM');
END;

//------------------------------------------------------------------------------
// Конец теста
//------------------------------------------------------------------------------
PROCEDURE TInej.ENDTEST;
//var
//  s, s1, s2: string;
//  re: Real;
BEGIN
  IF SKIP THEN
    Exit;

  outres;
  rele([]);

  IF ((fCounters[PLAN, 18] = 1)) and (not fUseFileNorm) THEN
  begin { запись имени теста и норм в конце каждого теста на первой схеме }
    lim[TESTNO, 2] := uplimit;
    lim[TESTNO, 1] := downlimit;
//    pars[TESTNO] := testnam + '_(' + testun + ')';
//    iii := iii + 1;
  end;

  TESTNO := TESTNO + 1;

  DoCommand('ENDTEST');
END;

//------------------------------------------------------------------------------
// НАЧАЛО ПРОГРАММЫ ИСПЫТАНИЙ
//------------------------------------------------------------------------------
procedure TInej.PROGRAMMA;
VAR
  // K: NUMBER;
  i: byte;
BEGIN
//  LOOP := FALSE;
//  STAT := FALSE;
//  HALTB := FALSE;
  TOTALBRAK := FALSE;
  brakgroup := FALSE;
  SKIP := FALSE;
  endpr := FALSE;
//  COUNT := 0;
//  countf := 0;
  TESTNO := 0;
//  FIRST := True;
//  addresour := 0;
//  PLN := PLAN;
  Inc(fCounters[PLAN, 18]); (* ВСЕГО *)
  rele([]);
  IF (fCounters[PLAN, 18] = 1) THEN
    if {(colon <= 8) and }not fUseFileNorm then
      for i := 1 to 100 do
      begin
//        pars[i]   := '';
        lim[i, 1] := 0;
        lim[i, 2] := 0;
      end;
  TESTNO := 1;

  DoCommand('PROGRAMMA');
END;

//------------------------------------------------------------------------------
// Начало теста
//------------------------------------------------------------------------------
PROCEDURE TInej.TEST(NAME, UNITS: String{IMYA});
BEGIN
  IF SKIP THEN
    Exit;

  testnam := NAME;
  testun := UNITS;
  GRIEF := FALSE;
  rele([]);

  DoCommand('TEST');
END;

//------------------------------------------------------------------------------
// ПОДСВЕТ ГРУППЫ КЛАССИФИКАЦИИ
//------------------------------------------------------------------------------
procedure TInej.GROUP(G: INTEGER; E: ITOGO);
BEGIN
  IF (G > 15) OR (G < 0) THEN
    ERRORI(6);
  IF SKIP THEN
    Exit;

  if not endpr then
    IF (E = pass) THEN
    begin
      GRIEF := FALSE;
      curgrp := G;
    end
    ELSE (* E=FAIL *)
    BEGIN
      GRIEF := True;
//      if (not endpr) and not(TOTALBRAK or brakgroup) then
//        fpr[TESTNO] := fpr[TESTNO] + 1;
      brakgroup := True;
    END;

  IF NOT((E = pass) AND (TOTALBRAK or brakgroup)) and endpr THEN
  BEGIN
    { PortW[OutPort]:=$8000+(g and 31); {команда 6N14 }
    fIO.wridat($8000 + (G and 31));
    fCounters[PLAN, G] := fCounters[PLAN, G] + 1;
  END (* IF *);

  IF (NOT fIgnoreBRAK) and (TOTALBRAK or brakgroup) and not endpr THEN
  BEGIN
    ENDTEST;
    ENDPROGRAM;
    SKIP := True;
  END;

  DoCommand('GROUP');
END;

//------------------------------------------------------------------------------
// Увеличить номер теста на 1
//------------------------------------------------------------------------------
procedure TInej.TestInc;
begin
  TEST(tsnam[TESTNO], tsun[TESTNO]);
end;

//------------------------------------------------------------------------------
// Управление реле
//------------------------------------------------------------------------------
procedure TInej.rele(a: relays);
var
	i: Byte;
	b: Cardinal;
	c: set of 0 .. 31 absolute b;
begin
	c := [];
	for i := 1 to 32 do
		if i in a then
			c := c + [i - 1]; { приводим к виду от 0 до 31 }
	fIO.writrele(b); { процедура побайтной передачи инф о реле }
end;

//------------------------------------------------------------------------------
// Тестовые условия
//------------------------------------------------------------------------------
procedure TInej.inpdata(p: parameter; c: conductivity; r: Rbe;
  D: Range; IA: Real; unitA: UNITS; IB: Real; unitB: UNITS; U: Real;
  unitU: UNITS; Tm: word; Ts: word);
label
  corrb, corrv, ia0, ib0, vv;
Var
  i: word;
  It, Mt, mnb, mnv, a1, a2     : word;
  Il, valb, valv               : real;
  res                          : real;
  signlast                     : jumps;
  ch                           : char;
  wrd1, wrd2, wrd3, wrd4, wrd5 : Word;
begin
  IF SKIP THEN
    EXIT;

  wrd1 := 0;  wrd2 := 0;  wrd3 := 0;  wrd4 := 0;  wrd5 := 0;
  signlast := Jumps.none;
  case p of
     Ice    : wrd1 := wrd1 or 256;
     Icbo   : wrd1 := wrd1 or 512;
     Iebo   : wrd1 := wrd1 or 256 or 512;
     h21e   : wrd1 := wrd1 or 1024;
     Ucesat : wrd1 := wrd1 or 1024 or 256;
     Ubesat : wrd1 := wrd1 or 1024 or 512;
     Uceo   : wrd1 := wrd1 or 1024 or 512 or 256;
     Uin    : wrd1 := wrd1 or 2048 or 256;
     h21    : wrd1 := wrd1 or 1024;
  end;
  if c = pnp then
    wrd1 := wrd1 or 128;
  if connection = inverse then
    wrd1 := wrd1 or 4096;
  case r of
     r1	: wrd1 := wrd1 or 16;
     r2 : wrd1 := wrd1 or 32;
     r3 : wrd1 := wrd1 or 32 or 16;
     r4 : wrd1 := wrd1 or 64;
     r5 : wrd1 := wrd1 or 64 or 16;
     r6 : wrd1 := wrd1 or 64 or 32;
     r7 : wrd1 := wrd1 or 64 or 32 or 16;
  end;
  case D of
     D1   : wrd1 := wrd1 or 7;
     D10  : wrd1 := wrd1 or 8;
     D100 : wrd1 := wrd1 or 9;
     D500 : wrd1 := wrd1 or 10;
  end;

  case UnitA of
    no   : begin Mt :=  0; Il :=  0; goto ia0; end;
    nA   : begin Mt :=  2;                     end;
    uA   : begin Mt :=  5;                     end;
    mA   : begin Mt :=  8;                     end;
    mA9  : begin Mt :=  9; Il := IA; goto ia0; end;
    mA10 : begin Mt := 10; Il := IA; goto ia0; end;
    A    : begin Mt := 11;                     end;
    x4   : begin Mt :=  4; Il := IA; goto ia0; end;
    x5   : begin Mt :=  5; Il := IA; goto ia0; end;
    x6   : begin Mt :=  6; Il := IA; goto ia0; end;
    x7   : begin Mt :=  7; Il := IA; goto ia0; end;
    x8   : begin Mt :=  8; Il := IA; goto ia0; end;
    x9   : begin Mt :=  9; Il := IA; goto ia0; end;
    x10  : begin Mt := 10; Il := IA; goto ia0; end;
    x11  : begin Mt := 11; Il := IA; goto ia0; end;
  end;
  {Нормализация A}
  Il:=IA;
  if Il = 0 then
    goto ia0;
  If trunc(IA) > 9 then
  begin
    while (trunc(Il) > 9) and (Mt < 11) do
    begin
      Il := Il / 10;
      Mt := Mt + 1
    end;
  end;
  If trunc(IA) = 0 then
  begin
    while (trunc(Il) = 0) and (Mt > 2) do
    begin
      Il := Il * 10;
      Mt := Mt - 1
    end;
  end;
  case Mt of
    2 : begin Il:=Il / 100; Mt:=4; end;
    3 : begin Il:=Il / 10;  Mt:=4; end;
  end;
  if mt=6 then
  begin
    Il := Il / 10;
    Mt := 7;
  end;
ia0:
  It   := round(Il * 100);
  wrd2 := Mt * 4096 + (It mod 10);
  It   := It div 10;
  wrd2 := wrd2 + (It mod 10) * 16;
  It   := It div 10;
  IF It < 10 then
    wrd2 := wrd2 + (It mod 10) * 256
  else
    wrd2 := wrd2 + It * 256;

  {Обработка значения тока Б}
  case UnitB of
    no  : begin Mt :=  0; Il :=  0; goto ib0; end;
    nA  : begin Mt :=  2;                     end;
    uA  : begin Mt :=  5;                     end;
    mA  : begin Mt :=  8;                     end;
    A   : begin Mt := 11;                     end;
    x3  : begin Mt :=  3; Il := IB; goto ib0; end;
    x4  : begin Mt :=  4; Il := IB; goto ib0; end;
    x5  : begin Mt :=  5; Il := IB; goto ib0; end;
    x6  : begin Mt :=  6; Il := IB; goto ib0; end;
    x7  : begin Mt :=  7; Il := IB; goto ib0; end;
    x8  : begin Mt :=  8; Il := IB; goto ib0; end;
    x9  : begin Mt :=  9; Il := IB; goto ib0; end;
    x10 : begin Mt := 10; Il := IB; goto ib0; end;
    x11 : begin Mt := 11; Il := IB; goto ib0; end;
  end; {case}

  {Нормализация Б}
  Il:=IB;
  if Il = 0 then
   goto ib0;
  If trunc(IB) > 9 then
  begin
   while (trunc(Il) > 9) and (Mt < 10) do
   begin
     Il := Il / 10;
     Mt := Mt + 1
   end;
  end;
  If trunc(IB) = 0 then
  begin
   while (trunc(Il) = 0) and (Mt > 2) do
   begin
     Il := Il * 10;
     Mt := Mt - 1
   end;
  end;
  case Mt of
   2:
     begin
       Il := Il / 10;
       Mt := 3
     end;
   11:
     begin
       Il := Il * 10;
       Mt := 10
     end;
  end;

ib0:
  valb := Il;
  mnb  := Mt;
corrb:
  Il   := valb; mt:=mnb;
  It   := round(Il*100);
  wrd3 := Mt * 4096 + (It mod 10);
  It   := It div 10;
  wrd3 := wrd3 + (It mod 10) * 16;
  It   := It div 10;

  IF It < 10 then
   wrd3 := wrd3 + (It mod 10) * 256
  else
   wrd3 := wrd3 + It * 256;

  { Обработка значения напряжеия В}
  case UnitU of
    no             : begin Mt :=  8; Il := 0; goto vv; end;
    mV             : begin Mt :=  5;                   end;
    V              : begin Mt :=  8;                   end;
    V8             : begin Mt :=  8; Il := U; goto vv; end;
    x3,x4,x5,x6,x7 : begin Mt :=  7; Il := U; goto vv; end;
    x8             : begin Mt :=  8; Il := U; goto vv; end;
    x9             : begin Mt :=  9; Il := U; goto vv; end;
    x10            : begin Mt := 10; Il := U; goto vv; end;
  end; {case}
  {Нормализация В}
  Il:=U;
  If trunc(U)>9 then
  begin
    while (trunc(Il)>9) and (Mt<10) do
    begin
      Il := Il / 10;
      Mt := Mt + 1
    end;
  end;
  If trunc(U) = 0 then
  begin
    while (trunc(Il) = 0) and (Mt > 5) do
    begin
      Il := Il * 10;
      Mt := Mt - 1
    end;
  end;
  case Mt of
    5:
      begin
        Il := Il / 100;
        Mt := 7
      end;
    6:
      begin
        Il := Il / 10;
        Mt := 7
      end;
  end;
  if Mt = 7 then
  begin
    Mt := 8;
    Il := Il / 10;
  end; { множитель 7 не реализован аппаратно }
vv:
  valv := Il;
  mnv  := Mt;
corrv:
  Il   := valv;
  Mt   := mnv;
  It   := round(Il * 100);
  wrd4 := Mt * 4096 + (It mod 10);
  It   := It div 10; wrd4:=wrd4+(It mod 10)*16;
	It   :=It div 10;
  IF it < 10 then
    wrd4 := wrd4+(It mod 10)*256
  else
    wrd4 := wrd4+it*256;

  {Преобразование длительности режима}
  It := round(Tm);
  a1 := It mod 10;
  if (a1 <= 5) and (It > 10) then
    a1 := a1 + 10;
  wrd5 := a1 * 256;
  It := (It-a1) div 10;
  wrd5 := wrd5+(It{ mod 10} ) * 4096;

  { Преобразование длительности теста }
  It := round(Ts / 10);
  a1 := It mod 10;
  if (a1 <= 5) and (It > 10) then
    a1 := a1 + 10;
  wrd5 := wrd5 + a1;
  { если был ненулевой оператор addresource заменяем 4 бита на указанные}
  It:=(It-a1) div 10;

  wrd5:=wrd5+(It{ mod 10})*16;

  fIO.readat(i);
  givedata(TArray<Word>.Create(wrd1, wrd2, wrd3, wrd4, wrd5)); { передача данных }
	getres;   {Считывание результата}


  if (fCONDITIONS[TESTNO] AND MHALT )<>0 then
    teststop;
end; {inpdata}

//------------------------------------------------------------------------------
// Больше нормы
//------------------------------------------------------------------------------
function TInej.MORE(UP: Real): Boolean;
begin
  IF SKIP THEN
    Exit;

  uplimit := UP;
  downlimit := -9999;
  MORE := (RES_ADC[TESTNO] > UP);
END;

//------------------------------------------------------------------------------
// Меньше нормы
//------------------------------------------------------------------------------
function TInej.LESS(DOWN: Real): Boolean;
BEGIN
  IF SKIP THEN
    Exit;

	UPLIMIT := 9999;
	DOWNLIMIT := DOWN;
	LESS := (RES_ADC[TESTNO] < DOWN);
END;

//------------------------------------------------------------------------------
// За пределами нормы
//------------------------------------------------------------------------------
FUNCTION TInej.OUTSIDE(DOWN, UP: Real): Boolean;
begin
  IF SKIP THEN
    Exit;
  UPLIMIT := UP;
  DOWNLIMIT := DOWN;

  if DOWN > UP then
  begin
    ERRORI(7);
    SKIP := True;
  end;
  if DOWN = UP then
  begin
    ERRORI(8);
    SKIP := True;
  end;

  OUTSIDE := (RES_ADC[TESTNO] < DOWN) or (RES_ADC[TESTNO] > UP);
end; { OUTSIDE }

//------------------------------------------------------------------------------
// Сравнение с файлом норм
//------------------------------------------------------------------------------
procedure TInej.normlim;
VAR
  DONE: Boolean;
begin
  IF SKIP THEN
    Exit;

  smenagr := FALSE;
  DONE := FALSE;
  lastgrp := curgrp;
  WHILE NOT DONE DO
  BEGIN
    if (LIMX[curgrp, TESTNO, 1] > LIMX[curgrp, TESTNO, 2]) and not TOTALBRAK then
    begin
      ERRORI(9);
      SKIP := True;
    end;
    if (LIMX[curgrp, TESTNO, 1] = LIMX[curgrp, TESTNO, 2]) and not TOTALBRAK then
    begin
      ERRORI(10);
      SKIP := True;
    end;

    if curgrp = 15 then { ЕСЛИ непонятная группа брака, бракуем по последней }
      IF (RES_ADC[TESTNO] < LIMX[maxgrp, TESTNO, 1]) or
         (RES_ADC[TESTNO] > LIMX[maxgrp, TESTNO, 2]) THEN
      begin
        GRIEF := True;
        { fpr[testno]:=fpr[testno]+1;{ }
        smenagr := FALSE;
        DONE := True;
        IF (NOT fIgnoreBRAK) THEN
        BEGIN
          ENDTEST;
          ENDPROGRAM;
          SKIP := True;
        END;
        Exit;
      end
      else
        Exit;

    IF (RES_ADC[TESTNO] < LIMX[curgrp, TESTNO, 1]) or
       (RES_ADC[TESTNO] > LIMX[curgrp, TESTNO, 2]) THEN
      if brakgroup then { ИС уже попала в какую-то группу брака }
      begin
        GRIEF := True;
        { fpr[testno]:=fpr[testno]+1;{ }
        smenagr := FALSE;
        DONE := True;
        IF (NOT fIgnoreBRAK) THEN
        BEGIN
          ENDTEST;
          ENDPROGRAM;
          SKIP := True;
        END;
      end
      else IF (curgrp < maxgrp) and not TOTALBRAK THEN
      BEGIN { еще есть группы годности }
        Inc(curgrp);
        smenagr := True;
      END
      else { дошли до конца списка групп }
      BEGIN
        GRIEF := True;
//        fpr[TESTNO] := fpr[TESTNO] + 1;
        TOTALBRAK := True; { флаг непонятной группы брака }
        curgrp := 15;
        smenagr := FALSE;
        DONE := True;
        IF (NOT fIgnoreBRAK) THEN
        BEGIN
          ENDTEST;
          ENDPROGRAM;
          SKIP := True;
        END;
      END
    ELSE
    begin
      DONE := True;
      if curgrp > 5 then
      begin
        brakgroup := True;
        GRIEF := True;
        smenagr := FALSE;
//        fpr[TESTNO] := fpr[TESTNO] + 1;
        IF (NOT fIgnoreBRAK) THEN
        BEGIN
          ENDTEST;
          ENDPROGRAM;
          SKIP := True;
        END;
      end;
    end;
  END;
  { if testno in  ostanov then teststop; }
end;

//------------------------------------------------------------------------------
// Пересылка тестовых условий в ТЕСТЕР
//------------------------------------------------------------------------------
procedure TInej.givedata(const Data: TArray<Word>);
var
	W: Word;
begin
	fIO.wridat($0);
  for W in Data do
  	fIO.wridat(W);

//  fIO.wridat(wrd1);                                                              { команда 6N32 }
//  fIO.wridat(wrd2);                                                              { команда 6N21 }
//  fIO.wridat(wrd3);                                                              { команда 6N22 }
//  fIO.wridat(wrd4);                                                              { команда 6N24 }
//  fIO.wridat(wrd5);                                                              { команда 6N34 }
  fIO.wridat($0);
end;

//------------------------------------------------------------------------------
// Получение результата из ТЕСТЕРА
//------------------------------------------------------------------------------
procedure TInej.getres;
var
  i, j, k: word;
  res: Real;
begin
  if fIO.DemoMode then
  begin
    RES_ADC[TESTNO] := 0.0;

    Exit;
  end;

  { Ожидаем готовности результатов измерения }
  if not fIO.WaitResult() then
  begin
    ERRORI(1);
    SKIP := True;
    TOTALBRAK := True;
    IF (NOT fIgnoreBRAK) THEN
    BEGIN
      ENDTEST;
      ENDPROGRAM;
      SKIP := True;
    END;

    Exit;
  end;

  fIO.readat(i);                                                                 { команда 6N12 и конец теста }
  fIO.readat(j);                                                                 { команда 6N42 }
	fIO.readat(k);                                                                 { команда 6N44 }

  res := (j div 4096) * 1000 + ((j and $0F00) div 256) * 100 +
    ((j and $00F0) div 16) * 10 + (j and 15);

  { Учет знака результата }
  If (k and 32) = 32 then
    res := -res;

  { Учет положения запятой }
  case (k and $01c0) div 64 of
    1: res := res/10000;
    2: res := res/1000;
    3: res := res/100;
    4: res := res/10;
    0, 6, 7: ERRORI(2);
  end;

  { Учет единицы измерения }
  case (k and $0E00) div 512 of
    1: ResultUnit := 'V';
    2: ResultUnit := 'mA';
    3: ResultUnit := 'mkA';
    4: ResultUnit := 'nA';
    5: ResultUnit := '';
    6: ResultUnit := '';
    0, 7: ERRORI(3);
  end;

  RES_ADC[TESTNO] := res;

  case (k and 1) of
  	1:  sign := over;                                                            { write ('ПЕРЕПОЛНЕНИЕ ');}
    4:  sign := osc;                                                             { write ('ГЕНЕР '); }
    8:  sign := grt;                                                             { write ('МНБ > НОРМЫ '); }
    16: sign := lwr;                                                             { write ('МНБ < НОРМЫ '); }
  else
  	sign := Jumps.none;
  end;
end;

procedure TInej.teststop;
begin
  Windows.MessageBox(0, 'Остановка на тесте', 'Тестер', MB_SYSTEMMODAL or
    MB_SETFOREGROUND or MB_TOPMOST or MB_ICONINFORMATION);
end;

//------------------------------------------------------------------------------
// Вывод результата замера
//------------------------------------------------------------------------------
procedure TInej.outres;
VAR
  // I: NUMBER;
  ResRecord: TInejResult;
BEGIN
  if not fUseFileNorm then
  begin
    // if not((lim[TESTNO, 1] = -999) and (lim[TESTNO, 2] = -999)) then
    // fMeasureResults[TESTNO] := RES_ADC[I];
    ResRecord.LNorm := lim[TESTNO, 1];
    ResRecord.HNorm := lim[TESTNO, 2];
  end
  else
  begin
    // if not((limx[1, testnum, 1] = -999) and (limx[1, testnum, 2] = -999))  then
    // fMeasureResults[testnum] := RES_ADC[I];
    ResRecord.LNorm := LIMX[1, TESTNO, 1];
    ResRecord.HNorm := LIMX[1, TESTNO, 2];
  end;

  ResRecord.TESTNO   := TESTNO;
  ResRecord.TestName := testnam;
  ResRecord.Val      := RES_ADC[TESTNO];
  ResRecord.UNITS    := testun;

  DoMeasureResult(GRIEF, ResRecord);
end;

procedure TInej.DoMeasureResult(Defect: Boolean; MResult: TInejResult);
begin
  if Assigned(FOnMeasureResultEvent) then
    FOnMeasureResultEvent(Self, Defect, MResult);
end;


end.