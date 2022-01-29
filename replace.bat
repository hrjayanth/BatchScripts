@echo off
if "%~1"=="" goto paramsMissing
set SEARCHSTRING=%~1

if "%~2"=="" goto replaceMissing

set REPLACESTRING=%~2
goto searchNreplace

:paramsMissing
set /p SEARCHSTRING="Find: "
set /p REPLACESTRING="Replace With: "
goto searchNreplace

:replaceMissing
set /p REPLACESTRING="Replace With: "
goto searchNreplace

:searchNreplace
echo ==================================================
echo FINDING STRING: %SEARCHSTRING%
echo REPLACING WITH: %REPLACESTRING%
echo ==================================================

call :treeProcess
goto :eof

:treeProcess
for %%f in (*.java) do (
	powershell -Command "(gc %%f) -replace %SEARCHSTRING%, %REPLACESTRING% | Out-File -encoding ASCII %%f"
	echo %%f
	)
for /D %%d in (*) do (
    cd %%d
    call :treeProcess
    cd ..
)
exit /b