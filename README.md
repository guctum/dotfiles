# Dotfiles

## Pre-requisites

1. Download Xcode using personal Apple ID/Password:
   > https://developer.apple.com/
2. Install Xcode Command Line Tools
   1. `xcode-select --install`
3. Add SSH RSA key to BitBucket
   1. `ssh-keygen` (just fast click thru steps)
   2. `open https://bitbucket.spectrum-health.org:7991/stash/plugins/servlet/ssh/account/keys/add`
   3. `pbcopy < ~/.ssh/id_rsa.pub`
   4. `ssh-add -K ~/.ssh/id_rsa` to add your passphrase to the keychain
4. Clone dotfiles
   1. `git clone ssh://git@bitbucket.spectrum-health.org:7999/ews/dotfiles.git ~/.dotfiles`

## Usage

Run `sh ~/.dotfiles/install.sh`

Make sure to execute the following commands to add your name and email to the global git config:

```bash
git config --global user.name "Your Name"
git config --global user.email "Your Email"
```

## Customize

You can now customize `~/.bash_profile` by adding aliases (i.e. from [bash_buffet.sh](https://bitbucket.spectrum-health.org:7991/stash/projects/EWS/repos/ews-standards/browse/best-practices/resources/bash_buffet.sh)), etc. When you're done, you need to run `source ~/.bash_profile` or reload your shell.

If you need to add cli's or applications, you can create your own Brewfile and place it in another directory of your choosing and run the following command:

```bash
brew bundle --file=<location of your brewfile>
```
