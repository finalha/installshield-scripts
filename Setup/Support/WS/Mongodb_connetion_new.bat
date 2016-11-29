set "MongodbConnectionstr=%~1"
set "CurrentDir=%~dp0"

:ConnectMongodb
echo exit|"%CurrentDir%mongo.exe" "%MongodbConnectionstr%"
if not %errorlevel% == 0 goto ConnectMongodbError
if %errorlevel% == 0 goto End

:ConnectMongodbError
echo Failed to connect Mongodb "%MongodbConnectionstr%"
exit /B 1 
goto :EOF

:End
echo Succeed to connect Mongodb "%MongodbConnectionstr%"
REM taskkill /F /IM mongo.exe /T
exit /B 0
goto :EOF