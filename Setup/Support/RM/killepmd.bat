pushd "C:\Program Files\erl%~1\erts-%~1\bin"
REM C:\Program Files\erl7.2.1\erts-7.2.1\bin
epmd -kill
if not %errorlevel% == 0 goto KillEPMDError
if %errorlevel% == 0 goto End

:KillEPMDError
echo Failed to kill epmd.exe
exit /B 1 
goto :EOF

:End
echo Succeed to kill epmd.exe
exit /B 0
goto :EOF

