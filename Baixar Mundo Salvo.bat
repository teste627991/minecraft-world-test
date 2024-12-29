@echo off
:: Get the directory of the script
set scriptDir=%~dp0

:: Change to the script directory
cd /d "%scriptDir%"

:: Discart all changes in the local repository
git checkout -- .

:: Get all changes from the remote repository
git pull origin master