set "INSTALLPATH=%~1"
set "REPLICASETNAME=%~2"
set "SERVICENAME=%~3"
set "RSCONFIGPATH=%INSTALLPATH%\cluster\%REPLICASETNAME%"
set "BINPATH=%INSTALLPATH%\bin"

:InstallMongoDb_shardService
pushd "%BINPATH%"
mongod --config "%RSCONFIGPATH%\config.conf" --install --serviceName "%SERVICENAME%" --serviceDisplayName "%SERVICENAME%" --serviceDescription "%SERVICENAME%"
if not %errorlevel% == 0 goto InstallMongoDb_shardServiceError
if %errorlevel% == 0 goto StartMongoDb_shardService

:StartMongoDb_shardService
net start "%SERVICENAME%"
if not %errorlevel% == 0 goto StartMongoDb_shardServiceError
if %errorlevel% == 0 goto End

:StartMongoDb_shardServiceError
echo Failed to start %SERVICENAME%
exit /B 1 
goto :EOF

:InstallMongoDb_shardServiceError
echo Failed to install %SERVICENAME%
exit /B 1 
goto :EOF

:End
echo Succeed to install and start %SERVICENAME%
exit /B 0
goto :EOF