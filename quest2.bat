@echo off
if "%1"=="--launch" goto initgame
if "%1"=="--launcher" goto launcher
rmdir /s /q system\files\tmp
mkdir system\files\tmp
(
	echo This is literally just a file to keep this directory from being ignored, while everything else in it is being ignored.
	echo Goodbye.
)>system\files\tmp\hello
goto l

:l
title Initiating...
start /min "" cmd /k "call %0 --launcher"
exit

:launcher
title Launcher
(
	echo @echo off
	echo title Server Connector
	echo :loop
	echo call "system\custom\phps" serverlogin -s
	echo timeout 1 ^>NUL
	echo goto loop
)>system\files\tmp\connector.bat

start /min "Server Connector" "system\files\tmp\connector.bat"
start /wait "Game" cmd /k "call %0 --launch" & taskkill /f /im cmd.exe


:initgame
setlocal enabledelayedexpansion
set level=10
set path=%PATH%;%cd%\system\PHP
set path=%PATH%;%cd%\system\PortableGit\bin
set path=%PATH%;%cd%\system\custom
set path=%PATH%;%cd%\system\3rdparty\bg39

:loadworld
call phps serverlogin -s
call phps loadworld
call phps render
call phps splitchunks

if not exist system\files\data\USERNAME.DAT call :changename
goto screen

:changename
set /p username=Enter your Username ^> 
echo %username% >system\files\data\USERNAME.DAT
exit /b

:screen
set remecho=rem
%remecho% Pinging Server.
%remecho% Refreshing Screen...
call phps showscreen -s "%level%"
rem TTTTTTTTTTTTTTTTTTTT
set string=1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
set loopc=/T 1 /D T
if "%actionlog%"=="TTTTTTTTTTTTTTTTTTTT" set loopc=
CHOICE /C 1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ %loopc%>NUL
%remecho% Executing...
set errorlevel2=%errorlevel%
set /a el=errorlevel2 - 1
set charac=!string:~%el%,1!
if "%lcharac%"=="O" call :debug-%charac%
if "%lcharac%"=="O" pause
if "%lcharac%"=="O" set lcharac=%charac%&goto screen
set lcharac=%charac%
if "%charac%" NEQ "O" set actionlog=%actionlog%%charac%
set actionlog=%actionlog:~-20,20%
set cphp=
call :action-%errorlevel2% 2>NUL
if "%cphp%" EQU "" call phps action -s "%errorlevel2%"
%remecho% Executed.
goto screen

:action-11
if "%blockYb%"=="true" set cphp=true
exit /b

:action-14
if "%blockYa%"=="true" set cphp=true
exit /b

:action-29
if "%blockXa%"=="true" set cphp=true
exit /b

:action-33
if "%blockXb%"=="true" set cphp=true
exit /b

:action-27
set /a level=level - 2
exit /b

:action-15
set /a level=level + 2
exit /b

:action-31
call :changename
exit /b

:debug-P
call phps pings -s
exit /b

:debug-V
set
exit /b

:debug-S
type system\files\tmp\stdata.json
echo(
exit /b