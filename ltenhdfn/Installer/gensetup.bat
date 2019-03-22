@echo off
@echo ===========================================================
@echo Norint pagaminti Lithuanian Enhanced (Fn) idiegimo paketa, 
@echo reikia is www.7-zip.org parsisiusti faila, kurio aprasas 
@echo "7z Library, SFXs for installers, Plugin for FAR Manager", 
@echo ir is jo i si aplanka ispakuoti 7zr.exe bei 7zS.sfx failus.
@echo ===========================================================

SET PATH=%PATH%;"C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4\bin\i386"

echo .
echo Salinami failai ir aplankai, kurie bus sukurti proceso metu...
echo .
cd ..
del Installer\LtEnhDFn.7z
del Installer\LtEnhDFn.exe
del /F LtEnhDFn.c
del /F LtEnhDFn.def
del /F LtEnhDFn.h
del /F LtEnhDFn.rc
if EXIST amd64 rmdir /S /Q amd64
if EXIST i386 rmdir /S /Q i386
if EXIST ia64 rmdir /S /Q ia64
if EXIST wow64 rmdir /S /Q wow64

echo .
echo Is LtEnhDFn.klc failo generuojami atitinkami c, def, h ir rc failai...
echo .
kbdutool -n -u -s LtEnhDFn.klc
if NOT ERRORLEVEL 0 (
   echo .
   echo Sugeneruoti iseities failu nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Koreguojamas LtEnhDFn.c failas...
echo .
Installer\patch.exe -s -p0 < LtEnhDFn.c.patch
if NOT ERRORLEVEL 0 (
   echo .
   echo Pritaikyti pataisos nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Failams LtEnhDFn.c, LtEnhDFn.def, LtEnhDFn.h, ir LtEnhDFn.rc suteikiamas Read-only pozymis...
echo Zemiau matysite keleta klaidu, informuojanciu, jog siu failu nepavyks pakeisti. Nekreipkite i tai demesio.
echo .
attrib +R LtEnhDFn.c
attrib +R LtEnhDFn.def
attrib +R LtEnhDFn.h
attrib +R LtEnhDFn.rc

echo .
echo Kompiliuojamas amd64 failas...
echo .
kbdutool -n -u -m LtEnhDFn.klc
IF ERRORLEVEL 0 (
   mkdir amd64
   move /Y LtEnhDFn.dll amd64
) ELSE (
   echo .
   echo amd64 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Kompiliuojamas i386 failas...
echo .
kbdutool -n -u -x LtEnhDFn.klc
IF ERRORLEVEL 0 (
   mkdir i386
   move /Y LtEnhDFn.dll i386
) ELSE (
   echo .
   echo i386 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Kompiliuojamas ia64 failas...
echo .
kbdutool -n -u -i LtEnhDFn.klc
IF ERRORLEVEL 0 (
   mkdir ia64
   move /Y LtEnhDFn.dll ia64
) ELSE (
   echo .
   echo ia64 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Kompiliuojamas wow64 failas...
echo .
kbdutool -n -u -o LtEnhDFn.klc
IF ERRORLEVEL 0 (
   mkdir wow64
   move /Y LtEnhDFn.dll wow64
) ELSE (
   echo .
   echo wow64 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

del /F LtEnhDFn.c
del /F LtEnhDFn.def
del /F LtEnhDFn.h
del /F LtEnhDFn.rc
Installer\7zr.exe a Installer\LtEnhDFn.7z amd64 i386 ia64 wow64 *.msi *.klc setup.exe Installer\config.txt Installer\gensetup.bat README.LtEnhDFn.txt LtEnhDFn.C.patch -m0=BCJ2 -m1=LZMA:d25:fb255 -m2=LZMA:d19 -m3=LZMA:d19 -mb0:1 -mb0s1:2 -mb0s2:3 -mx
cd Installer
copy /b 7zS.sfx + config.txt + LtEnhDFn.7z LtEnhDFn.exe
del LtEnhDFn.7z

:EOF
pause