@echo off
:: Get the directory of the script
set scriptDir=%~dp0

:: Change to the script directory
cd /d "%scriptDir%"

:: switch to the master branch
git checkout master

:: Add all changes to the staging area
git add .

:: Commit the changes with a message
git commit -m "Saved Using Bat File"

:: Push the changes to the remote repository
git push origin master