set "INSTALLPATH=%~1"
set "SERVICENAME=%~2"
set "RSCONFIGPATH=%INSTALLPATH%\cluster\configsvr"
set "BINPATH=%INSTALLPATH%\bin"

:InstallMongoDb_configsvrService
pushd "%BINPATH%"
mongod --config "%RSCONFIGPATH%\config.conf" --install --serviceName "%SERVICENAME%" --serviceDisplayName "%SERVICENAME%" --serviceDescription "%SERVICENAME%"
if not %errorlevel% == 0 goto InstallMongoDb_configsvrServiceError
if %errorlevel% == 0 goto StartMongoDb_configsvrService

:StartMongoDb_configsvrService
net start "%SERVICENAME%"
if not %errorlevel% == 0 goto StartMongoDb_configsvrServiceError
if %errorlevel% == 0 goto End

:StartMongoDb_configsvrServiceError
echo Failed to start %SERVICENAME%
exit /B 1 
goto :EOF

:InstallMongoDb_configsvrServiceError
echo Failed to install %SERVICENAME%
exit /B 1 
goto :EOF

:End
echo Succeed to install and start %SERVICENAME%
exit /B 0
goto :EOF