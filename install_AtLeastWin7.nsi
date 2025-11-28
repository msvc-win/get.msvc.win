!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "WinVer.nsh"
!include "x64.nsh"

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\Japanese.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\TradChinese.nlf"
LoadLanguageFile "${NSISDIR}\Contrib\Language files\SimpChinese.nlf"

Unicode true
SetCompressor /solid /final lzma
RequestExecutionLevel admin

!define /date BUILD_YEAR "%Y"
!define /date BUILD_MONTH "%m"
!define /date BUILD_DAY "%d"

LangString InstallerTitle ${LANG_ENGLISH} "MSVC Redistributable Runtime Offline Installer"
LangString InstallerTitle ${LANG_SIMPCHINESE} "MSVC 运行时离线安装程序"
LangString InstallerTitle ${LANG_TRADCHINESE} "MSVC 可再發行運行時離線安裝程式"
LangString InstallerTitle ${LANG_JAPANESE} "MSVC 再頒布可能ランタイムオフラインインストーラー"

LangString OSVersionMessage ${LANG_ENGLISH} "This installer requires Windows 7 or newer."
LangString OSVersionMessage ${LANG_SIMPCHINESE} "此安装程序仅支持 Windows 7 或更高版本。"
LangString OSVersionMessage ${LANG_TRADCHINESE} "此安裝程式僅支援 Windows 7 或更高版本。"
LangString OSVersionMessage ${LANG_JAPANESE} "このインストーラーには Windows 7 以降が必要です。"

Name "$(InstallerTitle)"
Icon "favicon.ico"
OutFile "MSVC_Offline_Setup_${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}_Win7.exe"
InstallDir $TEMP

BrandingText "msvc.win"

VIProductVersion "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0409 "ProductName" "MSVC Offline Installer"
VIAddVersionKey /LANG=0x0409 "FileDescription" "MSVC Offline Installer"
VIAddVersionKey /LANG=0x0409 "FileVersion" "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0409 "LegalCopyright" "msvc.win Project"

VIAddVersionKey /LANG=0x0404 "ProductName" "MSVC 可再發行運行時離線安裝程式"
VIAddVersionKey /LANG=0x0404 "FileDescription" "MSVC 可再發行運行時離線安裝程式"
VIAddVersionKey /LANG=0x0404 "FileVersion" "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0404 "LegalCopyright" "msvc.win Project"

VIAddVersionKey /LANG=0x0804 "ProductName" "MSVC 运行时离线安装程序"
VIAddVersionKey /LANG=0x0804 "FileDescription" "MSVC 运行时离线安装程序"
VIAddVersionKey /LANG=0x0804 "FileVersion" "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0804 "LegalCopyright" "msvc.win Project"

VIAddVersionKey /LANG=0x0411 "ProductName" "MSVC 再頒布可能ランタイムオフラインインストーラー"
VIAddVersionKey /LANG=0x0411 "FileDescription" "MSVC 再頒布可能ランタイムオフラインインストーラー"
VIAddVersionKey /LANG=0x0411 "FileVersion" "${BUILD_YEAR}.${BUILD_MONTH}.${BUILD_DAY}.0"
VIAddVersionKey /LANG=0x0411 "LegalCopyright" "msvc.win Project"

Function .onInit
${IfNot} ${AtLeastWin7}
  MessageBox MB_ICONSTOP "$(OSVersionMessage)"
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
  ${If} ${AtMostWin8}
    File "vcredist_v14_nt63_x86.exe"
    ExecWait '"$TEMP\vcredist\vcredist_v14_nt63_x86.exe" /quiet /norestart'
    ${If} ${RunningX64}
      File "vcredist_v14_nt63_x64.exe"
      ExecWait '"$TEMP\vcredist\vcredist_v14_nt63_x64.exe" /quiet /norestart'
    ${EndIf}
  ${Else}
    File "vcredist_v14_latest_x86.exe"
    ExecWait '"$TEMP\vcredist\vcredist_v14_latest_x86.exe" /quiet /norestart'
    ${If} ${RunningX64}
      File "vcredist_v14_latest_x64.exe"
      ExecWait '"$TEMP\vcredist\vcredist_v14_latest_x64.exe" /quiet /norestart'
    ${EndIf}
  ${EndIf}

  ; Cleanup
  RMDir /r $TEMP\vcredist

SectionEnd
