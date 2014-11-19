program Testers;
        
{$R 'RES.res' 'RES\RES.rc'}
{$R 'SQL.res' 'SQL\SQL.rc'}

uses
  Vcl.Forms,
  uAbout in 'uAbout.pas' {fAbout},
  uData in 'uData.pas' {MainData: TDataModule},
  uDBData in 'uDBData.pas' {DBData: TDataModule},
  uMain in 'uMain.pas' {fMain},
  uWPDialog in 'uWPDialog.pas' {fWPDialog},
  fLogin in 'fLogin.pas' {frmLogin},
  TESTER_BASE in '..\Testers\TESTER_BASE.pas',
  TESTER_INEJ in '..\Testers\Inej\TESTER_INEJ.pas',
  TESTER_INEJ_GLOBAL in '..\Testers\Inej\TESTER_INEJ_GLOBAL.PAS',
  TESTER_INEJ_IO in '..\Testers\Inej\TESTER_INEJ_IO.pas',
  TESTER_ISTINA in '..\Testers\Istina\TESTER_ISTINA.pas',
  TESTER_ISTINA_GLOBAL in '..\Testers\Istina\TESTER_ISTINA_GLOBAL.PAS',
  TESTER_ISTINA_IO in '..\Testers\Istina\TESTER_ISTINA_IO.pas',
  TESTER_ISTINA_REG in '..\Testers\Istina\TESTER_ISTINA_REG.PAS',
  uTestConditions in '..\Testers\Istina\uTestConditions.pas',
  IMPORT_Inej in '..\Testers\Inej\Import\IMPORT_Inej.pas',
  IMP_TESTER_INEJ in '..\Testers\Inej\Import\IMP_TESTER_INEJ.pas',
  IMP_TESTER_INEJ_GLOBAL in '..\Testers\Inej\Import\IMP_TESTER_INEJ_GLOBAL.PAS',
  IMPORT_Istina in '..\Testers\Istina\Import\IMPORT_Istina.pas',
  IMP_TESTER_ISTINA in '..\Testers\Istina\Import\IMP_TESTER_ISTINA.pas',
  IMP_TESTER_ISTINA_GLOBAL in '..\Testers\Istina\Import\IMP_TESTER_ISTINA_GLOBAL.PAS',
  uPlans in '..\Testers\uPlans.pas';

{$R *.res}

begin
//  ReportMemoryLeaksOnShutdown := True;

  Application.CreateForm(TMainData, MainData);
  Application.CreateForm(TDBData, DBData);
  if TfrmLogin.Execute then
  begin
    Application.Initialize;
    Application.Title := 'Тестер "' + Tester.TesterShortCaption + '"';
    Application.MainFormOnTaskbar := False;
    Application.CreateForm(TfWPDialog, fWPDialog);
    Application.Run;
  end;

//  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TfAbout, fAbout);
//  Application.CreateForm(TMainData, MainData);
//  Application.CreateForm(TDBData, DBData);
//  Application.CreateForm(TfMain, fMain);
//  Application.CreateForm(TfWPDialog, fWPDialog);
//  Application.Run;
end.
