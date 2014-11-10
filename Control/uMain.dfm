object fMain: TfMain
  Left = -1168
  Top = 42
  Caption = #1058#1077#1089#1090#1077#1088' ""'
  ClientHeight = 704
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 685
    Width = 854
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Alignment = taCenter
        Width = 75
      end
      item
        Width = 50
      end>
    ExplicitTop = 885
  end
  object pnlStatus: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 848
    Height = 78
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblStatus: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 234
      Height = 73
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -43
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 45
    end
    object GroupBox6: TGroupBox
      AlignWithMargins = True
      Left = 520
      Top = 4
      Width = 324
      Height = 70
      Align = alRight
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblFIO: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 18
        Width = 308
        Height = 19
        Margins.Left = 6
        Margins.Right = 6
        Align = alTop
        Caption = #1060#1048#1054': %s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 69
      end
      object lblTabN: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 43
        Width = 308
        Height = 19
        Margins.Left = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#8470': %s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 138
      end
    end
    object GroupBox7: TGroupBox
      AlignWithMargins = True
      Left = 244
      Top = 4
      Width = 270
      Height = 70
      Align = alClient
      Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lblWPFile: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 18
        Width = 254
        Height = 19
        Margins.Left = 6
        Margins.Right = 6
        Align = alTop
        Caption = #1060#1072#1081#1083': %s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 72
      end
      object lblPlan: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 43
        Width = 254
        Height = 19
        Margins.Left = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = #1055#1083#1072#1085': %s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 71
      end
    end
  end
  object pnlClient: TPanel
    Left = 244
    Top = 84
    Width = 610
    Height = 601
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    ExplicitHeight = 801
    object pnlMeasure: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 604
      Height = 511
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitHeight = 711
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 598
        Height = 505
        Align = alClient
        Caption = 'F2 - '#1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1074#1082#1083#1072#1076#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitHeight = 705
        object pgcMeasure: TPageControl
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 588
          Height = 482
          ActivePage = TabSheet1
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitHeight = 682
          object TabSheet1: TTabSheet
            Caption = #1058#1077#1082#1091#1097#1080#1081' '#1087#1088#1080#1073#1086#1088
            object grdCurrent: TDBGridEh
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 574
              Height = 448
              Align = alClient
              AutoFitColWidths = True
              DynProps = <>
              IndicatorOptions = [gioShowRowIndicatorEh]
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ReadOnly = True
              STFilter.InstantApply = False
              TabOrder = 0
              TitleParams.MultiTitle = True
              OnGetCellParams = grdCurrentGetCellParams
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
          object tsAll: TTabSheet
            Caption = #1042#1089#1077' '#1087#1088#1080#1073#1086#1088#1099
            ImageIndex = 2
            object grdAll: TDBGridEh
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 574
              Height = 448
              Align = alClient
              DynProps = <>
              IndicatorOptions = [gioShowRowIndicatorEh]
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              ReadOnly = True
              TabOrder = 0
              TitleParams.MultiTitle = True
              OnGetCellParams = grdAllGetCellParams
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
          object TabSheet2: TTabSheet
            Caption = #1041#1088#1072#1082'/'#1043#1086#1076#1077#1085
            ImageIndex = 1
            ExplicitHeight = 654
            object imgStatus: TImage
              AlignWithMargins = True
              Left = 30
              Top = 30
              Width = 520
              Height = 394
              Margins.Left = 30
              Margins.Top = 30
              Margins.Right = 30
              Margins.Bottom = 30
              Align = alClient
              Center = True
              Proportional = True
              Stretch = True
              ExplicitLeft = -8
              ExplicitTop = 5
              ExplicitWidth = 588
              ExplicitHeight = 494
            end
          end
          object tsLog: TTabSheet
            Caption = #1058#1077#1089#1090#1077#1088
            ImageIndex = 3
            object GroupBox2: TGroupBox
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 574
              Height = 337
              Align = alClient
              Caption = #1057#1054#1054#1041#1065#1045#1053#1048#1071
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object mmoLogs: TMemo
                AlignWithMargins = True
                Left = 5
                Top = 18
                Width = 564
                Height = 314
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                ScrollBars = ssVertical
                TabOrder = 0
              end
            end
            object GroupBox3: TGroupBox
              AlignWithMargins = True
              Left = 3
              Top = 346
              Width = 574
              Height = 105
              Align = alBottom
              Caption = #1054#1064#1048#1041#1050#1048
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object mmoErrors: TMemo
                AlignWithMargins = True
                Left = 5
                Top = 18
                Width = 564
                Height = 82
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                ScrollBars = ssVertical
                TabOrder = 0
              end
            end
          end
        end
      end
    end
    object pnlBottom: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 520
      Width = 604
      Height = 78
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 720
      object pnlHotKeys: TPanel
        Left = 0
        Top = 0
        Width = 516
        Height = 78
        Align = alClient
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 141
          Height = 32
          Alignment = taCenter
          Caption = '(F2)'#13#10#1056#1077#1078#1080#1084' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblF5: TLabel
          Left = 452
          Top = 0
          Width = 33
          Height = 78
          Align = alRight
          Alignment = taCenter
          Caption = '(F5)'#13#10#1055#1091#1089#1082
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          Visible = False
          ExplicitHeight = 32
        end
        object Label4: TLabel
          Left = 160
          Top = 8
          Width = 121
          Height = 32
          Alignment = taCenter
          Caption = '(F7)'#13#10#1056#1077#1078#1080#1084' '#1080#1089#1087#1099#1090#1072#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbbViewMode: TComboBox
          Left = 8
          Top = 44
          Width = 141
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = #1058#1077#1082#1091#1097#1080#1081' '#1087#1088#1080#1073#1086#1088
          OnChange = cbbViewModeChange
          Items.Strings = (
            #1058#1077#1082#1091#1097#1080#1081' '#1087#1088#1080#1073#1086#1088)
        end
        object cbbMeasureMode: TComboBox
          Left = 160
          Top = 44
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = #1042#1089#1077' '#1090#1077#1089#1090#1099
          OnChange = cbbMeasureModeChange
          Items.Strings = (
            #1042#1089#1077' '#1090#1077#1089#1090#1099
            #1044#1086' '#1073#1088#1072#1082#1072)
        end
        object btnAbout: TBitBtn
          AlignWithMargins = True
          Left = 488
          Top = 27
          Width = 25
          Height = 24
          Margins.Top = 27
          Margins.Bottom = 27
          Align = alRight
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C30E0000C30E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD9D783786D909090EFEFEFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAF3F3F3E3
            E3E3C39B73AB8561919191EBEBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFF9F9F9E5E5E5C5C5C5A1A1A1B19981DCB7929E856B6B6B6BB5B5B5E2E2
            E2F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFF0F0F0BBBBBB877D73937E69A28C76C6
            A989EAC49FBE9E7C675A4C525252707070B1B1B1EBEBEBFFFFFFFFFFFFF2F2F2
            B2A79CAB9074C1A48ACFAF92DEBF9DF3CEAAFFE7C0E4C3A0C4A685B1906E6F5E
            4D5C5C5C9F9F9FECECECFBFBFBC8B9A9B9A289DCC3A9FCDCBDFFEFCEE3B6939D
            3A11C87547FFDDB8FFDEBAE4C5A5C3A486856D545D5D5DB1B1B1EAE3DCB8A590
            E3CDB7FFEACDFFE8CBFFF4D7D3A988490000701F00FFE1BCFFE8C7FFE3BFEDCD
            AFC2A5876E6052656565D3BFAAD9C7B5FFECD4FFEBD1FFE6CDFFE9CFFFEFD6DC
            B699F1D1B6FFEFD2FFE3C5FFE3C5FFE5C6E5CAADB5997C444444CAB8A9F6E2D1
            FFF1DDFFEBD6FFEAD5FFEBD4FFFBE6CB8960E8BF9FFFFFE9FFE7CDFFE4CAFFE8
            CBFBE1C4D6BBA05D5B58CFC5B9FBECDDFFF3E3FFEEDEFFEEDCFFF1DFFFFFF8CE
            A082A54619FFEBCFFFF8E4FFE9D3FFEAD0FFE8CEDEC6B0847D75D2C9BFFCF1E6
            FFF7EBFFF2E5FFF4E7FFF6E7FFF2DEFFFEEF88340FA73B0FEDD2B8FFF8E7FFED
            D9FFF0DADDC7B2807B76E2D7CCF4EFE9FFFFF6FFF7EDFFFFFFC5997F8D1D00EB
            D3BEAB7A5E640000BD886AFFFFF8FFF9E9FAF0E1D6C0AB999999F6EFE8E3E2E0
            FFFEFCFFFFFBFFFFFFBD98855C0000E2C5B2853E21570000D2B39DFFFFFFFFFF
            FDF0E5DAB5A799E2E2E2FFFFFFF0E8E0EBEBECFFFFFFFFFFFFFFFFFFC59A84B9
            714D904E36C2A797FFFFFFFFFFFFF5F1EDD4C6B8DEDEDEFFFFFFFFFFFFFFFFFF
            F2EDE8EFEDECFAFCFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F0ECDDD3
            C9ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFAF8F2EEEAEFECE8F5F5F6F6
            F9FAF8F9F9F4EFEAEDE8E2EEEBE8FAFAFAFFFFFFFFFFFFFFFFFF}
          TabOrder = 2
          OnClick = btnAboutClick
        end
      end
      object Panel1: TPanel
        Left = 516
        Top = 0
        Width = 88
        Height = 78
        Align = alRight
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        object btnClose: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 82
          Height = 72
          Align = alClient
          Caption = #1047#1072#1082#1088#1099#1090#1100' (Ctrl+X)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          WordWrap = True
          OnClick = btnCloseClick
        end
      end
    end
  end
  object pnlLeft: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 87
    Width = 238
    Height = 595
    Align = alLeft
    ShowCaption = False
    TabOrder = 3
    ExplicitHeight = 795
    object ValueListEditor1: TValueListEditor
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 230
      Height = 117
      Align = alTop
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
      Strings.Strings = (
        '=')
      TabOrder = 0
      TitleCaptions.Strings = (
        #1055#1072#1088#1072#1084#1077#1090#1088
        #1047#1085#1072#1095#1077#1085#1080#1077)
      ColWidths = (
        117
        107)
    end
    object pcLeft: TPageControl
      Left = 1
      Top = 124
      Width = 236
      Height = 470
      ActivePage = tabCounters
      Align = alClient
      MultiLine = True
      Style = tsFlatButtons
      TabOrder = 1
      object tabCounters: TTabSheet
        Caption = #1057#1095#1077#1090#1095#1080#1082#1080
        object pnlCounters: TPanel
          Left = 0
          Top = 0
          Width = 228
          Height = 369
          Align = alTop
          BevelOuter = bvNone
          ShowCaption = False
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 228
            Height = 19
            Align = alTop
            Alignment = taCenter
            Caption = #1057#1063#1045#1058#1063#1048#1050#1048
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 81
          end
          object Panel3: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 22
            Width = 222
            Height = 337
            Align = alTop
            BevelOuter = bvLowered
            TabOrder = 0
            object Bevel1: TBevel
              Left = 85
              Top = 8
              Width = 1
              Height = 321
              Shape = bsLeftLine
            end
            object JvHTLabel1: TJvHTLabel
              Left = 8
              Top = 8
              Width = 63
              Height = 337
              Caption = 
                #1043#1056#1059#1055#1055#1040'  0<br>'#13#10#1043#1056#1059#1055#1055#1040'  1<br>'#13#10#1043#1056#1059#1055#1055#1040'  2<br>'#13#10#1043#1056#1059#1055#1055#1040'  3<br>'#13#10#1043#1056#1059#1055 +
                #1055#1040'  4<br>'#13#10#1043#1056#1059#1055#1055#1040'  5<br>'#13#10#1043#1056#1059#1055#1055#1040'  6<br>'#13#10#1043#1056#1059#1055#1055#1040'  7<br>'#13#10#1043#1056#1059#1055#1055#1040'  ' +
                '8<br>'#13#10#1043#1056#1059#1055#1055#1040'  9<br>'#13#10#1043#1056#1059#1055#1055#1040' 10<br>'#13#10#1043#1056#1059#1055#1055#1040' 11<br>'#13#10#1043#1056#1059#1055#1055#1040' 12<br' +
                '>'#13#10#1043#1056#1059#1055#1055#1040' 13<br>'#13#10#1043#1056#1059#1055#1055#1040' 14<br>'#13#10#1043#1056#1059#1055#1055#1040' 15<br>'#13#10'<br>'#13#10'<b>'#13#10'<font' +
                ' color=#007F00>'#1043#1054#1044#1053#1067#1045'</font><br>'#13#10'<font color=#0000FF>'#1041#1056#1040#1050'</font' +
                '><br>'#13#10#1042#1057#1045#1043#1054'<br>'#13#10'</b>'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object lblCounters: TJvHTLabel
              Left = 93
              Top = 8
              Width = 50
              Height = 321
              AutoSize = False
              Caption = 
                '<align="center">0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13 +
                #10'<font color=#0000FF>0</font><br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0' +
                '<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'<br>'#13#10'<b>'#13#10'<font color=#007F00>0</fon' +
                't><br>'#13#10'<font color=#0000FF>0</font><br>'#13#10'</b>'#13#10'</align>'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Bevel2: TBevel
              Left = 149
              Top = 8
              Width = 1
              Height = 305
              Shape = bsLeftLine
            end
            object lblPercents: TJvHTLabel
              Left = 157
              Top = 8
              Width = 50
              Height = 321
              AutoSize = False
              Caption = 
                '<align="center">0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13 +
                #10'<font color=#0000FF>0</font><br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0' +
                '<br>'#13#10'0<br>'#13#10'0<br>'#13#10'0<br>'#13#10'<br>'#13#10'<b>'#13#10'<font color=#007F00>0</fon' +
                't><br>'#13#10'<font color=#0000FF>0</font><br>'#13#10'</b>'#13#10'</align>'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object lblCountersAll: TLabel
              Left = 89
              Top = 312
              Width = 122
              Height = 16
              Alignment = taCenter
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
        object btnCountersReset: TButton
          AlignWithMargins = True
          Left = 3
          Top = 403
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1089#1095#1077#1090#1095#1080#1082#1080
          TabOrder = 1
          OnClick = btnCountersResetClick
        end
        object btnResetResults: TButton
          AlignWithMargins = True
          Left = 3
          Top = 372
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1079#1072#1084#1077#1088#1099
          TabOrder = 2
          OnClick = btnResetResultsClick
        end
      end
      object tabStat: TTabSheet
        Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        ImageIndex = 1
        object lblSTAFileName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 222
          Height = 23
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = #1047#1072#1087#1080#1089#1100' '#1085#1077' '#1074#1077#1076#1077#1090#1089#1103
          Layout = tlCenter
          ExplicitLeft = 0
          ExplicitTop = 25
          ExplicitWidth = 228
        end
        object btnSaveSTA: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1047#1072#1087#1080#1089#1100' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' '#1074' '#1092#1072#1081#1083'...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnSaveSTAClick
        end
        object btnBeginSTA: TButton
          AlignWithMargins = True
          Left = 3
          Top = 60
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1053#1072#1095#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnBeginSTAClick
        end
        object btnEndSTA: TButton
          AlignWithMargins = True
          Left = 3
          Top = 91
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnEndSTAClick
        end
      end
      object tabWP: TTabSheet
        Caption = #1056#1055
        ImageIndex = 2
        object btnShowWP: TButton
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1055#1088#1086#1089#1084#1086#1090#1088' "'#1056#1055'"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnShowWPClick
        end
        object btnShowNorms: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 222
          Height = 25
          Align = alTop
          Caption = #1055#1088#1086#1089#1084#1086#1090#1088' "'#1053#1086#1088#1084'"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnShowNormsClick
        end
      end
    end
  end
  object Thread: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = False
    FreeOnTerminate = True
    OnExecute = ThreadExecute
    Left = 555
    Top = 290
  end
  object AppEvents: TApplicationEvents
    OnShortCut = AppEventsShortCut
    Left = 556
    Top = 232
  end
  object PD: TJvProgressDialog
    ShowCancel = False
    Smooth = True
    Left = 555
    Top = 339
  end
  object Timer: TTimer
    Interval = 100
    OnTimer = TimerTimer
    Left = 611
    Top = 291
  end
end
