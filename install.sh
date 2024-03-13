#!/bin/zsh

sudo apt-get update
sudo apt-get upgrade

usr=$(whoami)

mkdir -p ~/.ssh

cp ${BASEDIR}/provisioning/my-aliases.sh ~/.my-aliases.sh
if ! grep -q "my-aliases.sh" ~/.zshrc
then
  echo "source ~/.my-aliases.sh"  >> ~/.zshrc
fi

echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

echo "VIM configuration"

if [ ! -f ~/.vimrc ]
then
        cp ${BASEDIR}/provisioning/vimrc ~/.vimrc
fi

if [ ! -d ~/.vim/pack/dist/start/vim-airline ]
then
	git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
fi

if [ ! -d ~/.vim/bundle/ctrlp.vim ]
then
        git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

echo " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

echo "Applications and tools install"

sudo snap install dbeaver-ce
sudo snap install intellij-idea-community --classic
sudo apt-get install nodejs npm
sudo snap install jq
sudo snap refresh

GREEN='\033[1;32m' # Green Color
NC='\033[0m' # No Color
echo "-----------------------------------------------------------------------------"
echo "${GREEN}INSTALLATION AND CONFIGURATION IS FINISH${NC}"
echo "-----------------------------------------------------------------------------"