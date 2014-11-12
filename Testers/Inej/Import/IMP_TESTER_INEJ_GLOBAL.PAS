//****************************************************************************
// Unit Name: TESTER_INEJ_GLOBAL
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

unit IMP_TESTER_INEJ_GLOBAL;
interface


function Register_TESTER_INEJ_GLOBAL: Integer;


implementation


uses
  PAXCOMP_STDLIB,
  PaxRegister,
  Classes,
  TESTER_INEJ_GLOBAL;


type
  TDummyClass = class
    procedure P; virtual; abstract;
  end;

function GetAbstractMethodAddress: Pointer;
begin
  result := PPointer(TDummyClass)^;
end;


function RegisterConstant__maxgroup(H: Integer): Integer;
begin
  result := RegisterConstant(H, 'maxgroup', maxgroup);
end;


function RegisterConstant__maxtest(H: Integer): Integer;
begin
  result := RegisterConstant(H, 'maxtest', maxtest);
end;


function RegisterEnumType_Parameter(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Parameter');
  RegisterEnumValue(result, 'Ice', 0);
  RegisterEnumValue(result, 'Icbo', 1);
  RegisterEnumValue(result, 'Iebo', 2);
  RegisterEnumValue(result, 'h21e', 3);
  RegisterEnumValue(result, 'Ucesat', 4);
  RegisterEnumValue(result, 'Ubesat', 5);
  RegisterEnumValue(result, 'Uceo', 6);
  RegisterEnumValue(result, 'Uin', 7);
  RegisterEnumValue(result, 'h21', 8);
end;


function RegisterEnumType_Conductivity(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Conductivity');
  RegisterEnumValue(result, 'npn', 0);
  RegisterEnumValue(result, 'pnp', 1);
end;


function RegisterEnumType_Plug(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Plug');
  RegisterEnumValue(result, 'normal', 0);
  RegisterEnumValue(result, 'inverse', 1);
end;


function RegisterEnumType_Rbe(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Rbe');
  RegisterEnumValue(result, 'r0', 0);
  RegisterEnumValue(result, 'r1', 1);
  RegisterEnumValue(result, 'r2', 2);
  RegisterEnumValue(result, 'r3', 3);
  RegisterEnumValue(result, 'r4', 4);
  RegisterEnumValue(result, 'r5', 5);
  RegisterEnumValue(result, 'r6', 6);
  RegisterEnumValue(result, 'r7', 7);
end;


function RegisterEnumType_Range(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Range');
  RegisterEnumValue(result, 'D0', 0);
  RegisterEnumValue(result, 'D1', 1);
  RegisterEnumValue(result, 'D10', 2);
  RegisterEnumValue(result, 'D100', 3);
  RegisterEnumValue(result, 'D500', 4);
end;


function RegisterEnumType_Units(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Units');
  RegisterEnumValue(result, 'no', 0);
  RegisterEnumValue(result, 'nA', 1);
  RegisterEnumValue(result, 'uA', 2);
  RegisterEnumValue(result, 'mA', 3);
  RegisterEnumValue(result, 'mA9', 4);
  RegisterEnumValue(result, 'mA10', 5);
  RegisterEnumValue(result, 'A', 6);
  RegisterEnumValue(result, 'mV', 7);
  RegisterEnumValue(result, 'V', 8);
  RegisterEnumValue(result, 'V8', 9);
  RegisterEnumValue(result, 'mS', 10);
  RegisterEnumValue(result, 'S', 11);
  RegisterEnumValue(result, 'x3', 12);
  RegisterEnumValue(result, 'x4', 13);
  RegisterEnumValue(result, 'x5', 14);
  RegisterEnumValue(result, 'x6', 15);
  RegisterEnumValue(result, 'x7', 16);
  RegisterEnumValue(result, 'x8', 17);
  RegisterEnumValue(result, 'x9', 18);
  RegisterEnumValue(result, 'x10', 19);
  RegisterEnumValue(result, 'x11', 20);
end;


function RegisterEnumType_Jumps(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'Jumps');
  RegisterEnumValue(result, 'none', 0);
  RegisterEnumValue(result, 'Osc', 1);
  RegisterEnumValue(result, 'Grt', 2);
  RegisterEnumValue(result, 'Lwr', 3);
  RegisterEnumValue(result, 'Over', 4);
end;


function RegisterSubrangeType_relay(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'relay =  1 .. 32;');
end;


function RegisterSetType_relays(H: Integer): Integer;
var T: Integer;
begin
  T := LookupTypeId('relay');
  result := RegisterSetType(H, 'relays', T);
end;


function RegisterEnumType_ITOGO(H: Integer): Integer;
begin
  result := RegisterEnumType(H, 'ITOGO');
  RegisterEnumValue(result, 'PASS', 0);
  RegisterEnumValue(result, 'FAIL', 1);
end;


function RegisterSubrangeType_SubType_1000145(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000145 = 1 .. maxtest;');
end;


function RegisterSubrangeType_SubType_1000152(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000152 =  1 .. 2;');
end;


function RegisterArrayType_ARLIM(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 2;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000145 = 1 .. maxtest;');
  R[1] := RegisterTypeDeclaration(H, 'SubType_1000152 =  1 .. 2;');
  ElemTypeId := LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ARLIM', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__Connection(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('Plug');
  result := RegisterVariable(H, 'Connection', T, @ Connection);
end;


function RegisterVariable__PLAN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PLAN', T, @ PLAN);
end;


function RegisterVariable__PLANK(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PLANK', T, @ PLANK);
end;


function RegisterVariable__PULT(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := RegisterVariable(H, 'PULT', T, @ PULT);
end;


function RegisterVariable__MEASURE(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'MEASURE', T, @ MEASURE);
end;


function RegisterVariable__PRINT(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'PRINT', T, @ PRINT);
end;


function RegisterSubrangeType_SubType_1000168(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000168 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000164(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000168 = 1 .. maxtest;');
  ElemTypeId := LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000164', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__RES_ADC(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000164');
  result := RegisterVariable(H, 'RES_ADC', T, @ RES_ADC);
end;


function RegisterVariable__ResultUnit(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeUNICSTRING;
  result := RegisterVariable(H, 'ResultUnit', T, @ ResultUnit);
end;


function RegisterVariable__sign(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('Jumps');
  result := RegisterVariable(H, 'sign', T, @ sign);
end;


function RegisterVariable__TESTNAM(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeUNICSTRING;
  result := RegisterVariable(H, 'TESTNAM', T, @ TESTNAM);
end;


function RegisterVariable__TESTUN(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeUNICSTRING;
  result := RegisterVariable(H, 'TESTUN', T, @ TESTUN);
end;


function RegisterVariable__TESTNO(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'TESTNO', T, @ TESTNO);
end;


function RegisterVariable__TOTALBRAK(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'TOTALBRAK', T, @ TOTALBRAK);
end;


function RegisterVariable__brakgroup(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'brakgroup', T, @ brakgroup);
end;


function RegisterVariable__GRIEF(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'GRIEF', T, @ GRIEF);
end;


function RegisterVariable__SKIP(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'SKIP', T, @ SKIP);
end;


function RegisterSubrangeType_SubType_1000184(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000184 =  set of 1 .. maxtest;');
end;


function RegisterSetType_SetType_1000182(H: Integer): Integer;
var T: Integer;
begin
  T := LookupTypeId('SubType_1000184');
  result := RegisterSetType(H, 'SetType_1000182', T);
end;


function RegisterVariable__ostanov(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('SetType_1000182');
  result := RegisterVariable(H, 'ostanov', T, @ ostanov);
end;


function RegisterVariable__DOWNLIMIT(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('Real');
  result := RegisterVariable(H, 'DOWNLIMIT', T, @ DOWNLIMIT);
end;


function RegisterVariable__UPLIMIT(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('Real');
  result := RegisterVariable(H, 'UPLIMIT', T, @ UPLIMIT);
end;


function RegisterVariable__lastgrp(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := RegisterVariable(H, 'lastgrp', T, @ lastgrp);
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


function RegisterSubrangeType_SubType_1000198(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000198 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000194(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000198 = 1 .. maxtest;');
  ElemTypeId := _typeINTEGER;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000194', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


//function RegisterVariable__pnno(H: Integer): Integer;
//var
//  T: Integer;
//begin
//  T := LookupTypeId('ArrayType_1000194');
//  result := RegisterVariable(H, 'pnno', T, @ pnno);
//end;


function RegisterSubrangeType_SubType_1000207(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000207 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000203(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000207 = 1 .. maxtest;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000203', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsun(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000203');
  result := RegisterVariable(H, 'tsun', T, @ tsun);
end;


function RegisterSubrangeType_SubType_1000216(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000216 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000212(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000216 = 1 .. maxtest;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000212', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsnam(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000212');
  result := RegisterVariable(H, 'tsnam', T, @ tsnam);
end;


function RegisterSubrangeType_SubType_1000225(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000225 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000221(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000225 = 1 .. maxgroup;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000221', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__grpmsg(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000221');
  result := RegisterVariable(H, 'grpmsg', T, @ grpmsg);
end;


function RegisterVariable__lim(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ARLIM');
  result := RegisterVariable(H, 'lim', T, @ lim);
end;


function RegisterSubrangeType_SubType_1000235(H: Integer): Integer;
begin
  result := RegisterTypeDeclaration(H, 'SubType_1000235 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000231(H: Integer): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := RegisterTypeDeclaration(H, 'SubType_1000235 = 1 .. maxgroup;');
  ElemTypeId := LookupTypeId('ARLIM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := RegisterArrayType(H, 'ArrayType_1000231', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__limx(H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('ArrayType_1000231');
  result := RegisterVariable(H, 'limx', T, @ limx);
end;


function RegisterVariable__smenagr(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'smenagr', T, @ smenagr);
end;


function RegisterVariable__endpr(H: Integer): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := RegisterVariable(H, 'endpr', T, @ endpr);
end;


procedure Part1(result: Integer);
begin
  RegisterConstant__maxgroup(result);
  RegisterConstant__maxtest(result);
  RegisterEnumType_Parameter(result);
  RegisterEnumType_Conductivity(result);
  RegisterEnumType_Plug(result);
  RegisterEnumType_Rbe(result);
  RegisterEnumType_Range(result);
  RegisterEnumType_Units(result);
  RegisterEnumType_Jumps(result);
  RegisterSubrangeType_relay(result);
  RegisterSetType_relays(result);
  RegisterEnumType_ITOGO(result);
  RegisterSubrangeType_SubType_1000145(result);
  RegisterSubrangeType_SubType_1000152(result);
  RegisterArrayType_ARLIM(result);
  RegisterVariable__Connection(result);
  RegisterVariable__PLAN(result);
  RegisterVariable__PLANK(result);
  RegisterVariable__PULT(result);
  RegisterVariable__MEASURE(result);
  RegisterVariable__PRINT(result);
  RegisterSubrangeType_SubType_1000168(result);
  RegisterArrayType_ArrayType_1000164(result);
  RegisterVariable__RES_ADC(result);
  RegisterVariable__ResultUnit(result);
  RegisterVariable__sign(result);
  RegisterVariable__TESTNAM(result);
  RegisterVariable__TESTUN(result);
  RegisterVariable__TESTNO(result);
  RegisterVariable__TOTALBRAK(result);
  RegisterVariable__brakgroup(result);
  RegisterVariable__GRIEF(result);
  RegisterVariable__SKIP(result);
  RegisterSubrangeType_SubType_1000184(result);
  RegisterSetType_SetType_1000182(result);
  RegisterVariable__ostanov(result);
  RegisterVariable__DOWNLIMIT(result);
  RegisterVariable__UPLIMIT(result);
  RegisterVariable__lastgrp(result);
  RegisterVariable__curgrp(result);
  RegisterVariable__maxgrp(result);
  RegisterVariable__maxtst(result);
  RegisterSubrangeType_SubType_1000198(result);
  RegisterArrayType_ArrayType_1000194(result);
//  RegisterVariable__pnno(result);
  RegisterSubrangeType_SubType_1000207(result);
  RegisterArrayType_ArrayType_1000203(result);
  RegisterVariable__tsun(result);
  RegisterSubrangeType_SubType_1000216(result);
  RegisterArrayType_ArrayType_1000212(result);
  RegisterVariable__tsnam(result);
  RegisterSubrangeType_SubType_1000225(result);
  RegisterArrayType_ArrayType_1000221(result);
  RegisterVariable__grpmsg(result);
  RegisterVariable__lim(result);
  RegisterSubrangeType_SubType_1000235(result);
  RegisterArrayType_ArrayType_1000231(result);
  RegisterVariable__limx(result);
  RegisterVariable__smenagr(result);
  RegisterVariable__endpr(result);
end;

function Register_TESTER_INEJ_GLOBAL: Integer;
begin
  result := RegisterNamespace(0, 'GLOBAL');
  Part1(result);
  UnregisterUsingNamespaces;
end;

end.
