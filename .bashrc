export CLICOLOR=1
export HISTSIZE=10000000
export EDITOR=vim
export PATH="$HOME/bin:/usr/local/bin:$PATH"

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

export MOZTREE=$HOME/code/mozilla-central.git
export MOZBUILDTREE=$HOME/code/mozilla-build.git

function mozconfig() {
    if [ $# -eq 0 ]; then
        echo "$MOZCONFIG"
    else
        file="$HOME/.mozconfigs/$1"
        if [ -f "$file" ]; then
            export MOZCONFIG="$file"
            export CCACHE_DIR="$HOME/.ccache/$1"
            ccache -M 4G
            echo "Set MOZCONFIG to $file"
        else
            echo "Can't find mozconfig at $file!"
        fi
    fi
}

export GOROOT=/usr/local/Cellar/go/1.1/
export GOPATH=$HOME/code/goworkdir
