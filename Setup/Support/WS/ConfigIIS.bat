
DISM.EXE /online /enable-feature /featurename:IIS-WebServer /all /featurename:IIS-WebSockets /all /NoRestart 

if not %errorlevel% == 0 goto Error
if %errorlevel% == 0 goto End

:Error
exit /B 1 
goto :EOF

:End
exit /B 0
goto :EOF