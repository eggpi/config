export CLICOLOR=1
export HISTSIZE=10000000

function hgdl() {
    hg diff "$@" | less
}

function hgqdl() {
    hg qdiff "$@"| less
}

function hgll() {
    hg log "$@" | less
}

for bash_completion_file in $(brew --prefix)/etc/bash_completion.d/*.bash; do
    . $bash_completion_file
done
