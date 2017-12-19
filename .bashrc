export CLICOLOR=1
export EDITOR=vim
export PATH="$HOME/bin:$HOME/.cabal/bin:/usr/local/bin:$PATH"

alias ?='echo $?'

function ask() {
    echo -n "$1 [Y/n] "
    read answer && [ -z "$answer" -o "$answer" == "y" ]
}

for bash_completion_file in $(brew --prefix)/etc/bash_completion.d/*.bash; do
    . $bash_completion_file
done

set -o vi

# clear screen with C-l on insert mode
bind -m vi-insert "\C-l":clear-screen

export GOPATH=$HOME/code/goworkdir

shopt -s histappend # append to history rather than overwriting
export HISTSIZE=10000000
export PROMPT_COMMAND='history -a' # save history on each prompt

function is_inside() {
    if [ $1 == / ]; then
        return 0
    fi
    (while [ $PWD != / ]; do
        if [ $PWD == $1 -o $PWD/ == $1 ]; then
            return 0
        fi
        cd ..
    done
    return 1) && return 0 || return 1
}

if [ -n "$VIRTUAL_ENV" -a -n "$TMUX_PANE" ]; then
    . "$VIRTUAL_ENV"/bin/activate
fi
