@echo off

set siteindex=%~1
set sitename=%~2

@set appcommand=%Systemroot%\system32\inetsrv\appcmd.exe
 
::IF exist IIS 7.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 7" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 7" /d) && goto IIS7


::IF exist IIS 8.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 8" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 8" /d) && goto IIS8


::If there is no IIS server
@echo there is no IIS server found
@exit /b 1

:IIS7
%appcommand% set site "%SiteName%" /limits.maxConnections:4294967295
@if %errorlevel% == 0 (
@echo Succeed to set default web site maxConnections %errorlevel%
)else (
@echo Failed to set default web site maxConnections %errorlevel%
)

"%appcommand%" start SITE "%sitename%"
goto checkstatus

:IIS8
%appcommand% set site "%SiteName%" /limits.maxConnections:4294967295
@if %errorlevel% == 0 (
@echo Succeed to set default web site maxConnections %errorlevel%
)else (
@echo Failed to set default web site maxConnections %errorlevel%
)

"%appcommand%" start SITE "%sitename%"
goto checkstatus

:checkstatus
@if %errorlevel% == 0 (
@echo Succeed to start web site 
)else (
@echo Failed to start web site
@set nret=-1
)


