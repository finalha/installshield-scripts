set "INSTALLPATH=%~1"
set "RABBITMQCONNECTIONSTR=%~2"
REM set "AMQPPORT=%~3"
set "REDISIP=%~3"
set "REDISPORT=%~4"
set "MONGODBRSSTRING=%~5"
set "AMQPPORT=%~6"
set "CurrentDir=%~dp0"

:ConfigWS
pushd "%INSTALLPATH%"

cscript.exe "%CurrentDir%\replacefiletextnew.vbs" "%INSTALLPATH%\Web.config" "/configuration/connectionStrings/add[@name='MongoDB']" "connectionString" "mongodb://%MONGODBRSSTRING%&maxPoolSize=1000" "%INSTALLPATH%\WebNew.config"
REM cscript.exe "%CurrentDir%\replacefiletextnew.vbs" "%INSTALLPATH%\WebNew.config" "/configuration/connectionStrings/add[@name='RabbitMQ']" "connectionString" "%RABBITMQCONNECTIONSTR%" "%INSTALLPATH%\WebNew.config"
cscript.exe "%CurrentDir%\replacefiletextnew.vbs" "%INSTALLPATH%\WebNew.config" "/configuration/connectionStrings/add[@name='Redis']" "connectionString" "%REDISIP%:%REDISPORT%,keepAlive=180,connectTimeout=200000" "%INSTALLPATH%\WebNew.config"
del "%INSTALLPATH%\Web.config"
ren "%INSTALLPATH%\WebNew.config" "Web.config"
if not %errorlevel% == 0 goto ConfigWSError
if not "%AMQPPORT%" == "" (
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%INSTALLPATH%\AmqpOption.json" "127.0.0.1" "%RABBITMQCONNECTIONSTR%" "%INSTALLPATH%\AmqpOption.json"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%INSTALLPATH%\AmqpOption.json" "|port| : 5672" "|port| : %AMQPPORT%" "%INSTALLPATH%\AmqpOption.json"
)
if not %errorlevel% == 0 goto ConfigAMQPError
if %errorlevel% == 0 goto End

:ConfigWSError
echo Failed to config Web Server
exit /B 1 
goto :EOF

:ConfigAMQPError
echo Failed to config AMQP
exit /B 1 
goto :EOF

:End
echo Succeed to config Web Server and AMQP
exit /B 0
goto :EOF