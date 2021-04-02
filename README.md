# Dotfiles

## Pre-requisites

1. Download Xcode using personal Apple ID/Password:
   > https://developer.apple.com/
2. Install Xcode Command Line Tools
   1. `xcode-select --install`

## Usage

Run `sh ~/.dotfiles/install.sh`

Make sure to execute the following commands to add your name and email to the global git config:

```bash
git config --global user.name "Your Name"
git config --global user.email "Your Email"
```

## Customize

You can now customize `~/.bash_profile` by adding aliases etc. When you're done, you need to run `source ~/.bash_profile` or reload your shell.

If you need to add cli's or applications, you can create your own Brewfile and place it in another directory of your choosing and run the following command:

```bash
brew bundle --file=<location of your brewfile>
```
