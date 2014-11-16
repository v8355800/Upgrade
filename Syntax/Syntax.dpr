program Syntax;

{$APPTYPE CONSOLE}

{$DEFINE INEJ}

{$R *.res}

uses
  Console,
  System.SysUtils,
  System.IOUtils,
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

var
  Tester: TCustomTester;

procedure WriteAtCenter(const Text: String);
begin
	GotoXY((ScreenWidth-Length(Text)) div 2, WhereY);
  Writeln(Text);
end;

procedure WriteHeader;
begin
	TextColor(Green);
  WriteAtCenter(StringReplace(Tester.TesterCaption, #13#10, ' ', [rfReplaceAll]));
  WriteAtCenter(QuotedStr(Tester.TesterShortCaption));
  Writeln;
  WriteAtCenter('Проверка синтаксиса РП');
  WriteAtCenter('ЗАО "НТЦ Схемотехники и Интегральных технологий"');
  Writeln;
  NormVideo;
end;

begin
  try
    {$IFDEF INEJ}
    Tester := TInej.Create(nil);
    {$ENDIF}
    {$IFDEF ISTINA}
    Tester := TIstina.Create(nil);
    {$ENDIF}
    Tester_Inej := TInej.Create(nil);
    Tester_Istina := TIstina.Create(nil);

    ClrScr;
    WriteHeader;
  	if ParamCount = 0 then
    begin
//    	TextColor(Red); Writeln('Недостаточно параметров для запуска !'#13#10);
//      TextColor(LightGray);
      Writeln('Синтаксис: '+ ExtractFileName(ParamStr(0)) + ' [Файл]');
      Writeln('           [Файл] - Файл Рабочей программы (РП)');
    end
  	else
      if not FileExists(ParamStr(1)) then
        Writeln('Файл "', ParamStr(1), '" не найден !')
      else
      begin
        Tester.InitScriptEngine(@Tester);
        Tester.GetWPFromFile(ParamStr(1));
        if Tester.CompileWP then
          WriteLn('Ошибок не найдено');
      end;
    Tester.Free;
    Tester_Inej.Free;

    Writeln;
    Writeln('Нажмите любую клавишу для выхода...');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.