@echo off

echo Creating archive and temp folder on Drive Z:... 
mkdir "Z: \archive"
mkdir "Z: \archive\sortedsize"

echo Sorting and moving text files on Drive C: older than 30 days to Drive Z:... 
forfiles /p C:\ /s /m * txt /d -30 /c "cmd /c move @path \"Z: \archive\""

echo Sorting archived files by size and moving to temp directory... 
for /f "tokens=*" %%A in ('dir /b /s /o-s "Z: \archive\****)'dir /b /s /o-s "Z: \archive\****) do (
    move "%%A" "Z: \archive\sortedsize"
)

echo The following large files have been moved to Z: \archive\sortedsize: 
dir Z: \archive\sortedsize\*.*

set /p delete="Do you want to delete these files? (Y/N): "
if /i "%delete%"=="Y" (
    cd Z: \archive sortedsize 
    del ** /s 
    rd Z: \archive\sortedsize 
    echo Files deleted successfully.
) else (
    echo No files were deleted.
)
