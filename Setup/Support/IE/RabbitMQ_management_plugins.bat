set "RabbitMQ_ROOT=%~1"

pushd "%RabbitMQ_ROOT%\sbin"
rabbitmq-plugins enable rabbitmq_management 

if not %errorlevel% == 0 goto Error
if %errorlevel% == 0 goto End

:Error
exit /B 1 
goto :EOF

:End

exit /B 0
goto :EOF