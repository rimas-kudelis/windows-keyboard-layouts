@echo off
setlocal

echo 1. Make sure to have MSKLC installed under "C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4" or adjust the path to KbdMsi.dll in ltenh.wxs.
echo 2. Open this file and make sure that the "PATH" variable is set to contain the path to WiX binaries.

set /p CONTINUE="Do you want to continue [y/N]? "
if /i "%CONTINUE%" NEQ "Y" GOTO END

set "PATH=%PATH%;C:\Users\Rimas\Downloads\wix311-binaries\"

candle.exe .\ltenh.wxs -arch x64 -out ltenh_amd64.wixobj
candle.exe .\ltenh.wxs -arch x86 -out ltenh_i386.wixobj
candle.exe .\ltenh.wxs -arch ia64 -out ltenh_ia64.wixobj

light.exe .\ltenh_amd64.wixobj
light.exe .\ltenh_i386.wixobj
light.exe .\ltenh_ia64.wixobj

del *.wixobj *.wixpdb
:END

endlocal