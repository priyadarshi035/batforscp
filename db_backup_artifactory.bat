echo.>"C:\Users\cloud_user\check1.txt"
waitfor StartBatchCommand /t 03
SET DatabaseBackupPath=D:\db\dbbackup

FOR /F "delims=|" %%I IN ('DIR "%DatabaseBackupPath%\*.001" /B /O:D') DO SET  NewestFile=%%I
echo %NewestFile%
set Pathname="D:\db\dbbackup"
cd /d %Pathname%
echo.>"C:\Users\cloud_user\check2.txt"

:loop
FOR %%A IN (%NewestFile%) DO SET fileSize=%%~zA
echo 'file size is ' %fileSize%
echo.>"C:\Users\cloud_user\check3.txt"
set /A COUNTER=COUNTER+1
echo "counter value---->"%COUNTER%
if %COUNTER% EQU 1 (
   set /A temp1 = 0;
)

echo 'temp is' %temp1%
echo.>"C:\Users\cloud_user\check4.txt"
if %fileSize% GTR %temp1% (
   echo File is greater than %minbytesize% bytes 
   set /A temp1=%fileSize%
   waitfor click /t 03
   echo peter
   goto :loop
echo.>"C:\Users\cloud_user\check5.txt" 
) else (
    echo File is ended
    echo %DatabaseBackupPath%
    echo %NewestFile%
echo.>"C:\Users\cloud_user\check6.txt"
    FOR /F "delims=|" %%I IN ('DIR "%DatabaseBackupPath%\*.001" /B /O:D') DO SET  NewestFile=%%I
    curl -k -i -H "X-JFrog-Art-Api: W" -X PUT "https://gbsarti.com/artifactory/ScopePlus/%1-db_backup_Maverick/%NewestFile%" -T %NewestFile%
echo.>"C:\Users\cloud_user\check7.txt"    
echo Build_Number %1
    echo response is %errorlevel%
    IF %errorlevel% NEQ 0 GOTO ERROR_HANDLER
    
)
echo "File processing ended"
goto :exitloop
:ERROR_HANDLER
echo ERROR HANDLER GETTING EXECUTED
echo.>"C:\Users\cloud_user\check8.txt"
curl -X POST http://9.1:8080/view/Maverick_DBDeploy/job/Maverick_ArtifactoryNotify/buildWithParameters?Error_Message=Artifactory_Backup_error --user 

admin:3
:exitloop
