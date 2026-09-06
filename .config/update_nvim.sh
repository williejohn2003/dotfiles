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

NVIM_PATH=""$HOME"/apps/neovim/"
RUN_TIME_NVIM="/usr/local/share/nvim/"
NVIM_APP="/usr/local/bin/nvim/"

# exit on any error
set -e
# print lines
#set -x

# script has to run as root to install
# this will call sudo if the user doesn't
#if [ "$(id -u)" -ne 0 ]; then
#  exec sudo "$0" "$@"
#fi

# ask user if they want to continue or abort install
read -rp "initiate clean build and install of latest release of NeoVIM (Y/N): " ANS;

# continue or abort install
case "$ANS" in
  [Yy])
    printf "continuing install..\n";
    ;;
  *)
    printf "aborting install..\n";
    exit 0;
    ;;
esac

# change directory to neovim repo
if [[ -e "$NVIM_PATH" ]]; then
  cd "$NVIM_PATH"
  
  # remove all previous nvim files and executable for a clean install
  make distclean
  echo "$RUN_TIME_NVIM"
  sudo rm -rf "$RUN_TIME_NVIM"
  sudo rm -rf "$NVIM_APP"
  
  # pull the lastest from stable branch
  git checkout master
  git pull
  git checkout "$(git describe --tags "$(git rev-list --tags --max-count=1)")"
  
  # build release version of latest stable branch
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  
  # installing clean version of latest stable NVIM
  sudo make install
  
  # print install completion message and neovim version
  printf "\n";
  printf "\n";
  printf "====================================================================\n";
  printf "NVIM install complete!\n";
  nvim --version
  printf "====================================================================\n";

else 
	printf "nvim repo not found at: $NVIM_PATH\n";
fi


exit 0

