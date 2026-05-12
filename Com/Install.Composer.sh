#!/bin/bash

# Exit immediately if any command fails
set -e

# Check if Composer is already installed in /usr/local/bin
if [ -x "$COMPOSER_PATH" ]; then
    echo "Composer is already installed at $COMPOSER_PATH"
else
    echo "Composer not found. Installing..."
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    echo "Composer installed successfully."
fi