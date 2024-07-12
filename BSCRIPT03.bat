@echo off
:menu
echo Select a command:
echo 1. ipconfig
echo 2. tasklist/taskkill
echo 3. chkdsk
echo 4. format
echo 5. defrag
echo 6. find
echo 7. attrib
echo 8. Exit

choice /c 12345678 /m "Choose an option: "

if errorlevel 8 goto end
if errorlevel 7 goto attrib_command
if errorlevel 6 goto find_command
if errorlevel 5 goto defrag_command
if errorlevel 4 goto format_command
if errorlevel 3 goto chkdsk_command
if errorlevel 2 goto task_command
if errorlevel 1 goto ipconfig_command

:ipconfig_command
ipconfig
goto menu

:task_command
echo Select one task to execute: 
echo 1. Tasklist 
echo 2. Taskkill 
echo 3. Back to menu
choice /c 123 /m "Choose an option: "

if errorlevel 3 goto menu
if errorlevel 2 goto UserTaskkill 
if errorlevel 1 goto UserTasklist

:UserTasklist
tasklist 
goto menu
:UserTaskkill
set /p filename="Enter the filename of the task you want to kill: "
taskkill /IM %fileName% /F
if %errorlevel% equ 0 (
goto menu
) else (
    echo Failed to kill %processname%
    goto task_command
)

:chkdsk_command
chkdsk
goto menu

:format_command
set /p pathName="Enter the drive letter you want to format (Add a colon. e.g., C:): "
format %pathName%
if %errorlevel% equ 0 (
    goto menu
) else (
    echo Failed to format %pathName%
    goto format_command
)
goto menu

:defrag_command
set /p drive="Enter the drive letter you want to defragment (e.g., C:): "
defrag %drive%
goto menu

:find_command
set /p search="Enter the string you want to search for: "
find "%search%"
goto menu

:attrib_command
set /p path="Enter the path of the file or directory: "
attrib %path%
goto menu

:end
echo Exiting...
