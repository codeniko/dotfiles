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
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias ls='ls --color=always'
mancrush='192.168.11.100'
halfcourt='192.168.11.101'
alias mount-mancrush='sudo mount $halfcourt:/home/niko/shared /mnt'
alias mount-homebase='sudo mount $halfcourt:/home/homebase /mnt'
alias umount-mnt='sudo umount /mnt'

alias vim='vim -O'
alias vimp='vim -p'
alias ifconfig='/sbin/ifconfig'
alias tmux='tmux -2'
alias vimupdate='vim +BundleInstall +qall'
alias valgrind='valgrind --leak-check=full --show-reachable=yes'
#alias mousefix='modprobe -r hid_logitech_dj && modprobe hid_logitech_dj'


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

# Tex
export TEXMFHOME="${HOME}/texmf"
alias updateTexHome="mktexlsr; updmap-sys; mktexlsr; texhash ${TEXMFHOME}"
if [ ! -d ${TEXMFHOME} ]; then
	mkdir -p "${HOME}/texmf/tex/latex"
	mkdir -p "${HOME}/texmf/fonts/vf/public"
	mkdir -p "${HOME}/texmf/fonts/type1/public"
	mkdir -p "${HOME}/texmf/fonts/tfm/public"
	mkdir -p "${HOME}/texmf/fonts/enc/public"
	mkdir -p "${HOME}/texmf/fonts/map/dvips/public"
fi

# remove beeps
# setterm -blength 0
set bell-style none

stty -ixon # disable Software Flow Control, (XON/XOFF)

# alias emu="/Users/nikolay/Library/Android/sdk/tools/emulator -avd Nexus_6_API_16_4_1 -gpu on -no-boot-anim -scale 0.26"
# alias emu43="/Users/nikolay/Library/Android/sdk/tools/emulator -avd Nexus_6_API_18_FB_4_3 -gpu on -no-boot-anim -scale 0.26"
# alias emu442="/Users/nikolay/Library/Android/sdk/tools/emulator -avd Nexus_6_API_19_4_4_2 -gpu on -no-boot-anim -scale 0.26"

export M2_HOME=/usr/local/opt/maven/libexec
export M2=$M2_HOME/bin
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home
export PATH=$M2:$PATH
export WAXEYE_HOME=/Users/nikolay/src/waxeye
export SBT_OPTS="-Xmx2G"

alias rebase='git rebase -i HEAD~2'
alias rebase3='git rebase -i HEAD~3'
alias submodulepull='git submodule update --remote --merge'

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

# Linux only
if [ "$(uname)" == 'Linux' ]; then
  alias pbcopy='xclip -selection c'
  alias chrome='/opt/google/chrome/chrome'
  alias sbt-clean='sbt clean clean-files; find . -regextype posix-awk -regex "\.(/project)*/target" -exec rm -r {} +'
else
  alias sbt-clean='sbt clean clean-files; find -E . -regex "\.(/project)*/target" -exec rm -r {} +'
fi

alias sbt-clean-dep='rm -rf ~/.sbt ~/.ivy2'
