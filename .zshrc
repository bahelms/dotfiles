# Path to your oh-my-zsh installation.
export ZSH=/Users/jimbonk/.oh-my-zsh

if [ -r $HOME/.custom_env_vars ];
then
  source $HOME/.custom_env_vars
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler rails docker-compose)

# User configuration

# export PATH="$PATH:/Users/barretthelms/.rvm/gems/ruby-2.2.1/bin:/Users/barretthelms/.rvm/gems/ruby-2.2.1@global/bin:/Users/barretthelms/.rvm/rubies/ruby-2.2.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/barretthelms/.rvm/bin:/Users/barretthelms/.rvm/bin"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH:/Users/jimbonk/apache-storm-1.0.1/bin:/Users/jimbonk/apache-maven-3.3.9/bin:/Users/jimbonk/noaa_weather:/Users/jimbonk/.cargo/bin:/Users/jimbonk/languages/dart/flutter/bin"

export CLASSPATH=".:/usr/local/lib/antlr-4.6-complete.jar:$CLASSPATH"

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# $(dinghy shellinit)
#
# Aliases
alias ls.="ls -alhG"
alias drc="docker ps -aqf status=exited | xargs docker rm -v"
alias dri="docker images -qf dangling=true | xargs docker rmi"
alias dcp="docker-compose"
alias glg="git lg"

# added by travis gem
[ -f /Users/barretthelms/.travis/travis.sh ] && source /Users/barretthelms/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Docker app shortcuts
alias dpy='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app python:3.6.3 python'
alias scl='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app flangelier/scala:latest scala'
alias drb='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:latest irb'
alias dex='docker run -it --rm -v $(pwd):/usr/src/app -w /usr/src/app elixir:1.6.0 iex'
alias neo='docker run --rm -p 7474:7474 -p 7687:7687 -v $HOME/neo4j/data:/data neo4j:latest'
alias dps='docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Status}}\t{{.CreatedAt}}"'

# ANTLR
alias antlr='java -jar /usr/local/lib/antlr-4.6-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

# Chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Reindex Spotlight
alias reindex='sudo mdutil -E /'
