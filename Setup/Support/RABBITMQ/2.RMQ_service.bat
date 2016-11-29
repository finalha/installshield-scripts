set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"

:InstallRabbitMQService
pushd "%RabbitMQ_ROOT%\sbin"
set "ERLANG_HOME=C:\Program Files\erl%~2"
rabbitmq-service install
if not %errorlevel% == 0 goto InstallRabbitMQServiceError
if %errorlevel% == 0 goto End

:InstallRabbitMQServiceError
echo Failed to install rabbitmqservice
exit /B 1 
goto :EOF

:End
echo Succeed to install rabbitmq service
exit /B 0
goto :EOF

