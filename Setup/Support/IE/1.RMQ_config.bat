set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"
set "ConfigPath=%RabbitMQ_ROOT%\etc"
set "DestPath=%APPDATA%\RabbitMQ"
set "CurrentDir=%~dp0"
set "LocalPort=%~3"

:DeployRabbitMQ
if not exist "%DestPath%" mkdir "%DestPath%"
copy "%ConfigPath%\rabbitmq.config.example" "%DestPath%\rabbitmq.config" /Y
pushd "%DestPath%"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "{tcp_listeners, \[\]}," "{tcp_listeners, [%LocalPort%]}," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {loopback_users, \[\]}," "{loopback_users, []}" "%DestPath%\rabbitmq.config"
if not %errorlevel% == 0 goto ModifyConfigError
if %errorlevel% == 0 goto RestartRabbitMQ

:RestartRabbitMQ
REM pushd "%RabbitMQ_ROOT%\sbin"
REM rabbitmq-server stop
REM ping localhost -n 10 > nul
REM rabbitmq-server start 
REM net stop RabbitMQ
REM ping localhost -n 10 > nul
REM net start RabbitMQ
if not %errorlevel% == 0 goto RestartServerError
if %errorlevel% == 0 goto End

:ModifyConfigError
echo Failed to modify rabbitmq.config
exit /B 1 
goto :EOF

:RestartServerError
echo Failed to restart rabbitmq-server
exit /B 1 
goto :EOF

:End
echo Succeed to modify rabbitmq.config
exit /B 0
goto :EOF
