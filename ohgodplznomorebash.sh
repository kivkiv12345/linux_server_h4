#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
DEFAULT='\e[0m'

# Function to switch to full-screen mode
function enter_fullscreen() {
  tput smcup  # Enter alternate screen buffer
  clear
  stty -echo
  tput civis  # Hide the cursor
}

# Function to exit full-screen mode
function exit_fullscreen() {
  stty echo
  tput cnorm  # Show the cursor
  tput rmcup  # Exit alternate screen buffer
  # clear
}

# Function to display animation
function play_lineloader_animation() {
  enter_fullscreen
  for i in {1..10}; do
    clear
    case $i in
      1)
        echo -e "${GREEN}O${RED}|||||||||";;
      2)
        echo -e "${YELLOW}|${GREEN}O${RED}||||||||";;
      3)
        echo -e "${YELLOW}||${GREEN}O${RED}|||||||";;
      4)
        echo -e "${YELLOW}|||${GREEN}O${RED}||||||";;
      5)
        echo -e "${YELLOW}||||${GREEN}O${RED}|||||";;
      6)
        echo -e "${YELLOW}|||||${GREEN}O${RED}||||";;
      7)
        echo -e "${YELLOW}||||||${GREEN}O${RED}|||";;
      8)
        echo -e "${YELLOW}|||||||${GREEN}O${RED}||";;
      9)
        echo -e "${YELLOW}||||||||${GREEN}O${RED}|";;
      10)
        echo -e "${YELLOW}|||||||||${GREEN}O${DEFAULT}";;
    esac
    sleep 0.5
  done
  exit_fullscreen
}

function play_circleloader_animation() {
  enter_fullscreen
  for i in {1..15}; do
    clear
    case $i in
      1) 
        echo -e ""
        echo -e " ${GREEN}O${RED}++"
        echo -e " ${RED}+ +"
        echo -e " ${RED}+++"
          ;;
      2) 
        echo -e ""
        echo -e " ${YELLOW}#${GREEN}O${RED}+"
        echo -e " ${RED}+ +"
        echo -e " ${RED}+++"
          ;;
      3) 
        echo -e ""
        echo -e " ${YELLOW}##${GREEN}O"
        echo -e " ${RED}+ +"
        echo -e " ${RED}+++"
          ;;
      4) 
        echo -e ""
        echo -e " ${YELLOW}###"
        echo -e " ${RED}+ ${GREEN}O"
        echo -e " ${RED}+++"
          ;;
      5) 
        echo -e ""
        echo -e " ${YELLOW}###"
        echo -e " ${RED}+ ${YELLOW}#"
        echo -e " ${RED}++${GREEN}O"
          ;;
      6) 
        echo -e ""
        echo -e " ${YELLOW}###"
        echo -e " ${RED}+ ${YELLOW}#"
        echo -e " ${RED}+${GREEN}O${YELLOW}#"
          ;;
      7) 
        echo -e ""
        echo -e " ${YELLOW}###"
        echo -e " ${RED}+ ${YELLOW}#"
        echo -e " ${GREEN}O${YELLOW}##"
          ;;
      8) 
        echo -e ""
        echo -e " ${YELLOW}###"
        echo -e " ${GREEN}O ${YELLOW}#"
        echo -e " ${YELLOW}###"
          ;;
      9) 
        echo -e ""
        echo -e " ${YELLOW}###"
        echo -e " ${YELLOW}#${GREEN}O${YELLOW}#"
        echo -e " ${YELLOW}###"
          ;;
      10) 
        echo -e ""
        echo -e " ${YELLOW}#${GREEN}O${YELLOW}#"
        echo -e " ${GREEN}OOO"
        echo -e " ${YELLOW}#${GREEN}O${YELLOW}#"
          ;;
      11) 
        echo -e "${GREEN}  O"
        echo -e "${GREEN} OOO"
        echo -e "${GREEN}OO OO"
        echo -e "${GREEN} OOO"
        echo -e "${GREEN}  O"
          ;;
      12) 
        echo -e "${GREEN}  O"
        echo -e "${GREEN} O O"
        echo -e "${GREEN}O   O"
        echo -e "${GREEN} O O"
        echo -e "${GREEN}  O"
          ;;
      13) 
        echo -e "${GREEN}  O"
        echo -e "${GREEN}    "
        echo -e "${GREEN}O   O"
        echo -e "${GREEN}    "
        echo -e "${GREEN}  O"
          ;;
      14) 
        echo -e "${GREEN}  O"
          ;;
      15) 
        echo -e "${GREEN}Fin${DEFAULT}"
        sleep 0.5
          ;;
    esac
    sleep 0.4
  done
  exit_fullscreen
}

function service_func() {
    # ps --no-headers --format "pid,comm"
    # ps auxw --no-headers --format "pid,comm"
    # systemctl list-units --type=service --no-legend | awk '{print $1, $4}'
    ps auxw | awk '{print $2, $11}';
    return 0;
}

function killpid_func() {
    echo "Please enter PID of process you wish to kill: "
    read pid
    process_name=$(ps -p $pid -o comm=)
    if [ -n "$process_name" ]; then
        echo "The process with PID $pid is named: $process_name"
        
        echo "Are you sure you want to kill this process? [y/N]"
        read confirmation

        if [ "$confirmation" = "y" ]; then
            kill $pid
            printf "Killed %d\n" "$pid"
        fi
    else
        echo "No process found with PID $pid"
    fi
    return 0;
}

function ident_func() {
    neofetch;
    return 0;
}

function find_func() {
    echo "Please enter the filename you want to search for: "
    read filename
    printf "Searching for files by filename: %s\n" "$filename"
    find / -name $filename 2>/dev/null;
    return 0;
}

function animation_func() {
    case $((1 + RANDOM % 3)) in
        1)
            # Cmatrix animation
            timeout --foreground 3 cmatrix;
            ;;
        2)
            play_lineloader_animation;
            ;;
        3)
            play_circleloader_animation;
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    return 0;
}


PS3="Select the operation: "

select opt in services killpid ident find animation quit; do

  case $opt in
    services)
      service_func
      ;;
    killpid)
      killpid_func
      ;;
    ident)
      ident_func
      ;;
    find)
      find_func
      ;;
    animation)
      animation_func
      ;;
    quit)
      break
      ;;
    *) 
      echo "Invalid option $REPLY"
      ;;
  esac
done
