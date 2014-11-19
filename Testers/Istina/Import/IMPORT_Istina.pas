//****************************************************************************
// Unit Name: IMPORT_Istina
//****************************************************************************

unit IMPORT_Istina;

interface

uses
  PaxCompiler;

procedure Register_Istina(compiler: TPaxCompiler; P: Pointer);

implementation

uses
  IMP_TESTER_ISTINA_GLOBAL,
  IMP_TESTER_ISTINA;

procedure Register_Istina(compiler: TPaxCompiler; P: Pointer);
begin
  Register_TESTER_ISTINA_GLOBAL(compiler);
  Register_TESTER_ISTINA(compiler, P);
end;

end.
