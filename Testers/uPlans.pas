unit uPlans;

interface

uses
  System.Classes,
  System.Generics.Collections;

const
  Pass = '1';

type
  TPlan = class
  public
    Caption: String;
    WPFile: string;
    NormFile: string;
    constructor Create(Caption, WP, Norm: string);
  end;

  TPlans = class(TObjectList<TPlan>)
  private
    fInfo: String;
  public
    function IsValidWPFile(const FileName, FileSignature: String): Boolean;
    function LoadFromFile(const FileName: String): Boolean;
    procedure Fill(Items: TStrings);

    property Info: string read fInfo write fInfo;
  end;

var
  Plans: TPlans;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs,  
  ZipForge;

{ TPlan }

constructor TPlan.Create(Caption, WP, Norm: string);
begin
  Self.Caption := Caption;
  WPFile := WP;
  NormFile := Norm;
end;

{ TPlans }

procedure TPlans.Fill(Items: TStrings);
var
  i: Integer;
begin
  if (Count = 0) and (not Assigned(Items)) then
    Exit;

  Items.Clear;
  for i := 1 to Count do
    Items.Add(IntToStr(i) + '. ' + Self.Items[i-1].Caption);
end;

function TPlans.IsValidWPFile(const FileName, FileSignature: String): Boolean;
var
  Archiver: TZipForge;
  ArchiveItem: TZFArchiveItem;
begin
  // Проверка на существование файла
  if not FileExists(FileName) then
    Exit(False);

  // Проверка на битый архив
  Archiver := TZipForge.Create(nil);
  Archiver.FileName := FileName;
  Archiver.Password := Pass;

  if not Archiver.IsValidArchiveFile then
    Exit(False);

  Archiver.OpenArchive(fmOpenRead);
  Result := Archiver.FindFirst(FileSignature, ArchiveItem, faAnyFile - faDirectory);
  Archiver.CloseArchive;

  Archiver.Free;
end;

function TPlans.LoadFromFile(const FileName: String): Boolean;
var
  Archiver: TZipForge;
  ArchiveItem: TZFArchiveItem;

  S, S1, S2: String;
  Lines: TStringList;
  Line: String;
  SplitLine: TArray<String>;
begin
//	if not IsValidWPFile(FileName) then
//  	Exit;
  Result := True;

  Self.Clear;
//  Plans.Clear;

	Archiver := TZipForge.Create(nil);
  try
    Archiver.Password := Pass;
    Archiver.FileName := FileName;
    Archiver.OpenArchive;
    { Описание РП }
    Archiver. ExtractToString('INFO.TXT', fInfo);

    { Информация о планах классификации }
    Archiver.ExtractToString('PLANS.TXT', S);
    Lines := TStringList.Create;
    Lines.Text := S;
    for Line in Lines do
    begin
      SplitLine := Line.Split([#9]);

      try
        Archiver.ExtractToString(SplitLine[1] + '.pas', S1);                        // Рабочая программа
        Archiver.ExtractToString(SplitLine[2] + '.nrm', S2);                        // Нормы

        Plans.Add( TPlan.Create(SplitLine[0], S1, S2) );
      except
        {$IFDEF CONSOLE}
          writeln('Ошибка в плане: "', SplitLine[0], '"!');
        {$ELSE}
          MessageDlg('Ошибка в плане: "' + SplitLine[0] + '"!', mtError, [mbOk], 0);  
        {$ENDIF}      
        Result := False;
      end;
    end;
    Lines.Free;

	  Archiver.CloseArchive;
  except
    on E: Exception do
    begin
      {$IFDEF CONSOLE}
        writeln('Error: ', E.Message);
      {$ELSE}
        ShowMessage('Error: ' + E.Message);
      {$ENDIF}      
      Result := False;
    end;
  end;
  Archiver.Free;
end;

end.
