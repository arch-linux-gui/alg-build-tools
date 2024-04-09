# ALG Build Tools

Welcome to the ALG Build Tools repository! Here, you'll find a comprehensive set of Bash scripts designed to automate various tasks for managing Arka Linux GUI (ALG) packages and repositories.

## Overview

The ALG Build Tools are a toolkit for streamlining the process of updating, managing, and maintaining ALG packages and repositories. From updating PKGBUILD files to managing repository servers, these scripts handle it all efficiently.

## For Whom

These scripts are for maintainers, contributors, and developers involved in ALG package management. Whether you're curating packages, adding features, or fine-tuning repositories, these scripts make your workflow smoother.

## Scripts

1. **main.sh**: Orchestrates package updates, guiding users through updating packages and managing repositories.
2. **get_pkgbuild.sh**: Handles PKGBUILD files, from cloning the repository to updating files.
3. **package_build.sh**: Builds packages using makepkg and identifies the correct zst file.
4. **update_server.sh**: Manages repository server operations, from cloning to pushing changes.
5. **cleanup.sh**: Removes directories and files matching specific patterns for a clean environment.
6. **start.sh**: Initiates the process and handles fatal errors gracefully.
7. **path_origin.sh**: Navigates back to the main directory from subdirectories.
8. **update_pkgbuild.sh**: Updates the PKGBUILD repository by committing and pushing changes.
9. **get_server.sh**: Manages repository cloning and file copying.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/arch-linux-gui/alg-build-tools.git
   cd alg-build-tools

Make sure your function scripts (update_pkgbuild.sh, get_pkgbuild.sh, update_server.sh, etc) are located in the same directory as the start.sh.

2. Make the start script executable:

   ```bash
   chmod +x start.sh

3. Run the script:

   ```bash
   ./start.sh

