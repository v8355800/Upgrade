//****************************************************************************
// Unit Name: TESTER_ISTINA_GLOBAL
//****************************************************************************
// This file is auto generated with paxCompiler engine.                       
// Import mode: global import.
// ---------------------------------------------------------------------------
// Site: http://www.paxcompiler.com                                           
// Author: Alexander Baranovsky (paxscript@gmail.com)                         
// ---------------------------------------------------------------------------
// Copyright (c) Alexander Baranovsky, 2014.                                  
// ---------------------------------------------------------------------------
// Portion copyright Full Circle Development Ltd.                             
// Content: initial design of importer.                                       
// ---------------------------------------------------------------------------
// Code Version: 1.1                                                   
//****************************************************************************

unit IMP_TESTER_ISTINA_GLOBAL;
interface


function Register_TESTER_ISTINA_GLOBAL: Integer;


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


//function RegisterConstant__MADC(H: Integer): Integer;
//begin
//  result := RegisterConstant(H, 'MADC', MADC);
//end;


//function RegisterConstant__MHALT(H: Integer): Integer;
//begin
//  result := RegisterConstant(H, 'MHALT', MHALT);
//end;


//function RegisterConstant__MLOOP(H: Integer): Integer;
//begin
//  result := RegisterConstant(H, 'MLOOP', MLOOP);
//end;


//function RegisterConstant__MSINCH(H: Integer): Integer;
//begin
//  result := RegisterConstant(H, 'MSINCH', MSINCH);
//end;


//function RegisterConstant__MSTAT(H: Integer): Integer;
//begin
//  result := RegisterConstant(H, 'MSTAT', MSTAT);
//end;


function RegisterConstant__MAXGROUP(H: Integer): Integer;
begin
  result := RegisterConstant(H, 'MAXGROUP', MAXGROUP);
end;


//function RegisterConstant__MAXPOINT(H: Integer): Integer;
//begin
//  result := RegisterConstant(H, 'MAXPOINT', MAXPOINT);
//end;


function RegisterConstant__OPEN(H: Integer): Integer;
begin
  result := RegisterConstant(H, 'OPEN', OPEN);
end;


function RegisterConstant__maxtest(H: Integer): Integer;
begin
  result := RegisterConstant(H, 'maxtest', maxtest);
end;


function RegisterEnumType_EDIZM(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'EDIZM');
  RegisterEnumValue(result, 'V', 0);
  RegisterEnumValue(result, 'NA', 1);
  RegisterEnumValue(result, 'MKA', 2);
  RegisterEnumValue(result, 'MA', 3);
  RegisterEnumValue(result, 'MS', 4);
  RegisterEnumValue(result, 'S', 5);
  RegisterEnumValue(result, 'OM', 6);
  RegisterEnumValue(result, 'KOM', 7);
  RegisterEnumValue(result, 'MOM', 8);
end;


function RegisterShortStringType_IMYA(H: Integer): Integer;
begin
RegisterShortStringType(H, 'IMYA', 4);
end;


function RegisterEnumType_ITOGO(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'ITOGO');
  RegisterEnumValue(result, 'PASS', 0);
  RegisterEnumValue(result, 'FAIL', 1);
end;


function RegisterSubrangeType_NUMBER(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'NUMBER =  1 .. 16;');
end;


function RegisterSetType_PINS(H: Integer): Integer;
var T: Integer;
begin
  T := LookupTypeId('NUMBER');
  result := RegisterSetType(H, 'PINS', T);
end;


function RegisterEnumType_SCALE(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'SCALE');
  RegisterEnumValue(result, 'S0V1', 0);
  RegisterEnumValue(result, 'S1V', 1);
  RegisterEnumValue(result, 'S10V', 2);
  RegisterEnumValue(result, 'S100V', 3);
  RegisterEnumValue(result, 'S1000V', 4);
end;


function RegisterEnumType_SELECTOR(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'SELECTOR');
  RegisterEnumValue(result, 'sON', 0);
  RegisterEnumValue(result, 'sOFF', 1);
end;


function RegisterEnumType_TYPMODE(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'TYPMODE');
  RegisterEnumValue(result, 'U', 0);
  RegisterEnumValue(result, 'I', 1);
end;


function RegisterSubrangeType_SubType_1000087(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000087 = 1 .. maxtest;');
end;


function RegisterSubrangeType_SubType_1000094(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000094 =  1 .. 2;');
end;


function RegisterArrayType_ARLIM(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 2;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000087 = 1 .. maxtest;');
  R[1] := RegisterTypeDeclaration(H, 'SubType_1000094 =  1 .. 2;');
  ElemTypeId := LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ARLIM', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterSubrangeType_SubType_1000103(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000103 = 1 .. maxtest;');
end;


function RegisterArrayType_arv(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000103 = 1 .. maxtest;');
  ElemTypeId := _typeINTEGER;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'arv', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterArrayType_ArrayType_1000108(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000108', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__RES_ADC(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000108');
  result := RegisterVariable(H, 'RES_ADC', T, @ RES_ADC);
end;


function RegisterVariable__LOWCOMP(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'LOWCOMP', T, @ LOWCOMP);
end;


function RegisterVariable__UPCOMP(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'UPCOMP', T, @ UPCOMP);
end;


function RegisterArrayType_ArrayType_1000115(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := LookupTypeId('EDIZM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000115', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__EDIZMRES(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000115');
  result := RegisterVariable(H, 'EDIZMRES', T, @ EDIZMRES);
end;


function RegisterVariable__N(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('PINS');
  result := RegisterVariable(H, 'N', T, @ N);
end;


function RegisterVariable__TESTNAM(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('IMYA');
  result := RegisterVariable(H, 'TESTNAM', T, @ TESTNAM);
end;


function RegisterVariable__TESTUN(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('IMYA');
  result := RegisterVariable(H, 'TESTUN', T, @ TESTUN);
end;


function RegisterVariable__TestNum(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'TestNum', T, @ TestNum);
end;


//function RegisterVariable__NLOOP(H: Integer): Integer;
//var
//  T: Integer;
//begin
//  T := _typeWORD;
//  result := RegisterVariable(H, 'NLOOP', T, @ NLOOP);
//end;


function RegisterVariable__PULT(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PULT', T, @ PULT);
end;


function RegisterVariable__PLAN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PLAN', T, @ PLAN);
end;


function RegisterVariable__PLN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PLN', T, @ PLN);
end;


function RegisterVariable__PLANK(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PLANK', T, @ PLANK);
end;


function RegisterVariable__COM032(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'COM032', T, @ COM032);
end;


function RegisterVariable__COM116(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'COM116', T, @ COM116);
end;


function RegisterArrayType_ArrayType_1000134(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := _typeWORD;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000134', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__COMU(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000134');
  result := RegisterVariable(H, 'COMU', T, @ COMU);
end;


function RegisterVariable__CLAMPRANGE(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000134');
  result := RegisterVariable(H, 'CLAMPRANGE', T, @ CLAMPRANGE);
end;


function RegisterVariable__PINNO(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000134');
  result := RegisterVariable(H, 'PINNO', T, @ PINNO);
end;


function RegisterVariable__COM376(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000134');
  result := RegisterVariable(H, 'COM376', T, @ COM376);
end;


function RegisterVariable__NEWMODE(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('PINS');
  result := RegisterVariable(H, 'NEWMODE', T, @ NEWMODE);
end;


function RegisterVariable__TOTALBRAK(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'TOTALBRAK', T, @ TOTALBRAK);
end;


function RegisterVariable__TOTALADC(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'TOTALADC', T, @ TOTALADC);
end;


function RegisterVariable__GRIEF(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'GRIEF', T, @ GRIEF);
end;


function RegisterVariable__STOP(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'STOP', T, @ STOP);
end;


function RegisterVariable__ADCSTAT(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'ADCSTAT', T, @ ADCSTAT);
end;


function RegisterVariable__ADCB(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'ADCB', T, @ ADCB);
end;


function RegisterVariable__HALTB(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'HALTB', T, @ HALTB);
end;


function RegisterVariable__LOOP(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'LOOP', T, @ LOOP);
end;


function RegisterVariable__SINCH(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'SINCH', T, @ SINCH);
end;


function RegisterVariable__STAT(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'STAT', T, @ STAT);
end;


function RegisterArrayType_ArrayType_1000150(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := LookupTypeId('TYPMODE');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000150', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__MOD376(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000150');
  result := RegisterVariable(H, 'MOD376', T, @ MOD376);
end;


function RegisterArrayType_ArrayType_1000160(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000160', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__FORCE(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000160');
  result := RegisterVariable(H, 'FORCE', T, @ FORCE);
end;


function RegisterVariable__CLAMP(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000160');
  result := RegisterVariable(H, 'CLAMP', T, @ CLAMP);
end;


function RegisterVariable__DOWNLIMIT(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000160');
  result := RegisterVariable(H, 'DOWNLIMIT', T, @ DOWNLIMIT);
end;


function RegisterVariable__UPLIMIT(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000160');
  result := RegisterVariable(H, 'UPLIMIT', T, @ UPLIMIT);
end;


function RegisterVariable__TIMEON(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000160');
  result := RegisterVariable(H, 'TIMEON', T, @ TIMEON);
end;


function RegisterVariable__TIMEOFF(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000160');
  result := RegisterVariable(H, 'TIMEOFF', T, @ TIMEOFF);
end;


function RegisterVariable__LENTEST(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('Real');
  result := RegisterVariable(H, 'LENTEST', T, @ LENTEST);
end;


function RegisterVariable__DEL3(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'DEL3', T, @ DEL3);
end;


function RegisterVariable__SMALLI(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'SMALLI', T, @ SMALLI);
end;


function RegisterVariable__OFFPIN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'OFFPIN', T, @ OFFPIN);
end;


function RegisterVariable__LOADPIN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'LOADPIN', T, @ LOADPIN);
end;


function RegisterVariable__DLOADPIN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'DLOADPIN', T, @ DLOADPIN);
end;


function RegisterArrayType_ArrayType_1000174(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := LookupTypeId('EDIZM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000174', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__UNITF(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000174');
  result := RegisterVariable(H, 'UNITF', T, @ UNITF);
end;


function RegisterVariable__UNITC(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000174');
  result := RegisterVariable(H, 'UNITC', T, @ UNITC);
end;


function RegisterVariable__UNITONOFF(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000174');
  result := RegisterVariable(H, 'UNITONOFF', T, @ UNITONOFF);
end;


function RegisterVariable__UNITCOMP(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000174');
  result := RegisterVariable(H, 'UNITCOMP', T, @ UNITCOMP);
end;


function RegisterVariable__UNITLEN(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('EDIZM');
  result := RegisterVariable(H, 'UNITLEN', T, @ UNITLEN);
end;


function RegisterArrayType_ArrayType_1000180(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := LookupTypeId('NUMBER');
  ElemTypeId := LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000180', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__DISCRADC(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000180');
  result := RegisterVariable(H, 'DISCRADC', T, @ DISCRADC);
end;


function RegisterVariable__TIMERANG(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'TIMERANG', T, @ TIMERANG);
end;


function RegisterVariable__CHANGEDELAYRANG(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'CHANGEDELAYRANG', T, @ CHANGEDELAYRANG);
end;


function RegisterVariable__CHANGELENGTH(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'CHANGELENGTH', T, @ CHANGELENGTH);
end;


function RegisterVariable__RESHIGH(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'RESHIGH', T, @ RESHIGH);
end;


function RegisterVariable__RESLOW(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'RESLOW', T, @ RESLOW);
end;


function RegisterVariable__RESCOM(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeWORD;
  result := RegisterVariable(H, 'RESCOM', T, @ RESCOM);
end;


function RegisterVariable__LOW(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'LOW', T, @ LOW);
end;


function RegisterVariable__HIGH(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'HIGH', T, @ HIGH);
end;


function RegisterVariable__CMPCHK(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'CMPCHK', T, @ CMPCHK);
end;


function RegisterVariable__SKIP(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'SKIP', T, @ SKIP);
end;


function RegisterVariable__numtst(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'numtst', T, @ numtst);
end;


function RegisterVariable__lim(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ARLIM');
  result := RegisterVariable(H, 'lim', T, @ lim);
end;


function RegisterSubrangeType_SubType_1000201(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000201 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000197(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000201 = 1 .. maxgroup;');
  ElemTypeId := LookupTypeId('ARLIM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000197', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__limx(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000197');
  result := RegisterVariable(H, 'limx', T, @ limx);
end;


function RegisterVariable__pnno(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('arv');
  result := RegisterVariable(H, 'pnno', T, @ pnno);
end;


function RegisterSubrangeType_SubType_1000211(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000211 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000207(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000211 = 1 .. maxtest;');
  ElemTypeId := LookupTypeId('IMYA');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000207', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsun(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000207');
  result := RegisterVariable(H, 'tsun', T, @ tsun);
end;


function RegisterSubrangeType_SubType_1000220(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000220 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000216(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000220 = 1 .. maxtest;');
  ElemTypeId := LookupTypeId('IMYA');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000216', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsnam(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000216');
  result := RegisterVariable(H, 'tsnam', T, @ tsnam);
end;


function RegisterVariable__izm_(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'izm_', T, @ izm_);
end;


function RegisterVariable__curgrp(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'curgrp', T, @ curgrp);
end;


function RegisterVariable__maxgrp(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'maxgrp', T, @ maxgrp);
end;


function RegisterVariable__maxtst(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'maxtst', T, @ maxtst);
end;


function RegisterSubrangeType_SubType_1000233(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000233 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000229(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000233 = 1 .. maxgroup;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000229', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__grpmsg(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000229');
  result := RegisterVariable(H, 'grpmsg', T, @ grpmsg);
end;


function RegisterVariable__lastpl(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'lastpl', T, @ lastpl);
end;


function RegisterVariable__endpr(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'endpr', T, @ endpr);
end;


function RegisterVariable__smenagr(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'smenagr', T, @ smenagr);
end;


function RegisterVariable__shiftres(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('Real');
  result := RegisterVariable(H, 'shiftres', T, @ shiftres);
end;


procedure Part1(result: Integer);
begin
//  RegisterConstant__MADC(result);
//  RegisterConstant__MHALT(result);
//  RegisterConstant__MLOOP(result);
//  RegisterConstant__MSINCH(result);
//  RegisterConstant__MSTAT(result);
  RegisterConstant__MAXGROUP(result);
//  RegisterConstant__MAXPOINT(result);
  RegisterConstant__OPEN(result);
  RegisterConstant__maxtest(result);
  RegisterEnumType_EDIZM(result);
  RegisterShortStringType_IMYA(result);
  RegisterEnumType_ITOGO(result);
  RegisterSubrangeType_NUMBER(result);
  RegisterSetType_PINS(result);
  RegisterEnumType_SCALE(result);
  RegisterEnumType_SELECTOR(result);
  RegisterEnumType_TYPMODE(result);
  RegisterSubrangeType_SubType_1000087(result);
  RegisterSubrangeType_SubType_1000094(result);
  RegisterArrayType_ARLIM(result);
  RegisterSubrangeType_SubType_1000103(result);
  RegisterArrayType_arv(result);
  RegisterArrayType_ArrayType_1000108(result);
  RegisterVariable__RES_ADC(result);
  RegisterVariable__LOWCOMP(result);
  RegisterVariable__UPCOMP(result);
  RegisterArrayType_ArrayType_1000115(result);
  RegisterVariable__EDIZMRES(result);
  RegisterVariable__N(result);
  RegisterVariable__TESTNAM(result);
  RegisterVariable__TESTUN(result);
  RegisterVariable__TestNum(result);
//  RegisterVariable__NLOOP(result);
  RegisterVariable__PULT(result);
  RegisterVariable__PLAN(result);
  RegisterVariable__PLN(result);
  RegisterVariable__PLANK(result);
  RegisterVariable__COM032(result);
  RegisterVariable__COM116(result);
  RegisterArrayType_ArrayType_1000134(result);
  RegisterVariable__COMU(result);
  RegisterVariable__CLAMPRANGE(result);
  RegisterVariable__PINNO(result);
  RegisterVariable__COM376(result);
  RegisterVariable__NEWMODE(result);
  RegisterVariable__TOTALBRAK(result);
  RegisterVariable__TOTALADC(result);
  RegisterVariable__GRIEF(result);
  RegisterVariable__STOP(result);
  RegisterVariable__ADCSTAT(result);
  RegisterVariable__ADCB(result);
  RegisterVariable__HALTB(result);
  RegisterVariable__LOOP(result);
  RegisterVariable__SINCH(result);
  RegisterVariable__STAT(result);
  RegisterArrayType_ArrayType_1000150(result);
  RegisterVariable__MOD376(result);
  RegisterArrayType_ArrayType_1000160(result);
  RegisterVariable__FORCE(result);
  RegisterVariable__CLAMP(result);
  RegisterVariable__DOWNLIMIT(result);
  RegisterVariable__UPLIMIT(result);
  RegisterVariable__TIMEON(result);
  RegisterVariable__TIMEOFF(result);
  RegisterVariable__LENTEST(result);
  RegisterVariable__DEL3(result);
  RegisterVariable__SMALLI(result);
  RegisterVariable__OFFPIN(result);
  RegisterVariable__LOADPIN(result);
  RegisterVariable__DLOADPIN(result);
  RegisterArrayType_ArrayType_1000174(result);
  RegisterVariable__UNITF(result);
  RegisterVariable__UNITC(result);
  RegisterVariable__UNITONOFF(result);
  RegisterVariable__UNITCOMP(result);
  RegisterVariable__UNITLEN(result);
  RegisterArrayType_ArrayType_1000180(result);
  RegisterVariable__DISCRADC(result);
  RegisterVariable__TIMERANG(result);
  RegisterVariable__CHANGEDELAYRANG(result);
  RegisterVariable__CHANGELENGTH(result);
  RegisterVariable__RESHIGH(result);
  RegisterVariable__RESLOW(result);
  RegisterVariable__RESCOM(result);
  RegisterVariable__LOW(result);
  RegisterVariable__HIGH(result);
  RegisterVariable__CMPCHK(result);
  RegisterVariable__SKIP(result);
  RegisterVariable__numtst(result);
  RegisterVariable__lim(result);
  RegisterSubrangeType_SubType_1000201(result);
  RegisterArrayType_ArrayType_1000197(result);
  RegisterVariable__limx(result);
  RegisterVariable__pnno(result);
  RegisterSubrangeType_SubType_1000211(result);
  RegisterArrayType_ArrayType_1000207(result);
  RegisterVariable__tsun(result);
  RegisterSubrangeType_SubType_1000220(result);
  RegisterArrayType_ArrayType_1000216(result);
  RegisterVariable__tsnam(result);
  RegisterVariable__izm_(result);
  RegisterVariable__curgrp(result);
  RegisterVariable__maxgrp(result);
  RegisterVariable__maxtst(result);
  RegisterSubrangeType_SubType_1000233(result);
  RegisterArrayType_ArrayType_1000229(result);
  RegisterVariable__grpmsg(result);
  RegisterVariable__lastpl(result);
  RegisterVariable__endpr(result);
  RegisterVariable__smenagr(result);
  RegisterVariable__shiftres(result);
end;

function Register_TESTER_ISTINA_GLOBAL: Integer;
begin
  result := RegisterNamespace(0, 'GLOBAL');
  Part1(result);
  UnregisterUsingNamespaces;
end;

end.
