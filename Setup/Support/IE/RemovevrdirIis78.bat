

@set SiteName=%~1
@set AppPool=%~2
@set Vdir=%~3
@set Vdirroot=%~4

@set nret=0


%Systemroot%\system32\inetsrv\appcmd stop apppool /apppool.name:%AppPool%
@if %errorlevel% == 0 (
@echo Succeed to stop apppool
)else (
@echo Failed to stop apppool
@set nret=-1
)

if "%Vdirroot%" == "" (
%Systemroot%\system32\inetsrv\appcmd delete app "%sitename%/%Vdir%"
@if %errorlevel% == 0 (
@echo Succeed to delete virual dir
)else (
@echo Failed to delete virual dir
@set nret=-1
)

) else (

%Systemroot%\system32\inetsrv\appcmd delete app "%sitename%/%Vdirroot%/%Vdir%"
@if %errorlevel% == 0 (
@echo Succeed to delete virual dir
)else (
@echo Failed to delete virual dir
@set nret=-1
)


)



%Systemroot%\system32\inetsrv\appcmd delete apppool %AppPool%
@if %errorlevel% == 0 (
@echo Succeed to delete apppool
)else (
@echo Failed to delete apppool
@set nret=-1
)

@exit /b %nret%
