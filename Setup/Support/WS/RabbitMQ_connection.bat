set "RabbitMQIP=%~1"

:ConnectRabbitMQ
ping "%RabbitMQIP%" -n 10
if not %errorlevel% == 0 goto ConnectRabbitMQError
if %errorlevel% == 0 goto End

:ConnectRabbitMQError
echo Failed to connect RabbitMQ "%RabbitMQIP%"
exit /B 1 
goto :EOF

:End
echo Succeed to connect RabbitMQ "%RabbitMQIP%"
exit /B 0
goto :EOF