cd "%1"

if "%~2"=="ASPNET45" (
Helper.exe /p InstallASPNET45.bat
) else (
Helper.exe /p InstallASPNET.bat
)
if not %errorlevel% == 0 goto Error
if %errorlevel% == 0 goto End

:Error
exit /B 1 
goto :EOF

:End
exit /B 0
goto :EOF