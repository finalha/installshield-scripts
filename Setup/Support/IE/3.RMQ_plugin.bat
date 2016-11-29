set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"

net stop RabbitMQ
ping localhost -n 10 > nul
net start RabbitMQ
REM set RabbitMQ reset in 5 seconds on failure
ping localhost -n 5 > nul
sc failure RabbitMQ reset= 0 actions= restart/5000
if not %errorlevel% == 0 goto SCFailureError
pushd "%RabbitMQ_ROOT%\sbin"
set "ERLANG_HOME=C:\Program Files\erl%~2"
rabbitmq-plugins enable rabbitmq_management 
if not %errorlevel% == 0 goto StartServerError
if %errorlevel% == 0 goto End

:SCFailureError
echo Failed to set RabbitMQ failure
exit /B 1 
goto :EOF

:StartServerError
echo Failed to enable rabbitmq_management 
exit /B 1 
goto :EOF

:End
echo Succeed to enable rabbitmq_management and set rabbitmq policy
exit /B 0
goto :EOF


