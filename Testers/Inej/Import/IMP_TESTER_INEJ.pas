//****************************************************************************
// Unit Name: TESTER_INEJ
//****************************************************************************

unit IMP_TESTER_INEJ;

interface

uses
  PaxCompiler;

function Register_TESTER_INEJ(compiler: TPaxCompiler; P: Pointer): Integer;

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

procedure RegisterRecordField_TInejResult_TestNo(H: Integer; compiler: TPaxCompiler);
var T: Integer;
begin
  T := _typeCARDINAL;
  compiler.RegisterRecordTypeField(H, 'TestNo', T);
end;


procedure RegisterRecordField_TInejResult_TestName(H: Integer; compiler: TPaxCompiler);
var T: Integer;
begin
  T := _typeUNICSTRING;
  compiler.RegisterRecordTypeField(H, 'TestName', T);
end;


procedure RegisterRecordField_TInejResult_LNorm(H: Integer; compiler: TPaxCompiler);
var T: Integer;
begin
  T := _typeDOUBLE;
  compiler.RegisterRecordTypeField(H, 'LNorm', T);
end;


procedure RegisterRecordField_TInejResult_HNorm(H: Integer; compiler: TPaxCompiler);
var T: Integer;
begin
  T := _typeDOUBLE;
  compiler.RegisterRecordTypeField(H, 'HNorm', T);
end;


procedure RegisterRecordField_TInejResult_Val(H: Integer; compiler: TPaxCompiler);
var T: Integer;
begin
  T := _typeDOUBLE;
  compiler.RegisterRecordTypeField(H, 'Val', T);
end;


procedure RegisterRecordField_TInejResult_Units(H: Integer; compiler: TPaxCompiler);
var T: Integer;
begin
  T := _typeUNICSTRING;
  compiler.RegisterRecordTypeField(H, 'Units', T);
end;


//// constructor Create(AOwner: TComponent); override;
//function RegisterConstructor_TInej_Create(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := RegisterConstructor(H, 'Create'
//    , @ TInej.Create // address
//    , _ccREGISTER // call convention
//    , false // class method
//    , _cmOVERRIDE
//    , 0
//    );
//  compiler.RegisterParameter(result, 'AOwner', 'TComponent', _parVAL);
//end;
//
//
//// destructor Destroy; override;
//function RegisterDestructor_TInej_Destroy(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := RegisterDestructor(H, 'Destroy'
//  , @ TInej.Destroy // address
//    );
//end;


//// procedure DoMeasureResult(Defect: Boolean; MResult: TInejResult);
//function RegisterMethodProcedure_TInej_DoMeasureResult(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'DoMeasureResult'
//    , _typeVOID // result type
//    , @ TInej.DoMeasureResult // address
//    );
//  compiler.RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
//  compiler.RegisterParameter(result, 'MResult', 'TInejResult', _parVAL);
//end;


//// procedure ResetTester; override;
//function RegisterMethodProcedure_TInej_ResetTester(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'ResetTester'
//    , _typeVOID // result type
//    , @ TInej.ResetTester // address
//    , _ccREGISTER // call convention
//    , false // class method
//    , _cmOVERRIDE
//    , 0
//    );
//end;


//// procedure Measure(ResetOnEnd: Boolean = True); override;
//function RegisterMethodProcedure_TInej_Measure(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'Measure'
//    , _typeVOID // result type
//    , @ TInej.Measure // address
//    , _ccREGISTER // call convention
//    , false // class method
//    , _cmOVERRIDE
//    , 0
//    );
//  compiler.RegisterParameter(result, 'ResetOnEnd', _typeBOOLEAN, _parVAL, true, 'True');
//end;


//// procedure ERRORI(ErrCode: INTEGER);
//function RegisterMethodProcedure_TInej_ERRORI(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'ERRORI'
//    , _typeVOID // result type
//    , @ fake_TInej.ERRORI // address
//    );
//  compiler.RegisterParameter(result, 'ErrCode', _typeINTEGER, _parVAL);
//end;


//// procedure PLANPULT;
//function RegisterMethodProcedure_TInej_PLANPULT(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'PLANPULT'
//    , _typeVOID // result type
//    , @ fake_TInej.PLANPULT // address
//    );
//end;


// procedure GROUP(G: INTEGER; E: ITOGO);
function RegisterMethodProcedure_TInej_GROUP(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'GROUP'
    , _typeVOID // result type
    , @ fake_TInej.GROUP // address
    );
  compiler.RegisterParameter(result, 'G', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'E', 'ITOGO', _parVAL);
end;


// procedure PROGRAMMA;
function RegisterMethodProcedure_TInej_PROGRAMMA(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'PROGRAMMA'
    , _typeVOID // result type
    , @ TInej.PROGRAMMA // address
    );
end;


// procedure TEST(NAME, UNITS: String{IMYA});
function RegisterMethodProcedure_TInej_TEST(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'TEST'
    , _typeVOID // result type
    , @ TInej.TEST // address
    );
  compiler.RegisterParameter(result, 'NAME', _typeUNICSTRING, _parVAL);
  compiler.RegisterParameter(result, 'UNITS', _typeUNICSTRING, _parVAL);
end;


// procedure TestInc;
function RegisterMethodProcedure_TInej_TestInc(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'TestInc'
    , _typeVOID // result type
    , @ TInej.TestInc // address
    );
end;


// procedure RELE(a: relays);
function RegisterMethodProcedure_TInej_RELE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'RELE'
    , _typeVOID // result type
    , @ TInej.RELE // address
    );
  compiler.RegisterParameter(result, 'a', 'relays', _parVAL);
end;


// procedure INPDATA(p: parameter; c: conductivity; r: Rbe; D: Range; IA: Real;        unitA: UNITS; IB: Real; unitB: UNITS; U: Real; unitU: UNITS; Tm: word;        Ts: word);
function RegisterMethodProcedure_TInej_INPDATA(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'INPDATA'
    , _typeVOID // result type
    , @ TInej.INPDATA // address
    );
  compiler.RegisterParameter(result, 'p', 'parameter', _parVAL);
  compiler.RegisterParameter(result, 'c', 'conductivity', _parVAL);
  compiler.RegisterParameter(result, 'r', 'Rbe', _parVAL);
  compiler.RegisterParameter(result, 'D', 'Range', _parVAL);
  compiler.RegisterParameter(result, 'IA', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'unitA', 'UNITS', _parVAL);
  compiler.RegisterParameter(result, 'IB', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'unitB', 'UNITS', _parVAL);
  compiler.RegisterParameter(result, 'U', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'unitU', 'UNITS', _parVAL);
  compiler.RegisterParameter(result, 'Tm', _typeWORD, _parVAL);
  compiler.RegisterParameter(result, 'Ts', _typeWORD, _parVAL);
end;


// function MORE(UP: Real): Boolean;
function RegisterMethodFunction_TInej_MORE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'MORE'
    , _typeBOOLEAN // result type
    , @ TInej.MORE // address
    );
  compiler.RegisterParameter(result, 'UP', 'Real', _parVAL);
end;


// function LESS(DOWN: Real): Boolean;
function RegisterMethodFunction_TInej_LESS(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'LESS'
    , _typeBOOLEAN // result type
    , @ TInej.LESS // address
    );
  compiler.RegisterParameter(result, 'DOWN', 'Real', _parVAL);
end;


// function OUTSIDE(DOWN, UP: Real): Boolean;
function RegisterMethodFunction_TInej_OUTSIDE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'OUTSIDE'
    , _typeBOOLEAN // result type
    , @ TInej.OUTSIDE // address
    );
  compiler.RegisterParameter(result, 'DOWN', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UP', 'Real', _parVAL);
end;


// procedure NORMLIM;
function RegisterMethodProcedure_TInej_NORMLIM(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'NORMLIM'
    , _typeVOID // result type
    , @ TInej.NORMLIM // address
    );
end;


// procedure ENDTEST;
function RegisterMethodProcedure_TInej_ENDTEST(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'ENDTEST'
    , _typeVOID // result type
    , @ TInej.ENDTEST // address
    );
end;


// procedure ENDPROGRAM;
function RegisterMethodProcedure_TInej_ENDPROGRAM(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'ENDPROGRAM'
    , _typeVOID // result type
    , @ TInej.ENDPROGRAM // address
    );
end;


//function RegisterRecordType_TInejResult(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := RegisterRecordType(H, 'TInejResult');
//  RegisterRecordField_TInejResult_TestNo(result);
//  RegisterRecordField_TInejResult_TestName(result);
//  RegisterRecordField_TInejResult_LNorm(result);
//  RegisterRecordField_TInejResult_HNorm(result);
//  RegisterRecordField_TInejResult_Val(result);
//  RegisterRecordField_TInejResult_Units(result);
//end;


//// procedure(Sender: TObject; Defect: Boolean; MResult: TInejResult)
//function RegisterProcedure_DummyProc_TOnMeasureResultInejEvent(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := RegisterRoutine(H, 'DummyProc_TOnMeasureResultInejEvent'
//    , _typeVOID // result type
//    , nil // address
//    );
//  compiler.RegisterParameter(result, 'Sender', 'TObject', _parVAL);
//  compiler.RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
//  compiler.RegisterParameter(result, 'MResult', 'TInejResult', _parVAL);
//end;


//function RegisterEventType_TOnMeasureResultInejEvent(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := RegisterProcedure_DummyProc_TOnMeasureResultInejEvent(H);
//  result := RegisterEventType(H, 'TOnMeasureResultInejEvent', result);
//end;


function RegisterClassType_TInej(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterClassType(H, TInej);
//  RegisterConstructor_TInej_Create(result, compiler);
//  RegisterDestructor_TInej_Destroy(result, compiler);
//  RegisterMethodProcedure_TInej_DoMeasureResult(result, compiler);
//  RegisterMethodProcedure_TInej_ResetTester(result, compiler);
//  RegisterMethodProcedure_TInej_Measure(result, compiler);
//  RegisterMethodProcedure_TInej_ERRORI(result, compiler);
//  RegisterMethodProcedure_TInej_PLANPULT(result, compiler);
  RegisterMethodProcedure_TInej_GROUP(result, compiler);
  RegisterMethodProcedure_TInej_PROGRAMMA(result, compiler);
  RegisterMethodProcedure_TInej_TEST(result, compiler);
  RegisterMethodProcedure_TInej_TestInc(result, compiler);
  RegisterMethodProcedure_TInej_RELE(result, compiler);
  RegisterMethodProcedure_TInej_INPDATA(result, compiler);
  RegisterMethodFunction_TInej_MORE(result, compiler);
  RegisterMethodFunction_TInej_LESS(result, compiler);
  RegisterMethodFunction_TInej_OUTSIDE(result, compiler);
  RegisterMethodProcedure_TInej_NORMLIM(result, compiler);
  RegisterMethodProcedure_TInej_ENDTEST(result, compiler);
  RegisterMethodProcedure_TInej_ENDPROGRAM(result, compiler);
end;

function RegisterVariable__Tester(H: Integer; compiler: TPaxCompiler; P: Pointer): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('TInej');
  result := compiler.RegisterVariable(H, 'Tester', T, P);
end;


procedure Part1(result: Integer; compiler: TPaxCompiler; P: Pointer);
begin
//  RegisterRecordType_TInejResult(result, compiler);
//  RegisterEventType_TOnMeasureResultInejEvent(result, compiler);
  RegisterClassType_TInej(result, compiler);
  RegisterVariable__Tester(result, compiler, P);
end;

function Register_TESTER_INEJ(compiler: TPaxCompiler; P: Pointer): Integer;
begin
  result := compiler.RegisterNamespace(0, 'INEJ');
  compiler.RegisterUsingNamespace('System.Classes');
  compiler.RegisterUsingNamespace('TESTER_BASE');
  compiler.RegisterUsingNamespace('TESTER_INEJ_IO');
  compiler.RegisterUsingNamespace('TESTER_INEJ_GLOBAL');
  Part1(result, compiler, P);
  compiler.UnregisterUsingNamespaces;
end;

end.
