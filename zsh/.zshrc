# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# fzf
source <(fzf --zsh)
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"
export FZF_CTRL_T_COMMAND="rg --files --hidden --no-ignore --follow --no-messages --glob '!.git/*'"
export FZF_CTRL_T_OPTS="--preview 'batcat --number --color=never {} | head -50' --preview-window=down:50%"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window=down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="fdfind --type d --hidden"
export FZF_ALT_C_OPTS="--preview 'tree -aC {} | head -50'"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias fd='fdfind --hidden --no-ignore'
alias bat='batcat'

# zplug - manage plugins
source /usr/share/zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "themes/bira", from:oh-my-zsh, as:theme   # Theme

# zplug - install/load new plugins when zsh is started or reloaded
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

# Path
export PATH=$HOME/tools/bin:$HOME/.local/bin:$PATH
