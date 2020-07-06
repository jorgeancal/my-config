#!/bin/sh

directory=$(pwd)
user=$(echo $USER)

GREEN='\033[0;32m'
NC='\033[0m' # No color

printf "${GREEN}Updating the ${user} shell to zsh${NC}\n"

chsh -s /bin/zsh ${user}

printf "${GREEN}Installing Oh my zsh!${NC}\n"

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

printf "${GREEN}powerlevel10k on its way${NC}\n"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

printf "${GREEN}Setting up powerlevel10k${NC}\n"

cp -f ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

mv ~/.zshrc ~/.zshrc.backup && sed 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc.backup > ~/.zshrc

mv ~/.zshrc ~/.zshrc.backup.2 && sed 's/plugins=(git)/plugins=(git kubectl docker-compose)/g' ~/.zshrc.backup.2 > ~/.zshrc  

cp -f  ${directory}/p10k.zsh ~/.p10k.zsh

git clone https://github.com/powerline/fonts.git --depth=1 &&  ./fonts/install.sh && rm -Rf fonts

printf "${GREEN}Installing kubernetes alias${NC}\n"

cp -f  ${directory}/kubernetes.alias $HOME/.kubernetes.alias

echo "source ~/.kubernetes.alias" >> ~/.zshrc

printf "${GREEN}Setting the powerlevel10k on your zsh config file${NC}\n"

echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc

printf "${GREEN}Disabling the config wizard${NC}\n"

echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=false' >> ~/.zshrc

printf "${GREEN}Done! Close this console and open a new one :)${NC}\n"


