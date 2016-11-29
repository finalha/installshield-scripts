set "PYTHONPATH=%~1"
set "MONGODBINITPATH=%~2"
set "MONGODBPRIMARYIP=%~3"
set "MONGODBPRIMARYPORT=%~4"
set "RSNAME=%~5"
set "SSL=%~6"
set "USERNAME=%~7"

@echo off
set "PASSWORD=%~8"
@echo on

:initMongodb
pushd "%MONGODBINITPATH%"

if "%MONGODBPRIMARYIP%" == "" goto initMongodbError
if "%MONGODBPRIMARYPORT%" == "" goto initMongodbError

set "PARAMETERS=main.py -s %MONGODBPRIMARYIP% -p %MONGODBPRIMARYPORT%"

if not "%RSNAME%" == "" (
set "PARAMETERS=%PARAMETERS% -r %RSNAME%"
)

@echo off
if not "%USERNAME%" == "" (
set "PARAMETERS=%PARAMETERS% --user %USERNAME% --password %PASSWORD%"
)

if "%SSL%" == "true" (
set "PARAMETERS=%PARAMETERS% -q"
)

"%PYTHONPATH%\python.exe" %PARAMETERS%
@echo on

if not %errorlevel% == 0 goto initMongodbError
if %errorlevel% == 0 goto End

:initMongodbError
echo Failed to init Mongodb
exit /B 1 
goto :EOF

:End
echo Succeed to init Mongodb
exit /B 0
goto :EOF