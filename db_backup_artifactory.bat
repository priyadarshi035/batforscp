@echo Writing text to dblank.txt>check1.txt
waitfor StartBatchCommand /t 20
SET DatabaseBackupPath=D:\db\dbbackup

FOR /F "delims=|" %%I IN ('DIR "%DatabaseBackupPath%\*.001" /B /O:D') DO SET  NewestFile=%%I
echo %NewestFile%
set Pathname="D:\db\dbbackup"
cd /d %Pathname%
@echo Writing text to dblank.txt>check2.txt

:loop
FOR %%A IN (%NewestFile%) DO SET fileSize=%%~zA
echo 'file size is ' %fileSize%
@echo Writing text to dblank.txt>check3.txt
set /A COUNTER=COUNTER+1
echo "counter value---->"%COUNTER%
if %COUNTER% EQU 1 (
   set /A temp1 = 0;
)

echo 'temp is' %temp1%
@echo Writing text to dblank.txt>check4.txt
if %fileSize% GTR %temp1% (
   echo File is greater than %minbytesize% bytes 
   set /A temp1=%fileSize%
   waitfor click /t 120
   echo peter
   goto :loop
@echo Writing text to dblank.txt>check5.txt 
) else (
    echo File is ended
    echo %DatabaseBackupPath%
    echo %NewestFile%
@echo Writing text to dblank.txt>check6.txt
    FOR /F "delims=|" %%I IN ('DIR "%DatabaseBackupPath%\*.001" /B /O:D') DO SET  NewestFile=%%I
    curl -k -i -H "X-JFrog-Art-Api: AKCp5Z2hL6AoTZbcqMeEbXZvJoxcB9AxyvCB979anTH83VViM9jKhaazoav8H4hNLtZKWVciW" -X PUT  

"https://gbsartifactory.in.edst.ibm.com/artifactory/ScopePlus/%1-db_backup_Maverick/%NewestFile%" -T %NewestFile%
@echo Writing text to dblank.txt>check7.txt    
echo Build_Number %1
    echo response is %errorlevel%
    IF %errorlevel% NEQ 0 GOTO ERROR_HANDLER
    
)
echo "File processing ended"
goto :exitloop
:ERROR_HANDLER
echo ERROR HANDLER GETTING EXECUTED
@echo Writing text to dblank.txt>check8.txt
curl -X POST http://9.193.198.74:8080/view/Maverick_DBDeploy/job/Maverick_ArtifactoryNotify/buildWithParameters?Error_Message=Artifactory_Backup_error --user 

admin:3660e902574e02e6db8f29058cc6cf5e
:exitloop
