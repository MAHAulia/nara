#!/bin/bash

# Display a welcome message
echo "Welcome to Nara Installation for macOS/Linux"

# Define variables
PLATFORM=$(uname -s)
ARCH=$(uname -m)
DOWNLOAD_URL=""
INSTALL_DIR="$HOME/Nara"
EXECUTABLE_NAME="nara"

# Check the platform and set the download URL accordingly
if [ "$PLATFORM" == "Darwin" ]; then
    echo "macOS Platform"
    DOWNLOAD_URL="https://drive.google.com/u/0/uc?id=1YhlwKuNq1X3X8ZzWMh7k4UonhBMgdKZJ&export=download"
elif [ "$PLATFORM" == "Linux" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        echo "Linux x86_64 Platform"
        DOWNLOAD_URL="https://drive.google.com/u/0/uc?id=1EJhYGW3_6FuA2L9S_yJWZndVxT3g6zkw&export=download"
    elif [ "$ARCH" == "i686" ]; then
        echo "Linux i686 Platform"
        DOWNLOAD_URL="https://drive.google.com/u/0/uc?id=12AUrEQxGi3sTHnrfbM3Pus1Fc2vyY2XB&export=download"
    else
        echo "Error: Unsupported architecture. Nara installation is supported only on 32-bit and 64-bit Linux platforms."
        exit 1
    fi
else
    echo "Error: Unsupported platform. Nara installation is supported only on macOS and Linux."
    exit 1
fi

# Create installation directory
echo "Creating installation directory"
sudo mkdir -p "$INSTALL_DIR"

# Download and rename the file
echo "Downloading Nara from $DOWNLOAD_URL..."
TMP_FILE=$(mktemp)
curl -L -o "$TMP_FILE" "$DOWNLOAD_URL"

# Check if the download was successful before proceeding
if [ $? -ne 0 ]; then
    echo "Error: Failed to download MrPostman."
    rm "$TMP_FILE"
    exit 1
fi

# Rename the downloaded file and set executable permissions
echo "Moving from $TMP_FILE to $INSTALL_DIR/$EXECUTABLE_NAME..."
mv "$TMP_FILE" "$INSTALL_DIR/$EXECUTABLE_NAME"
chmod +x "$INSTALL_DIR/$EXECUTABLE_NAME"

# Add MrPostman to the CLI permanently
echo "Adding Nara to the CLI..."
if [ "$PLATFORM" == "Darwin" ]; then
    echo "macOS Platform"
    echo 'export PATH=$PATH:'"$INSTALL_DIR" >> ~/.bash_profile
    source ~/.bash_profile
elif [ "$PLATFORM" == "Linux" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        echo "Linux x86_64 Platform"
        echo 'export PATH=$PATH:'"$INSTALL_DIR" >> ~/.bashrc
        source ~/.bashrc
    elif [ "$ARCH" == "i686" ]; then
        echo "Linux i686 Platform"
        echo 'export PATH=$PATH:'"$INSTALL_DIR" >> ~/.bashrc
        source ~/.bashrc
    fi
fi

# Display completion message
echo "Installation completed successfully!"

# Run Nara --version
echo "Checking Nara version..."
nara version

# Exit with a success status code
exit 0
