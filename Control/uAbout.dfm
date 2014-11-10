object fAbout: TfAbout
  Left = -883
  Top = 590
  BorderStyle = bsDialog
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
  ClientHeight = 184
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 142
    Width = 403
    Height = 42
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 8
    Top = 159
    Width = 277
    Height = 13
    Caption = #1047#1040#1054' "'#1053#1058#1062' '#1057#1093#1077#1084#1086#1090#1077#1093#1085#1080#1082#1080' '#1080' '#1048#1085#1090#1077#1075#1088#1072#1083#1100#1085#1099#1093' '#1058#1077#1093#1085#1086#1083#1086#1075#1080#1081'"'
  end
  object Label2: TLabel
    Left = 152
    Top = 14
    Width = 259
    Height = 115
    Alignment = taCenter
    AutoSize = False
    Caption = 
      #1058#1077#1089#1090#1077#1088' '#1082#1086#1085#1090#1088#1086#1083#1103' '#1089#1090#1072#1090#1080#1095#1077#1089#1082#1080#1093#13#10#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1062#1048#1057#13#10#1050#1042#1050'.'#1057#1048#1062'.'#1069#13#10#13#10#1059#1087#1088#1072#1074#1083 +
      #1103#1102#1097#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object imgTester: TImage
    Left = 8
    Top = 8
    Width = 128
    Height = 128
    Center = True
  end
  object btnOK: TButton
    Left = 336
    Top = 154
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
end
