#!/bin/bash

# Exit immediately if any command fails
set -e

COMPOSER_PATH="/usr/local/bin/composer"

# Check if Composer is already installed in /usr/local/bin
if [ -x "$COMPOSER_PATH" ]; then
    echo "Composer is already installed at $COMPOSER_PATH"
else
    echo "Composer not found. Installing..."
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    echo "Composer installed successfully."
fi

# Install Laravel installer globally
echo "Installing Laravel installer via Composer..."
"$COMPOSER_PATH" global require "laravel/installer"

# Copy the vendor directory to /usr/local/bin
echo "Copying vendor directory to /usr/local/bin..."
cd /root/.composer
cp -r vendor /usr/local/bin

echo "Configuring PATH to include Laravel installer..."
echo "/usr/local/bin/vendor/bin"
echo "Laravel installation and configuration complete."