sc create "ResourceManager" binpath= "%~1\bin\ResourceManagerService.exe" type= own start= auto displayname= "NetBrain Worker Server"
if not %errorlevel% == 0 goto SCCreateError
if %errorlevel% == 0 goto SetSCFailure

:SetSCFailure
sc failure ResourceManager reset= 0 actions= restart/5000
if not %errorlevel% == 0 goto SCFailureError
if %errorlevel% == 0 goto StartRMService

:StartRMService
ping localhost -n 5 > nul
net start ResourceManager
if not %errorlevel% == 2 if not %errorlevel% == 0 (
goto StartRMServiceError
)
if %errorlevel% == 0 goto End
if %errorlevel% == 2 goto End

:StartRMServiceError
echo Failed to start RM service
exit /B 1 
goto :EOF

:SCFailureError
echo Failed to set RM failure
exit /B 1 
goto :EOF

:SCCreateError
echo Failed to create RM service
exit /B 1 
goto :EOF

:End
echo Succeed to create RM service
exit /B 0
goto :EOF