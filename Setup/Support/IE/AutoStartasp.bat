sc config aspnet_state start= auto
if %errorlevel% == 0 goto startasp
if not %errorlevel% == 0 goto error
:startasp
sc start aspnet_state 
if %errorlevel% == 0 goto end
if not %errorlevel% == 0 goto error

:end
exit /b %errorlevel%

:error
exit /b %errorlevel%