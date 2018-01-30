# ~/.bashrc: executed by bash(1) for non-login shells.

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
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# Alias definitions.
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

stty -ixon # disable Software Flow Control, (XON/XOFF)



# Recursive sed
function sedr() {
  local file="$1"
  local sed_expr="$2"

  if [ -z "$file" -o -z "$sed_expr" ]; then
    echo "sedr: usage: sedr 'file' 'sed_expr'"
    return 1
  fi

  find . -type f -name "$file" -exec sed -i '' "$sed_expr" {} +
  return $?
}
export -f sedr

# Replace
function ctrlr() {
  local a="$1"

  sedr '*.scala' "s/${a}/${a}V1/g"
}
export -f ctrlr

# Tex
export TEXMFHOME="${HOME}/texmf"
if [ ! -d ${TEXMFHOME} ]; then
  mkdir -p "${HOME}/texmf/tex/latex"
  mkdir -p "${HOME}/texmf/fonts/vf/public"
  mkdir -p "${HOME}/texmf/fonts/type1/public"
  mkdir -p "${HOME}/texmf/fonts/tfm/public"
  mkdir -p "${HOME}/texmf/fonts/enc/public"
  mkdir -p "${HOME}/texmf/fonts/map/dvips/public"
fi

# Java, Scala, and SBT
export M2_HOME=/usr/local/opt/maven/libexec
export M2=$M2_HOME/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home
export PATH=$M2:$PATH
export SBT_OPTS="-Xmx2G"

# import OS level bashrc
if [ "$(uname)" == 'Linux' ] && [ -f ~/.bashrc_linux ]; then
  . ~/.bashrc_linux
else
  . ~/.bashrc_darwin
fi
