unit ScrUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.OleCtrls, WMPLib_TLB;

type
  TScrForm = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WMPPlayStateChange(ASender: TObject;
      NewState: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScrForm: TScrForm;

implementation

{$R *.dfm}

uses MainUnit;

procedure TScrForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    MainForm.Close
end;

procedure TScrForm.WMPPlayStateChange(ASender: TObject;
  NewState: Integer);
begin
  if (ASender as TWindowsMediaPlayer).playState = 1 then  //если ролик остановлен
    begin
      (ASender as TWindowsMediaPlayer).controls.play
    end;
end;

end.
