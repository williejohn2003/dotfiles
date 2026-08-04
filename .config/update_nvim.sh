NVIM_PATH="$HOME/apps/neovim/"
RUN_TIME_="/usr/local/share/nvim/"
NVIM_APP="/usr/local/bin/nvim/"

# pull the lastest from Master
printf "installing clean version of latest stable NVIM..\n"
cd "$NVIM_PATH"
git checkout stable
git pull
make distclean
rm -rf "$RUN_TIME"
rm -rf "$NVIM_APP"
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
printf "NVIM install complete..\n"

