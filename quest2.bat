@echo off
setlocal enabledelayedexpansion
set level=10
set path=%PATH%;%cd%\system\PHP
set path=%PATH%;%cd%\system\PortableGit\bin
set path=%PATH%;%cd%\system\custom

:loadworld
call phps serverlogin -s
call phps loadworld
call phps render

:screen
set remecho=rem
%remecho% Pinging Server.
call phps serverlogin -s
%remecho% Refreshing Screen...
call phps showscreen -s "%level%"
CHOICE /C 1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ /T 1 /D T>NUL
%remecho% Executing...
set errorlevel2=%errorlevel%
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