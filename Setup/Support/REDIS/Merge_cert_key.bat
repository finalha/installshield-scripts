set "REDIS_CERTPEM_FILE=%~1"
set "REDIS_KEYPEM_FILE=%~2"
set "REDIS_MERGED_CERTPEM_FILE=%~3"

if not "%REDIS_CERTPEM_FILE%" == "" if not "%REDIS_KEYPEM_FILE%" == "" ( 
copy "%REDIS_CERTPEM_FILE%"+"%REDIS_KEYPEM_FILE%" "%REDIS_MERGED_CERTPEM_FILE%"
if not %errorlevel% == 0 goto MergeCertKeyError
if %errorlevel% == 0 goto End
)

:MergeCertKeyError
echo Failed to merge cert.pem and key.pem 
exit /B 1 
goto :EOF

:End
echo Succeed to merge cert.pem and key.pem
exit /B 0
goto :EOF