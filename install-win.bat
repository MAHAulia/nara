@echo off
echo Welcome to Nara Installation for Windows

REM Define variables
SET "PLATFORM=unknown"
SET "ARCH=unknown"
SET "DOWNLOAD_URL="

REM Check the architecture
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    SET "ARCH=32"
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET "ARCH=64"
)

REM Set the download URL based on the architecture
if "%ARCH%"=="32" (
    SET "DOWNLOAD_URL=https://github.com/MAHAulia/nara/releases/download/v0.0.1/nara-win-32.exe"
) else if "%ARCH%"=="64" (
    SET "DOWNLOAD_URL=https://github.com/MAHAulia/nara/releases/download/v0.0.1/nara-win-64.exe"
) else (
    echo Error: Unsupported architecture.
    exit /b 1
)

REM Create installation directory
mkdir "C:\Program Files\Nara"

REM Download and rename the file
echo Downloading Nara from %DOWNLOAD_URL%...
curl -L -o "C:\Program Files\Nara\nara.exe" %DOWNLOAD_URL%

REM Add the installation directory to the PATH
setx PATH "%PATH%;C:\Program Files\Nara" /M

REM Display completion message
echo Installation completed successfully!

REM Run Nara --version
echo Checking Nara version...
"C:\Program Files\Nara\nara.exe" --version

REM Exit with a success status code
exit /b 0