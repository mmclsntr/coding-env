set -o ignoreeof

alias relogin='exec $SHELL -l'
alias ll='ls -alG'

# asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# go
if [ -x "$(command -v go)" ]; then
    export PATH="$(go env GOPATH)/bin:$PATH"
fi
