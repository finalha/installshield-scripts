
"%windir%\SysNative\dism" /online /get-featureinfo /featurename:IIS-ASPNET45|findstr /c:"State : Enabled" && goto end

"%windir%\SysNative\dism" /online /enable-feature /featurename:IIS-ASPNET45 /all /NoRestart /LimitAccess  || goto end

:end
exit /b %errorlevel%