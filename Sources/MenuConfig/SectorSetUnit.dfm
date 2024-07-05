object SectorSetForm: TSectorSetForm
  Left = 264
  Top = 158
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1089#1077#1082#1090#1086#1088#1072
  ClientHeight = 342
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object gbSectorSize: TGroupBox
    Left = 0
    Top = 0
    Width = 529
    Height = 89
    Align = alTop
    Caption = #1056#1072#1079#1084#1077#1088#1099' '#1089#1077#1082#1090#1086#1088#1072
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 21
      Width = 40
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object Label2: TLabel
      Left = 138
      Top = 21
      Width = 37
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072
    end
    object Label3: TLabel
      Left = 272
      Top = 21
      Width = 69
      Height = 13
      Caption = #1054#1090#1089#1090#1091#1087' '#1089#1083#1077#1074#1072
    end
    object Label4: TLabel
      Left = 399
      Top = 21
      Width = 75
      Height = 13
      Caption = #1054#1090#1089#1090#1091#1087' '#1089#1074#1077#1088#1093#1091
    end
    object seWidth: TSpinEdit
      Left = 11
      Top = 40
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = seWidthChange
    end
    object seHeight: TSpinEdit
      Left = 138
      Top = 40
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = seHeightChange
    end
    object seLeft: TSpinEdit
      Left = 272
      Top = 40
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = seLeftChange
    end
    object seTop: TSpinEdit
      Left = 399
      Top = 40
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = seTopChange
    end
  end
  object gbInfoType: TGroupBox
    Left = 0
    Top = 89
    Width = 529
    Height = 216
    Align = alTop
    Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1077#1084#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 1
    object rbImage: TRadioButton
      Left = 11
      Top = 24
      Width = 86
      Height = 17
      Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 24
      Top = 47
      Width = 417
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object rbVideo: TRadioButton
      Left = 11
      Top = 88
      Width = 54
      Height = 17
      Caption = #1042#1080#1076#1077#1086
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 24
      Top = 111
      Width = 417
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object Button1: TButton
      Left = 447
      Top = 43
      Width = 75
      Height = 25
      Caption = #1054#1073#1079#1086#1088'...'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 447
      Top = 109
      Width = 75
      Height = 25
      Caption = #1054#1073#1079#1086#1088'...'
      TabOrder = 5
      OnClick = Button2Click
    end
    object rbFlash: TRadioButton
      Left = 11
      Top = 152
      Width = 54
      Height = 17
      Caption = #1060#1083#1101#1096
      TabOrder = 6
    end
    object Edit3: TEdit
      Left = 24
      Top = 175
      Width = 417
      Height = 21
      ReadOnly = True
      TabOrder = 7
    end
    object Button3: TButton
      Left = 445
      Top = 174
      Width = 75
      Height = 25
      Caption = #1054#1073#1079#1086#1088'...'
      TabOrder = 8
      OnClick = Button3Click
    end
  end
  object CloseButton: TButton
    Left = 446
    Top = 311
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 8
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      #1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1077' '#1092#1072#1081#1083#1099' (*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*' +
      '.ico;*.emf;*.wmf)|*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.' +
      'ico;*.emf;*.wmf|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 168
    Top = 97
  end
  object OpenDialog2: TOpenDialog
    Filter = 
      #1042#1080#1076#1077#1086' (*.avi;*.mkv;*.mpg;*.mpeg;*.mp4;*.mov;*.wmv)|*.avi;*.mkv;*' +
      '.mpg;*.mpeg;*.mp4;*.mov;*.wmv|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 232
    Top = 97
  end
  object OpenDialog3: TOpenDialog
    Filter = 'Shockwave Flash (*.swf)|*.swf|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 296
    Top = 97
  end
end
