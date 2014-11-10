unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Imaging.pngimage, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids, Vcl.ValEdit, JvExStdCtrls, JvHtControls, MemTableDataEh, Data.DB,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh,
  DBAxisGridsEh, DBGridEh, MemTableEh, JvComponentBase, JvThread, System.IOUtils,
  {$IFDEF INEJ}
  TESTER_INEJ,
  {$ENDIF}
  {$IFDEF ISTINA}
  TESTER_ISTINA,
  {$ENDIF}
  Vcl.AppEvnts, JvBaseDlg, JvProgressDialog, Vcl.Buttons;

const
  TRA_Delay = 100;
  Demo_Delay = 15;

type
	TInfo = record
  	ValueList: string;
  end;

  TfMain = class(TForm)
    pnlLeft: TPanel;
    StatusBar: TStatusBar;
    pnlMeasure: TPanel;
    Thread: TJvThread;
    GroupBox1: TGroupBox;
    pgcMeasure: TPageControl;
    TabSheet1: TTabSheet;
    grdCurrent: TDBGridEh;
    tsAll: TTabSheet;
    grdAll: TDBGridEh;
    TabSheet2: TTabSheet;
    imgStatus: TImage;
    tsLog: TTabSheet;
    mmoErrors: TMemo;
    mmoLogs: TMemo;
    AppEvents: TApplicationEvents;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    pnlStatus: TPanel;
    PD: TJvProgressDialog;
    pnlClient: TPanel;
    pnlBottom: TPanel;
    pnlHotKeys: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    cbbViewMode: TComboBox;
    lblF5: TLabel;
    cbbMeasureMode: TComboBox;
    Label4: TLabel;
    btnClose: TButton;
    Timer: TTimer;
    ValueListEditor1: TValueListEditor;
    btnAbout: TBitBtn;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    lblStatus: TLabel;
    lblFIO: TLabel;
    lblTabN: TLabel;
    lblWPFile: TLabel;
    lblPlan: TLabel;
    pcLeft: TPageControl;
    tabCounters: TTabSheet;
    tabStat: TTabSheet;
    tabWP: TTabSheet;
    pnlCounters: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Bevel1: TBevel;
    JvHTLabel1: TJvHTLabel;
    lblCounters: TJvHTLabel;
    Bevel2: TBevel;
    lblPercents: TJvHTLabel;
    lblCountersAll: TLabel;
    btnCountersReset: TButton;
    btnResetResults: TButton;
    btnShowWP: TButton;
    btnShowNorms: TButton;
    btnSaveSTA: TButton;
    lblSTAFileName: TLabel;
    btnBeginSTA: TButton;
    btnEndSTA: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ThreadExecute(Sender: TObject; Params: Pointer);
    procedure AppEventsShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure cbbViewModeChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdCurrentGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btnCountersResetClick(Sender: TObject);
    procedure grdAllGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btnShowWPClick(Sender: TObject);
    procedure btnShowNormsClick(Sender: TObject);
    procedure btnSaveSTAClick(Sender: TObject);
    procedure btnBeginSTAClick(Sender: TObject);
    procedure btnEndSTAClick(Sender: TObject);
    procedure cbbMeasureModeChange(Sender: TObject);
    procedure btnResetResultsClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
  private
    { Private declarations }
    PNG_GOOD, PNG_BAD: TPngImage;
    WMF_GOOD, WMF_BAD: TMetafile;
    isMeasured: Boolean;

    procedure LoadRes;
    procedure ChangeViewMode(const ViewMode: Integer);
    procedure ChangeMeasureMode(const MeasureMode: Integer);

    procedure FillViewMode;

    procedure StartMeasureFromThread;
  public
    { Public declarations }
    procedure FillInfo(Text: String);

{$IFDEF INEJ}
    procedure TesterOnMeasRes(Sender: TObject; Defect: Boolean; MResult: TInejResult);
{$ENDIF}

{$IFDEF ISTINA}
    procedure TesterOnMeasRes(Sender: TObject; Defect: Boolean; MResult: TIstinaResult);
{$ENDIF}

    procedure TesterOnProgramEnd(Sender: TObject; GroupN: Byte; Defect: Boolean);
    procedure TesterOnCommand(Sender: TObject; CommandName: string);

    procedure TesterOnScriptEnd(Sender: TObject);

    procedure StartMeasure(FromThread: Boolean);
    procedure UpdateCounters;
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
{$IFDEF INEJ}
  TESTER_INEJ_GLOBAL,
{$ENDIF}

{$IFDEF ISTINA}
  TESTER_ISTINA_GLOBAL,
{$ENDIF}
  uData,
  uAbout,
  StopWatch,
  JclStrings,
  ShellApi,
  DBGridEhImpExp;

procedure TfMain.AppEventsShortCut(var Msg: TWMKey; var Handled: Boolean);
  procedure ComboBox_Rotate(ComboBox: TComboBox);
  begin
    if ComboBox.ItemIndex = ComboBox.Items.Count - 1 then
      ComboBox.ItemIndex := 0
    else
      ComboBox.ItemIndex := ComboBox.ItemIndex + 1;
  end;
begin
  { CTRL + ?}
  if (GetKeyState(VK_CONTROL) < 0) and
     (GetKeyState(VK_SHIFT)  >= 0) and
     (GetKeyState(VK_MENU)   >= 0) then
  begin
    case Msg.CharCode of
//      Ord('N') : begin btnNRMClick(Self); Handled := True; end; // CTRL + N;
      Ord('X') : begin btnCloseClick(Self); Handled := True; end; // CTRL + X;
    end;
  end;

  { F? }
  if (GetKeyState(VK_SHIFT)   >= 0) and
     (GetKeyState(VK_CONTROL) >= 0) and
     (GetKeyState(VK_MENU)    >= 0) then
  begin
    { Disable shortcuts on Measure time }
    if isMeasured then
    begin
      Handled := False;
      Exit;
    end;

    case Msg.CharCode of
      { View Mode }
      VK_F2:
        begin
          ComboBox_Rotate(cbbViewMode);
          ChangeViewMode(cbbViewMode.ItemIndex);
          Handled := True;
        end;
      { Measure }
      VK_F5:
        begin
          if Tester.IO.DemoMode then
          begin
            StartMeasure(False);
            Handled := True;
          end;
        end;
      VK_F7:
        begin
          ComboBox_Rotate(cbbMeasureMode);
          ChangeMeasureMode(cbbMeasureMode.ItemIndex);
          Handled := True;
        end;
    end;
  end;
end;

procedure TfMain.btnSaveSTAClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  SaveDlg := TSaveDialog.Create(nil);
  SaveDlg.Filter := 'Файлы статистики (*.STA)|*.STA|Все файлы (*.*)|*.*';
  SaveDlg.FilterIndex := 1;
  SaveDlg.DefaultExt := 'STA';
  SaveDlg.Options := SaveDlg.Options + [ofOverwritePrompt];
  if SaveDlg.Execute then
  begin
    MainData.WriteSTA(SaveDlg.FileName);
    ShowMessage('Файл статистики "' + SaveDlg.FileName + '" записан');
  end;

  SaveDlg.Free;
end;

procedure TfMain.btnAboutClick(Sender: TObject);
begin
//  fAbout := TfAbout.Create(Self);
//  fAbout.ShowModal;
//  fAbout.Free;
  TfAbout.Execute(Tester.TesterCaption);
end;

procedure TfMain.btnBeginSTAClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  SaveDlg := TSaveDialog.Create(nil);
  SaveDlg.Filter := 'Файлы статистики (*.STA)|*.STA|Все файлы (*.*)|*.*';
  SaveDlg.FilterIndex := 1;
  SaveDlg.DefaultExt := 'STA';
  SaveDlg.Options := SaveDlg.Options + [ofOverwritePrompt];
  if SaveDlg.Execute then
  begin
    MainData.BeginSTA(SaveDlg.FileName);
    (Sender as TButton).Enabled := False;
    btnEndSTA.Enabled := True;
    lblSTAFileName.Caption := ExtractFileName(SaveDlg.FileName);
//    ShowMessage('Файл статистики "' + SaveDlg.FileName + '" записан');
  end;

  SaveDlg.Free;
end;

procedure TfMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.btnCountersResetClick(Sender: TObject);
begin
  if Application.MessageBox('Вы уверены, что хотите сбросить значения счетчиков?',
    PWideChar('Тестер "' + Tester.TesterShortCaption + '"'), MB_OKCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDOK then
  begin
    Tester.ClearCounters;
    UpdateCounters;
  end;
end;

procedure TfMain.btnEndSTAClick(Sender: TObject);
begin
  MainData.EndSTA;
 (Sender as TButton).Enabled := False;
  btnBeginSTA.Enabled := True;
  lblSTAFileName.Caption := 'Запись не ведется';
end;

procedure TfMain.btnResetResultsClick(Sender: TObject);
begin
  if Application.MessageBox('Вы уверены, что хотите сбросить результаты замеров?',
    PWideChar('Тестер "' + Tester.TesterShortCaption + '"'), MB_OKCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDOK then
  begin
    MainData.tblAll.EmptyTable;
    MainData.tblCurrent.EmptyTable;
    Tester.ClearCounters;
    UpdateCounters;
  end;
end;

procedure TfMain.btnShowNormsClick(Sender: TObject);
begin
  TFile.WriteAllText(TPath.GetTempPath + 'NORMS.TXT', Tester.Norms);
  ShellExecute(0, 'open', PChar(TPath.GetTempPath + 'NORMS.TXT'), nil, '', SW_SHOWNORMAL);
end;

procedure TfMain.btnShowWPClick(Sender: TObject);
begin
  TFile.WriteAllText(TPath.GetTempPath + 'WP.TXT', Tester.WP);
  ShellExecute(0, 'open', PChar(TPath.GetTempPath + 'WP.TXT'), nil, '', SW_SHOWNORMAL);
end;

procedure TfMain.cbbMeasureModeChange(Sender: TObject);
begin
  ChangeMeasureMode(TComboBox(Sender).ItemIndex);
end;

procedure TfMain.cbbViewModeChange(Sender: TObject);
begin
  ChangeViewMode(TComboBox(Sender).ItemIndex);
end;

procedure TfMain.ChangeMeasureMode(const MeasureMode: Integer);
begin
  Tester.IgnoreBrak := (MeasureMode = 0);
end;

procedure TfMain.ChangeViewMode(const ViewMode: Integer);
begin
  pgcMeasure.ActivePageIndex := ViewMode;
end;

procedure TfMain.FillInfo(Text: String);
begin
  ValueListEditor1.Strings.Text := Text;

  lblWPFile.Caption := Format(lblWPFile.Caption, [IData.WPFile]);
  lblPlan.Caption   := Format(lblPlan.Caption,   [IData.PlanName]);
  lblFIO.Caption    := Format(lblFIO.Caption,    [IData.OperatorInfo.FIO]);
  lblTabN.Caption   := Format(lblTabN.Caption,   [IData.OperatorInfo.TAB_N]);
end;

procedure TfMain.FillViewMode;
var
  i: Byte;
begin
  cbbViewMode.Clear;
  for i := 0 to pgcMeasure.PageCount - 1 do
//  	if pgcMeasure.Pages[i].TabVisible then
	    cbbViewMode.Items.Append(pgcMeasure.Pages[i].Caption);

  cbbViewMode.ItemIndex := 0;
  ChangeViewMode(cbbViewMode.ItemIndex);
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Application.MessageBox('Вы уверены, что хотите прервать испытания и выйти?',
    PWideChar('Тестер "' + Tester.TesterShortCaption + '"'), MB_OKCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) = IDCANCEL then
  begin
    CanClose := false;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
	LoadRes;
  FillViewMode;
  ChangeMeasureMode(cbbMeasureMode.ItemIndex);
  pgcMeasure.ActivePageIndex := 0;
  pcLeft.ActivePageIndex     := 0;
//  UpdateCounters;

  { Сопоставить grid`ы с данными }
  grdCurrent.DataSource := MainData.dsCurrent;
  grdAll.DataSource := MainData.dsAll;

  isMeasured := False;

  Tester.OnMeasureResult := TesterOnMeasRes;
  Tester.OnProgramEnd := TesterOnProgramEnd;
  Tester.OnCommand := TesterOnCommand;
//  Tester.OnScriptEnd := TesterOnScriptEnd;

  Thread.Execute(Self);

  Caption := 'Тестер "' + Tester.TesterShortCaption + '"';
  if Tester.IO.DemoMode then
  begin
    Caption := Caption + ' (Режим имитации)';
    lblF5.Visible := True;
  end;
  if not Tester.UseFileNorm then
  begin
    btnShowNorms.Visible := False;
    btnSaveSTA.Visible := False;
//    tsAll.TabVisible := False;
    grdAll.Visible := False;
  end;

end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  MainData.EndSTA;
	PNG_GOOD.Free;
  PNG_BAD.Free;
  WMF_GOOD.Free;
  WMF_BAD.Free;
end;

procedure TfMain.grdAllGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if (not MainData.tblAll.FieldByName('Good').AsBoolean) and
     (MainData.tblAll.Fields[0].AsString <> '')  then
  begin
    Background := clMaroon;
    AFont.Color := clWhite;
  end;

//  if Column.FieldName = 'Val' then
//    AFont.Style := [fsBold];
end;

procedure TfMain.grdCurrentGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if (not MainData.tblCurrent.FieldByName('Good').AsBoolean) and
     (MainData.tblCurrent.Fields[0].AsString <> '') and
     (Column.FieldName = 'Val')  then
  begin
    Background := clMaroon;
    AFont.Color := clWhite;
    AFont.Style := [fsBold];
  end;

  if (Column.FieldName = 'Title') or
	   (Column.FieldName = 'Val')
  then
    AFont.Style := [fsBold];
end;

procedure TfMain.ThreadExecute(Sender: TObject; Params: Pointer);
begin
  repeat
    Sleep(TRA_Delay);
    if Tester.IO.TRA then
      Thread.Synchronize(TfMain(Params).StartMeasureFromThread);
  until Thread.Terminated;
end;

procedure TfMain.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  if Tester.IO.TRA then
		StartMeasure(True);
  Timer.Enabled := True;
end;

procedure TfMain.LoadRes;
  procedure LoadWMFFromResourceName(WMF: TMetafile; Instance: HInst;
    const Name: String);
  var
    ResStream: TResourceStream;
  begin
    {Creates an especial stream to load from the resource}
    try
      ResStream := TResourceStream.Create(Instance, Name, RT_RCDATA);
    except
      Exit;
    end;

    {Loads the png image from the resource}
    try
      WMF.LoadFromStream(ResStream);
    finally
      ResStream.Free;
    end;
  end;
begin
  PNG_GOOD := TPngImage.Create;
  PNG_BAD  := TPngImage.Create;
  PNG_GOOD.LoadFromResourceName(HInstance, 'IMG_GOOD');
  PNG_BAD.LoadFromResourceName(HInstance, 'IMG_BAD');

  WMF_GOOD := TMetafile.Create;
  WMF_BAD  := TMetafile.Create;
  LoadWMFFromResourceName(WMF_BAD, HInstance, 'IMG_BAD_WMF');
  LoadWMFFromResourceName(WMF_GOOD, HInstance, 'IMG_GOOD_WMF');
end;

procedure TfMain.StartMeasure(FromThread: Boolean);
var
  SW: TStopWatch;
begin
  isMeasured := True;

//  if not FromThread then
//  MainData.dsCurrent.DataSet.DisableControls;
//  MainData.dsAll.DataSet.DisableControls;

  MainData.tblCurrent.EmptyTable;

  PD.Position := 0;
  PD.Max := maxtst;
  PD.Show;
 	fMain.Enabled := False;
  SW := TStopWatch.Create(True);
  try
    Tester.Measure;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  SW.Stop;
  StatusBar.Panels[1].Text := SW.ElapsedMilliseconds.ToString + ' мс';
  SW.Free;

 	fMain.Enabled := True;
  PD.Hide;

  UpdateCounters;

//  if not FromThread then
//  MainData.dsCurrent.DataSet.EnableControls;
//  MainData.dsAll.DataSet.DisableControls;

  isMeasured := False;
end;

procedure TfMain.StartMeasureFromThread;
begin
//  fMain.Enabled := False;
  StartMeasure(True);
//  fMain.Enabled := True;
end;

procedure TfMain.TesterOnCommand(Sender: TObject; CommandName: string);
begin
  case StrIndex(CommandName, ['PROGRAMMA', 'ENDPROGRAM', 'TEST']) of
    0 : { 'PROOGRAMMA' }
      begin
        MainData.dsAll.DataSet.Append;
        MainData.dsAll.DataSet.FieldValues['N'] := Tester.Counters[PLAN, 18];
      end;
    1 : { 'ENDPROGRAM' }
      begin
        MainData.dsAll.DataSet.Post;
        MainData.WriteMeasure(MainData.tblAll.RecordCount, MainData.STAWriter);
      end;
    2 : { 'TEST' }
      begin
      end;
  end;
end;

{$IFDEF INEJ}
procedure TfMain.TesterOnMeasRes(Sender: TObject; Defect: Boolean; MResult: TInejResult);
{$ENDIF}
{$IFDEF ISTINA}
procedure TfMain.TesterOnMeasRes(Sender: TObject; Defect: Boolean; MResult: TIstinaResult);
{$ENDIF}
var
  i: Integer;
begin
  with MResult do
  begin
    with MainData.tblCurrent do
    begin
      Append;
//        if Tester.IO.DemoMode then
//        begin
//          Val := limx[1, TestNo, 1]*1.02 + Random * (limx[1, TestNo, 2]*1.02 - limx[1, TestNo, 1]*1.02);
//          Defect := (Val > limx[1, TestNo, 1]) and (Val < limx[1, TestNo, 1]);
//        end;

        FieldByName('N').AsInteger := TestNo;
        FieldByName('Title').AsString := TestName;
        {$IFDEF ISTINA}
        FieldByName('Pin').AsInteger := PinNo;
        {$ENDIF}
        FieldByName('Val').AsFloat := Val;
        FieldByName('Units').AsString := Units;
        FieldByName('Good').AsBoolean := not Defect;

        for i := 1 to maxgrp do
        begin
          FieldByName('Group_'+IntToStr(i)+'_L').AsFloat := limx[i, TestNo, 1];
          FieldByName('Group_'+IntToStr(i)+'_H').AsFloat := limx[i, TestNo, 2];
        end;

      Post;
    end;

    if Tester.UseFileNorm then
      if MainData.dsAll.State in [dsEdit, dsInsert]  then
      begin
        MainData.dsAll.DataSet.FieldByName('Test_'+IntToStr(TestNo)).AsFloat := Val;
      end;

    PD.Position := TestNo;
    PD.Text := Format('Выполняется тест №%d из %d', [TestNo, maxtst]);
//    grdCurrent.Repaint;
//    grdAll.Repaint;

    if Tester.IO.DemoMode then
      Sleep(Demo_Delay);
  end;
end;

procedure TfMain.TesterOnProgramEnd(Sender: TObject; GroupN: Byte;
  Defect: Boolean);
begin
  if MainData.dsAll.State in [dsEdit, dsInsert]  then
  begin
    MainData.dsAll.DataSet.FieldByName('Good').AsBoolean := not Defect;
    MainData.dsAll.DataSet.FieldByName('Group').AsInteger := GroupN;
  end;

  if Defect then
  begin
    imgStatus.Picture.Graphic := WMF_BAD;
    StatusBar.Panels[2].Text :='Прибор №' + IntToStr(Tester.Counters[PLAN, 18]) + ' - Брак';
    lblStatus.Font.Color := clMaroon;
    lblStatus.Caption := 'БРАК';
  end
  else
  begin
    imgStatus.Picture.Graphic := WMF_GOOD;
    StatusBar.Panels[2].Text :='Прибор №' + IntToStr(Tester.Counters[PLAN, 18]) + ' - Годен';
    lblStatus.Font.Color := clGreen;
    lblStatus.Caption := 'ГОДЕН';
  end;
end;

procedure TfMain.TesterOnScriptEnd(Sender: TObject);
begin
//  Tester.ResetTester;
//  SW.Stop;
//  StatusBar.Panels[1].Text := SW.ElapsedMilliseconds.ToString + ' мс';
//  SW.Free;
	fMain.Enabled := True;
  PD.Hide;

  UpdateCounters;

//  if not FromThread then
//    MainData.dsCurrent.DataSet.EnableControls;

  isMeasured := False;
end;

procedure TfMain.UpdateCounters;
const
  CaptionTemplate = '<align="center">(0)<br>(1)<br>(2)<br>(3)<br>(4)<br>(5)<br>(6)<br>'+
                    '<font color=#0000FF>(7)</font><br>' +
                    '(8)<br>(9)<br>(10)<br>(11)<br>(12)<br>(13)<br>(14)<br>(15)<br><br><b>' +
                    '<font color=#007F00>(16)</font><br>'+
                    '<font color=#0000FF>(17)</font><br>'+
                    '</b></align>';
  PercentTemplate = '<align="center">(0)<br>(1)<br>(2)<br>(3)<br>(4)<br>(5)<br>(6)<br>'+
                    '<font color=#0000FF>(7)</font><br>' +
                    '(8)<br>(9)<br>(10)<br>(11)<br>(12)<br>(13)<br>(14)<br>(15)<br><br><b>' +
                    '<font color=#007F00>(16)</font><br>'+
                    '<font color=#0000FF>(17)</font><br>'+
                    '</b></align>';
var
  i: Byte;
  CaptionS: String;
begin
  CaptionS := CaptionTemplate;
  for i := 0 to 17 do
    CaptionS := StringReplace(CaptionS, '('+IntToStr(i) +')', IntToStr(Tester.Counters[PLAN, i]), [rfReplaceAll]);
  lblCounters.Caption := CaptionS;

  lblCountersAll.Caption :=  IntToStr(Tester.Counters[PLAN, 18]);

  if Tester.Counters[PLAN, 18] <> 0 then
 	begin
    CaptionS := PercentTemplate;
    for i := 0 to 17 do
      CaptionS := StringReplace(CaptionS, '('+IntToStr(i) +')', Format('%.0f%%', [(Tester.Counters[PLAN, i] / Tester.Counters[PLAN, 18]{Всего})*100]), [rfReplaceAll]);
    lblPercents.Caption := CaptionS;
  end
  else
  begin
    CaptionS := PercentTemplate;
    for i := 0 to 17 do
      CaptionS := StringReplace(CaptionS, '(' + IntToStr(i) + ')', '0%', [rfReplaceAll]);
    lblPercents.Caption := CaptionS;
  end;

end;

end.
