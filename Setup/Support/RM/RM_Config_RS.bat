set "INSTALLPATH=%~1"
set "RABBITMQCONNECTIONSTR=%~2"
set "REDISIP=%~3"
set "REDISPORT=%~4"
set "MONGODBRSSTRING=%~5"
set "AMQPPORT=%~6"
set "CurrentDir=%~dp0"
set "RMCONFIGPATH=%INSTALLPATH%\conf"

:ConfigRM
pushd "%RMCONFIGPATH%"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RMCONFIGPATH%\fix_RMConfig.json" "amqp\://127.0.0.1\:5672" "%RABBITMQCONNECTIONSTR%" "%RMCONFIGPATH%\fix_RMConfig.json"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RMCONFIGPATH%\fix_RMConfig.json" "127.0.0.1\:6379" "%REDISIP%:%REDISPORT%" "%RMCONFIGPATH%\fix_RMConfig.json"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RMCONFIGPATH%\fix_RMConfig.json" "192.168.33.39\:27017" "%MONGODBRSSTRING%" "%RMCONFIGPATH%\fix_RMConfig.json"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RMCONFIGPATH%\fix_RMConfig.json" "|port| : 5672" "|port| : %AMQPPORT%" "%RMCONFIGPATH%\fix_RMConfig.json"
if not %errorlevel% == 0 goto ConfigRMError
if %errorlevel% == 0 goto End

:ConfigRMError
echo Failed to config Resource Manager
exit /B 1 
goto :EOF

:End
echo Succeed to config Resource Manager
exit /B 0
goto :EOF