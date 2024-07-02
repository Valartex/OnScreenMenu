program MenuConfig;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  SectorSetUnit in 'SectorSetUnit.pas' {SectorSetForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
