@echo off
cls

:: Colors (limited support in standard CMD, so using plain text here)
echo ==============================
echo  GAMEBOY COMPILE SCRIPT V1
echo ==============================

:: Remove old build files
echo Checking for and removing old builds...
IF EXIST Build (
    rmdir /s /q Build
)
mkdir Build

:: Compile build files
echo.
echo Building game...
Tools\gbdk_win\bin\lcc -o Build\game.gb src\*.c -Wall

:: Check if build succeeded
if exist Build\game.gb (
    echo.
    echo Build complete.
) else (
    echo Game failed to compile.
)
