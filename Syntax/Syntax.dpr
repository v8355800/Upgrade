program Syntax;

{$APPTYPE CONSOLE}

{$DEFINE INEJ}

{$R *.res}

uses
  Console,
  System.SysUtils,
  System.IOUtils,
  TESTER_BASE in '..\Testers\TESTER_BASE.pas',
  TESTER_ISTINA in '..\Testers\Истина\TESTER_ISTINA.pas',
  TESTER_INEJ in '..\Testers\Иней\TESTER_INEJ.pas',
  TESTER_ISTINA_IO in '..\Testers\Истина\TESTER_ISTINA_IO.pas';

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

//        Tester.WP := TFile.ReadAllText(ParamStr(1));
        if Tester.CompileWP then
          WriteLn('Ошибок не найдено');

      end;
    Tester.Free;

    Writeln;
    Writeln('Нажмите любую клавишу для выхода...');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.