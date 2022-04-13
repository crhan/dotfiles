# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
PS1='\n\[\e[01;37m\][`a=$?;if [ $a -ne 0 ]; then echo -n -e "\[\e[01;32;41m\]{$a}"; fi`\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;35m\]\h\[\033[00m\] \[\033[01;34m\]`pwd``B=$(git branch 2>/dev/null | sed -e "/^ /d" -e "s/* \(.*\)/\1/"); if [ "$B" != "" ]; then S="git"; elif [ -e .bzr ]; then S=bzr; elif [ -e .hg ]; then S="hg";B="$(hg branch)"; elif [ -e .svn ]; then S="svn"; else S=""; fi; if [ "$S" != "" ]; then if [ "$B" != "" ]; then M=$S:$B; else M=$S; fi; fi; [[ "$M" != "" ]] && echo -n -e "\[\e[33;40m\]($M)\[\033[01;32m\]\[\e[00m\]"`\[\033[01;34m\]\[\e[01;37m\]]\n\[\e[01;34m\]$ \[\e[00m\]'

pathmunge () {
  case ":${PATH}:" in
    *:"$1":*)
      ;;
    *)
      if [ "$2" = "after" ] ; then
        PATH=$PATH:$1
      else
        PATH=$1:$PATH
      fi
  esac
}


# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=200000
HISTFILESIZE=400000
export HISTTIMEFORMAT="%F %T: "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac


pathmunge /usr/local/sbin
pathmunge /usr/local/bin

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

gitlab_config() {
  git config user.email "ruohan.chen@antgroup.com"
  git config user.name "墨泪"
}





today() {
  local _today=$(date +%Y%m%d)
  local today_dir=$HOME/tmp/$_today
  [[ -d $today_dir ]] || mkdir -p $today_dir
  cd $today_dir
}

yesterday() {
  local _today=$(date +%Y%m%d -d yesterday)
  local today_dir=$HOME/tmp/$_today
  [[ -d $today_dir ]] || mkdir -p $today_dir
  cd $today_dir
}

alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"

show_virtual_env() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

export PS1='$(show_virtual_env)'$PS1


pathmunge $HOME/bin


export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh
pathmunge $HOME/.local/bin
pathmunge ~/.kusion/bin/

export HASS_SERVER=http://ha.crhan.com:8123/
export HASS_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI5M2NjNWFhYWY0MDA0NDBmODZiMTVhZTI5ODZhYjdkOSIsImlhdCI6MTU3NTA4MjQ1MSwiZXhwIjoxODkwNDQyNDUxfQ.lCYO87aTZrjkOp7YzZMsMykWCwrQKI1uC3I6MgHbugg
