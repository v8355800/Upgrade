unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvMemo, Vcl.StdCtrls, AdvmPS;

type
  TfMain = class(TForm)
    ListBox1: TListBox;
    Memo: TAdvMemo;
    PascalMemoStyler: TAdvPascalMemoStyler;
    procedure MemoFileDrop(Sender: TObject; FileName: string;
      var DefaultHandler: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.MemoFileDrop(Sender: TObject; FileName: string;
  var DefaultHandler: Boolean);
begin
	Self.Caption := 'Проверка синтаксиса - ' + FileName;
end;

end.
