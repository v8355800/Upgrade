//****************************************************************************
// Unit Name: TESTER_INEJ_GLOBAL
//****************************************************************************

unit IMP_TESTER_INEJ_GLOBAL;

interface

uses
  PaxCompiler;

function Register_TESTER_INEJ_GLOBAL(compiler: TPaxCompiler): Integer;

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


function RegisterConstant__maxgroup(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterConstant(H, 'maxgroup', maxgroup);
end;


function RegisterConstant__maxtest(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterConstant(H, 'maxtest', maxtest);
end;


function RegisterEnumType_Parameter(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Parameter');
  compiler.RegisterEnumValue(result, 'Ice', 0);
  compiler.RegisterEnumValue(result, 'Icbo', 1);
  compiler.RegisterEnumValue(result, 'Iebo', 2);
  compiler.RegisterEnumValue(result, 'h21e', 3);
  compiler.RegisterEnumValue(result, 'Ucesat', 4);
  compiler.RegisterEnumValue(result, 'Ubesat', 5);
  compiler.RegisterEnumValue(result, 'Uceo', 6);
  compiler.RegisterEnumValue(result, 'Uin', 7);
  compiler.RegisterEnumValue(result, 'h21', 8);
end;


function RegisterEnumType_Conductivity(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Conductivity');
  compiler.RegisterEnumValue(result, 'npn', 0);
  compiler.RegisterEnumValue(result, 'pnp', 1);
end;


function RegisterEnumType_Plug(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Plug');
  compiler.RegisterEnumValue(result, 'normal', 0);
  compiler.RegisterEnumValue(result, 'inverse', 1);
end;


function RegisterEnumType_Rbe(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Rbe');
  compiler.RegisterEnumValue(result, 'r0', 0);
  compiler.RegisterEnumValue(result, 'r1', 1);
  compiler.RegisterEnumValue(result, 'r2', 2);
  compiler.RegisterEnumValue(result, 'r3', 3);
  compiler.RegisterEnumValue(result, 'r4', 4);
  compiler.RegisterEnumValue(result, 'r5', 5);
  compiler.RegisterEnumValue(result, 'r6', 6);
  compiler.RegisterEnumValue(result, 'r7', 7);
end;


function RegisterEnumType_Range(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Range');
  compiler.RegisterEnumValue(result, 'D0', 0);
  compiler.RegisterEnumValue(result, 'D1', 1);
  compiler.RegisterEnumValue(result, 'D10', 2);
  compiler.RegisterEnumValue(result, 'D100', 3);
  compiler.RegisterEnumValue(result, 'D500', 4);
end;


function RegisterEnumType_Units(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Units');
  compiler.RegisterEnumValue(result, 'no', 0);
  compiler.RegisterEnumValue(result, 'nA', 1);
  compiler.RegisterEnumValue(result, 'uA', 2);
  compiler.RegisterEnumValue(result, 'mA', 3);
  compiler.RegisterEnumValue(result, 'mA9', 4);
  compiler.RegisterEnumValue(result, 'mA10', 5);
  compiler.RegisterEnumValue(result, 'A', 6);
  compiler.RegisterEnumValue(result, 'mV', 7);
  compiler.RegisterEnumValue(result, 'V', 8);
  compiler.RegisterEnumValue(result, 'V8', 9);
  compiler.RegisterEnumValue(result, 'mS', 10);
  compiler.RegisterEnumValue(result, 'S', 11);
  compiler.RegisterEnumValue(result, 'x3', 12);
  compiler.RegisterEnumValue(result, 'x4', 13);
  compiler.RegisterEnumValue(result, 'x5', 14);
  compiler.RegisterEnumValue(result, 'x6', 15);
  compiler.RegisterEnumValue(result, 'x7', 16);
  compiler.RegisterEnumValue(result, 'x8', 17);
  compiler.RegisterEnumValue(result, 'x9', 18);
  compiler.RegisterEnumValue(result, 'x10', 19);
  compiler.RegisterEnumValue(result, 'x11', 20);
end;


function RegisterEnumType_Jumps(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'Jumps');
  compiler.RegisterEnumValue(result, 'none', 0);
  compiler.RegisterEnumValue(result, 'Osc', 1);
  compiler.RegisterEnumValue(result, 'Grt', 2);
  compiler.RegisterEnumValue(result, 'Lwr', 3);
  compiler.RegisterEnumValue(result, 'Over', 4);
end;


function RegisterSubrangeType_relay(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'relay =  1 .. 32;');
end;


function RegisterSetType_relays(H: Integer; compiler: TPaxCompiler): Integer;
var T: Integer;
begin
  T := compiler.LookupTypeId('relay');
  result := compiler.RegisterSetType(H, 'relays', T);
end;


function RegisterEnumType_ITOGO(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterEnumType(H, 'ITOGO');
  compiler.RegisterEnumValue(result, 'PASS', 0);
  compiler.RegisterEnumValue(result, 'FAIL', 1);
end;


function RegisterSubrangeType_SubType_1000145(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000145 = 1 .. maxtest;');
end;


function RegisterSubrangeType_SubType_1000152(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000152 =  1 .. 2;');
end;


function RegisterArrayType_ARLIM(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 2;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000145 = 1 .. maxtest;');
  R[1] := compiler.RegisterTypeDeclaration(H, 'SubType_1000152 =  1 .. 2;');
  ElemTypeId := compiler.LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ARLIM', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__Connection(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('Plug');
  result := compiler.RegisterVariable(H, 'Connection', T, @ Connection);
end;


function RegisterVariable__PLAN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PLAN', T, @ PLAN);
end;


function RegisterVariable__PLANK(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PLANK', T, @ PLANK);
end;


function RegisterVariable__PULT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBYTE;
  result := compiler.RegisterVariable(H, 'PULT', T, @ PULT);
end;


function RegisterVariable__MEASURE(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'MEASURE', T, @ MEASURE);
end;


function RegisterVariable__PRINT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'PRINT', T, @ PRINT);
end;


function RegisterSubrangeType_SubType_1000168(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000168 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000164(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000168 = 1 .. maxtest;');
  ElemTypeId := compiler.LookupTypeId('Real');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000164', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__RES_ADC(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000164');
  result := compiler.RegisterVariable(H, 'RES_ADC', T, @ RES_ADC);
end;


function RegisterVariable__ResultUnit(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeUNICSTRING;
  result := compiler.RegisterVariable(H, 'ResultUnit', T, @ ResultUnit);
end;


function RegisterVariable__sign(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('Jumps');
  result := compiler.RegisterVariable(H, 'sign', T, @ sign);
end;


function RegisterVariable__TESTNAM(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeUNICSTRING;
  result := compiler.RegisterVariable(H, 'TESTNAM', T, @ TESTNAM);
end;


function RegisterVariable__TESTUN(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeUNICSTRING;
  result := compiler.RegisterVariable(H, 'TESTUN', T, @ TESTUN);
end;


function RegisterVariable__TESTNO(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'TESTNO', T, @ TESTNO);
end;


function RegisterVariable__TOTALBRAK(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'TOTALBRAK', T, @ TOTALBRAK);
end;


function RegisterVariable__brakgroup(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'brakgroup', T, @ brakgroup);
end;


function RegisterVariable__GRIEF(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'GRIEF', T, @ GRIEF);
end;


function RegisterVariable__SKIP(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'SKIP', T, @ SKIP);
end;


function RegisterSubrangeType_SubType_1000184(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000184 =  set of 1 .. maxtest;');
end;


function RegisterSetType_SetType_1000182(H: Integer; compiler: TPaxCompiler): Integer;
var T: Integer;
begin
  T := compiler.LookupTypeId('SubType_1000184');
  result := compiler.RegisterSetType(H, 'SetType_1000182', T);
end;


function RegisterVariable__ostanov(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('SetType_1000182');
  result := compiler.RegisterVariable(H, 'ostanov', T, @ ostanov);
end;


function RegisterVariable__DOWNLIMIT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('Real');
  result := compiler.RegisterVariable(H, 'DOWNLIMIT', T, @ DOWNLIMIT);
end;


function RegisterVariable__UPLIMIT(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('Real');
  result := compiler.RegisterVariable(H, 'UPLIMIT', T, @ UPLIMIT);
end;


function RegisterVariable__lastgrp(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeINTEGER;
  result := compiler.RegisterVariable(H, 'lastgrp', T, @ lastgrp);
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


function RegisterSubrangeType_SubType_1000198(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000198 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000194(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000198 = 1 .. maxtest;');
  ElemTypeId := _typeINTEGER;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000194', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


//function RegisterVariable__pnno(H: Integer; compiler: TPaxCompiler): Integer;
//var
//  T: Integer;
//begin
//  T := compiler.LookupTypeId('ArrayType_1000194');
//  result := compiler.RegisterVariable(H, 'pnno', T, @ pnno);
//end;


function RegisterSubrangeType_SubType_1000207(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000207 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000203(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000207 = 1 .. maxtest;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000203', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsun(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000203');
  result := compiler.RegisterVariable(H, 'tsun', T, @ tsun);
end;


function RegisterSubrangeType_SubType_1000216(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000216 = 1 .. maxtest;');
end;


function RegisterArrayType_ArrayType_1000212(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000216 = 1 .. maxtest;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000212', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__tsnam(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000212');
  result := compiler.RegisterVariable(H, 'tsnam', T, @ tsnam);
end;


function RegisterSubrangeType_SubType_1000225(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000225 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000221(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000225 = 1 .. maxgroup;');
  ElemTypeId := _typeUNICSTRING;
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000221', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__grpmsg(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000221');
  result := compiler.RegisterVariable(H, 'grpmsg', T, @ grpmsg);
end;


function RegisterVariable__lim(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ARLIM');
  result := compiler.RegisterVariable(H, 'lim', T, @ lim);
end;


function RegisterSubrangeType_SubType_1000235(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000235 = 1 .. maxgroup;');
end;


function RegisterArrayType_ArrayType_1000231(H: Integer; compiler: TPaxCompiler): Integer;
var
  I, ElemTypeId, RangeTypeId, K: Integer;
  R: array of Integer;
begin
  result := 0;
  K := 1;
  SetLength(R, K);
  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000235 = 1 .. maxgroup;');
  ElemTypeId := compiler.LookupTypeId('ARLIM');
  for I := 0 to K - 1 do
  begin
    RangeTypeId := R[K - I - 1];
    result := compiler.RegisterArrayType(H, 'ArrayType_1000231', RangeTypeId, ElemTypeId, true);
    ElemTypeId := result;
  end;
end;


function RegisterVariable__limx(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('ArrayType_1000231');
  result := compiler.RegisterVariable(H, 'limx', T, @ limx);
end;


function RegisterVariable__smenagr(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'smenagr', T, @ smenagr);
end;


function RegisterVariable__endpr(H: Integer; compiler: TPaxCompiler): Integer;
var
  T: Integer;
begin
  T := _typeBOOLEAN;
  result := compiler.RegisterVariable(H, 'endpr', T, @ endpr);
end;


procedure Part1(result: Integer; compiler: TPaxCompiler);
begin
  RegisterConstant__maxgroup(result, compiler);
  RegisterConstant__maxtest(result, compiler);
  RegisterEnumType_Parameter(result, compiler);
  RegisterEnumType_Conductivity(result, compiler);
  RegisterEnumType_Plug(result, compiler);
  RegisterEnumType_Rbe(result, compiler);
  RegisterEnumType_Range(result, compiler);
  RegisterEnumType_Units(result, compiler);
  RegisterEnumType_Jumps(result, compiler);
  RegisterSubrangeType_relay(result, compiler);
  RegisterSetType_relays(result, compiler);
  RegisterEnumType_ITOGO(result, compiler);
  RegisterSubrangeType_SubType_1000145(result, compiler);
  RegisterSubrangeType_SubType_1000152(result, compiler);
  RegisterArrayType_ARLIM(result, compiler);
  RegisterVariable__Connection(result, compiler);
  RegisterVariable__PLAN(result, compiler);
  RegisterVariable__PLANK(result, compiler);
  RegisterVariable__PULT(result, compiler);
  RegisterVariable__MEASURE(result, compiler);
  RegisterVariable__PRINT(result, compiler);
  RegisterSubrangeType_SubType_1000168(result, compiler);
  RegisterArrayType_ArrayType_1000164(result, compiler);
  RegisterVariable__RES_ADC(result, compiler);
  RegisterVariable__ResultUnit(result, compiler);
  RegisterVariable__sign(result, compiler);
  RegisterVariable__TESTNAM(result, compiler);
  RegisterVariable__TESTUN(result, compiler);
  RegisterVariable__TESTNO(result, compiler);
  RegisterVariable__TOTALBRAK(result, compiler);
  RegisterVariable__brakgroup(result, compiler);
  RegisterVariable__GRIEF(result, compiler);
  RegisterVariable__SKIP(result, compiler);
  RegisterSubrangeType_SubType_1000184(result, compiler);
  RegisterSetType_SetType_1000182(result, compiler);
  RegisterVariable__ostanov(result, compiler);
  RegisterVariable__DOWNLIMIT(result, compiler);
  RegisterVariable__UPLIMIT(result, compiler);
  RegisterVariable__lastgrp(result, compiler);
  RegisterVariable__curgrp(result, compiler);
  RegisterVariable__maxgrp(result, compiler);
  RegisterVariable__maxtst(result, compiler);
  RegisterSubrangeType_SubType_1000198(result, compiler);
  RegisterArrayType_ArrayType_1000194(result, compiler);
//  RegisterVariable__pnno(result, compiler);
  RegisterSubrangeType_SubType_1000207(result, compiler);
  RegisterArrayType_ArrayType_1000203(result, compiler);
  RegisterVariable__tsun(result, compiler);
  RegisterSubrangeType_SubType_1000216(result, compiler);
  RegisterArrayType_ArrayType_1000212(result, compiler);
  RegisterVariable__tsnam(result, compiler);
  RegisterSubrangeType_SubType_1000225(result, compiler);
  RegisterArrayType_ArrayType_1000221(result, compiler);
  RegisterVariable__grpmsg(result, compiler);
  RegisterVariable__lim(result, compiler);
  RegisterSubrangeType_SubType_1000235(result, compiler);
  RegisterArrayType_ArrayType_1000231(result, compiler);
  RegisterVariable__limx(result, compiler);
  RegisterVariable__smenagr(result, compiler);
  RegisterVariable__endpr(result, compiler);
end;

function Register_TESTER_INEJ_GLOBAL(compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterNamespace(0, 'INEJ_GLOBAL');
  Part1(result, compiler);
  compiler.UnregisterUsingNamespaces;
end;

end.
