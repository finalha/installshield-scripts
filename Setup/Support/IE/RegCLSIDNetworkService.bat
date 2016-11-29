set "CurrentDir=%~dp0"

REM "%CurrentDir%\subinacl.exe" /keyreg "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID" /grant=networkservice=f
REM SetACL.exe have 32bit and 64bit, we use 64bit here
"%CurrentDir%\SetACL.exe" -on "hklm\software\classes\clsid" -ot reg -actn ace -ace "n:localhost\networkservice;p:full"
"%CurrentDir%\SetACL.exe" -on "hklm\software\classes\clsid" -ot reg -actn ace -ace "n:NT Authority\NetworkService;p:full"

if not %errorlevel% == 0 goto RegCLSIDNetworkServiceError
if %errorlevel% == 0 goto End

:RegCLSIDNetworkServiceError
echo Failed to give NetworkService CLSID full permissions
exit /B 1 
goto :EOF

:End
echo Succeed to give NetworkService CLSID full permissions
exit /B 0
goto :EOF