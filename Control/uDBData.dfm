object DBData: TDBData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 235
  Width = 356
  object DB: TpFIBDatabase
    DBName = 'MZU_DB_YANDEX'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    DefaultTransaction = Transaction
    SQLDialect = 3
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 16
    Top = 8
  end
  object Transaction: TpFIBTransaction
    DefaultDatabase = DB
    Left = 16
    Top = 56
  end
  object PropStorage: TPropStorageEh
    Active = False
    Section = 'uData'
    StoredProps.Strings = (
      'DB.<P>.DBName')
    Left = 272
    Top = 56
  end
end
