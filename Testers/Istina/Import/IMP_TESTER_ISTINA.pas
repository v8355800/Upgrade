//****************************************************************************
// Unit Name: TESTER_ISTINA
//****************************************************************************

unit IMP_TESTER_ISTINA;

interface

uses
  PaxCompiler;

function Register_TESTER_ISTINA(compiler: TPaxCompiler; P: Pointer): Integer;

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

procedure RegisterProperty_TIstina_Perv(H: Integer; compiler: TPaxCompiler);
var TypeId, ReadId, WriteId: Integer;
begin
  TypeId := _typeBYTE;
  ReadId := compiler.RegisterFakeHeader(H,
  'function R_TIstina_Perv():BYTE;',
   @ R_TIstina_Perv);
  WriteId := compiler.RegisterFakeHeader(H,
  'procedure W_TIstina_Perv(const value: BYTE);',
   @ W_TIstina_Perv);
  compiler.RegisterProperty(H, 'Perv', TypeId, ReadId, WriteId, false);
end;

//procedure RegisterRecordField_TIstinaResult_TestNo(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeCARDINAL;
//  compiler.RegisterRecordTypeField(H, 'TestNo', T);
//end;


//procedure RegisterRecordField_TIstinaResult_TestName(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeUNICSTRING;
//  compiler.RegisterRecordTypeField(H, 'TestName', T);
//end;


//procedure RegisterRecordField_TIstinaResult_PinNo(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeBYTE;
//  compiler.RegisterRecordTypeField(H, 'PinNo', T);
//end;


//procedure RegisterRecordField_TIstinaResult_LNorm(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeDOUBLE;
//  compiler.RegisterRecordTypeField(H, 'LNorm', T);
//end;


//procedure RegisterRecordField_TIstinaResult_HNorm(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeDOUBLE;
//  compiler.RegisterRecordTypeField(H, 'HNorm', T);
//end;


//procedure RegisterRecordField_TIstinaResult_Val(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeDOUBLE;
//  compiler.RegisterRecordTypeField(H, 'Val', T);
//end;


//procedure RegisterRecordField_TIstinaResult_Units(H: Integer; compiler: TPaxCompiler);
//var T: Integer;
//begin
//  T := _typeUNICSTRING;
//  compiler.RegisterRecordTypeField(H, 'Units', T);
//end;


//// constructor Create(AOwner: TComponent); override;
//function RegisterConstructor_TIstina_Create(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterConstructor(H, 'Create'
//    , @ TIstina.Create // address
//    , _ccREGISTER // call convention
//    , false // class method
//    , _cmOVERRIDE
//    , 0
//    );
//  compiler.RegisterParameter(result, 'AOwner', 'TComponent', _parVAL);
//end;


//// destructor Destroy; override;
//function RegisterDestructor_TIstina_Destroy(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterDestructor(H, 'Destroy'
//  , @ TIstina.Destroy // address
//    );
//end;


//// procedure DoMeasureResult(Defect: Boolean; MResult: TIstinaResult);
//function RegisterMethodProcedure_TIstina_DoMeasureResult(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'DoMeasureResult'
//    , _typeVOID // result type
//    , @ TIstina.DoMeasureResult // address
//    );
//  compiler.RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
//  compiler.RegisterParameter(result, 'MResult', 'TIstinaResult', _parVAL);
//end;


//// procedure ResetTester; override;
//function RegisterMethodProcedure_TIstina_ResetTester(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'ResetTester'
//    , _typeVOID // result type
//    , @ TIstina.ResetTester // address
//    , _ccREGISTER // call convention
//    , false // class method
//    , _cmOVERRIDE
//    , 0
//    );
//end;


//// procedure Measure(ResetOnEnd: Boolean = True); override;
//function RegisterMethodProcedure_TIstina_Measure(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'Measure'
//    , _typeVOID // result type
//    , @ TIstina.Measure // address
//    , _ccREGISTER // call convention
//    , false // class method
//    , _cmOVERRIDE
//    , 0
//    );
//  compiler.RegisterParameter(result, 'ResetOnEnd', _typeBOOLEAN, _parVAL, true, 'True');
//end;


//function RegisterSubrangeType_SubType_1000108(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000108 = 1 .. maxtest;');
//end;
//
//
//function RegisterArrayType_ArrayType_1000104(H: Integer; compiler: TPaxCompiler): Integer;
//var
//  I, ElemTypeId, RangeTypeId, K: Integer;
//  R: array of Integer;
//begin
//  result := 0;
//  K := 1;
//  SetLength(R, K);
//  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000108 = 1 .. maxtest;');
//  ElemTypeId := compiler.LookupTypeId('Real');
//  for I := 0 to K - 1 do
//  begin
//    RangeTypeId := R[K - I - 1];
//    result := compiler.RegisterArrayType(H, 'ArrayType_1000104', RangeTypeId, ElemTypeId, true);
//    ElemTypeId := result;
//  end;
//end;


// function ADC(M: PINS; RNG: REAL; UN: EDIZM): REAL;
function RegisterMethodFunction_TIstina_ADC(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'ADC'
    , 'Real' // result type
    , @ TIstina.ADC // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
  compiler.RegisterParameter(result, 'RNG', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UN', 'EDIZM', _parVAL);
end;


// function LESS(M: PINS; DOWN: REAL; E: EDIZM): BOOLEAN;
function RegisterMethodFunction_TIstina_LESS(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'LESS'
    , _typeBOOLEAN // result type
    , @ TIstina.LESS // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
  compiler.RegisterParameter(result, 'DOWN', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'E', 'EDIZM', _parVAL);
end;


// function MORE(M: PINS; UP: REAL; E: EDIZM): BOOLEAN;
function RegisterMethodFunction_TIstina_MORE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'MORE'
    , _typeBOOLEAN // result type
    , @ TIstina.MORE // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
  compiler.RegisterParameter(result, 'UP', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'E', 'EDIZM', _parVAL);
end;


// function OUTSIDE(M: PINS; DOWN, UP: REAL; E: EDIZM): BOOLEAN;
function RegisterMethodFunction_TIstina_OUTSIDE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'OUTSIDE'
    , _typeBOOLEAN // result type
    , @ TIstina.OUTSIDE // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
  compiler.RegisterParameter(result, 'DOWN', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UP', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'E', 'EDIZM', _parVAL);
end;


// function RESVOLT(I: INTEGER; D: SCALE): REAL;
function RegisterMethodFunction_TIstina_RESVOLT(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'RESVOLT'
    , 'Real' // result type
    , @ TIstina.RESVOLT // address
    );
  compiler.RegisterParameter(result, 'I', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'D', 'SCALE', _parVAL);
end;


// procedure compare;
function RegisterMethodProcedure_TIstina_compare(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'compare'
    , _typeVOID // result type
    , @ TIstina.compare // address
    );
end;


// procedure DELAYCOMM(OPT: SELECTOR);
function RegisterMethodProcedure_TIstina_DELAYCOMM(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'DELAYCOMM'
    , _typeVOID // result type
    , @ TIstina.DELAYCOMM // address
    );
  compiler.RegisterParameter(result, 'OPT', 'SELECTOR', _parVAL);
end;


// procedure DELAYMEAS(M: PINS; TON, TOFF: REAL; UN: EDIZM);
function RegisterMethodProcedure_TIstina_DELAYMEAS(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'DELAYMEAS'
    , _typeVOID // result type
    , @ TIstina.DELAYMEAS // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
  compiler.RegisterParameter(result, 'TON', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'TOFF', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UN', 'EDIZM', _parVAL);
end;


// procedure DYNLOAD(M: PINS);
function RegisterMethodProcedure_TIstina_DYNLOAD(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'DYNLOAD'
    , _typeVOID // result type
    , @ TIstina.DYNLOAD // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure ENDPROGRAM;
function RegisterMethodProcedure_TIstina_ENDPROGRAM(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'ENDPROGRAM'
    , _typeVOID // result type
    , @ TIstina.ENDPROGRAM // address
    );
end;


// procedure ENDTEST;
function RegisterMethodProcedure_TIstina_ENDTEST(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'ENDTEST'
    , _typeVOID // result type
    , @ TIstina.ENDTEST // address
    );
end;


// procedure GROUP(G: INTEGER; E: ITOGO);
function RegisterMethodProcedure_TIstina_GROUP(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'GROUP'
    , _typeVOID // result type
    , @ TIstina.GROUP // address
    );
  compiler.RegisterParameter(result, 'G', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'E', 'ITOGO', _parVAL);
end;


// procedure LOAD(M: PINS);
function RegisterMethodProcedure_TIstina_LOAD(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'LOAD'
    , _typeVOID // result type
    , @ TIstina.LOAD // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure normlim(M, NUM: INTEGER; r: REAL);
function RegisterMethodProcedure_TIstina_normlim(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'normlim'
    , _typeVOID // result type
    , @ TIstina.normlim // address
    );
  compiler.RegisterParameter(result, 'M', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'NUM', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'r', 'Real', _parVAL);
end;


// procedure normlimZ(M, NUM: INTEGER; r: REAL);
function RegisterMethodProcedure_TIstina_normlimZ(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'normlimZ'
    , _typeVOID // result type
    , @ TIstina.normlimZ // address
    );
  compiler.RegisterParameter(result, 'M', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'NUM', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'r', 'Real', _parVAL);
end;


// procedure PINOFF(M: PINS);
function RegisterMethodProcedure_TIstina_PINOFF(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'PINOFF'
    , _typeVOID // result type
    , @ TIstina.PINOFF // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure PROGRAMMA;
function RegisterMethodProcedure_TIstina_PROGRAMMA(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'PROGRAMMA'
    , _typeVOID // result type
    , @ TIstina.PROGRAMMA // address
    );
end;


//// procedure SETCOMPS(M: PINS; LOWC, HIGHC: REAL; UN: EDIZM);
//function RegisterMethodProcedure_TIstina_SETCOMPS(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'SETCOMPS'
//    , _typeVOID // result type
//    , @ TIstina.SETCOMPS // address
//    );
//  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
//  compiler.RegisterParameter(result, 'LOWC', 'Real', _parVAL);
//  compiler.RegisterParameter(result, 'HIGHC', 'Real', _parVAL);
//  compiler.RegisterParameter(result, 'UN', 'EDIZM', _parVAL);
//end;


// procedure SMALL(OPT: SELECTOR);
function RegisterMethodProcedure_TIstina_SMALL(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'SMALL'
    , _typeVOID // result type
    , @ TIstina.SMALL // address
    );
  compiler.RegisterParameter(result, 'OPT', 'SELECTOR', _parVAL);
end;


// procedure SOURCE(M: PINS; FRC: REAL; UF: EDIZM; CLMP: REAL; UC: EDIZM);
function RegisterMethodProcedure_TIstina_SOURCE(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'SOURCE'
    , _typeVOID // result type
    , @ TIstina.SOURCE // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
  compiler.RegisterParameter(result, 'FRC', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UF', 'EDIZM', _parVAL);
  compiler.RegisterParameter(result, 'CLMP', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UC', 'EDIZM', _parVAL);
end;


// procedure START(M: PINS);
function RegisterMethodProcedure_TIstina_START(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'START'
    , _typeVOID // result type
    , @ TIstina.START // address
    );
  compiler.RegisterParameter(result, 'M', 'PINS', _parVAL);
end;


// procedure TEST(N: INTEGER; NAME, UNITS: IMYA);
function RegisterMethodProcedure_TIstina_TEST(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'TEST'
    , _typeVOID // result type
    , @ TIstina.TEST // address
    );
  compiler.RegisterParameter(result, 'N', _typeINTEGER, _parVAL);
  compiler.RegisterParameter(result, 'NAME', 'IMYA', _parVAL);
  compiler.RegisterParameter(result, 'UNITS', 'IMYA', _parVAL);
end;


// procedure TestInc;
function RegisterMethodProcedure_TIstina_TestInc(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'TestInc'
    , _typeVOID // result type
    , @ TIstina.TestInc // address
    );
end;


// procedure TESTLEN(LEN: REAL; UNITS: EDIZM);
function RegisterMethodProcedure_TIstina_TESTLEN(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'TESTLEN'
    , _typeVOID // result type
    , @ TIstina.TESTLEN // address
    );
  compiler.RegisterParameter(result, 'LEN', 'Real', _parVAL);
  compiler.RegisterParameter(result, 'UNITS', 'EDIZM', _parVAL);
end;


// procedure TestNo(No: INTEGER);
function RegisterMethodProcedure_TIstina_TestNo(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterMethod(H, 'TestNo'
    , _typeVOID // result type
    , @ TIstina.TestNo // address
    );
  compiler.RegisterParameter(result, 'No', _typeINTEGER, _parVAL);
end;


//// procedure SetCondition(TestN: Integer; Condition: Integer);
//function RegisterMethodProcedure_TIstina_SetCondition(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'SetCondition'
//    , _typeVOID // result type
//    , @ TIstina.SetCondition // address
//    );
//  compiler.RegisterParameter(result, 'TestN', _typeINTEGER, _parVAL);
//  compiler.RegisterParameter(result, 'Condition', _typeINTEGER, _parVAL);
//end;


//// procedure ClearCondition(TestN: Integer; Condition: Integer);
//function RegisterMethodProcedure_TIstina_ClearCondition(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'ClearCondition'
//    , _typeVOID // result type
//    , @ TIstina.ClearCondition // address
//    );
//  compiler.RegisterParameter(result, 'TestN', _typeINTEGER, _parVAL);
//  compiler.RegisterParameter(result, 'Condition', _typeINTEGER, _parVAL);
//end;


//// procedure ClearConditions;
//function RegisterMethodProcedure_TIstina_ClearConditions(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterMethod(H, 'ClearConditions'
//    , _typeVOID // result type
//    , @ TIstina.ClearConditions // address
//    );
//end;


//function RegisterRecordType_TIstinaResult(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterRecordType(H, 'TIstinaResult');
//  RegisterRecordField_TIstinaResult_TestNo(result);
//  RegisterRecordField_TIstinaResult_TestName(result);
//  RegisterRecordField_TIstinaResult_PinNo(result);
//  RegisterRecordField_TIstinaResult_LNorm(result);
//  RegisterRecordField_TIstinaResult_HNorm(result);
//  RegisterRecordField_TIstinaResult_Val(result);
//  RegisterRecordField_TIstinaResult_Units(result);
//end;


//// procedure(Sender: TObject; Defect: Boolean; MResult: TIstinaResult)
//function RegisterProcedure_DummyProc_TOnMeasureResulTIstinaEvent(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterRoutine(H, 'DummyProc_TOnMeasureResulTIstinaEvent'
//    , _typeVOID // result type
//    , nil // address
//    );
//  compiler.RegisterParameter(result, 'Sender', 'TObject', _parVAL);
//  compiler.RegisterParameter(result, 'Defect', _typeBOOLEAN, _parVAL);
//  compiler.RegisterParameter(result, 'MResult', 'TIstinaResult', _parVAL);
//end;


//function RegisterEventType_TOnMeasureResulTIstinaEvent(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterProcedure_DummyProc_TOnMeasureResulTIstinaEvent(H);
//  result := compiler.RegisterEventType(H, 'TOnMeasureResulTIstinaEvent', result);
//end;


//function RegisterSubrangeType_SubType_1000035(H: Integer; compiler: TPaxCompiler): Integer;
//begin
//  result := compiler.RegisterTypeDeclaration(H, 'SubType_1000035 = 1..MAXPOINT;');
//end;


//function RegisterArrayType_TConditions(H: Integer; compiler: TPaxCompiler): Integer;
//var
//  I, ElemTypeId, RangeTypeId, K: Integer;
//  R: array of Integer;
//begin
//  result := 0;
//  K := 1;
//  SetLength(R, K);
//  R[0] := compiler.RegisterTypeDeclaration(H, 'SubType_1000035 = 1..MAXPOINT;');
//  ElemTypeId := _typeINTEGER;
//  for I := 0 to K - 1 do
//  begin
//    RangeTypeId := R[K - I - 1];
//    result := compiler.RegisterArrayType(H, 'TConditions', RangeTypeId, ElemTypeId, true);
//    ElemTypeId := result;
//  end;
//end;


function RegisterClassType_TIstina(H: Integer; compiler: TPaxCompiler): Integer;
begin
  result := compiler.RegisterClassType(H, TIstina);
//  RegisterConstructor_TIstina_Create(result, compiler);
//  RegisterDestructor_TIstina_Destroy(result, compiler);
//  RegisterMethodProcedure_TIstina_DoMeasureResult(result, compiler);
//  RegisterMethodProcedure_TIstina_ResetTester(result, compiler);
//  RegisterMethodProcedure_TIstina_Measure(result, compiler);
//  RegisterSubrangeType_SubType_1000108(result, compiler);
//  RegisterArrayType_ArrayType_1000104(result, compiler);
  RegisterMethodFunction_TIstina_ADC(result, compiler);
  RegisterMethodFunction_TIstina_LESS(result, compiler);
  RegisterMethodFunction_TIstina_MORE(result, compiler);
  RegisterMethodFunction_TIstina_OUTSIDE(result, compiler);
  RegisterMethodFunction_TIstina_RESVOLT(result, compiler);
  RegisterMethodProcedure_TIstina_compare(result, compiler);
  RegisterMethodProcedure_TIstina_DELAYCOMM(result, compiler);
  RegisterMethodProcedure_TIstina_DELAYMEAS(result, compiler);
  RegisterMethodProcedure_TIstina_DYNLOAD(result, compiler);
  RegisterMethodProcedure_TIstina_ENDPROGRAM(result, compiler);
  RegisterMethodProcedure_TIstina_ENDTEST(result, compiler);
  RegisterMethodProcedure_TIstina_GROUP(result, compiler);
  RegisterMethodProcedure_TIstina_LOAD(result, compiler);
  RegisterMethodProcedure_TIstina_normlim(result, compiler);
  RegisterMethodProcedure_TIstina_normlimZ(result, compiler);
  RegisterMethodProcedure_TIstina_PINOFF(result, compiler);
  RegisterMethodProcedure_TIstina_PROGRAMMA(result, compiler);
//  RegisterMethodProcedure_TIstina_SETCOMPS(result, compiler);
  RegisterMethodProcedure_TIstina_SMALL(result, compiler);
  RegisterMethodProcedure_TIstina_SOURCE(result, compiler);
  RegisterMethodProcedure_TIstina_START(result, compiler);
  RegisterMethodProcedure_TIstina_TEST(result, compiler);
  RegisterMethodProcedure_TIstina_TestInc(result, compiler);
  RegisterMethodProcedure_TIstina_TESTLEN(result, compiler);
  RegisterMethodProcedure_TIstina_TestNo(result, compiler);
//  RegisterMethodProcedure_TIstina_SetCondition(result, compiler);
//  RegisterMethodProcedure_TIstina_ClearCondition(result, compiler);
//  RegisterMethodProcedure_TIstina_ClearConditions(result, compiler);
  RegisterProperty_TIstina_Perv(result, compiler);
end;


function RegisterVariable__Tester(H: Integer; compiler: TPaxCompiler; P: Pointer): Integer;
var
  T: Integer;
begin
  T := compiler.LookupTypeId('TIstina');
  result := compiler.RegisterVariable(H, 'Tester', T, P);
end;


procedure Part1(result: Integer; compiler: TPaxCompiler; P: Pointer);
begin
//  RegisterRecordType_TIstinaResult(result);
//  RegisterEventType_TOnMeasureResulTIstinaEvent(result);
//  RegisterSubrangeType_SubType_1000035(result);
//  RegisterArrayType_TConditions(result);
  RegisterClassType_TIstina(result, compiler);
  RegisterVariable__Tester(result, compiler, P);
end;

function Register_TESTER_ISTINA(compiler: TPaxCompiler; P: Pointer): Integer;
begin
  result := compiler.RegisterNamespace(0, 'Istina');
  compiler.RegisterUsingNamespace('System.Classes');
  compiler.RegisterUsingNamespace('TESTER_BASE');
  compiler.RegisterUsingNamespace('TESTER_ISTINA_IO');
  compiler.RegisterUsingNamespace('TESTER_ISTINA_GLOBAL');
  Part1(result, compiler, P);
  compiler.UnregisterUsingNamespaces;
end;

end.
