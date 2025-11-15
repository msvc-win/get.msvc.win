!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "WinVer.nsh"
!include "x64.nsh"

!define /date BUILD_YEAR "%Y"
!define /date BUILD_MONTH "%m"
!define /date BUILD_DAY "%d"


Name "MSVC Redistributable Runtime Offline Installer"
Icon "favicon.ico"
OutFile "MSVC_Offline_Setup_${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}_Win10_11.exe"
InstallDir $TEMP

VIProductVersion "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0409 "ProductName" "MSVC Offline Installer"
VIAddVersionKey /LANG=0x0409 "FileDescription" "MSVC Offline Installer"
VIAddVersionKey /LANG=0x0409 "FileVersion" "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0409 "LegalCopyright" "msvc.win Project"

VIAddVersionKey /LANG=0x0804 "ProductName" "MSVC 运行时离线安装程序"
VIAddVersionKey /LANG=0x0804 "FileDescription" "MSVC 运行时离线安装程序"
VIAddVersionKey /LANG=0x0804 "FileVersion" "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0804 "LegalCopyright" "msvc.win Project"

Unicode true
SetCompressor /solid /final lzma
RequestExecutionLevel admin

Function .onInit
${IfNot} ${AtLeastWin10}
  MessageBox MB_ICONSTOP "This installer requires Windows 10 or newer."
  Abort
${EndIf}
FunctionEnd

Section "MSVC Install"

  ; Create a temp folder
  SetOutPath $TEMP\vcredist

  ; --- VC++ 2005 ---
  File "vcredist_2005_x86.exe"
  ExecWait '"$TEMP\vcredist\vcredist_2005_x86.exe" /Q'
  ${If} ${RunningX64}
    File "vcredist_2005_x64.exe"
    ExecWait '"$TEMP\vcredist\vcredist_2005_x64.exe" /Q'
  ${EndIf}

  ; --- VC++ 2008 ---
  File "vcredist_2008_x86.exe"
  ExecWait '"$TEMP\vcredist\vcredist_2008_x86.exe" /Q'
  ${If} ${RunningX64}
    File "vcredist_2008_x64.exe"
    ExecWait '"$TEMP\vcredist\vcredist_2008_x64.exe" /Q'
  ${EndIf}

  ; --- VC++ 2010 ---
  File "vcredist_2010_x86.exe"
  ExecWait '"$TEMP\vcredist\vcredist_2010_x86.exe" /quiet /norestart'
  ${If} ${RunningX64}
    File "vcredist_2010_x64.exe"
    ExecWait '"$TEMP\vcredist\vcredist_2010_x64.exe" /quiet /norestart'
  ${EndIf}

  ; --- VC++ 2012 ---
  File "vcredist_2012_x86.exe"
  ExecWait '"$TEMP\vcredist\vcredist_2012_x86.exe" /quiet /norestart'
  ${If} ${RunningX64}
    File "vcredist_2012_x64.exe"
    ExecWait '"$TEMP\vcredist\vcredist_2012_x64.exe" /quiet /norestart'
  ${EndIf}

  ; --- VC++ 2013 ---
  File "vcredist_2013_x86.exe"
  ExecWait '"$TEMP\vcredist\vcredist_2013_x86.exe" /quiet /norestart'
  ${If} ${RunningX64}
    File "vcredist_2013_x64.exe"
    ExecWait '"$TEMP\vcredist\vcredist_2013_x64.exe" /quiet /norestart'
  ${EndIf}

  ; --- VC++ 14 ---
  File "vcredist_v14_latest_x86.exe"
  ExecWait '"$TEMP\vcredist\vcredist_v14_latest_x86.exe" /quiet /norestart'
  ${If} ${RunningX64}
    File "vcredist_v14_latest_x64.exe"
    ExecWait '"$TEMP\vcredist\vcredist_v14_latest_x64.exe" /quiet /norestart'
  ${EndIf}

  ; Cleanup
  RMDir /r $TEMP\vcredist

SectionEnd
