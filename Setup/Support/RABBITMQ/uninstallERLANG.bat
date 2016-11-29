pushd "C:\Program Files\erl%~1"
Uninstall.exe /S
if not %errorlevel% == 0 goto UninstallERLANGError
if %errorlevel% == 0 goto End

:UninstallERLANGError
echo Failed to uninstall ERLANG
exit /B 1 
goto :EOF

:End
echo Succeed to uninstall ERLANG
exit /B 0
goto :EOF

