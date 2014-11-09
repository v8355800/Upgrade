program Editor;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uPlans in '..\Testers\uPlans.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
