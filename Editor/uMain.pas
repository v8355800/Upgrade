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
    procedure lbLogDblClick(Sender: TObject);
    procedure mmoProgramCursorChange(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
  private
    { Private declarations }
    procedure EnableForm(Enable: Boolean);
		procedure FillList;
    procedure OnErrorEvent(Sender: TObject; ErrorCode: Cardinal;  ErrorMsg: string);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
	System.AnsiStrings,
	TESTER_BASE, TESTER_INEJ, TESTER_ISTINA,
  uPlans,
  uEditor;

var
  Editor : TEditor;
  Inej   : TInej;
  Istina : TIstina;

procedure TfMain.edtPlanNameChange(Sender: TObject);
begin
	if 	Editor.CurrentPlan <> nil then
  begin
		Editor.CurrentPlan.Caption := (Sender as TEdit).Text;
    lbPlans.Items[lbPlans.ItemIndex] := (Sender as TEdit).Text;
  end;
end;

procedure TfMain.EnableForm(Enable: Boolean);
begin
	gbInfo.Visible    := Enable;
  gbPlans.Visible   := Enable;
  gbPlan.Visible    := Enable;
  Splitter1.Visible := Enable;
  Splitter2.Visible := Enable;
end;

procedure TfMain.FileOpenAccept(Sender: TObject);
begin
  if Editor.Load(TFileOpen(Sender).Dialog.FileName) then
  begin
    Self.Caption := 'Редактор рабочих программ - ' + Editor.FileName;
    EnableForm(True);
    mmoInfo.Text := Editor.Plans.Info;
    FillList;

    lbPlans.ItemIndex := 0;
    lbPlansClick(lbPlans);
  end;
end;

procedure TfMain.FileSaveAsAccept(Sender: TObject);
begin
	Editor.SaveAs(TFileSaveAs(Sender).Dialog.FileName);

  Editor.Load(TFileSaveAs(Sender).Dialog.FileName);
  Self.Caption := 'Редактор рабочих программ - ' + Editor.FileName;
  EnableForm(True);
  mmoInfo.Text := Editor.Plans.Info;
  FillList;

  lbPlans.ItemIndex := 0;
  lbPlansClick(lbPlans);
end;

procedure TfMain.FileSaveExecute(Sender: TObject);
begin
  if Application.MessageBox('Вы уверены, что хотите перезаписать РП?',
    'Редактор рабочих программ', MB_OKCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDOK then
  begin
    Editor.Save;
  end;
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
  EnableForm(False);

	Editor := TEditor.Create;
  Inej   := TInej.Create(nil);
  Istina := TIstina.Create(nil);
  Inej.InitScriptEngine(@Inej);
  Istina.InitScriptEngine(@Istina);
  Inej.OnError   := OnErrorEvent;
  Istina.OnError := OnErrorEvent;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
	Editor.Free;
  Inej.Free;
  Istina.Free;
end;

procedure TfMain.lbLogDblClick(Sender: TObject);
  function GetLineNumber(const S: String): Integer;
  var
    X: string;
  begin
    X := Copy(S, 7, Pos(';', S)-7);
    Result := StrToInt(X);
  end;

  function GetLinePos(const S: String): Integer;
  var
    X: string;
  begin
    X := RightStr(S,Length(S)-Pos('Col:', S));
    X := Copy(X, 4, Pos(']', X)-4);
    Result := StrToInt(X);
  end;
begin
  if TListBox(Sender).ItemIndex = -1 then
    Exit;

  mmoProgram.CurY := GetLineNumber(TListBox(Sender).Items[TListBox(Sender).ItemIndex])-1;
  mmoProgram.CurX := GetLinePos(TListBox(Sender).Items[TListBox(Sender).ItemIndex])-1;
  mmoProgram.SetFocus;

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

procedure TfMain.mmoProgramCursorChange(Sender: TObject);
begin
	StatusBar.Panels[0].Text := 'Line: '+  inttostr((Sender as TAdvMemo).CurY + 1) + '  Col: ' + inttostr((Sender as TAdvMemo).CurX + 1);
end;

procedure TfMain.OnErrorEvent(Sender: TObject; ErrorCode: Cardinal;
  ErrorMsg: string);
begin
  lbLog.Items.Add(ErrorMsg);
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

		if Index <> 0 then
    	Index := Index - 1;

	 	lbPlans.ItemIndex := Index;
    lbPlansClick(lbPlans);
  end;
end;

procedure TfMain.ProgramSyntaxCheckExecute(Sender: TObject);
begin
  lbLog.Clear;
	if UpperCase(Editor.Sign) = 'INEJ' then
  begin
		Inej.GetWPFromString(mmoProgram.Lines.Text);
    Inej.CompileWP;
  end;

	if UpperCase(Editor.Sign) = 'ISTINA' then
  begin
		Istina.GetWPFromString(mmoProgram.Lines.Text);
    Istina.CompileWP;
  end;
end;

end.
