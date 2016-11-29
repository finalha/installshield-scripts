
Set "errorlevel=0"

"%windir%\SysNative\dism" /online /get-featureinfo /featurename:IIS-ASPNET|findstr /c:"State : Enabled" && goto end

"%windir%\SysNative\dism" /online /enable-feature /featurename:IIS-ISAPIFilter /NoRestart

if not %errorlevel%==0 goto end

"%windir%\SysNative\dism" /online /enable-feature /featurename:IIS-ISAPIExtensions /NoRestart

if not %errorlevel%==0 goto end

"%windir%\SysNative\dism" /online /enable-feature /featurename:IIS-NetFxExtensibility /NoRestart

if not %errorlevel%==0 goto end

"%windir%\SysNative\dism" /online /enable-feature /featurename:IIS-ASPNET /NoRestart 

if not %errorlevel%==0 goto end

sc config aspnet_state DisplayName= "ASP.NET State Service" start= auto 

if not %errorlevel%==0 goto end

sc start aspnet_state

if not %errorlevel%==0 goto end

%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -ir -enable

:end
exit /b %errorlevel%