set "REDIS_ROOT=%~1"
set "CurrentDir=%~dp0"
set "REDIS_PORT=%~2"
set "REDIS_PASSWORD=%~3"

net stop Redis
ping localhost -n 5 > nul
pushd "%REDIS_ROOT%"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "\#   save \"\"" "save \"\"" "%REDIS_ROOT%\redis.windows-service.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "save 900 1" "#save 900 1" "%REDIS_ROOT%\redis.windows-service.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "save 300 10" "#save 300 10" "%REDIS_ROOT%\redis.windows-service.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "save 60 10000" "#save 60 10000" "%REDIS_ROOT%\redis.windows-service.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "\# maxmemory \<bytes\>" "maxmemory 1073741824" "%REDIS_ROOT%\redis.windows-service.conf"
if not "%REDIS_PORT%" == "" (
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "port 6379" "port %REDIS_PORT%" "%REDIS_ROOT%\redis.windows-service.conf"
)
REM cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "\# masterauth \<master-password\>" "masterauth %REDIS_PASSWORD%" "%REDIS_ROOT%\redis.windows-service.conf"
cscript.exe "%CurrentDir%\replacefiletext.vbs" "%REDIS_ROOT%\redis.windows-service.conf" "\# requirepass foobared" "requirepass %REDIS_PASSWORD%" "%REDIS_ROOT%\redis.windows-service.conf"
if not %errorlevel% == 0 goto ModifyRedisConfigError
if %errorlevel% == 0 goto End

:ModifyRedisConfigError
echo Failed to modify redis.windows-service.conf
net start Redis
ping localhost -n 5 > nul
REM set RabbitMQ reset in 5 seconds on failure
sc failure Redis reset= 0 actions= restart/5000
exit /B 1 
goto :EOF

:End
echo Succeed to modify redis.windows-service.conf
net start Redis
ping localhost -n 5 > nul
REM set RabbitMQ reset in 5 seconds on failure
sc failure Redis reset= 0 actions= restart/5000
exit /B 0
goto :EOF