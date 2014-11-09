//****************************************************************************
// Unit Name: TESTER_ISTINA
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

unit IMP_TESTER_ISTINA;
interface

//uses
//  TESTER_ISTINA;

function Register_TESTER_ISTINA(P: Pointer): Integer;


implementation

uses
  PAXCOMP_STDLIB,
  PaxRegister,
  System.Classes,
  TESTER_BASE,
  TESTER_ISTINA,
  TESTER_ISTINA_IO,
  TESTER_ISTINA_GLOBAL;


type
  TDummyClass = class
    procedure P; virtual; abstract;
  end;

function GetAbstractMethodAddress: Pointer;
begin
  result := PPointer(TDummyClass)^;
end;

function R_TIstina_Perv(Self: TIstina):BYTE;
begin
  result := Self.Perv;
end;


procedure W_TIstina_Perv(Self: TIstina; const value: BYTE);
begin
  Self.Perv := value;
end;

procedure RegisterProperty_TIstina_Perv(H: Integer);
var TypeId, ReadId, WriteId: Integer;
begin
  TypeId := _typeBYTE;
  ReadId := RegisterFakeHeader(H,
  'function R_TIstina_Perv():BYTE;',
   @ R_TIstina_Perv);
  WriteId := RegisterFakeHeader(H,
  'procedure W_TIstina_Perv(const value: BYTE);',
   @ W_TIstina_Perv);
  RegisterProperty(H, 'Perv', TypeId, ReadId, WriteId, false);
end;

procedure RegisterRecordField_TIstinaResult_TestNo(H: Integer);
var T: Integer;
begin
  T := _typeCARDINAL;
  RegisterRecordTypeField(H, 'TestNo', T);
end;


procedure RegisterRecordField_TIstinaResult_TestName(H: Integer);
var T: Integer;
begin
  T := _typeUNICSTRING;
  RegisterRecordTypeField(H, 'TestName', T);
end;


procedure RegisterRecordField_TIstinaResult_PinNo(H: Integer);
var T: Integer;
begin
  T := _typeBYTE;
  RegisterRecordTypeField(H, 'PinNo', T);
end;


procedure RegisterRecordField_TIstinaResult_LNorm(H: Integer);
var T: Integer;
begin
  T := _typeDOUBLE;
  RegisterRecordTypeField(H, 'LNorm', T);
end;


procedure RegisterRecordField_TIstinaResult_HNorm(H: Integer);
var T: Integer;
begin
  T := _typeDOUBLE;
  RegisterRecordTypeField(H, 'HNorm', T);
end;


procedure RegisterRecordField_TIstinaResult_Val(H: Integer);
var T: Integer;
begin
  T := _typeDOUBLE;
  RegisterRecordTypeField(H, 'Val', T);
end;


procedure RegisterRecordField_TIstinaResult_Units(H: Integer);
var T: Integer;
begin
  T := _typeUNICSTRING;
  RegisterRecordTypeField(H, 'Units', T);
end;


// constructor Create(AOwner: TComponent); override;
function RegisterConstructor_TIstina_Create(H: Integer): Integer;
begin
  result := RegisterConstructor(H, 'Create'
    , @ TIstina.Create // address
    , _ccREGISTER // call convention
    , false // class method
    , _cmOVERRIDE
    , 0
    );
  RegisterParameter(result, 'AOwner', 'TComponent', _parVAL);
end;


// destructor Destroy; override;
function RegisterDestructor_TIstina_Destroy(H: Integer): Integer;
begin
  result := RegisterDestructor(H, 'Destroy'
  , @ TIstina.Destroy // address
    );
end;


// procedure DoMeasureResult(Defect: Boolean; MResult: TIstinaResult);
function RegisterMethodProcedure_TIstina_DoMeasureResult(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'DoMeasureResult'
    , _typeVOID // result type
    , @ TIstina.DoMeasureResult // address
    );
  RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
  RegisterParameter(result, 'MResult', 'TIstinaResult', _parVAL);
end;


// procedure ResetTester; override;
function RegisterMethodProcedure_TIstina_ResetTester(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ResetTester'
    , _typeVOID // result type
    , @ TIstina.ResetTester // address
    , _ccREGISTER // call convention
    , false // class method
    , _cmOVERRIDE
    , 0
    );
end;


// procedure Measure(ResetOnEnd: Boolean = True); override;
function RegisterMethodProcedure_TIstina_Measure(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'Measure'
    , _typeVOID // result type
    , @ TIstina.Measure // address
    , _ccREGISTER // call convention
    , false // class method
    , _cmOVERRIDE
    , 0
    );
  RegisterParameter(result, 'ResetOnEnd', _typeBOOLEAN, _parVAL, true, 'True');
end;


//function RegisterSubrangeType_SubType_1000108(H: Integer): Integer;
//begin
//  result := RegisterTypeDeclaration(H, 'SubType_1000108 = 1 .. maxtest;');
//end;
//
//
//function RegisterArrayType_ArrayType_1000104(H: Integer): Integer;
//var
//  I, ElemTypeId, RangeTypeId, K: Integer;
//  R: array of Integer;
//begin
//  result := 0;
//  K := 1;
//  SetLength(R, K);
//  R[0] := RegisterTypeDeclaration(H, 'SubType_1000108 = 1 .. maxtest;');
//  ElemTypeId := LookupTypeId('Real');
//  for I := 0 to K - 1 do
//  begin
//    RangeTypeId := R[K - I - 1];
//    result := RegisterArrayType(H, 'ArrayType_1000104', RangeTypeId, ElemTypeId, true);
//    ElemTypeId := result;
//  end;
//end;


// function ADC(M: PINS; RNG: REAL; UN: EDIZM): REAL;
function RegisterMethodFunction_TIstina_ADC(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ADC'
    , 'Real' // result type
    , @ TIstina.ADC // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'RNG', 'Real', _parVAL);
  RegisterParameter(result, 'UN', 'EDIZM', _parVAL);
end;


// function LESS(M: PINS; DOWN: REAL; E: EDIZM): BOOLEAN;
function RegisterMethodFunction_TIstina_LESS(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'LESS'
    , _typeBOOLEAN // result type
    , @ TIstina.LESS // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'DOWN', 'Real', _parVAL);
  RegisterParameter(result, 'E', 'EDIZM', _parVAL);
end;


// function MORE(M: PINS; UP: REAL; E: EDIZM): BOOLEAN;
function RegisterMethodFunction_TIstina_MORE(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'MORE'
    , _typeBOOLEAN // result type
    , @ TIstina.MORE // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'UP', 'Real', _parVAL);
  RegisterParameter(result, 'E', 'EDIZM', _parVAL);
end;


// function OUTSIDE(M: PINS; DOWN, UP: REAL; E: EDIZM): BOOLEAN;
function RegisterMethodFunction_TIstina_OUTSIDE(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'OUTSIDE'
    , _typeBOOLEAN // result type
    , @ TIstina.OUTSIDE // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'DOWN', 'Real', _parVAL);
  RegisterParameter(result, 'UP', 'Real', _parVAL);
  RegisterParameter(result, 'E', 'EDIZM', _parVAL);
end;


// function RESVOLT(I: INTEGER; D: SCALE): REAL;
function RegisterMethodFunction_TIstina_RESVOLT(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'RESVOLT'
    , 'Real' // result type
    , @ TIstina.RESVOLT // address
    );
  RegisterParameter(result, 'I', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'D', 'SCALE', _parVAL);
end;


// procedure compare;
function RegisterMethodProcedure_TIstina_compare(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'compare'
    , _typeVOID // result type
    , @ TIstina.compare // address
    );
end;


// procedure DELAYCOMM(OPT: SELECTOR);
function RegisterMethodProcedure_TIstina_DELAYCOMM(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'DELAYCOMM'
    , _typeVOID // result type
    , @ TIstina.DELAYCOMM // address
    );
  RegisterParameter(result, 'OPT', 'SELECTOR', _parVAL);
end;


// procedure DELAYMEAS(M: PINS; TON, TOFF: REAL; UN: EDIZM);
function RegisterMethodProcedure_TIstina_DELAYMEAS(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'DELAYMEAS'
    , _typeVOID // result type
    , @ TIstina.DELAYMEAS // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'TON', 'Real', _parVAL);
  RegisterParameter(result, 'TOFF', 'Real', _parVAL);
  RegisterParameter(result, 'UN', 'EDIZM', _parVAL);
end;


// procedure DYNLOAD(M: PINS);
function RegisterMethodProcedure_TIstina_DYNLOAD(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'DYNLOAD'
    , _typeVOID // result type
    , @ TIstina.DYNLOAD // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure ENDPROGRAM;
function RegisterMethodProcedure_TIstina_ENDPROGRAM(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ENDPROGRAM'
    , _typeVOID // result type
    , @ TIstina.ENDPROGRAM // address
    );
end;


// procedure ENDTEST;
function RegisterMethodProcedure_TIstina_ENDTEST(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ENDTEST'
    , _typeVOID // result type
    , @ TIstina.ENDTEST // address
    );
end;


// procedure GROUP(G: INTEGER; E: ITOGO);
function RegisterMethodProcedure_TIstina_GROUP(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'GROUP'
    , _typeVOID // result type
    , @ TIstina.GROUP // address
    );
  RegisterParameter(result, 'G', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'E', 'ITOGO', _parVAL);
end;


// procedure LOAD(M: PINS);
function RegisterMethodProcedure_TIstina_LOAD(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'LOAD'
    , _typeVOID // result type
    , @ TIstina.LOAD // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure normlim(M, NUM: INTEGER; r: REAL);
function RegisterMethodProcedure_TIstina_normlim(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'normlim'
    , _typeVOID // result type
    , @ TIstina.normlim // address
    );
  RegisterParameter(result, 'M', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'NUM', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'r', 'Real', _parVAL);
end;


// procedure normlimZ(M, NUM: INTEGER; r: REAL);
function RegisterMethodProcedure_TIstina_normlimZ(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'normlimZ'
    , _typeVOID // result type
    , @ TIstina.normlimZ // address
    );
  RegisterParameter(result, 'M', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'NUM', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'r', 'Real', _parVAL);
end;


// procedure PINOFF(M: PINS);
function RegisterMethodProcedure_TIstina_PINOFF(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'PINOFF'
    , _typeVOID // result type
    , @ TIstina.PINOFF // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure PROGRAMMA;
function RegisterMethodProcedure_TIstina_PROGRAMMA(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'PROGRAMMA'
    , _typeVOID // result type
    , @ TIstina.PROGRAMMA // address
    );
end;


// procedure SETCOMPS(M: PINS; LOWC, HIGHC: REAL; UN: EDIZM);
function RegisterMethodProcedure_TIstina_SETCOMPS(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'SETCOMPS'
    , _typeVOID // result type
    , @ TIstina.SETCOMPS // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'LOWC', 'Real', _parVAL);
  RegisterParameter(result, 'HIGHC', 'Real', _parVAL);
  RegisterParameter(result, 'UN', 'EDIZM', _parVAL);
end;


// procedure SMALL(OPT: SELECTOR);
function RegisterMethodProcedure_TIstina_SMALL(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'SMALL'
    , _typeVOID // result type
    , @ TIstina.SMALL // address
    );
  RegisterParameter(result, 'OPT', 'SELECTOR', _parVAL);
end;


// procedure SOURCE(M: PINS; FRC: REAL; UF: EDIZM; CLMP: REAL; UC: EDIZM);
function RegisterMethodProcedure_TIstina_SOURCE(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'SOURCE'
    , _typeVOID // result type
    , @ TIstina.SOURCE // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
  RegisterParameter(result, 'FRC', 'Real', _parVAL);
  RegisterParameter(result, 'UF', 'EDIZM', _parVAL);
  RegisterParameter(result, 'CLMP', 'Real', _parVAL);
  RegisterParameter(result, 'UC', 'EDIZM', _parVAL);
end;


// procedure START(M: PINS);
function RegisterMethodProcedure_TIstina_START(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'START'
    , _typeVOID // result type
    , @ TIstina.START // address
    );
  RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure TEST(N: INTEGER; NAME, UNITS: IMYA);
function RegisterMethodProcedure_TIstina_TEST(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'TEST'
    , _typeVOID // result type
    , @ TIstina.TEST // address
    );
  RegisterParameter(result, 'N', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'NAME', 'IMYA', _parVAL);
  RegisterParameter(result, 'UNITS', 'IMYA', _parVAL);
end;


// procedure TestInc;
function RegisterMethodProcedure_TIstina_TestInc(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'TestInc'
    , _typeVOID // result type
    , @ TIstina.TestInc // address
    );
end;


// procedure TESTLEN(LEN: REAL; UNITS: EDIZM);
function RegisterMethodProcedure_TIstina_TESTLEN(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'TESTLEN'
    , _typeVOID // result type
    , @ TIstina.TESTLEN // address
    );
  RegisterParameter(result, 'LEN', 'Real', _parVAL);
  RegisterParameter(result, 'UNITS', 'EDIZM', _parVAL);
end;


// procedure TestNo(No: INTEGER);
function RegisterMethodProcedure_TIstina_TestNo(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'TestNo'
    , _typeVOID // result type
    , @ TIstina.TestNo // address
    );
  RegisterParameter(result, 'No', _typeINTEGER, _parVAL);
end;


// procedure SetCondition(TestN: Integer; Condition: Integer);
function RegisterMethodProcedure_TIstina_SetCondition(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'SetCondition'
    , _typeVOID // result type
    , @ TIstina.SetCondition // address
    );
  RegisterParameter(result, 'TestN', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'Condition', _typeINTEGER, _parVAL);
end;


// procedure ClearCondition(TestN: Integer; Condition: Integer);
function RegisterMethodProcedure_TIstina_ClearCondition(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ClearCondition'
    , _typeVOID // result type
    , @ TIstina.ClearCondition // address
    );
  RegisterParameter(result, 'TestN', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'Condition', _typeINTEGER, _parVAL);
end;


// procedure ClearConditions;
function RegisterMethodProcedure_TIstina_ClearConditions(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ClearConditions'
    , _typeVOID // result type
    , @ TIstina.ClearConditions // address
    );
end;


function RegisterRecordType_TIstinaResult(H: Integer): Integer;
begin
  result := RegisterRecordType(H, 'TIstinaResult');
  RegisterRecordField_TIstinaResult_TestNo(result);
  RegisterRecordField_TIstinaResult_TestName(result);
  RegisterRecordField_TIstinaResult_PinNo(result);
  RegisterRecordField_TIstinaResult_LNorm(result);
  RegisterRecordField_TIstinaResult_HNorm(result);
  RegisterRecordField_TIstinaResult_Val(result);
  RegisterRecordField_TIstinaResult_Units(result);
end;


// procedure(Sender: TObject; Defect: Boolean; MResult: TIstinaResult)
function RegisterProcedure_DummyProc_TOnMeasureResulTIstinaEvent(H: Integer): Integer;
begin
  result := RegisterRoutine(H, 'DummyProc_TOnMeasureResulTIstinaEvent'
    , _typeVOID // result type
    , nil // address
    );
  RegisterParameter(result, 'Sender', 'TObject', _parVAL);
  RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
  RegisterParameter(result, 'MResult', 'TIstinaResult', _parVAL);
end;


function RegisterEventType_TOnMeasureResulTIstinaEvent(H: Integer): Integer;
begin
  result := RegisterProcedure_DummyProc_TOnMeasureResulTIstinaEvent(H);
  result := RegisterEventType(H, 'TOnMeasureResulTIstinaEvent', result);
end;


//function RegisterSubrangeType_SubType_1000035(H: Integer): Integer;
//begin
//  result := RegisterTypeDeclaration(H, 'SubType_1000035 = 1..MAXPOINT;');
//end;


//function RegisterArrayType_TConditions(H: Integer): Integer;
//var
//  I, ElemTypeId, RangeTypeId, K: Integer;
//  R: array of Integer;
//begin
//  result := 0;
//  K := 1;
//  SetLength(R, K);
//  R[0] := RegisterTypeDeclaration(H, 'SubType_1000035 = 1..MAXPOINT;');
//  ElemTypeId := _typeINTEGER;
//  for I := 0 to K - 1 do
//  begin
//    RangeTypeId := R[K - I - 1];
//    result := RegisterArrayType(H, 'TConditions', RangeTypeId, ElemTypeId, true);
//    ElemTypeId := result;
//  end;
//end;


function RegisterClassType_TIstina(H: Integer): Integer;
begin
  result := RegisterClassType(H, TIstina);
  RegisterConstructor_TIstina_Create(result);
  RegisterDestructor_TIstina_Destroy(result);
  RegisterMethodProcedure_TIstina_DoMeasureResult(result);
  RegisterMethodProcedure_TIstina_ResetTester(result);
  RegisterMethodProcedure_TIstina_Measure(result);
//  RegisterSubrangeType_SubType_1000108(result);
//  RegisterArrayType_ArrayType_1000104(result);
  RegisterMethodFunction_TIstina_ADC(result);
  RegisterMethodFunction_TIstina_LESS(result);
  RegisterMethodFunction_TIstina_MORE(result);
  RegisterMethodFunction_TIstina_OUTSIDE(result);
  RegisterMethodFunction_TIstina_RESVOLT(result);
  RegisterMethodProcedure_TIstina_compare(result);
  RegisterMethodProcedure_TIstina_DELAYCOMM(result);
  RegisterMethodProcedure_TIstina_DELAYMEAS(result);
  RegisterMethodProcedure_TIstina_DYNLOAD(result);
  RegisterMethodProcedure_TIstina_ENDPROGRAM(result);
  RegisterMethodProcedure_TIstina_ENDTEST(result);
  RegisterMethodProcedure_TIstina_GROUP(result);
  RegisterMethodProcedure_TIstina_LOAD(result);
  RegisterMethodProcedure_TIstina_normlim(result);
  RegisterMethodProcedure_TIstina_normlimZ(result);
  RegisterMethodProcedure_TIstina_PINOFF(result);
  RegisterMethodProcedure_TIstina_PROGRAMMA(result);
  RegisterMethodProcedure_TIstina_SETCOMPS(result);
  RegisterMethodProcedure_TIstina_SMALL(result);
  RegisterMethodProcedure_TIstina_SOURCE(result);
  RegisterMethodProcedure_TIstina_START(result);
  RegisterMethodProcedure_TIstina_TEST(result);
  RegisterMethodProcedure_TIstina_TestInc(result);
  RegisterMethodProcedure_TIstina_TESTLEN(result);
  RegisterMethodProcedure_TIstina_TestNo(result);
  RegisterMethodProcedure_TIstina_SetCondition(result);
  RegisterMethodProcedure_TIstina_ClearCondition(result);
  RegisterMethodProcedure_TIstina_ClearConditions(result);
  RegisterProperty_TIstina_Perv(result);
end;


function RegisterVariable__Tester(P: Pointer; H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('TIstina');
//  result := RegisterVariable(H, 'Tester', TL, @ T);
  result := RegisterVariable(H, 'Tester', T, P);
//  result := RegisterVariable(H, 'Tester', TL, @Tester);
end;


procedure Part1(P:Pointer; result: Integer);
begin
//  RegisterRecordType_TIstinaResult(result);
//  RegisterEventType_TOnMeasureResulTIstinaEvent(result);
//  RegisterSubrangeType_SubType_1000035(result);
//  RegisterArrayType_TConditions(result);
  RegisterClassType_TIstina(result);
  RegisterVariable__Tester(P, result);
end;

function Register_TESTER_ISTINA(P:Pointer): Integer;
begin
  result := RegisterNamespace(0, 'ISTINA');
  RegisterUsingNamespace('System.Classes');
  RegisterUsingNamespace('TESTER_BASE');
  RegisterUsingNamespace('TESTER_ISTINA_IO');
  RegisterUsingNamespace('TESTER_ISTINA_GLOBAL');
  Part1(P, result);
  UnregisterUsingNamespaces;
end;

end.
