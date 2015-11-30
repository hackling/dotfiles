echo "Installing Fresh"
bash -c "`curl -sL get.freshshell.com`"

echo "Sourcing Fresh"
source ~/.fresh/build/shell.sh

echo 'Symlinking freshrc from dotfiles'
ln -s .dotfiles/freshrc .freshrc
