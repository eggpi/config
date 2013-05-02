export CLICOLOR=1
export HISTSIZE=10000000
export EDITOR=vim
export PATH="$HOME/bin:/usr/local/bin:$PATH"

alias ?='echo $?'

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

function mozrebase() {
    if [ -n "$1" ]; then
        branches=$1
    else
        branches=$(git branch | sed 's/\*//; s/^ *//')
    fi

    git fetch mozilla-central
    oldbranch=$(git branch | sed -n 's/ *\*//p')

    for b in $branches; do
        echo "Rebasing $b"
        git rebase mozilla-central/master $b

        if [ $? != 0 ]; then
            git rebase --abort
            failed="$failed $b"
        fi
    done

    echo "Going back to start branch"
    git checkout $oldbranch

    if [ -n "$failed" ]; then
        echo "The following branches failed to be rebased:"
        for b in $failed; do
            echo $b
        done
    fi
}

export GOROOT=/usr/local/Cellar/go/1.0.3/
