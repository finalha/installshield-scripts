set "INSTALLPATH=%~1"
set "AMQPIP=%~2"
set "AMQPPORT=%~3"
set "REDISIP=%~4"
set "REDISPORT=%~5"
set "MONGODBIP=%~6"
set "MONGODBPORT=%~7"
set "CurrentDir=%~dp0"

:ConfigWS
pushd "%INSTALLPATH%"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%INSTALLPATH%\Web.config" "127.0.0.1\:5672" "%AMQPIP%:%AMQPPORT%" "%INSTALLPATH%\Web.config"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%INSTALLPATH%\Web.config" "127.0.0.1\:6379" "%REDISIP%:%REDISPORT%" "%INSTALLPATH%\Web.config"
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%INSTALLPATH%\Web.config" "10.10.0.47\:27017" "%MONGODBIP%:%MONGODBPORT%" "%INSTALLPATH%\Web.config"

cscript.exe "%CurrentDir%\replacefiletextnew.vbs" "%INSTALLPATH%\Web.config" "/configuration/connectionStrings/add[@name='MongoDB']" "connectionString" "mongodb://%MONGODBIP%:%MONGODBPORT%?maxPoolSize=1000" "%INSTALLPATH%\WebNew.config"
cscript.exe "%CurrentDir%\replacefiletextnew.vbs" "%INSTALLPATH%\WebNew.config" "/configuration/connectionStrings/add[@name='RabbitMQ']" "connectionString" "amqp://guest:guest@%AMQPIP%:%AMQPPORT%/" "%INSTALLPATH%\WebNew.config"
cscript.exe "%CurrentDir%\replacefiletextnew.vbs" "%INSTALLPATH%\WebNew.config" "/configuration/connectionStrings/add[@name='Redis']" "connectionString" "%REDISIP%:%REDISPORT%,keepAlive=180,connectTimeout=200000" "%INSTALLPATH%\WebNew.config"
del "%INSTALLPATH%\Web.config"
ren "%INSTALLPATH%\WebNew.config" "Web.config"
if not %errorlevel% == 0 goto ConfigWSError
if %errorlevel% == 0 goto End

:ConfigWSError
echo Failed to config Web Server
exit /B 1 
goto :EOF

:End
echo Succeed to config Web Server
exit /B 0
goto :EOF