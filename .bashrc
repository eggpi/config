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
