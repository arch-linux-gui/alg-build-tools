#!/bin/bash

# Function to handle repository operations
get_server() {
    local server=$1
    local package_name=$PACKAGE_NAME
    # Access the environment variables
    local zst_file=$ZST_FILE
    #local sig_file=$SIG_FILE

    # Clone the repository
    print_message1 "Cloning the $server"
    git clone git@github.com:arch-linux-gui/$server.git
    print_message4 $zst_file
    #print_message4 $sig_file

    mkdir alg-newpackages
    destination="alg-newpackages/"
    destination1="$server/x86_64/"

    # Remove the previous .zst file(s)
    old_zst_files="$destination1$package_name-*zst"
    for file in $old_zst_files; do
        if [ -e "$file" ]; then
            rm "$file"
        fi
    done

    #old_sig_files="$destination1$package_name-*zst.sig"
    #for file in $old_sig_files; do
    #    if [ -e "$file" ]; then
    #        rm "$file"
    #    fi
    #done


    # Copy the new file to the destination
    cp $pkgbuild_path/$zst_file $destination
    #cp $pkgbuild_path/$sig_file $destination


    # Update the repository database
    #print_message1 "Updating the repository database"
    #cd $server/x86_64/
    #./update_repo.sh

    #cd ../..

    cd $pkgbuild_path
    print_message2 "Cleaning up PKGBUILD"
    ./cleanup.sh

    path_origin
    

}
