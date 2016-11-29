set "STUNNEL_ROOT=%~1"
set "CurrentDir=%~dp0"
set "STUNNEL_PORT=%~2"
set "REDIS_PORT=%~3"

pushd "%STUNNEL_ROOT%\bin"
stunnel -install -quiet
ping localhost -n 5 > nul
stunnel -stop -quiet
ping localhost -n 5 > nul
pushd "%STUNNEL_ROOT%\config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%STUNNEL_ROOT%\config\stunnel.conf" "accept = 7000" "accept = %STUNNEL_PORT%" "%STUNNEL_ROOT%\config\stunnel.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%STUNNEL_ROOT%\config\stunnel.conf" "connect = 127.0.0.1:6379" "connect = 127.0.0.1:%REDIS_PORT%" "%STUNNEL_ROOT%\config\stunnel.conf"
if not %errorlevel% == 0 goto ModifyStunnelConfigError
if %errorlevel% == 0 goto End

:ModifyStunnelConfigError
echo Failed to modify stunnel.conf
pushd "%STUNNEL_ROOT%\bin"
stunnel -start -quiet
ping localhost -n 5 > nul
exit /B 1 
goto :EOF

:End
echo Succeed to modify stunnel.conf
pushd "%STUNNEL_ROOT%\bin"
stunnel -start -quiet
ping localhost -n 5 > nul
exit /B 0
goto :EOF