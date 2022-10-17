unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IniFiles, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.OleCtrls, WMPLib_TLB,
  ShockwaveFlashObjects_TLB, Vcl.Imaging.pngimage, Vcl.Imaging.gifimg;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Settings: TIniFile;

implementation

{$R *.dfm}

uses ScrUnit;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i, j, n: Integer;
  Image: TImage;
  VideoPanel: TPanel;
  WMP: TWindowsMediaPlayer;
  Flash: TShockwaveFlash;
  SectionName: String;
begin
  if Screen.MonitorCount = 0 then
    begin
      MessageBox(Application.Handle, 'Menu', 'Нет ни одного монитора!', MB_OK + MB_ICONINFORMATION);
      Halt
    end;

  Application.ShowMainForm := False;

  Settings := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Settings.ini');

  n := 0;

  for i := 0 to Screen.MonitorCount - 1 do
    begin
      if not Settings.ReadBool('Monitor' + IntToStr(i), 'Used', True) then
        Continue;

      Inc(n);

      ScrForm := TScrForm.Create(Self);
      ScrForm.Left := Screen.Monitors[i].Left;
      ScrForm.Top := Screen.Monitors[i].Top;

      for j := 0 to Settings.ReadInteger('Monitor' + IntToStr(i), 'SectorsCount', 0) - 1 do
        begin
          SectionName := 'Monitor' + IntToStr(i) + 'Sector' + IntToStr(j);
          case Settings.ReadInteger(SectionName, 'Tag', 0) of
          0:  begin //картинка
                Image := TImage.Create(ScrForm);
                Image.Parent := ScrForm;
                Image.Left := Settings.ReadInteger(SectionName, 'Left', 0);
                Image.Top := Settings.ReadInteger(SectionName, 'Top', 0);
                Image.Width := Settings.ReadInteger(SectionName, 'Width', 300);
                Image.Height := Settings.ReadInteger(SectionName, 'Height', 300);
                Image.Center := True;
                if AnsiLowerCase(ExtractFileExt(Settings.ReadString(SectionName, 'Hint', ''))) <> '.gif' then
                  begin //отключаем масштабирование для GIF
                    Image.Proportional := True;
                    Image.Stretch := True;
                  end;
                try
                  Image.Picture.LoadFromFile(Settings.ReadString(SectionName, 'Hint', ''));
                  if AnsiLowerCase(ExtractFileExt(Settings.ReadString(SectionName, 'Hint', ''))) = '.gif' then
                    TGIFImage(Image.Picture.Graphic).Animate := True; //включаем анимацию для GIF
                  Image.Hint := Settings.ReadString(SectionName, 'Hint', '');
                except
                end;
              end;
          1:  begin //видео
                VideoPanel := TPanel.Create(ScrForm);
                VideoPanel.Parent := ScrForm;
                VideoPanel.Left := Settings.ReadInteger(SectionName, 'Left', 0);
                VideoPanel.Top := Settings.ReadInteger(SectionName, 'Top', 0);
                VideoPanel.Width := Settings.ReadInteger(SectionName, 'Width', 300);
                VideoPanel.Height := Settings.ReadInteger(SectionName, 'Height', 300);
                VideoPanel.BevelOuter := bvNone;

                WMP := TWindowsMediaPlayer.Create(ScrForm);
                WMP.Parent := VideoPanel;
                WMP.Align := alClient;
                WMP.uiMode := 'none';
                WMP.enableContextMenu := False;
                WMP.stretchToFit := True;
                WMP.OnPlayStateChange := ScrForm.WMPPlayStateChange;
                WMP.URL := Settings.ReadString(SectionName, 'Hint', '');
              end;
          2:  begin //флэш
                Flash := TShockwaveFlash.Create(ScrForm);
                Flash.Parent := ScrForm;
                Flash.Left := Settings.ReadInteger(SectionName, 'Left', 0);
                Flash.Top := Settings.ReadInteger(SectionName, 'Top', 0);
                Flash.Width := Settings.ReadInteger(SectionName, 'Width', 300);
                Flash.Height := Settings.ReadInteger(SectionName, 'Height', 300);
                Flash.ScaleMode := 1;
                Flash.Menu := False;
                Flash.Movie := Settings.ReadString(SectionName, 'Hint', '');
              end;
          end;
        end;

      ScrForm.Show;
    end;

  if n = 0 then //если нет экранов или ни один экран не используется
    Application.Terminate

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Settings.Free
end;

end.
