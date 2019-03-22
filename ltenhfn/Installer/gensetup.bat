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
del Installer\LtEnhFn.7z
del Installer\LtEnhFn.exe
del /F ltenhfn.c
del /F ltenhfn.def
del /F ltenhfn.h
del /F ltenhfn.rc
if EXIST amd64 rmdir /S /Q amd64
if EXIST i386 rmdir /S /Q i386
if EXIST ia64 rmdir /S /Q ia64
if EXIST wow64 rmdir /S /Q wow64

echo .
echo Is ltenhfn.klc failo generuojami atitinkami c, def, h ir rc failai...
echo .
kbdutool -n -u -s ltenhfn.klc
if NOT ERRORLEVEL 0 (
   echo .
   echo Sugeneruoti iseities failu nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Koreguojamas ltenhfn.c failas...
echo .
Installer\patch.exe -s -p0 < ltenhfn.c.patch
if NOT ERRORLEVEL 0 (
   echo .
   echo Pritaikyti pataisos nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Failams ltenhfn.c, ltenhfn.def, ltenhfn.h, ir ltenhfn.rc suteikiamas Read-only pozymis...
echo Zemiau matysite keleta klaidu, informuojanciu, jog siu failu nepavyks pakeisti. Nekreipkite i tai demesio.
echo .
attrib +R ltenhfn.c
attrib +R ltenhfn.def
attrib +R ltenhfn.h
attrib +R ltenhfn.rc

echo .
echo Kompiliuojamas amd64 failas...
echo .
kbdutool -n -u -m ltenhfn.klc
IF ERRORLEVEL 0 (
   mkdir amd64
   move /Y ltenhfn.dll amd64
) ELSE (
   echo .
   echo amd64 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Kompiliuojamas i386 failas...
echo .
kbdutool -n -u -x ltenhfn.klc
IF ERRORLEVEL 0 (
   mkdir i386
   move /Y ltenhfn.dll i386
) ELSE (
   echo .
   echo i386 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Kompiliuojamas ia64 failas...
echo .
kbdutool -n -u -i ltenhfn.klc
IF ERRORLEVEL 0 (
   mkdir ia64
   move /Y ltenhfn.dll ia64
) ELSE (
   echo .
   echo ia64 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

echo .
echo Kompiliuojamas wow64 failas...
echo .
kbdutool -n -u -o ltenhfn.klc
IF ERRORLEVEL 0 (
   mkdir wow64
   move /Y ltenhfn.dll wow64
) ELSE (
   echo .
   echo wow64 failo sukompiliuoti nepavyko, operacija nutraukiama.
   GOTO EOF
)

del /F ltenhfn.c
del /F ltenhfn.def
del /F ltenhfn.h
del /F ltenhfn.rc
Installer\7zr.exe a Installer\LtEnhFn.7z amd64 i386 ia64 wow64 *.msi *.klc setup.exe Installer\config.txt Installer\gensetup.bat README.ltenhfn.txt ltenhfn.C.patch -m0=BCJ2 -m1=LZMA:d25:fb255 -m2=LZMA:d19 -m3=LZMA:d19 -mb0:1 -mb0s1:2 -mb0s2:3 -mx
cd Installer
copy /b 7zS.sfx + config.txt + LtEnhFn.7z LtEnhFn.exe
del LtEnhFn.7z

:EOF
pause