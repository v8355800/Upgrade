unit uMain;

{$DEFINE INEJ}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, Vcl.ComCtrls, JvExStdCtrls, JvGroupBox, uPlans;

type
//	TPlan = class
//    Caption: String;
//    WP: string;
//    Norms: string;
//    constructor Create;
//  end;
//  TPLans = TObjectList<TPlan>;

  TEditor = class(TObject)
  private
  	fPlans: TPlans;
    fInfo: String;
    fFileName: string;
    fSign: string;

    procedure EmptyList;
  protected
  	procedure New;
    procedure Load(const FileName: String);
    procedure Save(const FileName: String);

  public
    constructor Create;
    destructor Destroy; override;

  end;

type
  TForm1 = class(TForm)
    GroupBox2: TGroupBox;
    mmoInfo: TMemo;
    GroupBox3: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    edtP1_Title: TEdit;
    edtP2_Title: TEdit;
    edtP3_Title: TEdit;
    edtP4_Title: TEdit;
    edtP5_Title: TEdit;
    edtP6_Title: TEdit;
    edtP7_Title: TEdit;
    edtP8_Title: TEdit;
    edtP9_Title: TEdit;
    edtP10_Title: TEdit;
    edtP11_Title: TEdit;
    edtP12_Title: TEdit;
    edtP13_Title: TEdit;
    edtP14_Title: TEdit;
    edtP15_Title: TEdit;
    edtP1_WP: TJvFilenameEdit;
    edtP2_WP: TJvFilenameEdit;
    edtP3_WP: TJvFilenameEdit;
    edtP4_WP: TJvFilenameEdit;
    edtP5_WP: TJvFilenameEdit;
    edtP6_WP: TJvFilenameEdit;
    edtP7_WP: TJvFilenameEdit;
    edtP8_WP: TJvFilenameEdit;
    edtP9_WP: TJvFilenameEdit;
    edtP10_WP: TJvFilenameEdit;
    edtP11_WP: TJvFilenameEdit;
    edtP12_WP: TJvFilenameEdit;
    edtP13_WP: TJvFilenameEdit;
    edtP14_WP: TJvFilenameEdit;
    edtP15_WP: TJvFilenameEdit;
    edtP1_Norms: TJvFilenameEdit;
    edtP2_Norms: TJvFilenameEdit;
    edtP3_Norms: TJvFilenameEdit;
    edtP4_Norms: TJvFilenameEdit;
    edtP5_Norms: TJvFilenameEdit;
    edtP6_Norms: TJvFilenameEdit;
    edtP7_Norms: TJvFilenameEdit;
    edtP8_Norms: TJvFilenameEdit;
    edtP9_Norms: TJvFilenameEdit;
    edtP10_Norms: TJvFilenameEdit;
    edtP11_Norms: TJvFilenameEdit;
    edtP12_Norms: TJvFilenameEdit;
    edtP13_Norms: TJvFilenameEdit;
    edtP14_Norms: TJvFilenameEdit;
    edtP15_Norms: TJvFilenameEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnSave: TButton;
    btnExit: TButton;
    btnNew: TButton;
    btnOpen: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure mmoInfoChange(Sender: TObject);
    procedure edtP_TitleChange(Sender: TObject);
    procedure edtP_WPChange(Sender: TObject);
    procedure edtP_NormsChange(Sender: TObject);
  private
    { Private declarations }
    procedure PlansChange;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Editor: TEditor;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  ZipForge;

procedure TForm1.btnExitClick(Sender: TObject);
begin
	Close;
end;

{ TEditor }

constructor TEditor.Create;
begin
  {$IFDEF INEJ}
  fSign := 'INEJ';
  {$ENDIF}
  {$IFDEF ISTINA}
  fSign := 'ISTINA';
  {$ENDIF}

  fPlans := TPlans.Create; //TObjectList<TPlan>.Create();
	EmptyList;
end;

destructor TEditor.Destroy;
begin

	fPlans.Free;
  inherited;
end;

procedure TEditor.EmptyList;
var
	i: Byte;
begin
	fInfo := '';
	fFileName := 'Безымянный';

  fPlans.Clear;
  for i := 1 to 15 do
  begin
    fPlans.Add(TPlan.Create('План №' + IntToStr(i), '', ''));
  end;
end;

procedure TEditor.Load(const FileName: String);
begin
	if not FileExists(FileName) then
  	Exit;
end;

procedure TEditor.New;
begin
	EmptyList;
end;

procedure TEditor.Save(const FileName: String);
var
  Archiver: TZipForge;
  Lines: TStringList;
  Plan: TPlan;
  Index: Integer;
begin
	Archiver := TZipForge.Create(nil);
  try
    Archiver.Password := Pass;
    Archiver.FileName := FileName;
    Archiver.OpenArchive(fmCreate);

    { Описание РП }
    Archiver.AddFromString('INFO.TXT', Editor.fInfo);
    { Информация о планах классификации }
    Lines := TStringList.Create;
//    Lines.Text := S;
    for Plan in Editor.fPlans do
    begin
      Index := Editor.fPlans.IndexOf(Plan) + 1;
      Lines.Add( Format('%s'#9'PLAN%.2d'#9'PLAN%.2d', [Plan.Caption, Index, Index]) );
      Archiver.AddFromString( Format('PLAN%.2d.PAS', [Index]), Plan.WPFile );
      Archiver.AddFromString( Format('PLAN%.2d.NRM', [Index]), Plan.NormFile );
    end;
    Archiver.AddFromString('PLANS.TXT', Lines.Text);
    Archiver.AddFromString(fSign, '');
    Lines.Free;

	  Archiver.CloseArchive;
  except
    on E: Exception do
    begin
        ShowMessage('Error: ' + E.Message);
    end;
  end;
  Archiver.Free;
end;

//{ TPlan }
//
//constructor TPlan.Create;
//begin
//	Caption := '';
//	WP := '';
//  Norms := '';
//end;

procedure TForm1.btnNewClick(Sender: TObject);
//var
//  S: String;
//  i: Integer;
begin
//  S := TFile.ReadAllText('uMain.dfm');
//  for i:= 1 to 15 do
//  begin
//    S := StringReplace(S, 'object JvFilenameEdit'+IntToStr(i*2-1)+': TJvFilenameEdit',
//      'object edtP'+IntToStr(i+1)+'_Norms: TJvFilenameEdit', [rfReplaceAll]);
//    S := StringReplace(S, 'object JvFilenameEdit'+IntToStr(i*2)+': TJvFilenameEdit',
//      'object edtP'+IntToStr(i+1)+'_WP: TJvFilenameEdit', [rfReplaceAll]);
//  end;
//  TFile.WriteAllText('uMain.dfm.new', S);
  Editor.New;
  PlansChange;
end;

procedure TForm1.btnOpenClick(Sender: TObject);
var
  Dlg: TOpenDialog;
begin
  Dlg := TOpenDialog.Create(Self);
  Dlg.Filter := 'Файлы РП (*.dat)|*.dat|Все файлы (*.*)|*.*';
  if Dlg.Execute then
    if Editor.fPlans.IsValidWPFile(Dlg.FileName, Editor.fSign) then
      if Editor.fPlans.LoadFromFile(Dlg.FileName) then
        PlansChange;
  Dlg.Free;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  Dlg: TSaveDialog;
begin
  Dlg := TSaveDialog.Create(Self);
  Dlg.Filter := 'Файлы РП (*.dat)|*.dat|Все файлы (*.*)|*.*';
  Dlg.DefaultExt := 'dat';
  if Dlg.Execute then
    Editor.Save(Dlg.FileName);
  Dlg.Free;
end;

procedure TForm1.edtP_NormsChange(Sender: TObject);
begin
  if FileExists( TJvFilenameEdit(Sender).FileName ) then
    Editor.fPlans[TEdit(Sender).Tag-1].NormFile := TFile.ReadAllText( TJvFilenameEdit(Sender).FileName )
  else
    Editor.fPlans[TEdit(Sender).Tag-1].NormFile := '';
end;

procedure TForm1.edtP_TitleChange(Sender: TObject);
begin
  Editor.fPlans[TEdit(Sender).Tag-1].Caption := TEdit(Sender).Text;
end;

procedure TForm1.edtP_WPChange(Sender: TObject);
begin
  if FileExists( TJvFilenameEdit(Sender).FileName ) then
    Editor.fPlans[TEdit(Sender).Tag-1].WPFile := TFile.ReadAllText( TJvFilenameEdit(Sender).FileName )
  else
    Editor.fPlans[TEdit(Sender).Tag-1].WPFile := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	Editor := TEditor.Create;
  Editor.New;
  PlansChange;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
	Editor.Free;
end;

procedure TForm1.mmoInfoChange(Sender: TObject);
begin
  Editor.fInfo := TMemo(Sender).Text;
end;

procedure TForm1.PlansChange;
var
  i: Integer;
begin
  Self.Caption := 'Тестер "ИСТИНА" - ' + Editor.fFileName;
  mmoInfo.Text := Editor.fInfo;
  for i := 1 to Editor.fPlans.Count do
  begin
    TEdit(FindComponent('edtP'+IntToStr(i)+'_Title')).Text := Editor.fPlans[i-1].Caption;
    TJvFilenameEdit(FindComponent('edtP'+IntToStr(i)+'_WP')).FileName := Editor.fPlans[i-1].WPFile;
    TJvFilenameEdit(FindComponent('edtP'+IntToStr(i)+'_Norms')).FileName := Editor.fPlans[i-1].NormFile;
  end;
end;

end.
