object MainData: TMainData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 222
  Width = 311
  object tblAll: TMemTableEh
    Params = <>
    Left = 64
    Top = 8
  end
  object dsAll: TDataSource
    DataSet = tblAll
    Left = 64
    Top = 56
  end
  object tblCurrent: TMemTableEh
    FieldDefs = <
      item
        Name = 'N'
        DataType = ftInteger
        Precision = 15
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Pin'
        DataType = ftByte
        Precision = 15
      end
      item
        Name = 'LNorm'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'Val'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'HNorm'
        DataType = ftFloat
        Precision = 15
      end
      item
        Name = 'Units'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Res'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Brak'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 16
    Top = 8
  end
  object dsCurrent: TDataSource
    DataSet = tblCurrent
    Left = 16
    Top = 56
  end
end
