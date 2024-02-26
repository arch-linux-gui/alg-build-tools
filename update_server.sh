#!/bin/bash

# Function to handle repository operations
update_server() {
    local server=$1
    local package_name=$PACKAGE_NAME

    # Check if the server directory exists
    if [ -d "$server" ]; then
        print_message1 "Repository '$server' exists"
        
        # Update the repository database
        print_message1 "Updating the repository database"
        cp -r $destination/* $server/x86_64/
        cd $server/x86_64/
        ./update_repo.sh

        # Push to server
        print_message1 "Pushing to $server"
        cd ..
        git add .

        # Set the remote URL
        git remote set-url origin "git@github.com:arch-linux-gui/$server.git"

        # Create commit message
        if [ "$ans" == "all" ]; then
            commit_message="[PKG-UPD] All Packages Are Updated"
        elif [ "$ans" == "few" ]; then
            commit_message="[PKG-UPD] Few Packages Are Updated"
        else
            commit_message="[PKG-UPD] $package_name"    
        fi

        # Commit changes
        git commit -S -m "$commit_message"

        # Ask the user whether to push the changes
    print_message4 "Do you want to push the changes in $server repo (yes/y/enter to continue, any other key to exit):"
    read answer
    # Check the user's response
    if [[ $answer =~ ^[Yy]$|^$ ]]; then
        echo "Continuing..."
        # Your code to continue with pushing the changes goes here
    else
        echo "Exiting the script."
        perform_cleanup
    fi 

        # Attempt to push and check the exit status
        if ! git push; then
            print_message4 "Git push failed."
            perform_cleanup
        fi
        cd ..
    else
        print_message3 "Repository '$server' not found."
    fi
}
