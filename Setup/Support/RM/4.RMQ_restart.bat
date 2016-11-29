set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"

net stop RabbitMQ
ping localhost -n 10 > nul
net start RabbitMQ
pushd "%RabbitMQ_ROOT%\sbin"
set "ERLANG_HOME=C:\Program Files\erl%~2"
rabbitmqctl start_app
if not %errorlevel% == 0 goto RestartError
if %errorlevel% == 0 goto End

:RestartError
echo Failed to restart rabbitmq 
exit /B 1 
goto :EOF

:End
echo Succeed to restart rabbitmq
exit /B 0
goto :EOF


