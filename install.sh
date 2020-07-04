#!/bin/sh

directory=$(pwd)
user=$(echo $USER)

GREEN='\033[0;32m'
NC='\033[0m' # No color

printf "${GREEN}Installing Oh my zsh!${NC}\n"

cd /tmp && curl -Lo omyzsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && sudo chmod a+x omyzsh.sh && ./omyzsh.sh && rm -f omyzsh.sh

printf "${GREEN}powerlevel10k on its way${NC}\n"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

printf "${GREEN}Setting up powerlevel10k${NC}\n"

mv ~/.zshrc ~/.zshrc.backup && sed 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc.backup > ~/.zshrc

mv ~/.zshrc ~/.zshrc.backup.2 && sed 's/plugins=(git)/plugins=(git kubectl zsh-interactive-cd docker-compose)/g' ~/.zshrc.backup > ~/.zshrc  

mv ~/.p10k.zsh ~/.p10k.backup && sed 's/POWERLEVEL9K_AWS_SHOW_ON_COMMAND=/POWERLEVEL9K_KUBECONTEXT_SHOW_ALL=true #/g' ~/.p10k.backup > ~/.p10k.zsh

git clone https://github.com/powerline/fonts.git --depth=1 &&  ./fonts/install.sh && rm -Rf fonts

printf "${GREEN}Installing kubernetes alias${NC}\n"

cp -f  ${directory}/kubernetes.alias $HOME/.kubernetes.alias

echo "source ~/.kubernetes.alias" >> ~/.zshrc

printf "${GREEN}Updating the ${user} shell to zsh${NC}\n"

sudo usermod -s /bin/zsh ${user}


