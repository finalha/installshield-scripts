set "type=%~1"

if not exist "%ALLUSERSPROFILE%\Netbrain\Update\%type%" mkdir "%ALLUSERSPROFILE%\Netbrain\Update\%type%"

cscript.exe xcacls.vbs "%ALLUSERSPROFILE%\Netbrain" /E /T /G "NETWORK SERVICE":F

cscript.exe xcacls.vbs "%ALLUSERSPROFILE%\Netbrain" /E /T /G "USERS":F

cscript.exe xcacls.vbs "%ALLUSERSPROFILE%\Netbrain" /E /T /G "ADMINISTRATORS":F

cscript.exe xcacls.vbs "%ALLUSERSPROFILE%\Netbrain" /E /T /G "EVERYONE":F