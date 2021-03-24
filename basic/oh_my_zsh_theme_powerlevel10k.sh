git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

p10k configure

echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc