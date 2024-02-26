#!/bin/bash

# Importing source file
source get_pkgbuild.sh

# Back to main directory
path_origin(){

    local package_name=$PACKAGE_NAME

    path="$pkgbuild_path"
    back="../"

    # Convert $path into ../../
    while [[ $path == */* ]]; do
        path="${path#*/}"
        back="${back}../"
    done

    cd "$back"
}

