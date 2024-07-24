unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Menus, IniFiles, Vcl.XPMan, Vcl.Samples.Spin, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList;

type
  TMainForm = class(TForm)
    pcMain: TPageControl;
    PopupMenu1: TPopupMenu;
    CreateSectorMenu: TMenuItem;
    PopupMenu2: TPopupMenu;
    DelSectorMenu: TMenuItem;
    StatusBar1: TStatusBar;
    SetSectorMenu: TMenuItem;
    XPManifest1: TXPManifest;
    ToolBar1: TToolBar;
    btnSaveAll: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CreateSectorMenuClick(Sender: TObject);
    procedure SectorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SectorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SectorResize(Sender: TObject);
    procedure DelSectorMenuClick(Sender: TObject);
    procedure SetSectorMenuClick(Sender: TObject);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnSaveAllClick(Sender: TObject);
  private
    SB: TScrollBox;
    TS: TTabSheet;
    Panel, Sector: TPanel;
    ToolBar: TToolBar;
    ToolButton: TToolButton;
    Settings: TIniFile;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses SectorSetUnit;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i, j: Integer;
  SectorName: String;
begin
  Settings := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Settings.ini');

  for i := 0 to Screen.MonitorCount - 1 do //цикл по кол-ву мониторов в системе
    begin
      TS := TTabSheet.Create(Self); //создаЄм вкладку
      TS.PageControl := pcMain;
      TS.Caption :=  'Ёкран ' + IntToStr(Screen.Monitors[i].MonitorNum) + ': ' + IntToStr(Screen.Monitors[i].Width) + ' x ' + IntToStr(Screen.Monitors[i].Height);

      SB := TScrollBox.Create(Self); //создаЄм на вкладке ScrollBox
      SB.Parent := TS;
      SB.Align := alClient;
      SB.HorzScrollBar.Tracking := True;
      SB.VertScrollBar.Tracking := True;

      Panel := TPanel.Create(Self); //создаЄм в ScrollBox'е Panel
      Panel.Parent := SB;
      Panel.BevelOuter := bvNone;
      Panel.ParentBackground := False;
      Panel.Color := clBlack;
      Panel.Width := Screen.Monitors[i].Width; //размеры панели = разрешению монитора
      Panel.Height := Screen.Monitors[i].Height;
      Panel.PopupMenu := PopupMenu1;
      Panel.OnMouseMove := PanelMouseMove;

      {читаем информацию о расположении секторов из ini-файла}
      for j := 0 to Settings.ReadInteger('Monitor' + IntToStr(i), 'SectorsCount', 0) - 1 do //цикл по количеству секторов на одном мониторе
        begin
          SectorName := 'Monitor' + IntToStr(i) + 'Sector' + IntToStr(j); //им€ раздела информации о секторе
          Sector := TPanel.Create(Self);
          Sector.Parent := Panel;
          Sector.ParentBackground := False;
          Sector.Width := Settings.ReadInteger(SectorName, 'Width', 300);
          Sector.Height := Settings.ReadInteger(SectorName, 'Height', 300);
          Sector.Left := Settings.ReadInteger(SectorName, 'Left', 0);
          Sector.Top := Settings.ReadInteger(SectorName, 'Top', 0);
          Sector.Tag := Settings.ReadInteger(SectorName, 'Tag', 0);
          Sector.Hint := Settings.ReadString(SectorName, 'Hint', '');
          Sector.ShowHint := True;
          Sector.PopupMenu := PopupMenu2;
          Sector.OnMouseDown := SectorMouseDown;
          Sector.OnMouseMove := SectorMouseMove;
          Sector.OnResize := SectorResize;
        end;

      ToolBar := TToolBar.Create(Self); //создаЄм на вкладке ToolBar
      ToolBar.Parent := TS;
      ToolBar.Align := alTop;
      ToolBar.ButtonHeight := 32;
      ToolBar.ButtonWidth := 32;
      ToolBar.AutoSize := True;
      ToolBar.Images := ImageList2;

      ToolButton := TToolButton.Create(Self); //создаЄм в ToolBar'е кнопку, показывающую используетс€ монитор или нет
      ToolButton.Parent := ToolBar;
      ToolButton.Style := tbsCheck;
      ToolButton.Down := Settings.ReadBool('Monitor' + IntToStr(i), 'Used', True);
      ToolButton.ImageIndex := 0;
    end;
end;

procedure TMainForm.DelSectorMenuClick(Sender: TObject); //удал€ем сектор
begin
  (PopupMenu2.PopupComponent as TPanel).Free
end;

procedure TMainForm.PanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels[0].Text := 'X: ' + IntToStr(X) + ' Y: ' + IntToStr(Y);
end;

procedure TMainForm.SectorMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  p1, p2, p3, p4: Integer;
begin
  p1 := (Sender as TPanel).Width; //правый край панели
  p2 := (Sender as TPanel).Height; //нижний край панели
  p3 := p1 - 5;
  p4 := p2 - 5;

  if (X <= 5) or (X >= p3) or (Y <= 5) or (Y >= p4) then
    (Sender as TPanel).Cursor := crSizeAll
  else
    (Sender as TPanel).Cursor := crDefault
end;

procedure TMainForm.btnSaveAllClick(Sender: TObject); //сохранить всЄ
var
  i, j: Integer;
  SectorName: String;
begin
  for i := 0 to pcMain.PageCount - 1 do
    begin
      Settings.WriteBool('Monitor' + IntToStr(i), 'Used', ((pcMain.Pages[i].Controls[1] as TToolBar).Controls[0] as TToolButton).Down);
      Settings.WriteInteger('Monitor' + IntToStr(i), 'SectorsCount', ((pcMain.Pages[i].Controls[0] as TScrollBox).Controls[0] as TPanel).ControlCount); //сохран€ем количество секторов на текущей вкладке
      for j := 0 to ((pcMain.Pages[i].Controls[0] as TScrollBox).Controls[0] as TPanel).ControlCount - 1 do //цикл по количеству компонентов
        begin
          SectorName := 'Monitor' + IntToStr(i) + 'Sector' + IntToStr(j); //им€ раздела информации о секторе
          with ((pcMain.Pages[i].Controls[0] as TScrollBox).Controls[0] as TPanel).Controls[j] as TPanel do //конструкци€ вида PageControl1.Pages[i].ScrollBox.Panel.Panel[j]
            begin
              Settings.WriteInteger(SectorName, 'Width', Width);
              Settings.WriteInteger(SectorName, 'Height', Height);
              Settings.WriteInteger(SectorName, 'Left', Left);
              Settings.WriteInteger(SectorName, 'Top', Top);
              Settings.WriteInteger(SectorName, 'Tag', Tag);
              Settings.WriteString(SectorName, 'Hint', Hint);
            end;
        end;
    end;
end;

procedure TMainForm.SectorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p1, p2: Integer;
begin
  p1 := (Sender as TPanel).Width; //правый край панели
  p2 := (Sender as TPanel).Height; //нижний край панели

  if (X <= 5) or (Y <= 5) then //лева€ сторона и низ панели
  begin
    ReleaseCapture;
    (Sender as TPanel).Perform(WM_SYSCOMMAND, SC_SIZE or WMSZ_TOPLEFT, 0);
  end
  else
  if (X >= p1-5) or (Y >= p2-5) then //права€ сторона и верх панели
  begin
    ReleaseCapture;
    (Sender as TPanel).Perform(WM_SYSCOMMAND, SC_SIZE or WMSZ_BOTTOMRIGHT, 0);
  end
  else //всЄ остальное пространство
  begin
    ReleaseCapture;
    (Sender as TPanel).Perform(WM_SYSCOMMAND, $F012, 0); //чтобы панель двигалась мышкой
    (Sender as TPanel).Caption := 'W=' + IntToStr((Sender as TPanel).Width) +
                                  ' H=' + IntToStr((Sender as TPanel).Height) +
                                  ' L=' + IntToStr((Sender as TPanel).Left) +
                                  ' T=' + IntToStr((Sender as TPanel).Top) +
                                  ' | ' + ExtractFileName((Sender as TPanel).Hint);
  end;
end;

procedure TMainForm.CreateSectorMenuClick(Sender: TObject); //создаЄм новый сектор
begin
  Sector := TPanel.Create(Self);
  Sector.Parent := PopupMenu1.PopupComponent as TPanel;
  Sector.ParentBackground := False;
  Sector.Width := 300;
  Sector.Height := 300;
  Sector.ShowHint := True;

  Sector.PopupMenu := PopupMenu2;
  Sector.OnMouseDown := SectorMouseDown;
  Sector.OnMouseMove := SectorMouseMove;
  Sector.OnResize := SectorResize;
end;

procedure TMainForm.SectorResize(Sender: TObject);
begin
  (Sender as TPanel).Caption := 'W=' + IntToStr((Sender as TPanel).Width) +
                                ' H=' + IntToStr((Sender as TPanel).Height) +
                                ' L=' + IntToStr((Sender as TPanel).Left) +
                                ' T=' + IntToStr((Sender as TPanel).Top) +
                                ' | ' + ExtractFileName((Sender as TPanel).Hint);
end;

procedure TMainForm.SetSectorMenuClick(Sender: TObject); //окно свойств сектора
begin
  SectorSetForm := TSectorSetForm.Create(Self);
  //заполн€ем пол€ формы текущими значени€ми
  SectorSetForm.seWidth.Value := (PopupMenu2.PopupComponent as TPanel).Width;
  SectorSetForm.seHeight.Value := (PopupMenu2.PopupComponent as TPanel).Height;
  SectorSetForm.seLeft.Value := (PopupMenu2.PopupComponent as TPanel).Left;
  SectorSetForm.seTop.Value := (PopupMenu2.PopupComponent as TPanel).Top;
  case (PopupMenu2.PopupComponent as TPanel).Tag of
  0:  begin
        SectorSetForm.rbImage.Checked := True;
        SectorSetForm.edImagePath.Text := (PopupMenu2.PopupComponent as TPanel).Hint;
      end;
  1:  begin
        SectorSetForm.rbVideo.Checked := True;
        SectorSetForm.edVideoPath.Text := (PopupMenu2.PopupComponent as TPanel).Hint;
      end;
  2:  begin
        SectorSetForm.rbFlash.Checked := True;
        SectorSetForm.edFlashPath.Text := (PopupMenu2.PopupComponent as TPanel).Hint;
      end;
  end;
 //---
  SectorSetForm.ShowModal;
  SectorSetForm.Free
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Settings.Free;
end;

end.
