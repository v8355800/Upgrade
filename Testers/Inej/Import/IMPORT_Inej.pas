//****************************************************************************
// Unit Name: IMPORT_Inej
//****************************************************************************
unit IMPORT_Inej;

interface

uses
  PaxCompiler;

procedure Register_INEJ(compiler: TPaxCompiler; P: Pointer);

implementation

uses
  IMP_TESTER_INEJ_GLOBAL,
  IMP_TESTER_INEJ;

procedure Register_INEJ(compiler: TPaxCompiler; P: Pointer);
begin
  Register_TESTER_INEJ_GLOBAL(compiler);
  Register_TESTER_INEJ(compiler, P);
end;

end.
