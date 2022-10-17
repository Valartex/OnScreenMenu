program Menu;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ScrUnit in 'ScrUnit.pas' {ScrForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
