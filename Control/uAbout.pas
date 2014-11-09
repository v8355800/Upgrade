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
    Image1: TImage;
    procedure btnOKClick(Sender: TObject);

  private
    { Private declarations }
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

procedure TfAbout.btnOKClick(Sender: TObject);
begin
  Close;
end;

end.
