set "INSTALLPATH=%~1"
set "SERVICENAME=%~2"
set "RSCONFIGPATH=%INSTALLPATH%\cluster\mongos"
set "BINPATH=%INSTALLPATH%\bin"

:InstallMongoDb_mongosService
pushd "%BINPATH%"
mongos --config "%RSCONFIGPATH%\config.conf" --install --serviceName "%SERVICENAME%" --serviceDisplayName "%SERVICENAME%" --serviceDescription "%SERVICENAME%"
if not %errorlevel% == 0 goto InstallMongoDb_mongosServiceError
if %errorlevel% == 0 goto StartMongoDb_mongosService

:StartMongoDb_mongosService
net start "%SERVICENAME%"
if not %errorlevel% == 0 goto StartMongoDb_mongosServiceError
if %errorlevel% == 0 goto End

:StartMongoDb_mongosServiceError
echo Failed to start %SERVICENAME%
exit /B 1 
goto :EOF

:InstallMongoDb_mongosServiceError
echo Failed to install %SERVICENAME%
exit /B 1 
goto :EOF

:End
echo Succeed to install and start %SERVICENAME%
exit /B 0
goto :EOF