#!/bin/bash

# Function to handle PKGBUILD operations
get_pkgbuild() {
    local package_name
    local package_number
        
    # Clone the PKGBUILD repository
    print_message1 "Cloning PKGBUILD repository"
    git clone https://github.com/arch-linux-gui/alg-pkgbuild.git
    cd alg-pkgbuild
    git checkout dev
    cd ..
    

   # Prompt the user for a package name
   print_message1 "Enter a directory name to search for: "
   print_message2 "1) alg-cinnamon-settings"
   print_message2 "2) alg-firefox-settings"
   print_message2 "3) alg-gnome-settings"
   print_message2 "4) alg-i3-settings"
   print_message2 "5) alg-livecd-desktop"
   print_message2 "6) alg-mate-settings"
   print_message2 "7) alg-office-settings"
   print_message2 "8) alg-plasma-settings"
   print_message2 "9) alg-xfce-settings"
   print_message2 "10) alg-net-cala-config"
   print_message2 "11) alg-pure-cala-config"
   print_message2 "12) alg-theme-cala-config"
   print_message2 "13) alg-wm-cala-config"
   print_message2 "14) alg-zen-cala-config"
   print_message2 "15) studio-cala-config"
   print_message2 "16) calamares-3.2.62"
   
   if [ "$ans" == "all" ]; then
      package_number=$i

   elif [ "$ans" == "few" ]; then
      package_number=$i

   else
      read -p "Enter the number of your choice: " package_number
   fi

   # Prompt the user for a choice
   # read -p "Enter the number of your choice: " choice
   case $package_number in
      1) package_name="alg-cinnamon-settings"
         ;;
      2) package_name="alg-firefox-settings"
         ;;
      3) package_name="alg-gnome-settings"
         ;;
      4) package_name="alg-i3-settings"
         ;;
      5) package_name="alg-livecd-desktop"
         ;;
      6) package_name="alg-mate-settings"
         ;;
      7) package_name="alg-office-settings"
         ;;
      8) package_name="alg-plasma-settings"
         ;;
      9) package_name="alg-xfce-settings"
         ;;
      10) package_name="alg-net-cala-config"
          ;;
      11) package_name="alg-pure-cala-config"
          ;;
      12) package_name="alg-theme-cala-config"
          ;;
      13) package_name="alg-wm-cala-config"
          ;;
      14) package_name="alg-zen-cala-config"
          ;;
      15) package_name="studio-cala-config"
          ;;
      16) package_name="calamares-3.2.62"
          ;;
      *) print_message3 "Invalid choice"
         perform_cleanup ;;
   esac



    # Search for the directory within alg-pkgbuild folder
    pkgbuild_path=$(find alg-pkgbuild -type d -name "$package_name" -print)

    # Check if the directory was found
    if [ -z "$pkgbuild_path" ]; then
        echo "Directory '$package_name' not found within alg-pkgbuild folder."
        exit 1
    fi

    # Ask the user for confirmation
    #echo "Found directory: $pkgbuild_path"
    #echo -n "Do you want to navigate to this directory? (y/n): "
    #read user_choice

    # Check user's choice, if user presses on y or enter key it should run
   if [ "$user_choice" = "y" ] || [ "$user_choice" = "" ]; then
        cd "$pkgbuild_path"
        echo "Navigated to: $pkgbuild_path"
    else
        echo "Directory navigation aborted."
        perform_cleanup  # Exit successfully
    fi

    if [ "$package_name" = "calamares-3.2.62" ]; then
        pkgrel=$(grep -oP '^pkgrel=\K\d+' PKGBUILD)
        updatedRel=$((pkgrel + 1))
    
        # Update the PKGBUILD file with the new pkgrel value
        sed -i "s/^pkgrel=$pkgrel/pkgrel=$updatedRel/" PKGBUILD
        print_message3 "No need to update pkgbuild"

    else

        # Read the current pkgver value from PKGBUILD
        current_pkgver=$(grep -oP '^pkgver=\K\d+\.\d+' PKGBUILD)
        previous_year=$(echo "$current_pkgver" | cut -d'.' -f1)
        previous_month=$(echo "$current_pkgver" | cut -d'.' -f2)
    
        # Calculate current year and month
        current_year=$(date +'%y')
        current_month=$(date +'%m')
    
        # Update the PKGBUILD file with the new pkgver value
        new_pkgver="$current_year.$current_month"
        sed -i "s/^pkgver=.*/pkgver=$new_pkgver/" PKGBUILD
    
        # Reset pkgrel to 1 if pkgver year or month is updated
        if [ "$current_year" != "$previous_year" ] || [ "$current_month" != "$previous_month" ]; then
            sed -i "s/^pkgrel=.*/pkgrel=1/" PKGBUILD
            pkgrel=$(grep -oP '^pkgrel=\K\d+' PKGBUILD)
            updatedRel=$((pkgrel))
        else
            pkgrel=$(grep -oP '^pkgrel=\K\d+' PKGBUILD)
            updatedRel=$((pkgrel + 1))
    
            # Update the PKGBUILD file with the new pkgrel value
            sed -i "s/^pkgrel=$pkgrel/pkgrel=$updatedRel/" PKGBUILD
        fi
    fi
        print_message1 "Updated PKGBUILD:"
        cat PKGBUILD

        export PACKAGE_NAME="$package_name"
        export CURRENT_YEAR="$current_year"
        export CURRENT_MONTH="$current_month"
        export UPDATED_REL="$updatedRel"

}

