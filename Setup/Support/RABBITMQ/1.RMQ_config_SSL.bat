set "RabbitMQ_ROOT=%~1"
set "ERLANG_HOME=C:\Program Files\erl%~2"
set "ConfigPath=%RabbitMQ_ROOT%\etc"
set "DestPath=%APPDATA%\RabbitMQ"
set "CurrentDir=%~dp0"
set "LocalPort=%~3"
REM set "rabbitMqCertCaPath=%~4"
set "rabbitMqCertPath=%~4"
set "rabbitMqPrivateKey=%~5"

:DeployRabbitMQ
if not exist "%DestPath%" mkdir "%DestPath%"
copy "%ConfigPath%\rabbitmqfornetbrain.config.example" "%DestPath%\rabbitmq.config" /Y
pushd "%DestPath%"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {ssl, \[{versions, \[\'tlsv1.2\', \'tlsv1.1\', \'tlsv1\'\]}\]}," "{ssl, [{versions, ['tlsv1.2', 'tlsv1.1', 'tlsv1']}]}," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {ssl_listeners, \[5671\]}," "{ssl_listeners, [%LocalPort%]}," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "{channel_operation_timeout, 15000}" "{channel_operation_timeout, 15000}," "%DestPath%\rabbitmq.config"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {ssl_options,\[{cacertfile," "{ssl_options,[{cacertfile," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {ssl_options,\[" "{ssl_options,[" "%DestPath%\rabbitmq.config"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "C\:/cacert.pem" "%rabbitMqCertCaPath%" "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {certfile," "{certfile," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "C\:/cert.pem" "%rabbitMqCertPath%" "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {keyfile," "{keyfile," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "C\:/key.pem" "%rabbitMqPrivateKey%" "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {verify, verify_none}," "{verify, verify_none}," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {fail_if_no_peer_cert, false}," "{fail_if_no_peer_cert, false}," "%DestPath%\rabbitmq.config"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {versions, \[\'tlsv1.2\', \'tlsv1.1\', \'tlsv1\'\]}\]}," "{versions, ['tlsv1.2', 'tlsv1.1', 'tlsv1']}]}" "%DestPath%\rabbitmq.config"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {versions, \[\'tlsv1.2\', \'tlsv1.1\', \'tlsv1\'\]}\]}," "{versions, ['tlsv1.2', 'tlsv1.1', 'tlsv1']}]}," "%DestPath%\rabbitmq.config"
REM if exists username and password,we don't need lookback_users(guest/guest)
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%DestPath%\rabbitmq.config" "%%%% {loopback_users, \[\]}," "{loopback_users, []}" "%DestPath%\rabbitmq.config"
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
