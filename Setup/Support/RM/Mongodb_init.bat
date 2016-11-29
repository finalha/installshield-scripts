set "MONGODBINITPATH=%~1"
set "MONGODBPRIMARYIP=%~2"
set "MONGODBPRIMARYPORT=%~3"
set "RSNAME=%~4"
set "SSL=%~5"
set "MONGODBCONNECTIONSTR="


:initMongodb
pushd "%MONGODBINITPATH%"
if "%RSNAME%" == "" (
if "%SSL%" == "false" (
"C:\Python34\python.exe" main.py -s "%MONGODBPRIMARYIP%" -p "%MONGODBPRIMARYPORT%"
if not %errorlevel% == 0 goto initMongodbError
if %errorlevel% == 0 goto End
)
if "%SSL%" == "true" (
"C:\Python34\python.exe" main.py -s "%MONGODBPRIMARYIP%" -p "%MONGODBPRIMARYPORT%" -q  
if not %errorlevel% == 0 goto initMongodbError
if %errorlevel% == 0 goto End
)
) else (
if "%SSL%" == "false" (
"C:\Python34\python.exe" main.py -s "%MONGODBPRIMARYIP%" -p "%MONGODBPRIMARYPORT%" -r "%RSNAME%"
if not %errorlevel% == 0 goto initMongodbError
if %errorlevel% == 0 goto End
)
if "%SSL%" == "true" (
"C:\Python34\python.exe" main.py -s "%MONGODBPRIMARYIP%" -p "%MONGODBPRIMARYPORT%" -r "%RSNAME%" -q
if not %errorlevel% == 0 goto initMongodbError
if %errorlevel% == 0 goto End
)
)

:initMongodbError
echo Failed to init Mongodb
exit /B 1 
goto :EOF

:End
echo Succeed to init Mongodb
exit /B 0
goto :EOF