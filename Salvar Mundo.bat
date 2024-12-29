@echo off
:: Get the directory of the script
set scriptDir=%~dp0

:: Change to the script directory
cd /d "%scriptDir%"

:: Add all changes to the staging area
git add .

:: Commit the changes with a message
git commit -m "Commit message"

:: Push the changes to the remote repository
git push origin main