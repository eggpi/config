export CLICOLOR=1
export HISTSIZE=10000000
export EDITOR=vim
export PATH="$HOME/bin:/usr/local/bin:$PATH"

alias ?="echo $?"

function hgdl() {
    hg diff "$@" | less
}

function hgqdl() {
    hg qdiff "$@"| less
}

function hgll() {
    hg log "$@" | less
}

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

function mozconfig() {
    if [ $# -eq 0 ]; then
        echo "$MOZCONFIG"
    else
        file="$HOME/.mozconfigs/$1"
        if [ -f "$file" ]; then
            export MOZCONFIG="$file"
            echo "Set MOZCONFIG to $file"
        else
            echo "Can't find mozconfig at $file!"
        fi
    fi
}
