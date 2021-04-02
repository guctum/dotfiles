#!/bin/sh

export PATH=$HOME/.jenv/shims:$PATH

WORK=/work
BREW_FILE=./Brewfile
M2_HOME=$HOME/.m2

local_maven_settings_file=$M2_HOME/settings.xml

# -----------------------------------------------------------------

function java_version_parser {
	echo $1 | sed -e 's/\([a-z-]\)//g' -e 's/\([0-9]\{1,\}.[0-9]\{1,\}\).*/\1/'
}

function java_version_exists {
	local version_exists=0

  IFS=$'\n'
	for i in $(jenv whence java)
	do
		if [[ $(java_version_parser $1) = $i  ]]
		then
			version_exists=1
		fi
	done

	echo $version_exists
}

# -----------------------------------------------------------------

if [[ ! -f $(which brew) ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  printf "\033[0;32m\$(which brew)\033[0m:[$(which brew)] already exists. Skipping...\n"
fi

brewp="" # figure out what should go in here
printf "Updating Brewfile casks and brews...\n"
eval "$brewp tap homebrew/bundle" > /dev/null 2>&1
eval "$brewp bundle --file=$BREW_FILE" > /dev/null 2>&1

# -----------------------------------------------------------------

if [[ ! -d $JAVA_HOME ]]; then
    eval "$(jenv init -)"
    JAVA_HOME=$(jenv javahome)

    IFS=$'\n'
    for i in $(ls -1 /Library/Java/JavaVirtualMachines)
    do
        if [[ $(java_version_exists $i) -eq 0 ]]; then
            jenv add /Library/Java/JavaVirtualMachines/$i/Contents/Home
        else
            printf "$(java_version_parser $i) already exists. Skipping...\n"
        fi
    done

    if [[ $(jenv version-name) =~ "1.8" ]]; then
        printf "Java 8 already set. Skipping...\n"
    else
        printf "Setting your global java version to 8 \n"
        jenv global 1.8
    fi

else
    printf "\033[0;32m\$JAVA_HOME\033[0m:[$JAVA_HOME] is already set up. Skipping...\n"
fi

# -----------------------------------------------------------------

if [[ ! -f $HOME/.bash_profile ]]; then
  cp $HOME/.dotfiles/.bash_profile_template $HOME/.bash_profile
  printf "Copying bash profile template to home directory \n"
else
  printf "\033[0;32m\$HOME/.bash_profile\033[0m:[$HOME/.bash_profile] is already set up. Skipping...\n"
fi

if [[ ! -f $HOME/.git_profile ]]; then
  ln -s $HOME/.dotfiles/.git_profile $HOME
  printf "Symlinking git profile to home directory \n"
else
  printf "\033[0;32m\$HOME/.git_profile\033[0m:[$HOME/.git_profile] is already set up. Skipping...\n"
fi

if [[ ! -f $HOME/.gitconfig ]]; then
  cp $HOME/.dotfiles/.gitconfig_template $HOME/.gitconfig
  printf "Copying git config template to home directory \n"
else
  printf "\033[0;32m\$HOME/.gitconfig\033[0m:[$HOME/.gitconfig] is already set up. Skipping...\n"
fi

# -----------------------------------------------------------------

printf "\n\033[0;33mRestart bash session for \$JAVA_HOME to be set\033[0m\n"
printf "\033[0;33mThe following has been copied to your clipboard:\033[0m\n"
printf "\033[0;34m> source $HOME/.bash_profile\033[0m\n"
echo "source $HOME/.bash_profile" | pbcopy
