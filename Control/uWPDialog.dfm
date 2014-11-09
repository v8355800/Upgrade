object fWPDialog: TfWPDialog
  Left = -849
  Top = 46
  BorderStyle = bsDialog
  Caption = #1058#1077#1089#1090#1077#1088' - '#1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072
  ClientHeight = 333
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 121
    Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object edtWPFileName: TJvFilenameEdit
      Left = 8
      Top = 20
      Width = 401
      Height = 21
      Filter = #1056#1072#1073#1086#1095#1072#1103' '#1055#1088#1086#1075#1088#1072#1084#1084#1072' (*.dat)|*.dat|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
      DialogOptions = [ofHideReadOnly, ofFileMustExist]
      DialogTitle = #1042#1099#1073#1086#1088' "'#1056#1072#1073#1086#1095#1077#1081' '#1055#1088#1086#1075#1088#1072#1084#1084#1099'"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnChange = edtWPFileNameChange
    end
    object mmoInfo: TMemo
      Left = 8
      Top = 47
      Width = 401
      Height = 66
      ReadOnly = True
      TabOrder = 1
    end
  end
  object btnOK: TButton
    Left = 99
    Top = 303
    Width = 75
    Height = 25
    Caption = #1053#1040#1063#1040#1058#1068
    Enabled = False
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 261
    Top = 303
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 136
    Width = 417
    Height = 49
    Caption = #1055#1083#1072#1085' '#1082#1083#1072#1089#1089#1080#1092#1080#1082#1072#1094#1080#1080':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object cmbPlans: TComboBox
      Left = 12
      Top = 20
      Width = 397
      Height = 21
      Style = csDropDownList
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object gbConditions: TGroupBox
    Left = 8
    Top = 200
    Width = 417
    Height = 97
    Caption = #1056#1077#1078#1080#1084':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 30
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1040#1062#1055':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 30
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1064#1072#1075':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 68
      Width = 30
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1062#1080#1082#1083':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 257
      Top = 68
      Width = 85
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1063#1080#1089#1083#1086' '#1087#1086#1074#1090#1086#1088#1086#1074':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtADC: TEdit
      Left = 48
      Top = 16
      Width = 361
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '1-100'
    end
    object edtHalt: TEdit
      Left = 48
      Top = 40
      Width = 361
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtLoop: TEdit
      Left = 48
      Top = 64
      Width = 201
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtLoopCount: TSpinEdit
      Left = 344
      Top = 64
      Width = 65
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 3
      Value = 0
    end
  end
end
