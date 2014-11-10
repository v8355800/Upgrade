unit uDBData;

interface

uses
  System.SysUtils, System.Variants, PropFilerEh, PropStorageEh, FIBDatabase,
  pFIBDatabase, System.Classes;

type
  TDBData = class(TDataModule)
    DB: TpFIBDatabase;
    Transaction: TpFIBTransaction;
    PropStorage: TPropStorageEh;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure ConnetToDatabase;
  public
    { Public declarations }
    function LoadSqlResource(resourceName: string): string;
  end;

var
  DBData: TDBData;
//  IData: TInputDataRec;

implementation

{$R *.dfm}
//{$R 'SQLResources.res' 'SQL\SQLResources.rc'}

uses
  System.Types,
  Vcl.Dialogs,
  FIB;


function TDBData.LoadSqlResource(resourceName: string): string;
var
  rs: TResourceStream;
  sl: TStringList;
  s : string;
begin
    sl := TStringList.Create;
  try
    rs := TResourceStream.Create(hinstance, resourceName, RT_RCDATA);
  try
    rs.Position := 0;
    sl.LoadFromStream(rs);
    Result := sl.Text;
  finally
    rs.Free;
  end;
  finally
    sl.Free;
  end;
end;


procedure TDBData.ConnetToDatabase;
begin
  try
    DB.Open(True);
  except
    on e: EFIBError do
    begin
      MessageDlg('Не удается подключится к "Базе Данных"!',  mtWarning, [mbOK], 0);
      PropStorage.SaveProperties;
      Halt;
    end;
  end;
end;


procedure TDBData.DataModuleCreate(Sender: TObject);
begin
  PropStorage.LoadProperties;

  ConnetToDatabase;
end;

procedure TDBData.DataModuleDestroy(Sender: TObject);
begin
  PropStorage.SaveProperties;
end;

end.
