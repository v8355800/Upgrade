unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Forms, Vcl.StdCtrls, Vcl.Controls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.Classes;

type
  TfrmLogin = class(TForm)
    cmbLogin: TComboBox;
    edtPassword: TEdit;
    btnLogin: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure FillUsersList(List: TStrings);
    function CheckPassword(const Login, Tabl_N, Password: string): Boolean;
    procedure SetTimeStamp(const ID: Integer);
  public
    { Public declarations }
    class function Execute: Boolean;
  end;

//var
//  frmLogin: TfrmLogin;

implementation

//{$R 'SQLResources.res' 'SQL\SQLResources.rc'}

uses
  System.SysUtils,
  uData,
  uDBData,
  pFIBQuery,
  pFIBProps;

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  S: string;
  FIO, TablN: string;
begin
  // Пользователь не выбран
  if cmbLogin.ItemIndex = -1 then
  begin
    SendMessage(cmbLogin.Handle, CB_SHOWDROPDOWN, 1, 0);
    Exit;
  end;

  S := cmbLogin.Items[cmbLogin.ItemIndex];
  FIO := Copy(S, Length(S) + 1 - (Length(S)-16), Length(S)-16);
  TablN := Copy(S,10,5);
  if CheckPassword(FIO, TablN, edtPassword.Text) = True then
  begin
    IData.OperatorInfo.FIO := FIO;
    IData.OperatorInfo.TAB_N := TablN;
    ModalResult := mrOk;
  end;
end;

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

function TfrmLogin.CheckPassword(const Login, Tabl_N, Password: string): Boolean;
var
  Query: TpFIBQuery;
begin
  Result := False;

  Query := TpFIBQuery.Create(nil);
  with Query do
  try
    Database := DBData.DB;
    Transaction := DBData.DB.DefaultTransaction;
    Options := [qoStartTransaction];
    SQL.Text := DBData.LoadSqlResource('GetPass');
    ParamByName('FIO').AsString := Login;
    ParamByName('TABL_N').AsString := Tabl_N;
    ExecQuery;
    if RecordCount = 0 then
      Application.MessageBox('Такого пользователя не существует', 'Аутентификация', MB_ICONINFORMATION)
    else
    begin
      if CompareStr(FieldByName('PASS').AsString, Password) = 0 then
      begin
        Result := True;
        SetTimeStamp(FieldByName('ID').AsInteger);
      end
      else
        Application.MessageBox('Пароль не верный', 'Аутентификация', MB_ICONERROR)
    end;
  finally
    Query.Free;
  end;
end;

class function TfrmLogin.Execute: Boolean;
begin
  with TfrmLogin.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  FillUsersList(cmbLogin.Items);
end;

procedure TfrmLogin.SetTimeStamp(const ID: Integer);
var
  Query: TpFIBQuery;
begin
  Query := TpFIBQuery.Create(nil);
  with Query do
  try
    Database := DBData.DB;
    Transaction := DBData.DB.DefaultTransaction;
    Options := [qoStartTransaction,qoAutoCommit];
    SQL.Text := DBData.LoadSqlResource('UpdateTimeStamp');
    ParamByName('ID').AsInteger := ID;
    ParamByName('LAST_TIME').AsTimeStamp := DateTimeToTimeStamp(Now);
    ExecQuery;
  finally
    Query.Free;
  end;
end;

procedure TfrmLogin.FillUsersList(List: TStrings);
var
  Query: TpFIBQuery;
begin
  List.Clear;

  Query := TpFIBQuery.Create(nil);
  with Query do
  try
    Database := DBData.DB;
    Transaction := DBData.DB.DefaultTransaction;
    Options := [qoStartTransaction];
    SQL.Text := DBData.LoadSqlResource('UsersList');
    ExecQuery;
    repeat
      List.Append('(Таб. №: ' + FieldByName('tabl_n').AsString + ') ' + FieldByName('fio').AsString);
      Next;
    until Eof;
  finally
    Query.Free;
  end;
end;

end.
