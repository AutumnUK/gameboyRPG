@echo off
cls
echo ==============================
echo  GAMEBOY INCREMENTAL BUILD
echo ==============================

:: Ensure build directory exists
if not exist Build mkdir Build

:: Compile changed files
for %%F in (src\*.c) do (
    if not exist Build\%%~nF.o (
        echo Compiling %%F ...
        Tools\gbdk_win\bin\lcc -c -o Build\%%~nF.o %%F -Wall
    ) else (
        for %%I in (%%F) do for %%J in (Build\%%~nF.o) do (
            if %%~tI GTR %%~tJ (
                echo Recompiling %%F ...
                Tools\gbdk_win\bin\lcc -c -o Build\%%~nF.o %%F -Wall
            )
        )
    )
)

:: Link step
echo Linking game.gb ...
Tools\gbdk_win\bin\lcc -o Build\game.gb Build\*.o

:: Result
if exist Build\game.gb (
    echo Build complete.
) else (
    echo Build failed.
)
