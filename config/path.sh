# Add EDH specific applications to PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="~/code/plain-utils/bin:$PATH"

# Source Chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Source NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
