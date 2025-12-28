@echo off

cls

echo.
echo Restoring the project
echo.
echo.

dotnet restore "./CsStealer/CS Stealer.csproj"

echo.
echo.
echo Finished. Press any key to exit.

pause >nul