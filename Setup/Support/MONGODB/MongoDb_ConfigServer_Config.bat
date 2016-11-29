set "INSTALLPATH=%~1"
set "PORT=%~2"
set "CurrentDir=%~dp0"
set "RSCONFIGPATH=%INSTALLPATH%\cluster\configsvr"

:ConfigMongoDbConfigServer
pushd "%RSCONFIGPATH%"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "D\:\\MongoDB" "%INSTALLPATH%" "%RSCONFIGPATH%\config.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "21110" "%PORT%" "%RSCONFIGPATH%\config.conf"
if not %errorlevel% == 0 goto ConfigMongoDbConfigServerError
if %errorlevel% == 0 goto End

:ConfigMongoDbConfigServerError
echo Failed to config MongoDb ConfigServer
exit /B 1 
goto :EOF

:End
echo Succeed to config MongoDb ConfigServer
exit /B 0
goto :EOF