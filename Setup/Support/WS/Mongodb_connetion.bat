set "MongodbIP=%~1"
set "MongodbPort=%~2"
set "CurrentDir=%~dp0"

:ConnectMongodb
echo exit|"%CurrentDir%mongo.exe" "%MongodbIP%:%MongodbPort%"
if not %errorlevel% == 0 goto ConnectMongodbError
if %errorlevel% == 0 goto End

:ConnectMongodbError
echo Failed to connect Mongodb
exit /B 1 
goto :EOF

:End
echo Succeed to connect Mongodb 
REM taskkill /F /IM mongo.exe /T
exit /B 0
goto :EOF