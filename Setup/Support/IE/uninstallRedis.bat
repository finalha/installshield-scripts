pushd "%~1"
msiexec /uninstall "%~1\%~2" /qn
if not %errorlevel% == 0 goto UninstallRedisError
if %errorlevel% == 0 goto End

:UninstallRedisError
echo Failed to uninstall Redis
exit /B 1 
goto :EOF

:End
echo Succeed to uninstall Redis
exit /B 0
goto :EOF

