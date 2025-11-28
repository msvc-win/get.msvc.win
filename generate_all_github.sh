#!/bin/bash

# This script is for GitHub Actions only.

shopt -s nocasematch

cat << EOF > downloadLink.txt
https://download.microsoft.com/download/8/b/4/8b42259f-5d70-43f4-ac2e-4b208fd8d66a/vcredist_x86.exe
    out=vcredist_2005_x86.exe

https://download.microsoft.com/download/8/b/4/8b42259f-5d70-43f4-ac2e-4b208fd8d66a/vcredist_x64.exe
    out=vcredist_2005_x64.exe

https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe
    out=vcredist_2008_x86.exe

https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe
    out=vcredist_2008_x64.exe

https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe
    out=vcredist_2010_x86.exe

https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe
    out=vcredist_2010_x64.exe

https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe
    out=vcredist_2012_x86.exe

https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe
    out=vcredist_2012_x64.exe

https://aka.ms/highdpimfc2013x86enu
    out=vcredist_2013_x86.exe

https://aka.ms/highdpimfc2013x64enu
    out=vcredist_2013_x64.exe

https://download.visualstudio.microsoft.com/download/pr/566435ac-4e1c-434b-b93f-aecc71e8cffc/0D59EC7FDBF05DE813736BF875CEA5C894FFF4769F60E32E87BD48406BBF0A3A/VC_redist.x86.exe
    out=vcredist_v14_nt52_x86.exe

https://download.visualstudio.microsoft.com/download/pr/566435ac-4e1c-434b-b93f-aecc71e8cffc/B75590149FA14B37997C35724BC93776F67E08BFF9BD5A69FACBF41B3846D084/VC_redist.x64.exe
    out=vcredist_v14_nt52_x64.exe

https://download.visualstudio.microsoft.com/download/pr/ed95ef9e-da02-4735-9064-bd1f7f69b6ed/CF92A10C62FFAB83B4A2168F5F9A05E5588023890B5C0CC7BA89ED71DA527B0F/VC_redist.x86.exe
    out=vcredist_v14_nt60_x86.exe

https://download.visualstudio.microsoft.com/download/pr/ed95ef9e-da02-4735-9064-bd1f7f69b6ed/CE6593A1520591E7DEA2B93FD03116E3FC3B3821A0525322B0A430FAA6B3C0B4/VC_redist.x64.exe
    out=vcredist_v14_nt60_x64.exe

https://aka.ms/vs/17/release/vc_redist.x86.exe
    out=vcredist_v14_nt63_x86.exe

https://aka.ms/vs/17/release/vc_redist.x64.exe
    out=vcredist_v14_nt63_x64.exe

https://aka.ms/vc14/vc_redist.x86.exe
    out=vcredist_v14_latest_x86.exe

https://aka.ms/vc14/vc_redist.x64.exe
    out=vcredist_v14_latest_x64.exe
EOF

mkdir msvc_offline
aria2c --dir=msvc_offline --allow-overwrite=true --retry-wait=5 --max-connection-per-server=8 --split=8 --min-split-size=1M -i downloadLink.txt

pushd msvc_offline
makensis ../install_AllOS.nsi
makensis ../install_AtLeastWin7.nsi
makensis ../install_AtLeastWin10.nsi
rm vcredist*.exe
installerFileName=$(ls *.exe)
mv *.exe ../
popd

rm -rf msvc_offline

echo -e "All installer files are generated at current directory. "