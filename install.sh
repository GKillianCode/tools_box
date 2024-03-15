#!/bin/zsh

DEFAUlT='\033[0m'        # couleur console par defaut
GREEN='\033[0;32m'       # vert mince
WHITE='\033[1;37m'       # blanc gras
BLACK='\033[0;30m'       # noir mince
RED='\033[0;31m'         # rouge mince
BROWN='\033[0;33m'       # marron mince
BLUE='\033[0;34m'        # bleu fonce mince
PURPLE='\033[0;35m'      # violet mince
CYAN='\033[0;36m'        # cyan mince
GRAY='\033[0;37m'        # gris clair mince
WHITE_SMALL='\033[0;38m' # blanc mince
LIGNT_RED='\033[1;31m'   # rouge clair gras
LIGHT_GREEN='\033[1;32m' # vert clair gras
YELLOW='\033[1;33m'      # jaune gras
LIGHT_BLUE='\033[1;34m'  # bleu clair gras
PINK='\033[1;35m'        # rose clair gras
LIGHT_CYAN='\033[1;36m'  # cyan clair gras

echo "${WHITE}"

BASEDIR=$(dirname "$0")

echo "${BLUE}##### System update #####${WHITE}"

sudo apt-get update
sudo apt-get upgrade

usr=$(whoami)

mkdir -p ~/.ssh
rm ~/.my-aliases.sh
cp ${BASEDIR}/provisioning/my-aliases.sh ~/.my-aliases.sh
if ! grep -q "my-aliases.sh" ~/.bashrc; then
        cat ${BASEDIR}/provisioning/git-config.sh >>~/.bashrc
        echo "source ~/.my-aliases.sh" >>~/.bashrc
fi

mkdir temp
cd temp

echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

echo "${BLUE}##### VIM configuration #####${WHITE}"

if [ ! -f ~/.vimrc ]; then
        cp ${BASEDIR}/provisioning/vimrc ~/.vimrc
fi

if [ ! -d ~/.vim/pack/dist/start/vim-airline ]; then
        git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
fi

if [ ! -d ~/.vim/bundle/ctrlp.vim ]; then
        git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

echo "${BLUE}##### Applications and tools install #####${WHITE}"
sudo apt install wget

echo "${GREEN}--- Add GIT ${WHITE}"
sudo apt install git-all

echo "${GREEN}--- Add Google chrome ${WHITE}"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

echo "${GREEN}--- Add docker ${WHITE}"
sudo snap install docker

echo "${GREEN}--- Add NodeJS ${WHITE}"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&
        sudo apt-get install -y nodejs

echo "${GREEN}--- Add Dbeaver ${WHITE}"
sudo snap install dbeaver-ce

echo "${GREEN}--- Add Intellij ${WHITE}"
sudo snap install intellij-idea-community --classic

echo "${GREEN}--- Add JQ ${WHITE}"
sudo snap install jq
sudo snap refresh

echo "${GREEN}--- Python3 tools ${WHITE}"
sudo apt install python3 python3-venv python3-pip

echo "${GREEN}--- Vuejs3 tools ${WHITE}"
npm install @vue/cli-service

echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

echo "${BLUE}##### Delete temporary files #####${WHITE}"

cd ../
rm -Rf temp

echo "${GREEN}"
echo "+ ----------------------------------------------------------------------------- +"
echo "| ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ |"
echo "+ ----------------------------------------------------------------------------- +"
echo "${WHITE}"
echo "---              INSTALLATION AND CONFIGURATION ARE FINISHED                  ---"
echo "${GREEN}"
echo "+ ----------------------------------------------------------------------------- +"
echo "| ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ |"
echo "+ ----------------------------------------------------------------------------- +"
echo "${WHITE}"
