#
# ~/.bash_profile
#

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.juliaup/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH
. "$HOME/.cargo/env"

# Bash configulation for Git
if [ -d /usr/share/git ]; then
  . /usr/share/git/completion/git-completion.bash
fi

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r ~/.opam/opam-init/init.sh && . ~/.opam/opam-init/init.sh >/dev/null 2>/dev/null || true
# END opam configuration

[[ -f ~/.bashrc ]] && . ~/.bashrc
