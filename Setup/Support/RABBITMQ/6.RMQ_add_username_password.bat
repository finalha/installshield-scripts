set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"
set "RabbitMQ_USERNAME=%~3"
set "RabbitMQ_PASSWORD=%~4"

ping localhost -n 10 > nul
pushd "%RabbitMQ_ROOT%\sbin"
set "ERLANG_HOME=C:\Program Files\erl%~2"
rabbitmqctl add_user "%RabbitMQ_USERNAME%" "%RabbitMQ_PASSWORD%"
if not %errorlevel% == 0 goto AddUserNamePasswordError
if %errorlevel% == 0 goto End

:AddUserNamePasswordError
echo Failed to add rabbitmq username and password
exit /B 1 
goto :EOF

:End
echo Succeed to add rabbitmq username and password
exit /B 0
goto :EOF


