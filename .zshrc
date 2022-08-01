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
plugins=(git bundler docker-compose)

# User configuration

export GOPATH="/Users/barretthelms/languages/go"
export CLASSPATH=".:/usr/local/lib/antlr-4.6-complete.jar:$CLASSPATH"
export PATH="/usr/local/opt/llvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH:/Users/barretthelms/apache-storm-1.0.1/bin:/Users/barretthelms/apache-maven-3.3.9/bin:/Users/barretthelms/noaa_weather:/Users/barretthelms/.cargo/bin:/Users/barretthelms/languages/dart/flutter/bin:$GOPATH/bin"
export FZF_DEFAULT_COMMAND='rg --files'

source $ZSH/oh-my-zsh.sh
source $GOPATH/src/github.com/sachaos/todoist/todoist_functions.sh

preexec() { print "" } # runs before command is executed
# precmd() { print "" }  # runs before prompt is displayed

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# $(dinghy shellinit)
#
# Aliases
alias drc="docker ps -aqf status=exited | xargs docker rm -v"
alias dri="docker images -qf dangling=true | xargs docker rmi"
alias dcp="docker-compose"
alias glg="git lg"
alias nv="nvim"
alias lg="lazygit"
alias py="python3"

# added by travis gem
[ -f /Users/barretthelms/.travis/travis.sh ] && source /Users/barretthelms/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

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

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
# . /usr/local/opt/asdf/libexec/asdf.sh

# Todoist
alias tl='todoist --color --indent'

# SalesLoft
export NPM_TOKEN=oO/T6PS7rOAzoIqrc/AHw63/Te0aWhf4O+L3F+pi2OnZ4BxdWdEL3s9iZHo3khAv
source $HOME/.projectrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/barretthelms/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/barretthelms/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/barretthelms/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/barretthelms/google-cloud-sdk/completion.zsh.inc'; fi

# Tmuxinator
export EDITOR="nvim"
source ~/.bin/tmuxinator.zsh
alias sl_start='~/sl-start.sh'

# ctags
alias ctags="`brew --prefix`/bin/ctags"
source /Users/barretthelms/.projectrc
fpath+=${ZDOTDIR:-~}/.zsh_functions

# homebrew postgresql@12
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"

# ruby openssl issues
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Elixir
# keep erl/iex history with 1mb
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"
# view Erlang docs in iex
export KERL_BUILD_DOCS="yes"
alias mt='mix test'
