#!/bin/bash

function service_func() {
    # ps --no-headers --format "pid,comm"
    # ps auxw --no-headers --format "pid,comm"
    # systemctl list-units --type=service --no-legend | awk '{print $1, $4}'
    ps auxw | awk '{print $2, $11}';
    return 0;
}

function killpid_func() {
    read pid
    process_name=$(ps -p $pid -o comm=)
    if [ -n "$process_name" ]; then
        echo "The process with PID $pid is named: $process_name"
        
        echo "Are you sure you want to kill this process? [y/N]"
        read confirmation

        if [ "$confirmation" = "y" ]; then
            kill $PID
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

function services_func() {
    return 0;
}

function find_func() {
    return 0;
}

function animation_func() {
    case $((1 + RANDOM % 1)) in
        1)
            # Cmatrix animation
            timeout --foreground 3 cmatrix;
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
