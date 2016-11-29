set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"

ping localhost -n 10 > nul
pushd "%RabbitMQ_ROOT%\sbin"
set "ERLANG_HOME=C:\Program Files\erl%~2"
rabbitmqctl set_policy ha-all ".*" "{""ha-mode"":""all"", ""queue-master-locator"":""min-masters"", ""ha-sync-mode"":""automatic""}"
if not %errorlevel% == 0 goto SetPolicyError
if %errorlevel% == 0 goto End

:SetPolicyError
echo Failed to set rabbitmq policy
exit /B 1 
goto :EOF

:End
echo Succeed to set rabbitmq policy
exit /B 0
goto :EOF


