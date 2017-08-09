# Add EDH specific applications to PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="~/code/plain-utils/bin:$PATH"

# Source NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export $(dinghy shellinit)
