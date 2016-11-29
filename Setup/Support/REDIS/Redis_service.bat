set "Redis_ROOT=%~1"

:InstallRedisService
sc create Redis binPath= "\"%Redis_ROOT%\redis-server.exe\" --service-run \"%Redis_ROOT%\redis.windows-service.conf\"" start= auto displayname= "RedisForNetbarin"
if not %errorlevel% == 0 goto InstallRedisServiceError
sc description Redis "Redis-3.0.501 for NetBrain"
REM sc start Redis
if %errorlevel% == 0 goto End

:InstallRedisServiceError
echo Failed to install Redisservice
exit /B 1 
goto :EOF

:End
echo Succeed to install Redis service
exit /B 0
goto :EOF

