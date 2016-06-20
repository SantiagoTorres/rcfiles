# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
force_color_prompt=yes

PROMPT_DIRTRIM=2
case "$TERM" in
xterm*|rxvt*)
    PS1="$(if [[ ${EUID} == 0 ]];
            then
               echo '\[\033[00;31m\]\h';
            else
               echo '\[\033[01;36m\]\u';
            fi)\[\033[00;37m\] at\[\033[00;33m\] \w \$(
            if [ \${?} -eq 0 ];
            then
               echo '\[\033[00;33m\]✔\[\033[00;34m\]';
            else
               echo '\[\033[00;31m\]✗\[\033[00;34m\]';
            fi)\[\033[00;37m\] "
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
source ~/Documents/personal/configuration/.bashrc_constants
source ~/Documents/personal/configuration/.bashrc_functions

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

echo "welcome to LykOS"
echo " Checking our tasks..."
#are_tasks_overdue
when ci
#show_pp_schedule

# is the internet on fire status reports from a random cow
COW=`ls -1 /usr/share/cows/ | sort -R | head -1`
host -t txt istheinternetonfire.com | cut -f 2 -d '"' | cowsay -f $COW | lolcat

export PATH=~/bin:$PATH

eval "$(thefuck --alias)"
eval $(dircolors ~/.dircolors)
source /usr/bin/virtualenvwrapper.sh

# prettay matlab functions
alias matlab='MATLABPATH=${PWD} /usr/local/MATLAB/R2012b/bin/matlab -nosplash -nodesktop -r "cd ${PWD}"'

# listening to wqxr without the bloat
alias wqxr="rtmpdump --quiet --live -r "rtmp://wnyc-wowza.streamguys.com:80/wqxr" --playpath classical | mpv -"

# trying out nvim
alias vim=nvim

