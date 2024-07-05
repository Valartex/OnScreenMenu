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
    Edit1: TEdit;
    rbVideo: TRadioButton;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    CloseButton: TButton;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    rbFlash: TRadioButton;
    Edit3: TEdit;
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
  if RadioButton1.Checked then
  begin
    (MainForm.PopupMenu2.PopupComponent as TPanel).Tag := 0;
    (MainForm.PopupMenu2.PopupComponent as TPanel).Hint := Edit1.Text
  end
  else
  if RadioButton2.Checked then
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
  (MainForm.PopupMenu2.PopupComponent as TPanel).Width := SpinEdit1.Value
end;

procedure TSectorSetForm.seHeightChange(Sender: TObject); //высота
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Height := SpinEdit2.Value
end;

procedure TSectorSetForm.seLeftChange(Sender: TObject); //отступ слева
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Left := SpinEdit3.Value
end;

procedure TSectorSetForm.seTopChange(Sender: TObject); //отступ сверху
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Top := SpinEdit4.Value
end;

end.
