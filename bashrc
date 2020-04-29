# .bashrc

setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

alias dockerkillall=`docker ps | awk '{print $1}' | sed '1d' | while read pid ; do docker kill $pid ; done`

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

alias workspace='cd $HOME/workspace'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
