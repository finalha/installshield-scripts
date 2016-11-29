

@set SiteName=%~1
@set AppPool=%~2

@set nret=0


%Systemroot%\system32\inetsrv\appcmd stop apppool /apppool.name:%AppPool%
@if %errorlevel% == 0 (
@echo Succeed to stop apppool
)else (
@echo Failed to stop apppool
@set nret=-1
)

%Systemroot%\system32\inetsrv\appcmd delete apppool %AppPool%
@if %errorlevel% == 0 (
@echo Succeed to delete apppool
)else (
@echo Failed to delete apppool
@set nret=-1
)

REM %Systemroot%\system32\inetsrv\appcmd delete site "%SiteName%"  
REM @if %errorlevel% == 0 (
REM @echo Succeed to delete site
REM )else (
REM @echo Failed to delete site
REM @set nret=-1
REM )

@exit /b %nret%
