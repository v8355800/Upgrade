unit uMain;

//{$DEFINE INEJ}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, Vcl.ComCtrls, JvExStdCtrls, JvGroupBox, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, AdvMemo, AdvmPS, Vcl.ActnMenus,
  Vcl.PlatformDefaultStyleActnCtrls, System.Actions, Vcl.ActnList, Vcl.StdActns,
  Vcl.ImgList, Vcl.ExtCtrls, JvComponentBase, JvAppStorage, JvAppIniStorage,
  JvFormPlacement;

type
  TfMain = class(TForm)
    gbInfo: TGroupBox;
    mmoInfo: TMemo;
    gbPlans: TGroupBox;
    lbPlans: TListBox;
    gbPlan: TGroupBox;
    pcPlan: TPageControl;
    pageProgram: TTabSheet;
    pageNorms: TTabSheet;
    lbLog: TListBox;
    mmoProgram: TAdvMemo;
    AdvPascalMemoStyler: TAdvPascalMemoStyler;
    mmoNorms: TMemo;
    ActionMainMenuBar: TActionMainMenuBar;
    ImageList: TImageList;
    ActionManager: TActionManager;
    AdvMemoUndo1: TAdvMemoUndo;
    AdvMemoCut1: TAdvMemoCut;
    AdvMemoCopy1: TAdvMemoCopy;
    AdvMemoPaste1: TAdvMemoPaste;
    AdvMemoDelete1: TAdvMemoDelete;
    AdvMemoSelectAll1: TAdvMemoSelectAll;
    FileNew: TAction;
    FileOpen: TFileOpen;
    FileSave: TAction;
    FileSaveAs: TFileSaveAs;
    FileExit: TFileExit;
    SearchFind: TAction;
    SearchReplace: TAction;
    ProgramSyntaxCheck: TAction;
    PlanAdd: TAction;
    PlanDelete: TAction;
    ActionToolBar2: TActionToolBar;
    FindDialog: TAdvMemoFindDialog;
    ReplaceDialog: TAdvMemoFindReplaceDialog;
    edtPlanName: TEdit;
    StatusBar: TStatusBar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ActionToolBar1: TActionToolBar;
    JvAppIniFileStorage: TJvAppIniFileStorage;
    JvFormStorage: TJvFormStorage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mmoInfoChange(Sender: TObject);
    procedure lbPlansClick(Sender: TObject);
    procedure SearchFindExecute(Sender: TObject);
    procedure SearchReplaceExecute(Sender: TObject);
    procedure FileOpenAccept(Sender: TObject);
    procedure FileSaveAsAccept(Sender: TObject);
    procedure edtPlanNameChange(Sender: TObject);
    procedure mmoProgramChange(Sender: TObject);
    procedure mmoNormsChange(Sender: TObject);
    procedure PlanDeleteExecute(Sender: TObject);
    procedure PlanAddExecute(Sender: TObject);
    procedure ProgramSyntaxCheckExecute(Sender: TObject);
  private
    { Private declarations }
		procedure FillList;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
	TESTER_BASE, TESTER_INEJ, TESTER_ISTINA,
  uPlans,
  uEditor;

var
  Editor: TEditor;
  Inej: TInej;
  Istina: TIstina;

procedure TfMain.edtPlanNameChange(Sender: TObject);
begin
	if 	Editor.CurrentPlan <> nil then
  begin
		Editor.CurrentPlan.Caption := (Sender as TEdit).Text;
    lbPlans.Items[lbPlans.ItemIndex] := (Sender as TEdit).Text;
  end;
end;

procedure TfMain.FileOpenAccept(Sender: TObject);
begin
  if Editor.Load(TFileOpen(Sender).Dialog.FileName) then
  begin
    Self.Caption := 'Редактор рабочих программ - ' + Editor.FileName;
    mmoInfo.Text := Editor.Plans.Info;
    FillList;

    lbPlans.ItemIndex := 0;
    lbPlansClick(lbPlans);
  end;
end;

procedure TfMain.FileSaveAsAccept(Sender: TObject);
begin
	Editor.SaveAs(TFileSaveAs(Sender).Dialog.FileName);
end;

procedure TfMain.FillList;
var
  i: Integer;
begin
  lbPlans.Items.Clear;
  for i := 1 to Editor.Plans.Count do
    lbPlans.Items.Add(Editor.Plans[i-1].Caption);
end;

procedure TfMain.SearchFindExecute(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TfMain.SearchReplaceExecute(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
	Editor := TEditor.Create;
  Inej   := TInej.Create(nil);
  Istina := TIstina.Create(nil);
  Inej.InitScriptEngine(@Inej);
  Istina.InitScriptEngine(@Istina);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
	Editor.Free;
  Inej.Free;
  Istina.Free;
end;

procedure TfMain.lbPlansClick(Sender: TObject);
const
	gbPlanCaption = 'План №%d - "%s"';
var
	Index: Integer;
begin
//	{ Save changes }
//  if Editor.CurrentPlan <> nil then
//    with Editor.CurrentPlan do
//    begin
//      Caption  := edtPlanName.Text;
//      WPFile   := mmoProgram.Lines.Text;
//      NormFile := mmoNorms.Lines.Text;
//    end;
	Index := TListBox(Sender).ItemIndex;
  if Index = -1 then
  	Exit;

  Editor.SetActivePlan(TListBox(Sender).ItemIndex);
	gbPlan.Caption        := Format(gbPlanCaption, [Index + 1, Editor.CurrentPlan.Caption]);
  edtPlanName.Text      := Editor.CurrentPlan.Caption;
  mmoProgram.Lines.Text := Editor.CurrentPlan.WPFile;
  mmoNorms.Lines.Text   := Editor.CurrentPlan.NormFile;
end;

procedure TfMain.mmoInfoChange(Sender: TObject);
begin
	if 	Editor.CurrentPlan <> nil then
		Editor.Plans.Info := (Sender as TMemo).Lines.Text;
end;

procedure TfMain.mmoNormsChange(Sender: TObject);
begin
	if 	Editor.CurrentPlan <> nil then
		Editor.CurrentPlan.NormFile := (Sender as TMemo).Lines.Text;
end;

procedure TfMain.mmoProgramChange(Sender: TObject);
begin
	if 	Editor.CurrentPlan <> nil then
		Editor.CurrentPlan.WPFile := (Sender as TAdvMemo).Lines.Text;
end;

procedure TfMain.PlanAddExecute(Sender: TObject);
begin
	Editor.Plans.Add(TPlan.Create('Новый', '', ''));
  lbPlans.Items.Add('Новый');
end;

procedure TfMain.PlanDeleteExecute(Sender: TObject);
var
	Index: integer;
begin
	if (Editor.CurrentPlan <> nil) and (Editor.Plans.Count > 1) then
  begin
		Editor.Plans.Delete(Editor.Plans.IndexOf(Editor.CurrentPlan));
    Index := lbPlans.ItemIndex;
    lbPlans.DeleteSelected;
//    FillList;
		if Index <> 0 then
    	Index := Index - 1;

	 	lbPlans.ItemIndex := Index;
    lbPlansClick(lbPlans);
  end;
end;

procedure TfMain.ProgramSyntaxCheckExecute(Sender: TObject);
//var
//	Tester: TCustomTester;
begin
	if UpperCase(Editor.Sign) = 'INEJ' then
  begin
//		Tester := TInej.Create(nil);
//    Tester.InitScriptEngine(@Tester);
		Inej.GetWPFromString(mmoProgram.Lines.Text);
//    Tester.GetWPFromFile('MZU.PAS');
    Inej.CompileWP;
//    Tester.Free;
  end;

	if UpperCase(Editor.Sign) = 'ISTINA' then
  begin
//    Tester.InitScriptEngine(@Tester);
		Istina.GetWPFromString(mmoProgram.Lines.Text);
//    Tester.GetWPFromFile('SD3.PAS');
    Istina.CompileWP;
//    Tester.Free;
  end;
end;

end.
