# Variables
    RESET='\033[0m'
    GREEN='\033[0;32m'
GREENBOLD='\033[1;32m'
      RED='\033[0;31m'


#!/bin/bash
clear
echo    -e "${GREENBOLD}GAMEBOY COMPILE SCRIPT V1${RESET}"

# Remove old build files.
echo    -e  "Checking for and removing old builds."
rm      -rf Build/*

# Compile build files.
echo "Building game"
echo ""
Tools/GBDK/bin/lcc -o Build/game.gb src/*.c -Wall


# Run the game? (errors out if file didn't compile)
if [ -f Build/game.gb ]; then
    echo ""
    echo -e "Build complete"
    


    read -n1 -p "Run the game? (y/n): " answer
    echo ""
    echo ""

    if [ "$answer" = "y" ]; then
        echo "Running game."
        sameboy Build/game.gb
    else
        echo "Don't forget to test any changes. :)"
    fi
else
    echo -e "${RED}Game failed to compile.${RESET}"
fi