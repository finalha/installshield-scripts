set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"
set "RabbitMQ_USERNAME=%~3"

ping localhost -n 10 > nul
pushd "%RabbitMQ_ROOT%\sbin"
set "ERLANG_HOME=C:\Program Files\erl%~2"
rabbitmqctl set_permissions "%RabbitMQ_USERNAME%" ".*" ".*" ".*"
if not %errorlevel% == 0 goto SetPermissionsError
if %errorlevel% == 0 goto End

:SetPermissionsError
echo Failed to set user administrator tags
exit /B 1 
goto :EOF

:End
echo Succeed to set user administrator tags
exit /B 0
goto :EOF


