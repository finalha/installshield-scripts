@echo aspnet_regiis  aspnetstateserver >>%1

if NOT exist   %Systemroot%\Microsoft.NET\Framework64\v4.0.30319  goto  NormalInstall
@echo Framework64 >>%1
cscript.exe adsutil.vbs set W3SVC/AppPools/Enable32bitAppOnWin64 0 >>%1
%Systemroot%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -u >>%1
%Systemroot%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -i >>%1
cscript.exe adsutil.vbs set W3SVC/AppPools/Enable32bitAppOnWin64 1 >>%1
%Systemroot%\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -i >>%1
@exit /b 0

:NormalInstall
@echo Framework32 >>%1
if NOT exist   %Systemroot%\Microsoft.NET\Framework\v4.0.30319  goto  FailedInstall
cscript.exe adsutil.vbs set W3SVC/AppPools/Enable32bitAppOnWin64 1 >>%1
%Systemroot%\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -i >>%1
%Systemroot%\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -u >>%1
%Systemroot%\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis.exe -i >>%1

@exit /b 0

:FailedInstall
@exit /b -1

