# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

. "$HOME/.cargo/env"

# Finding in Files
alias search=~/.search.sh

# VimUnity
alias uvi=~/.unity.sh

# Disable ScreenPad
# xrandr --output HDMI-1-1 --off

# Git
alias dot='/usr/bin/git --git-dir=$HOME/Documents/dotfiles/ --work-tree=$HOME'

# Python Virtual Environments
alias create='python3 -m venv venv'
alias activate='source venv/bin/activate'


# Flutter 220
export PATH="$PATH:~/Downloads/flutter220/bin"
export PATH="$PATH:~/Downloads/flutter220/bin/cache/dart-sdk/bin"
alias flutter220="~/Downloads/flutter220/bin/flutter"
alias flutter223="~/Downloads/flutter223/bin/flutter"

# React-Native
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias metro="npx react-native start"
alias nun="npx react-native run-android"

# Flutter
export PATH="$PATH:~/Android/Sdk/emulator"
export PATH="$PATH:~/Downloads/flutter/bin"
export PATH="$PATH:~/Downloads/flutter/bin/cache/dart-sdk/bin"
alias flutter="~/Downloads/flutter/bin/flutter"
alias pix3a="emulator -avd Pixel_3a_API_30_x86 &> /dev/null &"
alias pix2="emulator -avd Pixel_2_API_32 &> /dev/null &"
alias fr='flutter run --no-sound-null-safety'
alias studio='~/.local/share/flatpak/app/com.google.AndroidStudio/x86_64/stable/2a92149277f511ea41de599d99b7b01dbc03ae05daca395262cd25069e958699/files/extra/android-studio/bin/studio.sh'

alias ..='cd ..'
alias vim='vim -p'
alias cl='clear'
alias up='sudo apt -y update && sudo apt -y upgrade'
alias ar='sudo apt autoremove -y'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias purge='sudo apt purge'
alias vim_up=./.vim_up.sh
export UNITYPROJECTPATH="/home/agrimv/Documents/Unity"

echo && echo && echo
cat ~/.notes
echo && echo && echo

alias vs='cd ~/Documents/Flutter/vestudy'
alias vsp='cd ~/Documents/Flutter/vestudy && git pull'
export AWS_PAss="=P&fxE7#H!AnBec"
alias awsconf='amplify configure --appId d3tjez39k1u8ck --envName dev'

alias vw='cd ~/Documents/Web/VeStudyweb'
alias vwp='cd ~/Documents/Web/VeStudyweb && git pull'

alias mp='cd ~/Documents/IoT/covid-monitoring-system'
alias mpp='cd ~/Documents/IoT/covid-monitoring-system && git pull'
alias nmon='npm run nodemon'

alias sw='cd ~/Documents/Flutter/sw_customer_flutter_app'
alias sv='cd ~/Documents/Flutter/sw-vendor-app'

alias note='vim ~/.notes'

alias mqtt='sudo service mosquitto start'
alias mqt='sudo service mosquitto stop'
