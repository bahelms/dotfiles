# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

if [ -r $HOME/.custom_env_vars ];
then
  source $HOME/.custom_env_vars
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="af-magic"
ZSH_THEME="crunch"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler docker-compose asdf)

# User configuration

export GOPATH="$HOME/local/go"
export PATH="/usr/local/opt/llvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH:$HOME/.cargo/bin:/usr/local/go/bin:$GOPATH/bin"
export FZF_DEFAULT_COMMAND='rg --files'

# add psql to path
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

source $ZSH/oh-my-zsh.sh

preexec() { print "" } # runs before command is executed

# Aliases
alias drc="docker ps -aqf status=exited | xargs docker rm -v"
alias dri="docker images -qf dangling=true | xargs docker rmi"
alias dcp="docker-compose"
alias glg="glods"
alias nv="nvim"
alias lg="lazygit"
alias py="python3"

# Docker app shortcuts
alias dpy='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app python:3.6.3 python'
alias scl='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app flangelier/scala:latest scala'
alias drb='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:latest irb'
alias dex='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app elixir:latest iex'
alias neo='docker run --rm -p 7474:7474 -p 7687:7687 -v $HOME/neo4j/data:/data neo4j:latest'
alias dps='docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Status}}\t{{.CreatedAt}}"'

# ANTLR
alias antlr='java -jar /usr/local/lib/antlr-4.6-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

# Reindex Spotlight
alias reindex='sudo mdutil -E /'

# Find file with FZF and open in neovim
function fnv { 
  nv $(fzf -q $1) 
}

# Git
alias git-clean='git branch --merged | grep -Ev "(^\*|master|dev)" | xargs git branch -d && git remote prune origin'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/barretthelms/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/barretthelms/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/barretthelms/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/barretthelms/google-cloud-sdk/completion.zsh.inc'; fi

# Tmuxinator
export EDITOR="nvim"

# ctags
# alias ctags="`brew --prefix`/bin/ctags"
fpath+=${ZDOTDIR:-~}/.zsh_functions

# ruby openssl issues
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Elixir
# keep erl/iex history with 1mb
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"
# view Erlang docs in iex
export KERL_BUILD_DOCS="yes"
alias mt='mix test'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Github GPG
export GPG_TTY=$(tty)

# asdf-vm
# toAdd="$ASDF_DIR/shims:$ASDF_DIR/bin"
# toRemove="$toAdd:"
# export PATH=${PATH#$toRemove}:$toAdd

export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init zsh)"

# fly.io
# export FLYCTL_INSTALL="/home/jb/.fly"
# export PATH="$FLYCTL_INSTALL/bin:$PATH"

alias tt="$HOME/bin/time_tracker"
