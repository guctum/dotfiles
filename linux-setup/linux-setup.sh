#!/bin/sh

# Note: this is designed for Red Hat Enterprise Linux or macOS

if [[ ! -f $(which brew) ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  printf "\033[0;32m\$(which brew)\033[0m:[$(which brew)] already exists. Skipping...\n"
fi

printf "Updating Brewfile casks and brews...\n"
eval "brew tap homebrew/bundle" > /dev/null 2>&1
eval "brew bundle --file=$BREW_FILE" > /dev/null 2>&1
