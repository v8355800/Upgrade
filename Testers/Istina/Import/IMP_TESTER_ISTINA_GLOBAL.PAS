//****************************************************************************
// Unit Name: TESTER_ISTINA_GLOBAL
//****************************************************************************

unit IMP_TESTER_ISTINA_GLOBAL;

interface

uses
  PaxCompiler;

function Register_TESTER_ISTINA_GLOBAL(compiler: TPaxCompiler): Integer;

implementation

uses
  PAXCOMP_STDLIB,
  PaxRegister,
  Classes,
  TESTER_ISTINA_GLOBAL;


type
  TDummyClass = class
    procedure P; virtual; abstract;
  end;

function GetAbstractMethodAddress: Pointer;
begin
  result := PPointer(TDummyClass)^;
end;


//function RegisterConstant__MADC(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstant(H, 'MADC', MADC);
//end;


//function RegisterConstant__MHALT(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstant(H, 'MHALT', MHALT);
//end;


//function RegisterConstant__MLOOP(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstant(H, 'MLOOP', MLOOP);
//end;


//function RegisterConstant__MSINCH(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstant(H, 'MSINCH', MSINCH);
//end;


//function RegisterConstant__MSTAT(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstant(H, 'MSTAT', MSTAT);
//end;


function RegisterConstant__MAXGROUP(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterConstant(H, 'MAXGROUP', MAXGROUP);
end;


//function RegisterConstant__MAXPOINT(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstant(H, 'MAXPOINT', MAXPOINT);
//end;


function RegisterConstant__OPEN(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterConstant(H, 'OPEN', OPEN);
end;


function RegisterConstant__maxtest(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterConstant(H, 'maxtest', maxtest);
end;


function RegisterEnumType_EDIZM(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'EDIZM');
  compiler.RegisterEnumValue(result, 'V', 0);
  compiler.RegisterEnumValue(result, 'NA', 1);
  compiler.RegisterEnumValue(result, 'MKA', 2);
  compiler.RegisterEnumValue(result, 'MA', 3);
  compiler.RegisterEnumValue(result, 'MS', 4);
  compiler.RegisterEnumValue(result, 'S', 5);
  compiler.RegisterEnumValue(result, 'OM', 6);
  compiler.RegisterEnumValue(result, 'KOM', 7);
  compiler.RegisterEnumValue(result, 'MOM', 8);
end;


function RegisterShortStringType_IMYA(H: Integer; compiler: TPaxCompiler): Integer;
begin
  compiler.RegisterShortStringType(H, 'IMYA', 4);
end;


function RegisterEnumType_ITOGO(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'ITOGO');
  compiler.RegisterEnumValue(result, 'PASS', 0);
  compiler.RegisterEnumValue(result, 'FAIL', 1);
end;


function RegisterSubrangeType_NUMBER(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'NUMBER =  1 .. 16;');
end;


function RegisterSetType_PINS(H: Integer; compiler: TPaxCompiler): Integer;
var T: Integer;
begin
  T := compiler.LookupTypeId('NUMBER');
  result := compiler.RegisterSetType(H, 'PINS', T);
end;


function RegisterEnumType_SCALE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'SCALE');
  compiler.RegisterEnumValue(result, 'S0V1', 0);
  compiler.RegisterEnumValue(result, 'S1V', 1);
  compiler.RegisterEnumValue(result, 'S10V', 2);
  compiler.RegisterEnumValue(result, 'S100V', 3);
  compiler.RegisterEnumValue(result, 'S1000V', 4);
end;


function RegisterEnumType_SELECTOR(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'SELECTOR');
  compiler.RegisterEnumValue(result, 'sON', 0);
  compiler.RegisterEnumValue(result, 'sOFF', 1);
end;


function RegisterEnumType_TYPMODE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'TYPMODE');
  compiler.RegisterEnumValue(result, 'U', 0);
  compiler.RegisterEnumValue(result, 'I', 1);
end;


function RegisterSubrangeType_SubType_1000087(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000087 = 1 .. maxtest;');
end;


function RegisterSubrangeType_SubType_1000094(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000094 =  1 .. 2;');
end;


function RegisterArrayType_ARLIM(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 2;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000087 = 1 .. maxtest;');
  R[1] := compiler.RegisterTypeDeclaration(H, 'SubType_1000094 =  1 .. 2;');
  ElemTypeId := compiler.LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ARLIM', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterSubrangeType_SubType_1000103(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000103 = 1 .. maxtest;');
end;


function RegisterArrayType_arv(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000103 = 1 .. maxtest;');
  ElemTypeId := _typeINTEGER;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'arv', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterArrayType_ArrayType_1000108(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := compiler.LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000108', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__RES_ADC(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000108');
  result := compiler.RegisterVariable(H, 'RES_ADC', T, @ RES_ADC);
end;


function RegisterVariable__LOWCOMP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'LOWCOMP', T, @ LOWCOMP);
end;


function RegisterVariable__UPCOMP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'UPCOMP', T, @ UPCOMP);
end;


function RegisterArrayType_ArrayType_1000115(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := compiler.LookupTypeId('EDIZM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000115', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__EDIZMRES(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000115');
  result := compiler.RegisterVariable(H, 'EDIZMRES', T, @ EDIZMRES);
end;


function RegisterVariable__N(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('PINS');
  result := compiler.RegisterVariable(H, 'N', T, @ N);
end;


function RegisterVariable__TESTNAM(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('IMYA');
  result := compiler.RegisterVariable(H, 'TESTNAM', T, @ TESTNAM);
end;


function RegisterVariable__TESTUN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('IMYA');
  result := compiler.RegisterVariable(H, 'TESTUN', T, @ TESTUN);
end;


function RegisterVariable__TestNum(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'TestNum', T, @ TestNum);
end;


//function RegisterVariable__NLOOP(H: Integer; compiler: TPaxCompiler): Integer;
//var
//  T: Integer;
//begin
//  T := _typeWORD;
//  result := compiler.RegisterVariable(H, 'NLOOP', T, @ NLOOP);
//end;


function RegisterVariable__PULT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PULT', T, @ PULT);
end;


function RegisterVariable__PLAN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PLAN', T, @ PLAN);
end;


function RegisterVariable__PLN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PLN', T, @ PLN);
end;


function RegisterVariable__PLANK(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PLANK', T, @ PLANK);
end;


function RegisterVariable__COM032(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'COM032', T, @ COM032);
end;


function RegisterVariable__COM116(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'COM116', T, @ COM116);
end;


function RegisterArrayType_ArrayType_1000134(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := _typeWORD;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000134', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__COMU(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000134');
  result := compiler.RegisterVariable(H, 'COMU', T, @ COMU);
end;


function RegisterVariable__CLAMPRANGE(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000134');
  result := compiler.RegisterVariable(H, 'CLAMPRANGE', T, @ CLAMPRANGE);
end;


function RegisterVariable__PINNO(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000134');
  result := compiler.RegisterVariable(H, 'PINNO', T, @ PINNO);
end;


function RegisterVariable__COM376(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000134');
  result := compiler.RegisterVariable(H, 'COM376', T, @ COM376);
end;


function RegisterVariable__NEWMODE(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('PINS');
  result := compiler.RegisterVariable(H, 'NEWMODE', T, @ NEWMODE);
end;


function RegisterVariable__TOTALBRAK(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'TOTALBRAK', T, @ TOTALBRAK);
end;


function RegisterVariable__TOTALADC(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'TOTALADC', T, @ TOTALADC);
end;


function RegisterVariable__GRIEF(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'GRIEF', T, @ GRIEF);
end;


function RegisterVariable__STOP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'STOP', T, @ STOP);
end;


function RegisterVariable__ADCSTAT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'ADCSTAT', T, @ ADCSTAT);
end;


function RegisterVariable__ADCB(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'ADCB', T, @ ADCB);
end;


function RegisterVariable__HALTB(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'HALTB', T, @ HALTB);
end;


function RegisterVariable__LOOP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'LOOP', T, @ LOOP);
end;


function RegisterVariable__SINCH(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'SINCH', T, @ SINCH);
end;


function RegisterVariable__STAT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'STAT', T, @ STAT);
end;


function RegisterArrayType_ArrayType_1000150(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := compiler.LookupTypeId('TYPMODE');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000150', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__MOD376(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000150');
  result := compiler.RegisterVariable(H, 'MOD376', T, @ MOD376);
end;


function RegisterArrayType_ArrayType_1000160(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := compiler.LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000160', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__FORCE(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000160');
  result := compiler.RegisterVariable(H, 'FORCE', T, @ FORCE);
end;


function RegisterVariable__CLAMP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000160');
  result := compiler.RegisterVariable(H, 'CLAMP', T, @ CLAMP);
end;


function RegisterVariable__DOWNLIMIT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000160');
  result := compiler.RegisterVariable(H, 'DOWNLIMIT', T, @ DOWNLIMIT);
end;


function RegisterVariable__UPLIMIT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000160');
  result := compiler.RegisterVariable(H, 'UPLIMIT', T, @ UPLIMIT);
end;


function RegisterVariable__TIMEON(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000160');
  result := compiler.RegisterVariable(H, 'TIMEON', T, @ TIMEON);
end;


function RegisterVariable__TIMEOFF(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000160');
  result := compiler.RegisterVariable(H, 'TIMEOFF', T, @ TIMEOFF);
end;


function RegisterVariable__LENTEST(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('Real');
  result := compiler.RegisterVariable(H, 'LENTEST', T, @ LENTEST);
end;


function RegisterVariable__DEL3(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'DEL3', T, @ DEL3);
end;


function RegisterVariable__SMALLI(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'SMALLI', T, @ SMALLI);
end;


function RegisterVariable__OFFPIN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'OFFPIN', T, @ OFFPIN);
end;


function RegisterVariable__LOADPIN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'LOADPIN', T, @ LOADPIN);
end;


function RegisterVariable__DLOADPIN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'DLOADPIN', T, @ DLOADPIN);
end;


function RegisterArrayType_ArrayType_1000174(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := compiler.LookupTypeId('EDIZM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000174', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__UNITF(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000174');
  result := compiler.RegisterVariable(H, 'UNITF', T, @ UNITF);
end;


function RegisterVariable__UNITC(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000174');
  result := compiler.RegisterVariable(H, 'UNITC', T, @ UNITC);
end;


function RegisterVariable__UNITONOFF(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000174');
  result := compiler.RegisterVariable(H, 'UNITONOFF', T, @ UNITONOFF);
end;


function RegisterVariable__UNITCOMP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000174');
  result := compiler.RegisterVariable(H, 'UNITCOMP', T, @ UNITCOMP);
end;


function RegisterVariable__UNITLEN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('EDIZM');
  result := compiler.RegisterVariable(H, 'UNITLEN', T, @ UNITLEN);
end;


function RegisterArrayType_ArrayType_1000180(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.LookupTypeId('NUMBER');
  ElemTypeId := compiler.LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000180', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__DISCRADC(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000180');
  result := compiler.RegisterVariable(H, 'DISCRADC', T, @ DISCRADC);
end;


function RegisterVariable__TIMERANG(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'TIMERANG', T, @ TIMERANG);
end;


function RegisterVariable__CHANGEDELAYRANG(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'CHANGEDELAYRANG', T, @ CHANGEDELAYRANG);
end;


function RegisterVariable__CHANGELENGTH(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'CHANGELENGTH', T, @ CHANGELENGTH);
end;


function RegisterVariable__RESHIGH(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'RESHIGH', T, @ RESHIGH);
end;


function RegisterVariable__RESLOW(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'RESLOW', T, @ RESLOW);
end;


function RegisterVariable__RESCOM(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := compiler.RegisterVariable(H, 'RESCOM', T, @ RESCOM);
end;


function RegisterVariable__LOW(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'LOW', T, @ LOW);
end;


function RegisterVariable__HIGH(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'HIGH', T, @ HIGH);
end;


function RegisterVariable__CMPCHK(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'CMPCHK', T, @ CMPCHK);
end;


function RegisterVariable__SKIP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'SKIP', T, @ SKIP);
end;


function RegisterVariable__numtst(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'numtst', T, @ numtst);
end;


function RegisterVariable__lim(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ARLIM');
  result := compiler.RegisterVariable(H, 'lim', T, @ lim);
end;


function RegisterSubrangeType_SubType_1000201(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000201 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000197(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000201 = 1 .. maxgroup;');
  ElemTypeId := compiler.LookupTypeId('ARLIM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000197', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__limx(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000197');
  result := compiler.RegisterVariable(H, 'limx', T, @ limx);
end;


function RegisterVariable__pnno(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('arv');
  result := compiler.RegisterVariable(H, 'pnno', T, @ pnno);
end;


function RegisterSubrangeType_SubType_1000211(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000211 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000207(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000211 = 1 .. maxtest;');
  ElemTypeId := compiler.LookupTypeId('IMYA');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000207', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsun(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000207');
  result := compiler.RegisterVariable(H, 'tsun', T, @ tsun);
end;


function RegisterSubrangeType_SubType_1000220(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000220 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000216(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000220 = 1 .. maxtest;');
  ElemTypeId := compiler.LookupTypeId('IMYA');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000216', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsnam(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000216');
  result := compiler.RegisterVariable(H, 'tsnam', T, @ tsnam);
end;


function RegisterVariable__izm_(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'izm_', T, @ izm_);
end;


function RegisterVariable__curgrp(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'curgrp', T, @ curgrp);
end;


function RegisterVariable__maxgrp(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'maxgrp', T, @ maxgrp);
end;


function RegisterVariable__maxtst(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'maxtst', T, @ maxtst);
end;


function RegisterSubrangeType_SubType_1000233(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000233 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000229(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000233 = 1 .. maxgroup;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000229', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__grpmsg(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000229');
  result := compiler.RegisterVariable(H, 'grpmsg', T, @ grpmsg);
end;


function RegisterVariable__lastpl(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'lastpl', T, @ lastpl);
end;


function RegisterVariable__endpr(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'endpr', T, @ endpr);
end;


function RegisterVariable__smenagr(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'smenagr', T, @ smenagr);
end;


function RegisterVariable__shiftres(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('Real');
  result := compiler.RegisterVariable(H, 'shiftres', T, @ shiftres);
end;


procedure Part1(result: Integer; compiler: TPaxCompiler);
begin
//  RegisterConstant__MADC(result);
//  RegisterConstant__MHALT(result);
//  RegisterConstant__MLOOP(result);
//  RegisterConstant__MSINCH(result);
//  RegisterConstant__MSTAT(result);
//  RegisterConstant__MAXPOINT(result);
//  RegisterVariable__NLOOP(result);

  RegisterConstant__MAXGROUP(result, compiler);
  RegisterConstant__OPEN(result, compiler);
  RegisterConstant__maxtest(result, compiler);
  RegisterEnumType_EDIZM(result, compiler);
  RegisterShortStringType_IMYA(result, compiler);
  RegisterEnumType_ITOGO(result, compiler);
  RegisterSubrangeType_NUMBER(result, compiler);
  RegisterSetType_PINS(result, compiler);
  RegisterEnumType_SCALE(result, compiler);
  RegisterEnumType_SELECTOR(result, compiler);
  RegisterEnumType_TYPMODE(result, compiler);
  RegisterSubrangeType_SubType_1000087(result, compiler);
  RegisterSubrangeType_SubType_1000094(result, compiler);
  RegisterArrayType_ARLIM(result, compiler);
  RegisterSubrangeType_SubType_1000103(result, compiler);
  RegisterArrayType_arv(result, compiler);
  RegisterArrayType_ArrayType_1000108(result, compiler);
  RegisterVariable__RES_ADC(result, compiler);
  RegisterVariable__LOWCOMP(result, compiler);
  RegisterVariable__UPCOMP(result, compiler);
  RegisterArrayType_ArrayType_1000115(result, compiler);
  RegisterVariable__EDIZMRES(result, compiler);
  RegisterVariable__N(result, compiler);
  RegisterVariable__TESTNAM(result, compiler);
  RegisterVariable__TESTUN(result, compiler);
  RegisterVariable__TestNum(result, compiler);
  RegisterVariable__PULT(result, compiler);
  RegisterVariable__PLAN(result, compiler);
  RegisterVariable__PLN(result, compiler);
  RegisterVariable__PLANK(result, compiler);
  RegisterVariable__COM032(result, compiler);
  RegisterVariable__COM116(result, compiler);
  RegisterArrayType_ArrayType_1000134(result, compiler);
  RegisterVariable__COMU(result, compiler);
  RegisterVariable__CLAMPRANGE(result, compiler);
  RegisterVariable__PINNO(result, compiler);
  RegisterVariable__COM376(result, compiler);
  RegisterVariable__NEWMODE(result, compiler);
  RegisterVariable__TOTALBRAK(result, compiler);
  RegisterVariable__TOTALADC(result, compiler);
  RegisterVariable__GRIEF(result, compiler);
  RegisterVariable__STOP(result, compiler);
  RegisterVariable__ADCSTAT(result, compiler);
  RegisterVariable__ADCB(result, compiler);
  RegisterVariable__HALTB(result, compiler);
  RegisterVariable__LOOP(result, compiler);
  RegisterVariable__SINCH(result, compiler);
  RegisterVariable__STAT(result, compiler);
  RegisterArrayType_ArrayType_1000150(result, compiler);
  RegisterVariable__MOD376(result, compiler);
  RegisterArrayType_ArrayType_1000160(result, compiler);
  RegisterVariable__FORCE(result, compiler);
  RegisterVariable__CLAMP(result, compiler);
  RegisterVariable__DOWNLIMIT(result, compiler);
  RegisterVariable__UPLIMIT(result, compiler);
  RegisterVariable__TIMEON(result, compiler);
  RegisterVariable__TIMEOFF(result, compiler);
  RegisterVariable__LENTEST(result, compiler);
  RegisterVariable__DEL3(result, compiler);
  RegisterVariable__SMALLI(result, compiler);
  RegisterVariable__OFFPIN(result, compiler);
  RegisterVariable__LOADPIN(result, compiler);
  RegisterVariable__DLOADPIN(result, compiler);
  RegisterArrayType_ArrayType_1000174(result, compiler);
  RegisterVariable__UNITF(result, compiler);
  RegisterVariable__UNITC(result, compiler);
  RegisterVariable__UNITONOFF(result, compiler);
  RegisterVariable__UNITCOMP(result, compiler);
  RegisterVariable__UNITLEN(result, compiler);
  RegisterArrayType_ArrayType_1000180(result, compiler);
  RegisterVariable__DISCRADC(result, compiler);
  RegisterVariable__TIMERANG(result, compiler);
  RegisterVariable__CHANGEDELAYRANG(result, compiler);
  RegisterVariable__CHANGELENGTH(result, compiler);
  RegisterVariable__RESHIGH(result, compiler);
  RegisterVariable__RESLOW(result, compiler);
  RegisterVariable__RESCOM(result, compiler);
  RegisterVariable__LOW(result, compiler);
  RegisterVariable__HIGH(result, compiler);
  RegisterVariable__CMPCHK(result, compiler);
  RegisterVariable__SKIP(result, compiler);
  RegisterVariable__numtst(result, compiler);
  RegisterVariable__lim(result, compiler);
  RegisterSubrangeType_SubType_1000201(result, compiler);
  RegisterArrayType_ArrayType_1000197(result, compiler);
  RegisterVariable__limx(result, compiler);
  RegisterVariable__pnno(result, compiler);
  RegisterSubrangeType_SubType_1000211(result, compiler);
  RegisterArrayType_ArrayType_1000207(result, compiler);
  RegisterVariable__tsun(result, compiler);
  RegisterSubrangeType_SubType_1000220(result, compiler);
  RegisterArrayType_ArrayType_1000216(result, compiler);
  RegisterVariable__tsnam(result, compiler);
  RegisterVariable__izm_(result, compiler);
  RegisterVariable__curgrp(result, compiler);
  RegisterVariable__maxgrp(result, compiler);
  RegisterVariable__maxtst(result, compiler);
  RegisterSubrangeType_SubType_1000233(result, compiler);
  RegisterArrayType_ArrayType_1000229(result, compiler);
  RegisterVariable__grpmsg(result, compiler);
  RegisterVariable__lastpl(result, compiler);
  RegisterVariable__endpr(result, compiler);
  RegisterVariable__smenagr(result, compiler);
  RegisterVariable__shiftres(result, compiler);
end;

function Register_TESTER_ISTINA_GLOBAL(compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterNamespace(0, 'Istina_Global');
  Part1(result, compiler);
  compiler.UnregisterUsingNamespaces;
end;

end.
