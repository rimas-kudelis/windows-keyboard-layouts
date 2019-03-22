@echo off
echo Palaukite...
.\iexpress.exe /N /Q LtEnh9x.sed /d:.
IF %ERRORLEVEL% NEQ 0 GOTO Nepavyko
echo.
echo ‘diegimo paketas (LtEnh9x.exe) pagamintas s”kmingai.
echo.
SET TESTUOJAM=N
SET /P TESTUOJAM=Ar norite j‘ i’bandyti(t/N)? 
IF /I %TESTUOJAM%==t .\LtEnh9x.exe
SET TESTUOJAM=
GOTO EOF
:Nepavyko
echo.
echo Pagaminti ‘diegimo failo nepavyko.
echo.
pause
:EOF
