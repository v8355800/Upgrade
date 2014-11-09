//****************************************************************************
// Unit Name: TESTER_INEJ
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

unit IMP_TESTER_INEJ;
interface

//uses
//  TESTER_INEJ;


function Register_TESTER_INEJ(P: Pointer): Integer;


implementation


uses
  PAXCOMP_STDLIB,
  PaxRegister,
  System.Classes,
  TESTER_BASE,
  TESTER_INEJ,
  TESTER_INEJ_IO,
  TESTER_INEJ_GLOBAL;


type
  TDummyClass = class
    procedure P; virtual; abstract;
  end;

function GetAbstractMethodAddress: Pointer;
begin
  result := PPointer(TDummyClass)^;
end;


type
  fake_TInej = class(TInej);

procedure RegisterRecordField_TInejResult_TestNo(H: Integer);
var T: Integer;
begin
  T := _typeCARDINAL;
  RegisterRecordTypeField(H, 'TestNo', T);
end;


procedure RegisterRecordField_TInejResult_TestName(H: Integer);
var T: Integer;
begin
  T := _typeUNICSTRING;
  RegisterRecordTypeField(H, 'TestName', T);
end;


procedure RegisterRecordField_TInejResult_LNorm(H: Integer);
var T: Integer;
begin
  T := _typeDOUBLE;
  RegisterRecordTypeField(H, 'LNorm', T);
end;


procedure RegisterRecordField_TInejResult_HNorm(H: Integer);
var T: Integer;
begin
  T := _typeDOUBLE;
  RegisterRecordTypeField(H, 'HNorm', T);
end;


procedure RegisterRecordField_TInejResult_Val(H: Integer);
var T: Integer;
begin
  T := _typeDOUBLE;
  RegisterRecordTypeField(H, 'Val', T);
end;


procedure RegisterRecordField_TInejResult_Units(H: Integer);
var T: Integer;
begin
  T := _typeUNICSTRING;
  RegisterRecordTypeField(H, 'Units', T);
end;


// constructor Create(AOwner: TComponent); override;
function RegisterConstructor_TInej_Create(H: Integer): Integer;
begin
  result := RegisterConstructor(H, 'Create'
    , @ TInej.Create // address
    , _ccREGISTER // call convention
    , false // class method
    , _cmOVERRIDE
    , 0
    );
  RegisterParameter(result, 'AOwner', 'TComponent', _parVAL);
end;


// destructor Destroy; override;
function RegisterDestructor_TInej_Destroy(H: Integer): Integer;
begin
  result := RegisterDestructor(H, 'Destroy'
  , @ TInej.Destroy // address
    );
end;


// procedure DoMeasureResult(Defect: Boolean; MResult: TInejResult);
function RegisterMethodProcedure_TInej_DoMeasureResult(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'DoMeasureResult'
    , _typeVOID // result type
    , @ TInej.DoMeasureResult // address
    );
  RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
  RegisterParameter(result, 'MResult', 'TInejResult', _parVAL);
end;


// procedure ResetTester; override;
function RegisterMethodProcedure_TInej_ResetTester(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ResetTester'
    , _typeVOID // result type
    , @ TInej.ResetTester // address
    , _ccREGISTER // call convention
    , false // class method
    , _cmOVERRIDE
    , 0
    );
end;


// procedure Measure(ResetOnEnd: Boolean = True); override;
function RegisterMethodProcedure_TInej_Measure(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'Measure'
    , _typeVOID // result type
    , @ TInej.Measure // address
    , _ccREGISTER // call convention
    , false // class method
    , _cmOVERRIDE
    , 0
    );
  RegisterParameter(result, 'ResetOnEnd', _typeBOOLEAN, _parVAL, true, 'True');
end;


// procedure ERRORI(ErrCode: INTEGER);
function RegisterMethodProcedure_TInej_ERRORI(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ERRORI'
    , _typeVOID // result type
    , @ fake_TInej.ERRORI // address
    );
  RegisterParameter(result, 'ErrCode', _typeINTEGER, _parVAL);
end;


// procedure PLANPULT;
function RegisterMethodProcedure_TInej_PLANPULT(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'PLANPULT'
    , _typeVOID // result type
    , @ fake_TInej.PLANPULT // address
    );
end;


// procedure GROUP(G: INTEGER; E: ITOGO);
function RegisterMethodProcedure_TInej_GROUP(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'GROUP'
    , _typeVOID // result type
    , @ fake_TInej.GROUP // address
    );
  RegisterParameter(result, 'G', _typeINTEGER, _parVAL);
  RegisterParameter(result, 'E', 'ITOGO', _parVAL);
end;


// procedure PROGRAMMA;
function RegisterMethodProcedure_TInej_PROGRAMMA(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'PROGRAMMA'
    , _typeVOID // result type
    , @ TInej.PROGRAMMA // address
    );
end;


// procedure TEST(NAME, UNITS: String{IMYA});
function RegisterMethodProcedure_TInej_TEST(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'TEST'
    , _typeVOID // result type
    , @ TInej.TEST // address
    );
  RegisterParameter(result, 'NAME', _typeUNICSTRING, _parVAL);
  RegisterParameter(result, 'UNITS', _typeUNICSTRING, _parVAL);
end;


// procedure TestInc;
function RegisterMethodProcedure_TInej_TestInc(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'TestInc'
    , _typeVOID // result type
    , @ TInej.TestInc // address
    );
end;


// procedure RELE(a: relays);
function RegisterMethodProcedure_TInej_RELE(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'RELE'
    , _typeVOID // result type
    , @ TInej.RELE // address
    );
  RegisterParameter(result, 'a', 'relays', _parVAL);
end;


// procedure INPDATA(p: parameter; c: conductivity; r: Rbe; D: Range; IA: Real;        unitA: UNITS; IB: Real; unitB: UNITS; U: Real; unitU: UNITS; Tm: word;        Ts: word);
function RegisterMethodProcedure_TInej_INPDATA(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'INPDATA'
    , _typeVOID // result type
    , @ TInej.INPDATA // address
    );
  RegisterParameter(result, 'p', 'parameter', _parVAL);
  RegisterParameter(result, 'c', 'conductivity', _parVAL);
  RegisterParameter(result, 'r', 'Rbe', _parVAL);
  RegisterParameter(result, 'D', 'Range', _parVAL);
  RegisterParameter(result, 'IA', 'Real', _parVAL);
  RegisterParameter(result, 'unitA', 'UNITS', _parVAL);
  RegisterParameter(result, 'IB', 'Real', _parVAL);
  RegisterParameter(result, 'unitB', 'UNITS', _parVAL);
  RegisterParameter(result, 'U', 'Real', _parVAL);
  RegisterParameter(result, 'unitU', 'UNITS', _parVAL);
  RegisterParameter(result, 'Tm', _typeWORD, _parVAL);
  RegisterParameter(result, 'Ts', _typeWORD, _parVAL);
end;


// function MORE(UP: Real): Boolean;
function RegisterMethodFunction_TInej_MORE(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'MORE'
    , _typeBOOLEAN // result type
    , @ TInej.MORE // address
    );
  RegisterParameter(result, 'UP', 'Real', _parVAL);
end;


// function LESS(DOWN: Real): Boolean;
function RegisterMethodFunction_TInej_LESS(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'LESS'
    , _typeBOOLEAN // result type
    , @ TInej.LESS // address
    );
  RegisterParameter(result, 'DOWN', 'Real', _parVAL);
end;


// function OUTSIDE(DOWN, UP: Real): Boolean;
function RegisterMethodFunction_TInej_OUTSIDE(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'OUTSIDE'
    , _typeBOOLEAN // result type
    , @ TInej.OUTSIDE // address
    );
  RegisterParameter(result, 'DOWN', 'Real', _parVAL);
  RegisterParameter(result, 'UP', 'Real', _parVAL);
end;


// procedure NORMLIM;
function RegisterMethodProcedure_TInej_NORMLIM(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'NORMLIM'
    , _typeVOID // result type
    , @ TInej.NORMLIM // address
    );
end;


// procedure ENDTEST;
function RegisterMethodProcedure_TInej_ENDTEST(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ENDTEST'
    , _typeVOID // result type
    , @ TInej.ENDTEST // address
    );
end;


// procedure ENDPROGRAM;
function RegisterMethodProcedure_TInej_ENDPROGRAM(H: Integer): Integer;
begin
  result := RegisterMethod(H, 'ENDPROGRAM'
    , _typeVOID // result type
    , @ TInej.ENDPROGRAM // address
    );
end;


function RegisterRecordType_TInejResult(H: Integer): Integer;
begin
  result := RegisterRecordType(H, 'TInejResult');
  RegisterRecordField_TInejResult_TestNo(result);
  RegisterRecordField_TInejResult_TestName(result);
  RegisterRecordField_TInejResult_LNorm(result);
  RegisterRecordField_TInejResult_HNorm(result);
  RegisterRecordField_TInejResult_Val(result);
  RegisterRecordField_TInejResult_Units(result);
end;


// procedure(Sender: TObject; Defect: Boolean; MResult: TInejResult)
function RegisterProcedure_DummyProc_TOnMeasureResultInejEvent(H: Integer): Integer;
begin
  result := RegisterRoutine(H, 'DummyProc_TOnMeasureResultInejEvent'
    , _typeVOID // result type
    , nil // address
    );
  RegisterParameter(result, 'Sender', 'TObject', _parVAL);
  RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
  RegisterParameter(result, 'MResult', 'TInejResult', _parVAL);
end;


function RegisterEventType_TOnMeasureResultInejEvent(H: Integer): Integer;
begin
  result := RegisterProcedure_DummyProc_TOnMeasureResultInejEvent(H);
  result := RegisterEventType(H, 'TOnMeasureResultInejEvent', result);
end;


function RegisterClassType_TInej(H: Integer): Integer;
begin
  result := RegisterClassType(H, TInej);
  RegisterConstructor_TInej_Create(result);
  RegisterDestructor_TInej_Destroy(result);
  RegisterMethodProcedure_TInej_DoMeasureResult(result);
  RegisterMethodProcedure_TInej_ResetTester(result);
  RegisterMethodProcedure_TInej_Measure(result);
  RegisterMethodProcedure_TInej_ERRORI(result);
  RegisterMethodProcedure_TInej_PLANPULT(result);
  RegisterMethodProcedure_TInej_GROUP(result);
  RegisterMethodProcedure_TInej_PROGRAMMA(result);
  RegisterMethodProcedure_TInej_TEST(result);
  RegisterMethodProcedure_TInej_TestInc(result);
  RegisterMethodProcedure_TInej_RELE(result);
  RegisterMethodProcedure_TInej_INPDATA(result);
  RegisterMethodFunction_TInej_MORE(result);
  RegisterMethodFunction_TInej_LESS(result);
  RegisterMethodFunction_TInej_OUTSIDE(result);
  RegisterMethodProcedure_TInej_NORMLIM(result);
  RegisterMethodProcedure_TInej_ENDTEST(result);
  RegisterMethodProcedure_TInej_ENDPROGRAM(result);
end;

function RegisterVariable__Tester(P: Pointer; H: Integer): Integer;
var
  T: Integer;
begin
  T := LookupTypeId('TInej');
  result := RegisterVariable(H, 'Tester', T, P);
end;


procedure Part1(P: Pointer; result: Integer);
begin
  RegisterRecordType_TInejResult(result);
  RegisterEventType_TOnMeasureResultInejEvent(result);
  RegisterClassType_TInej(result);
  RegisterVariable__Tester(P, result);
end;

function Register_TESTER_INEJ(P: Pointer): Integer;
begin
  result := RegisterNamespace(0, 'INEJ');
  RegisterUsingNamespace('System.Classes');
  RegisterUsingNamespace('TESTER_BASE');
  RegisterUsingNamespace('TESTER_INEJ_IO');
  RegisterUsingNamespace('TESTER_INEJ_GLOBAL');
  Part1(P, result);
  UnregisterUsingNamespaces;
end;

end.
