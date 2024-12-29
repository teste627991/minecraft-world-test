@echo off
:: Get the directory of the script
set scriptDir=%~dp0

:: Change to the script directory
cd /d "%scriptDir%"

:: Get all changes from the remote repository
git pull origin main