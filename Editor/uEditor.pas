unit uEditor;

interface

uses
	uPlans;

type
  TEditor = class(TObject)
  private
  	fPlans: TPlans;
    fCurrentPlan: TPlan;
//    fInfo: String;
    fFileName: string;
    fSign: string;
  protected
  public
    constructor Create;
    destructor Destroy; override;

  	procedure New(const Sign: String);
    function Load(const FileName: String): Boolean;
    procedure Save;
    procedure SaveAs(const FileName: String);
    procedure SetActivePlan(const Index: Integer);

    property CurrentPlan: TPlan read fCurrentPlan;
    property FileName: string read fFileName;
    property Plans: TPlans read fPlans;
    property Sign: string read fSign;
//    property Info: String  read fInfo write fInfo;
  end;

implementation

uses
	System.SysUtils;

{ TEditor }

constructor TEditor.Create;
begin
//  fInfo     := '';
  fFileName := '';
  fSign     := '';

  fPlans := TPlans.Create;
  fCurrentPlan := nil;
end;

destructor TEditor.Destroy;
begin
	fPlans.Free;
  inherited;
end;

function TEditor.Load(const FileName: String): Boolean;
var
	Ext: string;
begin
	Ext := ExtractFileExt(FileName);
  Delete(Ext, 1, 1);
  if fPlans.IsValidWPFile(FileName, UpperCase( Ext )) and
     fPlans.LoadFromFile(FileName) then
  begin
	 	fFileName := FileName;
    fSign     := UpperCase(Ext);
    Result    := True;
  end
	else
  	Result := False;
end;

procedure TEditor.New(const Sign: String);
var
	i: Byte;
begin
	fFileName := 'Безымянный';
  fSign     := Sign;
	fPlans.Info     := '';

  fPlans.Clear;
  for i := 1 to 15 do
  begin
    fPlans.Add(TPlan.Create('План №' + IntToStr(i), '', ''));
  end;
end;

procedure TEditor.Save;
begin
	fPlans.SaveToFile(fFileName, fSign);
end;

procedure TEditor.SaveAs(const FileName: String);
begin
	fPlans.SaveToFile(FileName, fSign);
end;

procedure TEditor.SetActivePlan(const Index: Integer);
begin
	fCurrentPlan := fPlans[Index];
end;

end.
