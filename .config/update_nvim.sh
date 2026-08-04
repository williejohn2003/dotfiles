#!/bin/bash

# by: John Campbell
# This script performs a clean install of the latest stable release of neovim
#
# usage:
# calling the script will prompt for sudo password then perform all tasks to complete the install
#
# recommendations:
# - add a check on the stable branch to your bashrc or zshrc files to keep
#   up with the latest releases of neovim.
# - add an alias to call the update from any directory in the terminal
#


NVIM_PATH="$HOME/apps/neovim/"
RUN_TIME_="/usr/local/share/nvim/"
NVIM_APP="/usr/local/bin/nvim/"

printf "installing clean version of latest stable NVIM..\n"
cd "$NVIM_PATH"

# pull the lastest from stable branch
git checkout stable
git pull

# remove all previous nvim files and executable for a clean install
make distclean
rm -rf "$RUN_TIME"
rm -rf "$NVIM_APP"

# build release version of latest stable branch
make CMAKE_BUILD_TYPE=RelWithDebInfo

# install nvim on the system
sudo make install
printf "NVIM install complete..\n"

