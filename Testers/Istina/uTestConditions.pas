unit uTestConditions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.Forms, NxScrollControl, NxCustomGridControl, NxCustomGrid,
  NxGrid, NxColumnClasses, NxColumns, Vcl.ImgList, Vcl.AppEvnts;

type
  TPins = set of 1..16;

  TPinsData = record
  	N              : string;
  	PinOn          : Boolean;
    Force          : Double;
    ForceUnits     : string;
    Clamp          : Double;
    ClampUnits     : string;
    TimeOn         : Double;
    TimeOnUnits    : string;
    TimeOff        : Double;
    TimeOffUnits   : string;
    DownLimit      : Double;
    DownLimitUnits : string;
    UpLimit        : Double;
    UpLimitUnits   : string;
    ADC            : Double;
    ADCUnits       : String;
    K1             : string;
    K2             : String;
  end;

  TInputData = record
    M            : TPins;
//    OffPin       : Word;
    ADCB         : Boolean;
    TestCaption  : string;
    TestNumber   : Cardinal;
    TestUnits    : String;
    Brak         : Boolean;
    Pins         : array[1..16] of TPinsData;
    LenTest      : Double;
    LenTestUntis : String;
    Del3         : Boolean;
    SmallI       : Boolean;
  end;

type
  TfTestConditions = class(TForm)
    Panel1: TPanel;
    btnRetry: TButton;
    btnContinue: TButton;
    btnAbort: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    lblTestCaption: TLabel;
    NG: TNextGrid;
    colK1: TNxTextColumn;
    colK2: TNxTextColumn;
    colForceUnits: TNxTextColumn;
    colClampUnits: TNxTextColumn;
    colTimeOffUnits: TNxTextColumn;
    colDownLimitUnits: TNxTextColumn;
    colADCUnits: TNxTextColumn;
    colUpLimitUnits: TNxTextColumn;
    colTimeOnUnits: TNxTextColumn;
    lblTitle: TLabel;
    lblBrak: TLabel;
    lblTestLen: TLabel;
    lblDelayComm: TLabel;
    lblSmallI: TLabel;
    ImageList: TImageList;
    NxCheckBoxColumn1: TNxCheckBoxColumn;
    colForce: TNxTextColumn;
    colClamp: TNxTextColumn;
    colTimeOn: TNxTextColumn;
    colTimeOff: TNxTextColumn;
    colDownLimit: TNxTextColumn;
    colADC: TNxTextColumn;
    colUpLimit: TNxTextColumn;
    colN: TNxTextColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure FillView(Data: TInputData);
  public
    { Public declarations }
    class function Execute(Data: TInputData): Integer;
  end;

var
  fTestConditions: TfTestConditions;

implementation

{$R *.dfm}

//uses
//  System.SysUtils;

//
//PROCEDURE UNITTOCH(UNITS: EDIZM; VAR UCH: UNITCHAR);
//BEGIN
//  IF UNITS = V THEN
//    UCH := 'V'
//  ELSE IF UNITS = MKA THEN
//    UCH := 'MKA'
//  ELSE IF UNITS = MA THEN
//    UCH := 'MA'
//END;
//
//PROCEDURE TESTCONDITIONS(M: PINS);
//type
//  s16 = set of 0 .. 15;
//
//VAR
//  N: NUMBER;
//  CH: CHAR;
//  UCH: UNITCHAR;
//  BRAK: BOOLEAN;
//  m1: s16 absolute OFFPIN;
//  m2: s16 absolute LOADPIN;
//  f1: text;
//  dir1, dir2, s: string;
//  fzast: text;
//  pp, e: integer;
//
//  PROCEDURE POINTS;
//  VAR
//    I: integer;
//  BEGIN
//    FOR I := 1 TO 79 DO
//      WRITE('.');
//    WRITELN
//  END;
//
//  PROCEDURE WRITEINT(I, N: WORD; CH: CHAR);
//  BEGIN
//    IF (I AND STEP(N)) <> 0 THEN
//      IF CH = 'K' THEN
//        WRITE('1':4)
//      ELSE
//        WRITE(CH)
//    ELSE IF CH = 'K' THEN
//      WRITE('0':4)
//    ELSE
//      WRITE(' ')
//  END;
//
//BEGIN
////  IF CURVER <> VERSION THEN
////    ERRORI(18);
//  USETT := HALTTT;
//  BRAK := FALSE;
//  ClrScr;
//  write(' ', testnam);
//  DIRECT(' ', '?');
//  WRITE('Т Е С Т', TestNum:5, '[':5, TESTUN, ']');
//  WRITELN(' ':11, '<<<        >>>');
//  POINTS;
//  WRITE(' N    НОМИНАЛ   ОГРАНИЧ. Т.ВКЛ. Т.ВЫКЛ.');
//  WRITELN(' НИЖ.ГР.     АЦП     ВЕРХ.ГР.   К1   К2');
//  POINTS;
//  FOR N := 1 TO 16 DO
//  BEGIN
//    WRITEINT(OFFPIN, N, '-');
//    WRITE(PINNO[N]:2);
//    IF (DLOADPIN AND STEP(N)) <> 0 THEN
//      WRITE('Д')
//    ELSE
//      WRITEINT(LOADPIN, N, 'H');
//    WRITEREAL(FORCE[N], 7, UNITF[N]);
//    WRITEREAL(CLAMP[N], 7, UNITC[N]);
//    WRITEREAL(TIMEON[N], 4, UNITONOFF[N]); { WRITE(CHR(33B),CHR(104B)); }
//    WRITEREAL(TIMEOFF[N], 4, UNITONOFF[N]);
//    IF N IN M THEN
//    BEGIN
//      WRITEREAL(DOWNLIMIT[N], 6, UNITCOMP[N]);
//      IF ADCB THEN
//        WRITEREAL(RESULT[N], 7, UNITCOMP[N])
//      ELSE
//        WRITE(' ':10);
//      WRITEREAL(UPLIMIT[N], 7, UNITCOMP[N]);
//      IF LOW THEN
//      BEGIN
//        WRITEINT(NOT RESLOW, N, 'K');
//        IF (STEP(N) AND RESLOW) <> 0 THEN
//        BEGIN
//          WRITE('*');
//          BRAK := TRUE
//        END
//        ELSE
//          WRITE(' ');
//      END (* IF *)
//      ELSE
//        WRITE(' ':5);
//      IF HIGH THEN
//      BEGIN
//        WRITEINT(RESHIGH, N, 'K');
//        IF (STEP(N) AND RESHIGH) <> 0 THEN
//        BEGIN
//          WRITE('*');
//          BRAK := TRUE
//        END
//        ELSE
//          WRITE(' ');
//      END (* IF *)
//    END (* IF *);
//    WRITELN
//  END (* FOR *);
//  DIRECT(' ', 'd');
//  IF BRAK THEN
//    WRITE(' БРАК ')
//  ELSE
//    WRITE('ГОДНАЯ');
//  DIRECT('4', ' ');
//  POINTS;
//  WRITE('ДЛИТ. ТЕСТА:');
//  WRITEREAL(LENTEST, 6, UNITLEN);
//  WRITE(';':4, ' ':4);
//  WRITE('ЗАДЕРЖКА КОМ В');
//  IF NOT DEL3 THEN
//    WRITE('Ы');
//  WRITE('КЛ.');
//  WRITE(';':4, ' ':3);
//  WRITE('РЕЖИМ МАЛЫХ ТОКОВ В');
//  IF NOT SMALLI THEN
//    WRITE('Ы');
//  WRITELN('КЛ.');
//  POINTS;
//  WRITE('КУДА? (ПОВТОРИТЬ=0; ДАЛЬШЕ=1; <МЕНЮ  "А">=<ВК>; ВАХ=<F5>) > ');
//  CH := ReadKey;
//  IF CH = '1' THEN
//    HALTB := FALSE (* ДАЛЕЕ *)
//  ELSE if CH = '0' then
//  begin
//    (* CH='0' *) STARTR(REG110) (* ПОВТОРИТЬ *)
//  end
//  else IF CH = CHR(RETURN) THEN
//  BEGIN
//    ENDPROGRAM;
//    SKIP := TRUE;
//    HALTB := FALSE;
//  END
//  ELSE if CH = #0 then
//  begin
//    CH := ReadKey;
//    if CH = #59 then
//    begin
//      ClrScr;
//
//      WRITELN('                               ПОДСКАЗКА');
//      WRITELN('<0>     - повторить измерение на данном тесте');
//      WRITELN('<1>     - продолжить выполнение программы');
//      WRITELN('<Enter> - прекратить выполнение программы');
//      WRITELN('<F5>    - переход в программу измерения ВАХ с копированием режимов');
//      WRITELN('          данного теста (для плана No3)');
//      CH := ReadKey;
//    end;
//
//    if CH = #63 then
//    begin
//      GetDir(0, dir2); { 0 = Current drive }
//      assign(fzast, nastr[2]);
//{$I-}
//      reset(fzast);
//      if ioresult = 0 then
//      begin
//        repeat
//          readln(fzast, s);
//        until pos('vahpath', s) > 0;
//        pp := pos('=', s);
//        delete(s, 1, pp);
//        dir1 := s;
//        WRITELN(dir1);
//        close(fzast);
//      end;
//      assign(f1, dir1 + '\ist.dat');
//      rewrite(f1);
//
//      { запись режимов в файл }
//      for N := 1 to 16 do
//      begin
//        e := E2(FORCE[N]);
//        UNITTOCH(UNITF[N], UCH);
//        WRITE(f1, FORCE[N]:6:e, UCH:6);
//        e := E2(CLAMP[N]);
//        UNITTOCH(UNITC[N], UCH);
//        WRITE(f1, CLAMP[N]:6:e, UCH:6);
//        if not(N - 1 in m1) then
//          write(f1, ' 1')
//        else
//          write(f1, ' 0');
//        if N - 1 in m2 then
//          write(f1, ' 1')
//        else
//          write(f1, ' 0');
//        WRITELN(f1);
//      end;
//      for N := 1 to 16 do
//        if N in M then
//        begin
//          WRITELN(f1, N);
//          break;
//        end;
//      WRITELN(f1, 0);
//      WRITELN(f1, 100);
//      WRITELN(f1, N);
//      close(f1);
//      BEGIN
//        ENDPROGRAM;
//        SKIP := TRUE;
//        HALTB := FALSE;
//      END;
//
//      savemod;
//      IF RELIST THEN
//      begin
//        close(LISTFILE);
//      end;
//      IF ONSTAT > 0 THEN
//        WRITESTAT(STATFILE);
//      ChDir(dir1);
//{$I+}
//      if ioresult <> 0 then
//      begin
//        WRITELN('Путь указан неверно');
//        readln;
//      end
//      else
//      begin
//        exec('tstvach.exe', '');
//
//        if DosError = 8 then
//          WRITELN('не хватает памяти');
//        if DosError = 8 then
//          readln;;
//        if DosError = 2 then
//          WRITELN('Путь указан неверно');
//      end; { IOResult }
//      ChDir(dir2);
//      restmod;
//
//    end;
//  end;
//END;

class function TfTestConditions.Execute(Data: TInputData): Integer;
begin
  with TfTestConditions.Create(nil) do
  try
    FillView(Data);
    Result := ShowModal;
  finally
    Free;
  end;
end;

procedure TfTestConditions.FillView(Data: TInputData);
const
	FormatStr = '0.##0';
var
  N: Integer;
begin
  lblTestCaption.Caption := Format(lblTestCaption.Caption, [Data.TestCaption]);
  lblTitle.Caption := Format(lblTitle.Caption, [Data.TestNumber, Data.TestUnits]);
  if Data.Brak then
    lblBrak.Caption := Format(lblBrak.Caption, ['БРАК'])
  else
    lblBrak.Caption := Format(lblBrak.Caption, ['ГОДЕН']);
  lblTestLen.Caption := Format(lblTestLen.Caption, [Data.LenTest, Data.LenTestUntis]);
  if Data.Del3 then
    lblDelayComm.Caption := Format(lblDelayComm.Caption, ['ВКЛ'])
  else
    lblDelayComm.Caption := Format(lblDelayComm.Caption, ['ВЫКЛ']);
  if Data.SmallI then
    lblSmallI.Caption := Format(lblSmallI.Caption, ['ВКЛ'])
  else
    lblSmallI.Caption := Format(lblSmallI.Caption, ['ВЫКЛ']);

  NG.AddRow(16);
  for N := 1 to 16 do
  begin
  	NG.Cell[0 , N-1].AsBoolean                      := Data.Pins[N].PinOn;
	  NG.CellByName['colN'            , N-1].AsString := Data.Pins[N].N;
    NG.CellByName['colForce'        , N-1].AsString := FormatFloat(FormatStr, Data.Pins[N].Force);
    NG.CellByName['colForceUnits'   , N-1].AsString := Data.Pins[N].ForceUnits;
    NG.CellByName['colClamp'        , N-1].AsString := FormatFloat(FormatStr, Data.Pins[N].Clamp);
    NG.CellByName['colClampUnits'   , N-1].AsString := Data.Pins[N].ClampUnits;
    NG.CellByName['colTimeOn'       , N-1].AsString := FormatFloat(FormatStr, Data.Pins[N].TimeOn);
    NG.CellByName['colTimeOnUnits'  , N-1].AsString := Data.Pins[N].TimeOnUnits;
    NG.CellByName['colTimeOff'      , N-1].AsString := FormatFloat(FormatStr, Data.Pins[N].TimeOff);
    NG.CellByName['colTimeOffUnits' , N-1].AsString := Data.Pins[N].TimeOffUnits;

    if N in Data.M then
    begin
      NG.CellByName['colDownLimit'      , N-1].AsString  := FormatFloat(FormatStr, Data.Pins[N].DownLimit);
      NG.CellByName['colDownLimitUnits' , N-1].AsString := Data.Pins[N].DownLimitUnits;
      if Data.ADCB then
      begin
        NG.CellByName['colADC'      , N-1].AsString := FormatFloat(FormatStr, Data.Pins[N].ADC);
        NG.CellByName['colADCUnits' , N-1].AsString := Data.Pins[N].ADCUnits;
      end;
      NG.CellByName['colUpLimit'      , N-1].AsString := FormatFloat(FormatStr, Data.Pins[N].UpLimit);
      NG.CellByName['colUpLimitUnits' , N-1].AsString := Data.Pins[N].UpLimitUnits;
      NG.CellByName['colK1'           , N-1].AsString := Data.Pins[N].K1;
      NG.CellByName['colK2'           , N-1].AsString := Data.Pins[N].K2;
    end;
  end;
end;

procedure TfTestConditions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
	CanClose := ModalResult <> mrCancel ;
end;

procedure TfTestConditions.FormCreate(Sender: TObject);
var
  InpData: TInputData;
begin
  FormatSettings.DecimalSeparator := '.';
  EnableMenuItem(GetSystemMenu(Self.Handle, LongBool(False)),
    SC_CLOSE, MF_BYCOMMAND or MF_GRAYED);
end;

procedure TfTestConditions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    Ord('0')  : btnRetry.Click;
    Ord('1')  : btnContinue.Click;
    VK_RETURN : btnAbort.Click;
  end;
end;

end.
