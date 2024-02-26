#!/bin/bash

# Function to perform cleanup
perform_cleanup() {
    # Function to remove directories matching the name pattern "alg*"
    echo
    cleanup() {
        for dir in alg*; do
            if [ -d "$dir" ]; then
                rm -rf "$dir"
            fi
        done
    }

    # Check if "alg-package-automation-scripts" exists in the current directory
    if [ -d "alg-package-automation-scripts" ]; then
        print_message4 "Found 'alg-package-automation-scripts' in the current directory. Exiting..."
        exit 0
    fi

    # Start the loop
    while :; do
        # Check if "main.sh" exists in the current directory
        if [ -f "main.sh" ]; then
            # Perform final cleanup
            cleanup
            print_message4 "Cleanup completed. Exiting..."
            exit 0
        fi

        # Move up one directory level
        cd ..

        # Check if we are already at the root directory ("/")
        if [ "$(pwd)" = "/" ]; then
            print_message4 "Reached the root directory. Exiting..."
            exit 0
        fi
    done
}

