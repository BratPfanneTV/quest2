system\PHP\php.exe system\files\pre.php "%~1" "%~3">system\files\tmp\%~1.bat
if "%2"=="-s" call system\files\tmp\%~1.bat
exit /b