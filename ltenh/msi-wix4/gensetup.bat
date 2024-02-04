@echo off
setlocal

echo 1. Make sure to have MSKLC installed under "C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4" or adjust the path to KbdMsi.dll in KbdMsi.wxs.
echo 2. Make sure that wix.exe from WiX4 is available in %%PATH%%.

set /p CONTINUE="Do you want to continue [y/N]? "
if /i "%CONTINUE%" NEQ "Y" GOTO END

@echo on

wix.exe build -arch x86 ltenh.wxs KbdMsi.wxs -out ltenh_x86.msi -loc ltenh_lt-LT.wxl || GOTO ERROR
wix.exe build -arch x64 ltenh.wxs KbdMsi.wxs -out ltenh_x64.msi -loc ltenh_lt-LT.wxl || GOTO ERROR
wix.exe build -arch arm64 ltenh.wxs KbdMsi.wxs -out ltenh_arm64.msi -loc ltenh_lt-LT.wxl || GOTO ERROR

del *.wixpdb
@goto END

:ERROR
@echo An error has been encountered. Script execution has been aborted.

:END
@endlocal