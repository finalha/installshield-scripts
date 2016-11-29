set "INSTALLPATH=%~1"
set "REPLICASETNAME=%~2"
set "PORT=%~3"
set "CurrentDir=%~dp0"
set "RSCONFIGPATH=%INSTALLPATH%\cluster\%REPLICASETNAME%"

:ConfigMongoDbRelicaSet
pushd "%RSCONFIGPATH%"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "D\:\\MongoDB" "%INSTALLPATH%" "%RSCONFIGPATH%\config.conf"
if "%REPLICASETNAME%" == "shard1" (
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "22001" "%PORT%" "%RSCONFIGPATH%\config.conf"
)
if "%REPLICASETNAME%" == "shard2" (
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "22002" "%PORT%" "%RSCONFIGPATH%\config.conf"
)
if "%REPLICASETNAME%" == "shard3" (
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%RSCONFIGPATH%\config.conf" "22003" "%PORT%" "%RSCONFIGPATH%\config.conf"
)
if not %errorlevel% == 0 goto ConfigMongoDbRelicaSetError
if %errorlevel% == 0 goto End

:ConfigMongoDbRelicaSetError
echo Failed to config MongoDb RelicaSet
exit /B 1 
goto :EOF

:End
echo Succeed to config MongoDb RelicaSet
exit /B 0
goto :EOF