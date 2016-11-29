
@echo off

set siteindex=%~1
set sitename=%~2

set appcommand=%Systemroot%\system32\inetsrv\appcmd.exe
 
::IF exist IIS 7.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 7" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 7" /d) && goto IIS7

::IF exist IIS 8.0
(reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "Version 8" /d) && (reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp  /f "IIS 8" /d) && goto IIS8


::If there is no IIS server
@echo there is no IIS server found
@exit /b 1

:IIS7
net start "W3SVC"
@if %errorlevel% == 0 (
@echo Succeed to start World Wide Web service
)else (
@echo Failed to start World Wide Web service %errorlevel%
)
"%appcommand%" stop SITE "%sitename%"
@if %errorlevel% == 0 (
@echo Succeed to stop SITE "%sitename%"
)else (
@echo Failed to stop SITE "%sitename%"  %errorlevel%
)
goto checkstatus

:IIS8
net start "W3SVC"
@if %errorlevel% == 0 (
@echo Succeed to start World Wide Web service
)else (
@echo Failed to start World Wide Web service %errorlevel%
)
"%appcommand%" stop SITE "%sitename%"
@if %errorlevel% == 0 (
@echo Succeed to stop SITE "%sitename%"
)else (
@echo Failed to stop SITE "%sitename%"  %errorlevel%
)
goto checkstatus


:checkstatus
@if %errorlevel% == 0 (
@echo Succeed to stop web site 
)else (
@echo Failed to stop web site
@set nret=-1
)