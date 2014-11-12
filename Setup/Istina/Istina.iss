; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "�� ������� '������'"
#define MyAppVersion "0.1"
#define MyAppPublisher "��� ��� ������������ � ������������ ����������"
#define MyAppExeName "Istina_VCL.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{EE353F15-E858-4E13-B22B-DB0A1A91F174}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\Istina
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputBaseFilename=Istina_setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "D:\OUT\BIN\Release\Istina_VCL.exe"; DestDir: "{app}"
Source: "D:\OUT\BIN\Release\Istina_Console.exe"; DestDir: "{app}"
Source: "D:\OUT\BIN\Release\Istina_Editor.exe"; DestDir: "{app}"
Source: "D:\OUT\BIN\Release\Istina_Syntax.exe"; DestDir: "{app}"

[Icons]
Name: "{group}\����������� ���������"; Filename: "{app}\Istina_VCL.exe"
Name: "{group}\����������� ��������� (�������)"; Filename: "{app}\Istina_Console.exe"
Name: "{group}\�������� ��"; Filename: "{app}\Istina_Editor.exe"
Name: "{group}\�������� ���������� ��"; Filename: "{app}\Istina_Syntax.exe"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\������ - ��"; Filename: "{app}\Istina_VCL.exe"; Tasks: desktopicon
Name: "{commondesktop}\������ - �� (�������)"; Filename: "{app}\Istina_Console.exe"; Tasks: desktopicon
Name: "{commondesktop}\������ - �������� ��"; Filename: "{app}\Istina_Editor.exe"; Tasks: desktopicon
Name: "{commondesktop}\������ - ��������� ��"; Filename: "{app}\Istina_Syntax.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Types]
Name: "minimal"; Description: "����������� ���������"
Name: "full"; Description: "������ ���������"
Name: "custom"; Description: "���������� ���������"; Flags: iscustom

[Components]
Name: "a"; Description: "�� ������� '������'"; Types: full
Name: "a\a"; Description: "����������� ���������"; Types: full minimal
Name: "a\b"; Description: "����������� ��������� (�������)"; Types: full
Name: "b"; Description: "����������� ������������"; Types: full
Name: "b\a"; Description: "�������� ��"; Types: full
Name: "b\b"; Description: "�������� ���������� ��"; Types: full