object Form1: TForm1
  Left = -884
  Top = 326
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1058#1077#1089#1090#1077#1088' "'#1048#1057#1058#1048#1053#1040'" - '#1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1088#1086#1075#1088#1072#1084#1084
  ClientHeight = 296
  ClientWidth = 473
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
  object GroupBox2: TGroupBox
    Left = 3
    Top = 8
    Width = 464
    Height = 105
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object mmoInfo: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 454
      Height = 82
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = mmoInfoChange
    end
  end
  object GroupBox3: TGroupBox
    Left = 3
    Top = 120
    Width = 464
    Height = 137
    Caption = #1055#1083#1072#1085#1099' '#1082#1083#1072#1089#1089#1080#1092#1080#1082#1072#1094#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 454
      Height = 114
      ActivePage = TabSheet1
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabWidth = 30
      object TabSheet1: TTabSheet
        Caption = '1'
        object Label1: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label2: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP1_Title: TEdit
          Tag = 1
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP1_WP: TJvFilenameEdit
          Tag = 1
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_WPChange
        end
        object edtP1_Norms: TJvFilenameEdit
          Tag = 1
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_NormsChange
        end
      end
      object TabSheet2: TTabSheet
        Caption = '2'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label3: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label4: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP2_Title: TEdit
          Tag = 2
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP2_Norms: TJvFilenameEdit
          Tag = 2
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP2_WP: TJvFilenameEdit
          Tag = 2
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet3: TTabSheet
        Caption = '3'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label5: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label6: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP3_Title: TEdit
          Tag = 3
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP3_Norms: TJvFilenameEdit
          Tag = 3
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP3_WP: TJvFilenameEdit
          Tag = 3
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet4: TTabSheet
        Caption = '4'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label7: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label8: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP4_Title: TEdit
          Tag = 4
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP4_Norms: TJvFilenameEdit
          Tag = 4
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP4_WP: TJvFilenameEdit
          Tag = 4
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet5: TTabSheet
        Caption = '5'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label9: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label10: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP5_Title: TEdit
          Tag = 5
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP5_Norms: TJvFilenameEdit
          Tag = 5
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP5_WP: TJvFilenameEdit
          Tag = 5
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet6: TTabSheet
        Caption = '6'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label11: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label12: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP6_Title: TEdit
          Tag = 6
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP6_Norms: TJvFilenameEdit
          Tag = 6
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP6_WP: TJvFilenameEdit
          Tag = 6
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet7: TTabSheet
        Caption = '7'
        ImageIndex = 6
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label13: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label14: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP7_Title: TEdit
          Tag = 7
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP7_Norms: TJvFilenameEdit
          Tag = 7
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP7_WP: TJvFilenameEdit
          Tag = 7
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet8: TTabSheet
        Caption = '8'
        ImageIndex = 7
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label15: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label16: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP8_Title: TEdit
          Tag = 8
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP8_Norms: TJvFilenameEdit
          Tag = 8
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP8_WP: TJvFilenameEdit
          Tag = 8
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet9: TTabSheet
        Caption = '9'
        ImageIndex = 8
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label17: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label18: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP9_Title: TEdit
          Tag = 9
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP9_Norms: TJvFilenameEdit
          Tag = 9
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP9_WP: TJvFilenameEdit
          Tag = 9
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet10: TTabSheet
        Caption = '10'
        ImageIndex = 9
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label19: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label20: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP10_Title: TEdit
          Tag = 10
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP10_Norms: TJvFilenameEdit
          Tag = 10
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP10_WP: TJvFilenameEdit
          Tag = 10
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet11: TTabSheet
        Caption = '11'
        ImageIndex = 10
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label21: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label22: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP11_Title: TEdit
          Tag = 11
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP11_Norms: TJvFilenameEdit
          Tag = 11
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP11_WP: TJvFilenameEdit
          Tag = 11
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet12: TTabSheet
        Caption = '12'
        ImageIndex = 11
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label23: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label24: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP12_Title: TEdit
          Tag = 12
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP12_Norms: TJvFilenameEdit
          Tag = 12
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP12_WP: TJvFilenameEdit
          Tag = 12
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet13: TTabSheet
        Caption = '13'
        ImageIndex = 12
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label25: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label26: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP13_Title: TEdit
          Tag = 13
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP13_Norms: TJvFilenameEdit
          Tag = 13
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP13_WP: TJvFilenameEdit
          Tag = 13
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet14: TTabSheet
        Caption = '14'
        ImageIndex = 13
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label27: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label28: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP14_Title: TEdit
          Tag = 14
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP14_Norms: TJvFilenameEdit
          Tag = 14
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP14_WP: TJvFilenameEdit
          Tag = 14
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
      object TabSheet15: TTabSheet
        Caption = '15'
        ImageIndex = 14
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label29: TLabel
          Left = 3
          Top = 30
          Width = 102
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
        end
        object Label30: TLabel
          Left = 3
          Top = 57
          Width = 37
          Height = 13
          Caption = #1053#1086#1088#1084#1099':'
        end
        object edtP15_Title: TEdit
          Tag = 15
          Left = 3
          Top = 3
          Width = 440
          Height = 21
          TabOrder = 0
          OnChange = edtP_TitleChange
        end
        object edtP15_Norms: TJvFilenameEdit
          Tag = 15
          Left = 111
          Top = 57
          Width = 332
          Height = 21
          TabOrder = 1
          Text = ''
          OnChange = edtP_NormsChange
        end
        object edtP15_WP: TJvFilenameEdit
          Tag = 15
          Left = 111
          Top = 30
          Width = 332
          Height = 21
          TabOrder = 2
          Text = ''
          OnChange = edtP_WPChange
        end
      end
    end
  end
  object btnSave: TButton
    Left = 8
    Top = 263
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnExit: TButton
    Left = 387
    Top = 263
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 3
    OnClick = btnExitClick
  end
  object btnNew: TButton
    Left = 131
    Top = 263
    Width = 75
    Height = 25
    Caption = #1053#1086#1074#1099#1081
    TabOrder = 4
    Visible = False
    OnClick = btnNewClick
  end
  object btnOpen: TButton
    Left = 212
    Top = 263
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100'...'
    TabOrder = 5
    Visible = False
    OnClick = btnOpenClick
  end
end
