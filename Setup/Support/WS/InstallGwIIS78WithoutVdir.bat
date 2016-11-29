
@echo off

@set "SiteName=%~1"
@set "AppPoolname=%~2"
@set "PhysicalPath=%~3"

@set "nret=0"
@set "appcommand=%Systemroot%\system32\inetsrv\appcmd.exe"
@set "Framework64=%Systemroot%\Microsoft.NET\Framework64\v4.0.30319"
@set "Framework=%Systemroot%\Microsoft.NET\Framework\v4.0.30319"

@if NOT exist %appcommand% (
	echo can not find %appcommand%
	exit /b 1
)

::%Systemroot%\system32\inetsrv\appcmd delete app "%SiteName%/netbrain"
::@if %errorlevel% == 0 (
::@echo Succeed to remove old
::)else (
::@echo Failed to remove old
::)

::net start "World Wide Web Publishing Service"

::%Systemroot%\system32\inetsrv\appcmd list apppool "%AppPoolname%"

::if %errorlevel% == 0 %Systemroot%\system32\inetsrv\appcmd delete apppool "%AppPoolname%"

%appcommand% list apppool "%AppPoolname%"
if %errorlevel% == 0 (
%appcommand% set apppool /name:"%AppPoolname%" /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated
echo Succeed to set apppool
)else (
echo Failed to set apppool
echo Begin to add apppool
%appcommand% add apppool /name:"%AppPoolname%" /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated
@if %errorlevel% == 0 (
@echo Succeed to add apppool
)else (
@echo Failed to add apppool
@set nret=-1
)
)

%appcommand% set config /section:applicationPools /[name='%AppPoolname%'].processModel.idleTimeout:0.00:00:00
@if %errorlevel% == 0 (
@echo Succeed to set apppool idleTimeout
)else (
@echo Failed to set apppool idleTimeout
)

%appcommand% set config /section:applicationPools /[name='%AppPoolname%'].recycling.periodicRestart.time:0.00:00:00
@if %errorlevel% == 0 (
@echo Succeed to set apppool periodicRestart.time
)else (
@echo Failed to set apppool periodicRestart.time
)

%appcommand% set config /section:applicationPools /[name='%AppPoolname%'].queueLength:10000
@if %errorlevel% == 0 (
@echo Succeed to set apppool queueLength
)else (
@echo Failed to set apppool queueLength
)

%appcommand% set config /section:applicationPools /[name='%AppPoolname%'].processModel.identityType:NetworkService
@if %errorlevel% == 0 (
@echo Succeed to set apppool identityType
)else (
@echo Failed to set apppool identityType
)

%appcommand% list site "%SiteName%" 
@if %errorlevel% == 0 (
@echo %SiteName% exists
%appcommand% set vdir "%SiteName%/" -physicalPath:"%PhysicalPath%"
)else (
@echo %SiteName% not exists
%appcommand% add site /name:"%SiteName%" /id:1 /bindings:http/*:80: /physicalPath:"%PhysicalPath%"
)
@if %errorlevel% == 0 (
@echo Succeed to config site
%appcommand% set app /app.name:"%SiteName%/" /applicationPool:"%AppPoolname%"
)else (
@echo Failed to config site
@set nret=-1
)

@if NOT exist %Framework64%  goto  Normal
%appcommand% set apppool /apppool.name:"%AppPoolname%" /enable32BitAppOnWin64:false
goto NextInstall

:Normal
@if NOT exist %Framework%  goto  FailedInstall
%appcommand% set apppool /apppool.name:"%AppPoolname%" /enable32BitAppOnWin64:false


:NextInstall
@if %errorlevel% == 0 (
@echo Succeed to enable32BitAppOnWin64
)else (
@echo Failed to enable32BitAppOnWin64
)


::for %%i in (%DisableFolderList%) do call IIS7DisableDir.bat "%SiteName%" "%Vdirname%" "%%~i"



@exit /b %nret%

:FailedInstall

@exit /b -1