#!/bin/bash

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/SourceCodePro.zip"
FONT_ZIP="SourceCodePro.zip"
FONT_DIR="SourceCodePro"
FONT_NAME="SourceCodePro.ttf"
FONT_INSTALL_PATH="$HOME/.local/share/fonts/$FONT_NAME"


# Check if the font is already installed
if [ -f "$FONT_INSTALL_PATH" ]; then
    echo "Font is already installed. Skipping..."
    exit 0
fi

# Download the file
wget "$FONT_URL" -O "$FONT_ZIP"

# Unzip the file
unzip -d "$FONT_DIR" "$FONT_ZIP"

# Create a directory for fonts if it doesn't exist
mkdir -p ~/.local/share/fonts

# Copy ExtraLight to ~/.local/share/fonts as SourceCodePro
cp "$FONT_DIR/SauceCodeProNerdFont-ExtraLight.ttf" "$FONT_INSTALL_PATH"

# Run fc-cache
fc-cache -f -v

# Remove the unzipped directory and zip file
rm -rf "$FONT_DIR" "$FONT_ZIP"

echo "Font installed successfully."
