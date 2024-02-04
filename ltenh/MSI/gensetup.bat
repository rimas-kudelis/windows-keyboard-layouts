@echo off
setlocal

echo 1. Make sure to have MSKLC installed under "C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4" or adjust the path to KbdMsi.dll in ltenh.wxs.
echo 2. Open this file and make sure that the "PATH" variable is set to contain the path to WiX binaries.

set /p CONTINUE="Do you want to continue [y/N]? "
if /i "%CONTINUE%" NEQ "Y" GOTO END

@echo on
set "PATH=%PATH%;C:\Users\Rimas\Downloads\wix314-binaries\"

candle.exe .\KbdMsi.wxs -arch x64 -out KbdMsi_x64.wixobj || GOTO ERROR
candle.exe .\ltenh.wxs -arch x64 -out ltenh_x64.wixobj || GOTO ERROR

candle.exe .\KbdMsi.wxs -arch x86 -out KbdMsi_x86.wixobj || GOTO ERROR
candle.exe .\ltenh.wxs -arch x86 -out ltenh_x86.wixobj || GOTO ERROR

candle.exe .\KbdMsi.wxs -arch arm64 -out KbdMsi_arm64.wixobj || GOTO ERROR
candle.exe .\ltenh.wxs -arch arm64 -out ltenh_arm64.wixobj || GOTO ERROR

candle.exe .\KbdMsi.wxs -arch ia64 -out KbdMsi_ia64.wixobj || GOTO ERROR
candle.exe .\ltenh.wxs -arch ia64 -out ltenh_ia64.wixobj || GOTO ERROR

light.exe .\ltenh_x64.wixobj KbdMsi_x64.wixobj -ext WixUIExtension -cultures:lt-LT -loc ltenh_lt-LT.wxl -out ltenh_x64.msi
light.exe .\ltenh_x86.wixobj KbdMsi_x86.wixobj -ext WixUIExtension -cultures:lt-LT -loc ltenh_lt-LT.wxl -out ltenh_x86.msi
light.exe .\ltenh_arm64.wixobj KbdMsi_arm64.wixobj -ext WixUIExtension -cultures:lt-LT -loc ltenh_lt-LT.wxl -out ltenh_arm64.msi
light.exe .\ltenh_ia64.wixobj KbdMsi_ia64.wixobj -ext WixUIExtension -cultures:lt-LT -loc ltenh_lt-LT.wxl -out ltenh_ia64.msi

del *.wixobj *.wixpdb
@goto END

:ERROR
@echo An error has been encountered. Script execution has been aborted.

:END
@endlocal