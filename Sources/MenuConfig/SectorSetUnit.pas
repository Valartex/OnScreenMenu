unit SectorSetUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtDlgs, Vcl.ExtCtrls;

type
  TSectorSetForm = class(TForm)
    gbSectorSize: TGroupBox;
    seWidth: TSpinEdit;
    seHeight: TSpinEdit;
    seLeft: TSpinEdit;
    seTop: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    gbInfoType: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    rbImage: TRadioButton;
    edImagePath: TEdit;
    rbVideo: TRadioButton;
    edVideoPath: TEdit;
    Button1: TButton;
    Button2: TButton;
    CloseButton: TButton;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    rbFlash: TRadioButton;
    edFlashPath: TEdit;
    Button3: TButton;
    OpenDialog3: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure seWidthChange(Sender: TObject);
    procedure seHeightChange(Sender: TObject);
    procedure seLeftChange(Sender: TObject);
    procedure seTopChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SectorSetForm: TSectorSetForm;

implementation

{$R *.dfm}

uses MainUnit;

procedure TSectorSetForm.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName
end;

procedure TSectorSetForm.Button2Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
    Edit2.Text := OpenDialog2.FileName
end;

procedure TSectorSetForm.Button3Click(Sender: TObject);
begin
  if OpenDialog3.Execute then
    Edit3.Text := OpenDialog3.FileName
end;

procedure TSectorSetForm.FormClose(Sender: TObject; //при закрытии сохраняем информацию об отображаемой информации
  var Action: TCloseAction);
begin
  if rbImage.Checked then
  begin
    (MainForm.PopupMenu2.PopupComponent as TPanel).Tag := 0;
    (MainForm.PopupMenu2.PopupComponent as TPanel).Hint := Edit1.Text
  end
  else
  if rbVideo.Checked then
  begin
    (MainForm.PopupMenu2.PopupComponent as TPanel).Tag := 1;
    (MainForm.PopupMenu2.PopupComponent as TPanel).Hint := Edit2.Text
  end
  else
  begin
    (MainForm.PopupMenu2.PopupComponent as TPanel).Tag := 2;
    (MainForm.PopupMenu2.PopupComponent as TPanel).Hint := Edit3.Text
  end;

  MainForm.SectorResize(MainForm.PopupMenu2.PopupComponent); //для обновления информации в Caption панели
end;

procedure TSectorSetForm.seWidthChange(Sender: TObject); //ширина
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Width := seWidth.Value
end;

procedure TSectorSetForm.seHeightChange(Sender: TObject); //высота
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Height := seHeight.Value
end;

procedure TSectorSetForm.seLeftChange(Sender: TObject); //отступ слева
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Left := seLeft.Value
end;

procedure TSectorSetForm.seTopChange(Sender: TObject); //отступ сверху
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Top := seTop.Value
end;

end.
