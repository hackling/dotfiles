#!/bin/bash

# Function to check if a package is installed
is_package_installed() {
    dpkg -s "$1" &> /dev/null
}

# Function to install a package if not already installed
install_if_not_installed() {
    if ! is_package_installed "$1"; then
        sudo apt install "$1" -y
        echo "$1 installed."
    else
        echo "$1 is already installed."
    fi
}

# sudo apt update

install_if_not_installed git
install_if_not_installed curl
# sudo add-apt-repository ppa:neovim-ppa/unstable
install_if_not_installed neovim
install_if_not_installed bat
install_if_not_installed build-essential
install_if_not_installed ripgrep

copy_ssh_keys() {
    # Check if SSH keys exist on the new laptop
    if [ ! -f ~/.ssh/id_rsa ] || [ ! -f ~/.ssh/id_rsa.pub ]; then
        # Prompt for username and old laptop IP
        read -p "Enter the username@old_laptop_ip: " remote_user

        # Use SCP to copy SSH keys
        scp -v "$remote_user:~/.ssh/*" ~/.ssh/

        # Check the exit status of the SCP command
        if [ $? -eq 0 ]; then
            # Set correct permissions
            chmod 600 ~/.ssh/id_rsa
            chmod 644 ~/.ssh/id_rsa.pub

            echo "SSH keys copied successfully."
        else
            echo "Error: SCP connection refused. Make sure the SSH server is running on the old laptop and the credentials are correct."
        fi
    else
        echo "SSH keys already exist on the new laptop."
    fi
}

# Call the function
copy_ssh_keys
# Function to check if a directory exists
is_directory_exists() {
    [ -d "$1" ]
}

# Function to clone a Git repository if not already cloned
clone_repo_if_not_exists() {
    local repo_url="$1"
    local target_dir="$2"
    local branch="$3"

    if ! is_directory_exists "$target_dir"; then
        git clone "$repo_url" "$target_dir" --branch "$branch"
        echo "Repository cloned to $target_dir."
    else
        echo "Repository already exists in $target_dir."
    fi
} 
clone_repo_if_not_exists "https://github.com/hackling/dotfiles.git" "$HOME/.dotfiles" "topic/2023" 
clone_repo_if_not_exists "https://github.com/asdf-vm/asdf.git" "$HOME/.asdf" "v0.13.1" 

# mv .bashrc .bashrc.old
# bash -c "`curl -sL https://get.freshshell.com`"

# Function to append a line to a file if not already present
append_line_to_file() {
    local line="$1"
    local file_path="$2"

    if ! grep -qF "$line" "$file_path"; then
        echo "$line" >> "$file_path"
        echo "Line appended to $file_path."
    else
        echo "Line already present in $file_path."
    fi
}

# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_package() {
    local package_name="$1"
    local download_url="$2"

    if command_exists $package_name; then
        echo "$package_name is already installed"
    else
        echo "Installing $package_name..."

        # Download the package
        wget -O "$package_name.deb" "$download_url"

        # Install the downloaded package
        sudo dpkg -i "$package_name.deb"

        # Install dependencies (if any)
        sudo apt install -f

        # Remove the downloaded package (optional)
        rm "$package_name.deb"

        echo "$package_name installed."
    fi
}


install_package "google-chrome-stable" "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
install_package "discord" "https://discord.com/api/download?platform=linux&format=deb"
install_if_not_installed chromium-chromedriver
install_if_not_installed libreoffice

# ASDF Dependencies
install_if_not_installed dirmngr
install_if_not_installed gpg
install_if_not_installed gawk
install_if_not_installed zlib1g-dev # Required for old ruby installs
/home/nick/.asdf/bin/asdf plugin add nodejs 
/home/nick/.asdf/bin/asdf plugin add ruby
/home/nick/.asdf/bin/asdf install

initialize_directory() {
    local directory_path="$1"
    if [ ! -d "$directory_path" ]; then
        mkdir -p "$directory_path"
        echo "Created $directory_path."
    else
        echo "$directory_path already exists."
    fi
}

initialize_directory "$HOME/code"
clone_repo_if_not_exists "git@github.com:hackling/mtgmate.git" "$HOME/code/mtgmate" "master"


if command_exists heroku; then
    echo "Heroku is already installed"
else
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
fi

install_if_not_installed make
install_if_not_installed pkg-config
install_if_not_installed libx11-dev
install_if_not_installed libxtst-dev
install_if_not_installed libxi-dev


if command_exists xcape; then
    echo "xcape is already installed"
else
clone_repo_if_not_exists "git@github.com:alols/xcape.git" "$HOME/code/xcape" "master"
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
    make -C ~/code/xcape
    sudo make -C ~/code/xcape install
fi
install_if_not_installed fzf #This might need a custom install
