
set "version=%~2"

cd "%1"

if %version%==8 ( 
Helper.exe /p InstallIIS8.bat
) else (
Helper.exe /p InstallIIS7.bat
)

if not %errorlevel% == 0 goto Error
if %errorlevel% == 0 goto End

:Error
exit /B 1 
goto :EOF

:End
exit /B 0
goto :EOF