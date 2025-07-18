#!/bin/bash

BLACK='\033[30m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'
NC="\033[0m"

if [[ $# -eq 0 ]]; then
    echo -e "${MAGENTA}Description:\n\tuse this tool to disable sleep on lid close while on battery.${NC}"
    echo -e "${MAGENTA}Usage:\n\tnosleep <option>${NC}"
    echo -e "${MAGENTA}Options:\n\toff - re-enables sleep on lid close\n\ton - disables sleep on lid close\n\tstatus - shows current sleep disabled status${NC}"
    exit 0
fi

shopt -s nocasematch
if [[ $1 == "STATUS" ]]; then
	SLEEP_DISABLED=$(pmset -g | grep SleepDisabled | awk '{print $2}')
    echo -e "${MAGENTA}SLEEP_DISABLED = $SLEEP_DISABLED${NC}"
	exit 0
fi

if [[ $1 == "ON" ]]; then
    echo -e "${YELLOW}DISABLING SLEEP ON LID CLOSE${NC}"
    sudo pmset -a lidwake 0
    sudo pmset disablesleep 1
fi

if [[ $1 == "OFF" ]]; then
    echo -e "${YELLOW}ENABLING SLEEP ON LID CLOSE${NC}"
    sudo pmset -a lidwake 1
    sudo pmset disablesleep 0
fi
shopt -u nocasematch

SLEEP_DISABLED=$(pmset -g | grep SleepDisabled | awk '{print $2}')
if [[ $SLEEP_DISABLED == 0 ]]; then
    echo -e "${GREEN}ENABLED SLEEP ON LID CLOSE${NC}"
else
    echo -e "${BLUE}DISABLED SLEEP ON LID CLOSE${NC}"
    echo -e "${RED}REMEMBER TO RE-ENABLE!${NC}"
fi

