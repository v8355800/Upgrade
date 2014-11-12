unit uData;

interface

uses
{$IFDEF INEJ}
	TESTER_INEJ,
{$ENDIF}
{$IFDEF ISTINA}
  TESTER_ISTINA,
{$ENDIF}
  System.SysUtils, System.Classes, MemTableDataEh, Data.DB, MemTableEh,
  Vcl.Dialogs, DBGridEh, PropStorageEh;

type
  { Информация о операторе }
  TOperatorInfoRec = record
    FIO,            // ФИО
    TAB_N: string;  // Табельный номер
  end;

  { Входные данные }
  TInputDataRec = record
    OperatorInfo : TOperatorInfoRec;
    CRC32, MD5   : string;
    WPFile       : string;
    PlanName     : string;
    PlanNumber   : Integer;
  end;

type
  TMainData = class(TDataModule)
    tblAll: TMemTableEh;
    tblCurrent: TMemTableEh;
    dsAll: TDataSource;
    dsCurrent: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure WriteSTAHeader(Stream: TStreamWriter);
  public
    STAWriter: TStreamWriter;
    { Public declarations }
    procedure CreateStructureTableAll;
    procedure CreateStructureTableCurrent;

    procedure WriteSTA(const FileName: String);
    procedure BeginSTA(const FileName: String);
    procedure EndSTA;
//    procedure WriteLastMeasure(Stream: TStreamWriter);
    procedure WriteMeasure(MeasureNumber: Cardinal; Stream: TStreamWriter);
  end;

var
  MainData: TMainData;
  INI: TIniPropStorageManEh;
  IData: TInputDataRec;
{$IFDEF INEJ}
	Tester: TInej;
{$ENDIF}
{$IFDEF ISTINA}
	Tester: TIstina;
{$ENDIF}


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.Variants,
  System.IOUtils,
{$IFDEF INEJ}
//  TESTER_INEJ,
  TESTER_INEJ_GLOBAL;
{$ENDIF}

{$IFDEF ISTINA}
//  TESTER_ISTINA,
  TESTER_ISTINA_GLOBAL;
{$ENDIF}


procedure TMainData.BeginSTA(const FileName: String);
begin
  if Assigned(STAWriter) then
  begin
    STAWriter.Close;
    FreeAndNil(STAWriter);
  end;

  STAWriter := TStreamWriter.Create(FileName, False, TEncoding.ANSI);
  STAWriter.AutoFlush := True;
  STAWriter.NewLine := sLineBreak;
  STAWriter.WriteLine('Начало записи: ' + DateTimeToStr(Now));
  STAWriter.WriteLine;
  WriteSTAHeader(STAWriter);
end;

procedure TMainData.CreateStructureTableAll;
var
  i: Integer;
begin
  if tblAll.Active then
    tblAll.Close;

  tblAll.Fields.Clear;

  with TIntegerField.Create(tblAll) do
  begin
    FieldName := 'N';
    DisplayLabel := '№';
    DisplayWidth := 5;
    DataSet := tblAll;
  end;

  with TBooleanField.Create(tblAll) do
  begin
    FieldName := 'Good';
    DisplayLabel := 'Г/Б';
    Alignment := taCenter;
    DisplayWidth := 5;
    DataSet := tblAll;
  end;

  with TIntegerField.Create(tblAll) do
  begin
    FieldName := 'Group';
    DisplayLabel := 'Группа';
    Alignment := taCenter;
    DisplayWidth := 10;
    DataSet := tblAll;
//    Visible := False;
  end;

  for i := 1 to maxtst do
    with TFloatField.Create(tblAll) do
    begin
      FieldName := 'Test_'+ IntToStr(i);
      Precision := 3;
      DisplayFormat := '0.000';

      {$IFDEF INEJ}
        if Trim(tsun[i]) <> '' then
          DisplayLabel := Format('%s'+#13#10+'(%s)', [Trim(tsnam[i]), tsun[i]])
        else
          DisplayLabel := Format('%s', [Trim(tsnam[i])]);
      {$ENDIF}

      {$IFDEF ISTINA}
        if Trim(tsun[i]) <> '' then
          DisplayLabel := Format('%s'+#13#10+'(%s)'+#13#10#13#10+'№%d', [Trim(tsnam[i]), tsun[i], pnno[i]])
        else
          DisplayLabel := Format('%s'+#13#10#13#10#13#10+'№%d', [Trim(tsnam[i]), pnno[i]]);
      {$ENDIF}

      DisplayWidth := 8;
      DataSet := tblAll;
    end;

  tblAll.CreateDataSet;
end;

procedure TMainData.CreateStructureTableCurrent;
var
  i: Integer;
begin
  if tblCurrent.Active then
    tblCurrent.Close;

  tblCurrent.Fields.Clear;

  with TIntegerField.Create(tblCurrent) do
  begin
    FieldName := 'N';
    DisplayLabel := '№';
    DisplayWidth := 5;
    DataSet := tblCurrent;
  end;

  with TStringField.Create(tblCurrent) do
  begin
    FieldName := 'Title';
    DisplayLabel := 'Параметр';
    Alignment := taCenter;
    DisplayWidth := 15;
    DataSet := tblCurrent;
  end;

  {$IFDEF ISTINA}
  with TIntegerField.Create(tblCurrent) do
  begin
    FieldName := 'Pin';
    DisplayLabel := '№'+#13#10+'вывода';
    Alignment := taCenter;
    DisplayWidth := 10;
    DataSet := tblCurrent;
  end;
  {$ENDIF}

  for i := 1 to maxgrp do
  begin
    with TFloatField.Create(tblCurrent) do
    begin
      FieldName := 'Group_'+IntToStr(i)+'_L';
      Precision := 3;
      DisplayFormat := '0.000';
      if Trim(grpmsg[i]) = '' then
        DisplayLabel := 'Группа ' + IntToStr(i) + '|Н.норма'
      else
        DisplayLabel := grpmsg[i] + '|Н.норма';
      DisplayWidth := 15;
      DataSet := tblCurrent;
    end;

    with TFloatField.Create(tblCurrent) do
    begin
      FieldName := 'Group_'+IntToStr(i)+'_H';
      Precision := 3;
      DisplayFormat := '0.000';
      if Trim(grpmsg[i]) = '' then
        DisplayLabel := 'Группа ' + IntToStr(i) + '|В.норма'
      else
        DisplayLabel := grpmsg[i] + '|В.норма';
      DisplayWidth := 15;
      DataSet := tblCurrent;
    end;
  end;

  with TFloatField.Create(tblCurrent) do
  begin
    FieldName := 'Val';

    Alignment := taCenter;
    Precision := 3;
    DisplayFormat := '0.000';
    DisplayLabel := 'Значение';
    DisplayWidth := 20;
    DataSet := tblCurrent;
  end;

  with TStringField.Create(tblCurrent) do
  begin
    FieldName := 'Units';
    Alignment := taCenter;
    DisplayLabel := 'Ед. изм.';
    DisplayWidth := 10;
    DataSet := tblCurrent;
  end;

//  with TStringField.Create(tblCurrent) do
//  begin
//    FieldName := 'Comparator';
//    DisplayLabel := 'Ед. изм.';
//    DisplayWidth := 10;
//    DataSet := tblCurrent;
//  end;

  with TBooleanField.Create(tblCurrent) do
  begin
    FieldName := 'Good';
    DisplayLabel := 'Г/Б';
    Alignment := taCenter;
    DisplayWidth := 5;
    DataSet := tblCurrent;
  end;

  tblCurrent.CreateDataSet;
end;

procedure TMainData.DataModuleCreate(Sender: TObject);
begin
  {$IFDEF INEJ}
  Tester := TInej.Create(nil);
  {$ENDIF}
  {$IFDEF ISTINA}
  Tester := TIstina.Create(nil);
  {$ENDIF}
	Tester.InitScriptEngine(@Tester);
end;

procedure TMainData.EndSTA;
begin
  if not Assigned(STAWriter) then
    Exit;

  STAWriter.WriteLine;
  STAWriter.WriteLine('Конец записи: ' + DateTimeToStr(Now));

  STAWriter.Close;
  FreeAndNil(STAWriter);
end;

procedure TMainData.WriteMeasure(MeasureNumber: Cardinal; Stream: TStreamWriter);
var
  i: Integer;
  V: Variant;
begin
  if not Assigned(Stream) then
    Exit;

  if Tester.UseFileNorm then
  begin
    for i := tblAll.FieldByName('Test_1').Index to tblAll.Fields.Count - 1 do
    begin
      V := tblAll.RecordsView.MemTableData.RecordsList[MeasureNumber-1].DataValues[tblAll.Fields[i].FieldName, dvvValueEh];
      if not VarIsNull(V) then
        Stream.Write(#9 + FormatFloat('0.000', V) );
    end;
  end
  else
  begin
    for i := 0 to tblCurrent.RecordCount - 1 do
    begin
      V := tblCurrent.RecordsView.MemTableData.RecordsList[i].DataValues['Val', dvvValueEh];
      if not VarIsNull(V) then
        Stream.Write(#9 + FormatFloat('0.000', V) );
    end;
  end;
  Stream.WriteLine;
end;

procedure TMainData.WriteSTA(const FileName: String);
var
  i: Integer;
  Stream: TStreamWriter;
begin
  Stream := TStreamWriter.Create(FileName, False, TEncoding.ANSI);
  WriteSTAHeader(Stream);
  { Результаты замера по каждому тесту }
  for i := 1 to tblAll.RecordsView.MemTableData.RecordsList.Count do
    WriteMeasure(i, Stream);
  Stream.Close;
  Stream.Free;
end;

procedure TMainData.WriteSTAHeader(Stream: TStreamWriter);
var
  i: Cardinal;
begin
  if not Assigned(Stream) then
    Exit;

  with Stream do
  begin
    WriteLine('Нормы');
    { Название тестов }
    for i := 1 to maxtst do
      Write(#9 + tsnam[i]);

    WriteLine;
    { Ед. изм. }
    for i := 1 to maxtst do
      Write(#9 + tsun[i]);

    WriteLine;
	  { печать строчки нижних норм }
	  if not Tester.UseFileNorm then
     for i:=1 to maxtst do
       Write(#9 + FormatFloat('0.000', lim[i,1]))
    else
     for i:=1 to maxtst do
       Write(#9 + FormatFloat('0.000', limx[1,i,1]));

    WriteLine;
	  { печать строчки верхних норм }
	  if not Tester.UseFileNorm then
     for i:=1 to maxtst do
       Write(#9 + FormatFloat('0.000', lim[i,2]))
    else
     for i:=1 to maxtst do
       Write(#9 + FormatFloat('0.000', limx[1,i,2]));
    WriteLine;
    WriteLine;
    WriteLine('Значения');
  end;
end;

initialization
  INI := TIniPropStorageManEh.Create(nil);
  INI.IniFileName := ChangeFileExt( ParamStr(0), '.ini' );
  SetDefaultPropStorageManager(INI);

end.
