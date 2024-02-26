#!/bin/bash

# Function to run main.sh and handle fatal errors
run_main() {
    while true; do
        # Run main.sh and capture its exit status
        ./main.sh
        exit_status=$?

        # Check the exit status of main.sh
        if [ $exit_status -eq 0 ]; then
            exit 0
        else
            echo "main.sh encountered a fatal error with exit status $exit_status."
            echo "Restarting..."
        fi
    done
}

# Call the function
run_main

