@echo off
title %~f0

rem Automatically run by answer file upon first boot after installation

set from_drive=D:
set to_drive=E:

if "%~d0" == "%from_drive%" (
    rem Changing the driver letter takes a while so we must disable the network prompt now before it is displayed
    start /wait cmd /c "%from_drive%\no-network-prompt.bat"

    rem After changing the drive letter the batch file is on, the command processor will no longer be able to read from it and close
    rem Therefore, we must run run.bat again
    start /wait cmd /c "%from_drive%\change-drive-letter.bat %to_drive%" & start cmd /c "%to_drive%\run.bat"
)
cd /d %to_drive%

start cscript "allow-device-software.vbs"
start /wait cmd /c "trust-certificates.bat"
start cmd /c "install-qwt.bat"
start cmd /c "wait-for-shutdown.bat"
