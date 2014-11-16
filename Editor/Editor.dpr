program Editor;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  uEditor in 'uEditor.pas',
  uPlans in '..\Testers\uPlans.pas',
  TESTER_ISTINA in '..\Testers\Istina\TESTER_ISTINA.pas',
  TESTER_INEJ in '..\Testers\Inej\TESTER_INEJ.pas',
  TESTER_ISTINA_IO in '..\Testers\Istina\TESTER_ISTINA_IO.pas',
  TESTER_ISTINA_GLOBAL in '..\Testers\Istina\TESTER_ISTINA_GLOBAL.PAS',
  TESTER_ISTINA_REG in '..\Testers\Istina\TESTER_ISTINA_REG.PAS',
  IMPORT_Istina in '..\Testers\Istina\Import\IMPORT_Istina.pas',
  IMP_TESTER_ISTINA in '..\Testers\Istina\Import\IMP_TESTER_ISTINA.pas',
  IMP_TESTER_ISTINA_GLOBAL in '..\Testers\Istina\Import\IMP_TESTER_ISTINA_GLOBAL.PAS',
  TESTER_INEJ_GLOBAL in '..\Testers\Inej\TESTER_INEJ_GLOBAL.PAS',
  TESTER_INEJ_IO in '..\Testers\Inej\TESTER_INEJ_IO.pas',
  IMPORT_Inej in '..\Testers\Inej\Import\IMPORT_Inej.pas',
  IMP_TESTER_INEJ in '..\Testers\Inej\Import\IMP_TESTER_INEJ.pas',
  IMP_TESTER_INEJ_GLOBAL in '..\Testers\Inej\Import\IMP_TESTER_INEJ_GLOBAL.PAS',
  TESTER_BASE in '..\Testers\TESTER_BASE.pas',
  uTestConditions in '..\Testers\Istina\uTestConditions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
