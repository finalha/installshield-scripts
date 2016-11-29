
@echo off

@set SiteName=%~1
@set AppPool=%~2
@set Vdir=%~3
@set PhysicalPath=%~4
@set DisableFolderList=%~5
@set Vdirroot=%~6
@set "errorlevel=0"

@set nret=0
 
::IF exist IIS 7.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 7" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 7" /d) && goto IIS7

::IF exist IIS 8.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 8" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 8" /d) && goto IIS8


::If there is no IIS server
@echo there is no IIS server found
@exit /b 1

:IIS7
echo This is IIS7 server ...>>&3
if not "%Vdir%" == "" (
@call InstallGwIIS78.bat "%SiteName%" "%AppPool%" "%Vdir%" "%PhysicalPath%" "%DisableFolderList%"  "%Vdirroot%"
)else (
@call InstallGwIIS78WithoutVdir.bat "%SiteName%" "%AppPool%" "%PhysicalPath%" 
)
goto checkstatus

:IIS8
echo This is IIS8 server ...>>&3
if not "%Vdir%" == "" (
@call InstallGwIIS78.bat "%SiteName%" "%AppPool%" "%Vdir%" "%PhysicalPath%" "%DisableFolderList%"  "%Vdirroot%"
)else (
@call InstallGwIIS78WithoutVdir.bat "%SiteName%" "%AppPool%" "%PhysicalPath%"
)
goto checkstatus

:checkstatus
@if %errorlevel% == 0 (
@echo Succeed to install web site 
)else (
@echo Failed to install web site
@set nret=-1
)


sc start aspnet_state

@if %errorlevel% == 0 (
@echo Succeed to start ASP.NET State Service 
)else (
@echo Failed to start ASP.NET State Service
)


::for /f "delims=" %%i in ('dir "%temp%" /B /O-D "ASPNETSetup_*.log"') do (
:: set asplog=%temp%\%%~nxi
:: goto copyaspnetreglog 
::)

::copyaspnetreglog
::copy "%asplog%" "%windir%\..\nbesinstall_netreg.log" /y

@exit /b %nret%
