@echo off

@set SiteName=%~1
@set AppPool=%~2
@set Vdir=%~3
set Vdirroot=%~4

::IF exist IIS 7.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 7" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 7" /d) && goto IIS7

::IF exist IIS 8.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 8" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 8" /d) && goto IIS8


::If there is no IIS server
@echo there is no IIS server found
@exit /b 1

:IIS7
if not "%Vdir%" == "" (
@call RemovevrdirIis78.bat "%SiteName%" "%AppPool%" "%Vdir%"  "%Vdirroot%"
)else (
@call RemovevrdirIis78WithoutVdir.bat "%SiteName%" "%AppPool%" 
)
goto checkstatus

:IIS8
if not "%Vdir%" == "" (
@call RemovevrdirIis78.bat "%SiteName%" "%AppPool%" "%Vdir%"  "%Vdirroot%"
)else (
@call RemovevrdirIis78WithoutVdir.bat "%SiteName%" "%AppPool%" 
)
goto checkstatus

:checkstatus
@if %errorlevel% == 0 (
@echo Succeed to uninstall web site 
)else (
@echo Failed to uninstall web site
@set nret=-1
)

exit /b %nret%