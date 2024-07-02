unit SectorSetUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtDlgs, Vcl.ExtCtrls;

type
  TSectorSetForm = class(TForm)
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    Edit1: TEdit;
    RadioButton2: TRadioButton;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    CloseButton: TButton;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    RadioButton3: TRadioButton;
    Edit3: TEdit;
    Button3: TButton;
    OpenDialog3: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
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

procedure TSectorSetForm.SpinEdit1Change(Sender: TObject); //ширина
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Width := SpinEdit1.Value
end;

procedure TSectorSetForm.SpinEdit2Change(Sender: TObject); //высота
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Height := SpinEdit2.Value
end;

procedure TSectorSetForm.SpinEdit3Change(Sender: TObject); //отступ слева
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Left := SpinEdit3.Value
end;

procedure TSectorSetForm.SpinEdit4Change(Sender: TObject); //отступ сверху
begin
  (MainForm.PopupMenu2.PopupComponent as TPanel).Top := SpinEdit4.Value
end;

end.
