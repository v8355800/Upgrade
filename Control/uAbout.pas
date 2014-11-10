unit uAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TfAbout = class(TForm)
    btnOK: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    imgTester: TImage;
    procedure btnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    PNG_INEJ, PNG_ISTINA: TPngImage;
  public
    { Public declarations }
    class function Execute(const TesterCaption: string): Boolean;
  end;

//var
//  fAbout: TfAbout;

implementation

{$R *.dfm}

class function TfAbout.Execute(const TesterCaption: string): Boolean;
begin
  with TfAbout.Create(nil) do
  try
    Label2.Caption := TesterCaption + #13#10#13#10'”правл€юща€ программа';
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfAbout.FormCreate(Sender: TObject);
begin
  PNG_INEJ   := TPngImage.Create;
  PNG_ISTINA := TPngImage.Create;
  PNG_INEJ.LoadFromResourceName(HInstance, 'IMG_INEJ_BIG');
  PNG_ISTINA.LoadFromResourceName(HInstance, 'IMG_ISTINA_BIG');

  {$IFDEF INEJ}
  imgTester.Picture.Graphic := PNG_INEJ;
  {$ENDIF}

  {$IFDEF ISTINA}
  imgTester.Picture.Graphic := PNG_ISTINA;
  {$ENDIF}
end;

procedure TfAbout.FormDestroy(Sender: TObject);
begin
  PNG_INEJ.Free;
  PNG_ISTINA.Free;
end;

procedure TfAbout.btnOKClick(Sender: TObject);
begin
  Close;
end;

end.
