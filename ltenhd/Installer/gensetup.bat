@echo ===========================================================
@echo Norint pagaminti Lithuanian Enhanced idiegimo paketa, 
@echo reikia is www.7-zip.org parsisiusti faila, kurio aprasas 
@echo "7z Library, SFXs for installers, Plugin for FAR Manager", 
@echo ir is jo i si aplanka ispakuoti 7zr.exe bei 7zS.sfx failus.
@echo ===========================================================
del LtEnhD.7z
del LtEnhD.exe
cd ..
Installer\7zr a Installer\LtEnhD.7z amd64 i386 ia64 wow64 *.msi *.klc setup.exe Installer\config.txt Installer\gensetup.bat -m0=BCJ2 -m1=LZMA:d25:fb255 -m2=LZMA:d19 -m3=LZMA:d19 -mb0:1 -mb0s1:2 -mb0s2:3 -mx
cd Installer
copy /b 7zS.sfx + config.txt + LtEnhD.7z LtEnhD.exe
del LtEnhD.7z