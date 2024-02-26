#!/bin/bash

#function to build package and it's signature package

package_build(){
    local package_name=$PACKAGE_NAME
    local current_year=$CURRENT_YEAR
    local current_month=$CURRENT_MONTH
    local updatedRel=$UPDATED_REL
    
    # Makepkg
    print_message1 "Running makepkg"
    if ! makepkg -s; then
        print_message3 "makepkg encountered an error."
        perform_cleanup
    fi
    

    # Set the file names and directory paths
    zst_file=""
    
    # Check if the zst file exists with the first naming convention
    if ls $package_name-*-$current_year.$current_month-$updatedRel-any.pkg.tar.zst 1> /dev/null 2>&1; then
        zst_file=$(ls $package_name-*-$current_year.$current_month-$updatedRel-any.pkg.tar.zst)
    fi
    
    # If the first pattern not found, check the second naming convention
    if [ -z "$zst_file" ] && ls $package_name-*-$updatedRel-any.pkg.tar.zst 1> /dev/null 2>&1; then
        zst_file=$(ls $package_name-*-$updatedRel-any.pkg.tar.zst)
    fi
    
    # If both patterns are not found, fallback to the third naming convention
    if [ -z "$zst_file" ] && ls $package_name-*-$updatedRel-x86_64.pkg.tar.zst 1> /dev/null 2>&1; then
        zst_file=$(ls $package_name-*-$updatedRel-x86_64.pkg.tar.zst)
    fi
    
    # If zst_file is still empty, no matching zst file found
    if [ -z "$zst_file" ]; then
        echo "No matching zst file found."
    else
        echo "Found zst file: $zst_file"
    fi

    #if [[ ! "$gpg_key_choice" =~ ^[1-${#gpg_keys[@]}]$ ]]; then
    # print_message3 "Invalid choice. Aborting."
    # perform_cleanup
    #fi

    #selected_gpg_key=$(echo "${gpg_keys[gpg_key_choice-1]}" | cut -d'-' -f1)
    #print_message1 "Selected GPG key: $selected_gpg_key"

    #gpgkey() {
    # gpg --output "$1.sig" \
    #     --default-key "$selected_gpg_key" \
    #     --detach-sign \
    #     --sign "$1"
    #}

    #if ! gpgkey "$zst_file"; then
    # print_message3 "sig packages creation encountered an error."
    # perform_cleanup
    #fi

    
    # Set the file names and directory paths
    #sig_file=$zst_file.sig

    # Check if the sig_file exists, otherwise, use the alternative pattern
    #if [ ! -e "$sig_file" ]; then
    #   sig_file=$package_name-$updatedRel-x86_64.pkg.tar.zst.sig
    #fi

    
    export ZST_FILE="$zst_file"
    #export SIG_FILE="$sig_file"

}
