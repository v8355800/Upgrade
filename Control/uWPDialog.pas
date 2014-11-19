unit uWPDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, Vcl.Samples.Spin;

type
  TfWPDialog = class(TForm)
    GroupBox1: TGroupBox;
    edtWPFileName: TJvFilenameEdit;
    btnOK: TButton;
    btnCancel: TButton;
    GroupBox2: TGroupBox;
    cmbPlans: TComboBox;
    mmoInfo: TMemo;
    gbConditions: TGroupBox;
    edtADC: TEdit;
    edtHalt: TEdit;
    edtLoop: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtLoopCount: TSpinEdit;
    Label4: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure edtWPFileNameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
//{$IFDEF ISTINA}
    procedure SetConditions;
//{$ENDIF}
  public
    { Public declarations }
  end;

var
  fWPDialog: TfWPDialog;

implementation

{$R *.dfm}

uses
  frxUtils,
  uPlans,
  TESTER_BASE,
{$IFDEF INEJ}
//  TESTER_INEJ,
  TESTER_INEJ_GLOBAL,
{$ENDIF}

{$IFDEF ISTINA}
//  TESTER_ISTINA,
  TESTER_ISTINA_GLOBAL,
{$ENDIF}

  uData,
  uMain;

var
  Plans: TPlans;



procedure TfWPDialog.btnOKClick(Sender: TObject);
begin
  if cmbPlans.ItemIndex = -1 then
  begin
    MessageDlg('Не выбран "План классификациии"!',  mtWarning, [mbOK], 0);
    Exit;
  end;

  if ( Trim(Plans.Items[cmbPlans.ItemIndex].WPFile) = '' ) or
     ( Trim(Plans.Items[cmbPlans.ItemIndex].NormFile) = '' ) then
  begin
    MessageDlg('Программа испытаний или файл норм пуст!',  mtWarning, [mbOK], 0);
    Exit;
  end;

  Tester.ClearCounters;

//  fCaption := Plan.Caption;
  Tester.GetWPFromString(Plans.Items[cmbPlans.ItemIndex].WPFile);
  Tester.GetNormsFromString(Plans.Items[cmbPlans.ItemIndex].NormFile);
  if not Tester.CompileWP then
    Exit;

//  {$IFDEF ISTINA}
  SetConditions;
//  {$ENDIF}

  MainData.CreateStructureTableCurrent;
  MainData.CreateStructureTableAll;

  Tester.ResetTester;

  IData.WPFile := ExtractFileName(edtWPFileName.FileName);
  IData.PlanName := cmbPlans.Text;
  IData.PlanNumber := cmbPlans.ItemIndex;

  fMain := TfMain.Create(nil);
  with fMain do
  try
    FillInfo(mmoInfo.Text);
    Self.Hide;
    WindowState := wsMaximized;
    ShowModal;
    Self.Show;
  finally
    Free;
  end;
end;

procedure TfWPDialog.edtWPFileNameChange(Sender: TObject);
begin
	if Plans.IsValidWPFile((Sender as TJvFilenameEdit).FileName, Tester.TesterSignature) then
  begin
  	Plans.LoadFromFile((Sender as TJvFilenameEdit).FileName);
    mmoInfo.Text := Plans.Info;
    Plans.Fill(cmbPlans.Items);

//    { По умолчанию выбрать план, который установлен на пульте }
//    if Tester.GetPlan in  [1..cmbPlans.Items.Count-1] then
//      cmbPlans.ItemIndex := Tester.GetPlan
//    else
      cmbPlans.ItemIndex := 0;

    cmbPlans.Enabled := True;
  	btnOK.Enabled := True;
  end
  else
  begin
    mmoInfo.Clear;
    cmbPlans.Clear;
    cmbPlans.Enabled := False;
  	btnOK.Enabled := False;
  end;
end;

procedure TfWPDialog.FormCreate(Sender: TObject);
begin
  Plans := TPlans.Create;

  { Conditions }
  with Tester.Feathers do
  begin
    edtADC.Enabled       := ADC;
    edtHalt.Enabled      := HALT;
    edtLoop.Enabled      := LOOP;
    edtLoopCount.Enabled := LOOP;
  end;

//  if not Tester.ClassNameIs('TIstina') then
//  begin
//    edtADC.Enabled       := False;
//    edtHalt.Enabled      := False;
//    edtLoop.Enabled      := False;
//    edtLoopCount.Enabled := False;
//  end;

  if Tester.IO.DemoMode then
    Application.MessageBox(PWideChar('Плата согласования для тестера "' + Tester.TesterShortCaption + '" не найдена!'
      + #13#10 + 'Работа будет продолжена в режиме имитации.'),
      'Тестер - Управляющая программа', MB_OK + MB_ICONWARNING);

  if ParamCount > 0 then
    edtWPFileName.FileName := ParamStr(1);
end;

procedure TfWPDialog.FormDestroy(Sender: TObject);
begin
  Plans.Free;
  Tester.Free;
end;

//{$IFDEF ISTINA}
procedure TfWPDialog.SetConditions;
var
  List: TStringList;
  i: Integer;
begin
  Tester.ClearConditions;

  List := TStringList.Create;
  try
    { ADC }
    frxParsePageNumbers(edtADC.Text, List, maxtest);
    for i := 0 to List.Count-1 do
      Tester.SetCondition(List[i].ToInteger, MADC);

    { HALT }
    List.Clear;
    frxParsePageNumbers(edtHalt.Text, List, maxtest);
    for i := 0 to List.Count-1 do
      Tester.SetCondition(List[i].ToInteger, MHALT);

    { LOOP }
    List.Clear;
    frxParsePageNumbers(edtLoop.Text, List, maxtest);
    for i := 0 to List.Count-1 do
      Tester.SetCondition(List[i].ToInteger, MLOOP);
    NLOOP := edtLoopCount.Value;
  finally
    List.Free;
  end;
end;
//{$ENDIF}

procedure TfWPDialog.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
