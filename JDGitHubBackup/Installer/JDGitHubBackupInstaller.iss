#define MyAppName "JD GitHub Backup"
#define MyAppVersion "0.3.3"
#define MyAppPublisher "JD Software Inc"
#define MyAppURL "http://www.jerrydodge.com/GitHubBackup"
#define MyAppExeName "JDGitHubBackup.exe"

[Setup]
AppId={{C07914D4-3BDD-433C-9CB6-A3F3EB25F99F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=..\..\Bin\Win32\
OutputBaseFilename=JDGitHubBackupSetup
SetupIconFile=..\..\Images\media (1).ico 
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "..\..\Bin\Win32\JDGitHubBackup.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\Bin\Win32\libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\Bin\Win32\ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion     
Source: "..\..\Bin\Win32\JDGitHubBackupHelp.chm"; DestDir: "{app}"; Flags: ignoreversion
; Source: "..\..\Bin\Win32\FontAwesome.ttf"; DestDir: "{fonts}"; FontInstall: "FontAwesome"; Flags: onlyifdoesntexist uninsneveruninstall

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[InstallDelete]
Type: files; Name: "{app}\GitHubBackup.exe"

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

