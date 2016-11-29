set "INSTALLPATH=%~1"
set "CONFIGSVRPORT=%~2"
set "MONGOSPORT=%~3"
set "MONGOSIP=%~4"
set "CurrentDir=%~dp0"
set "RSCONFIGPATH=%INSTALLPATH%\cluster\mongos"

:ConfigMongos
pushd "%RSCONFIGPATH%"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "D\:\\MongoDB" "%INSTALLPATH%" "%RSCONFIGPATH%\config.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "21110" "%CONFIGSVRPORT%" "%RSCONFIGPATH%\config.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "21100" "%MONGOSPORT%" "%RSCONFIGPATH%\config.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "127.0.0.1" "%MONGOSIP%" "%RSCONFIGPATH%\config.conf"
if not %errorlevel% == 0 goto ConfigMongosError
if %errorlevel% == 0 goto End

:ConfigMongosError
echo Failed to config MongoDb ConfigServer
exit /B 1 
goto :EOF

:End
echo Succeed to config MongoDb ConfigServer
exit /B 0
goto :EOF