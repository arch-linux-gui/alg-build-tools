#!/bin/bash

# Function to handle PKGBUILD repository update
update_pkgbuild() {
    local package_name=$PACKAGE_NAME
    # Clean up the PKGBUILD repository
    cd alg-pkgbuild
    #print_message2 "Cleaning up PKGBUILD"
    #./cleanup.sh

    # Update the PKGBUILD repository
    print_message1 "Updating PKGBUILD repository"
    #git checkout dev
    git add .
    git remote set-url origin git@github.com:arch-linux-gui/alg-pkgbuild.git

    if [ "$ans" == "all" ]; then
    commit_message="All PKGBUILD Have Been Updated"
    elif [ "$ans" == "few" ]; then
    commit_message="Few PKGBUILD Have Been Updated"
    else
    commit_message="$package_name PKGBUILD Have Been Updated"    
    fi

    # Commit changes
    git commit -S -m "$commit_message"

 
    # Ask the user whether to push the changes
    print_message4 "Do you want to push the changes in alg-pkgbuild repo (yes/y/enter to continue, any other key to exit):"
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

    print_message1 "PKGBUILD repository has been updated"
}
