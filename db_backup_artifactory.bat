waitfor StartBatchCommand /t 20
SET DatabaseBackupPath=D:\db\dbbackup

FOR /F "delims=|" %%I IN ('DIR "%DatabaseBackupPath%\*.001" /B /O:D') DO SET  NewestFile=%%I
echo %NewestFile%
set Pathname="D:\db\dbbackup"
cd /d %Pathname%


:loop
FOR %%A IN (%NewestFile%) DO SET fileSize=%%~zA
echo 'file size is ' %fileSize%

set /A COUNTER=COUNTER+1
echo "counter value---->"%COUNTER%
if %COUNTER% EQU 1 (
   set /A temp1 = 0;
)

echo 'temp is' %temp1%

if %fileSize% GTR %temp1% (
   echo File is greater than %minbytesize% bytes 
   set /A temp1=%fileSize%
   waitfor click /t 120
   echo peter
   goto :loop 
) else (
    echo File is ended
    echo %DatabaseBackupPath%
    echo %NewestFile%
    FOR /F "delims=|" %%I IN ('DIR "%DatabaseBackupPath%\*.001" /B /O:D') DO SET  NewestFile=%%I
    curl -X POST http://9.193.198.74:8080/view/Maverick_DBDeploy/job/ScoePlus-StoreArtifacts/buildWithParameters?NewestFile=%NewestFile% --user admin:3660e902574e02e6db8f29058cc6cf5e
)
echo "File processing ended"
:exitloop
