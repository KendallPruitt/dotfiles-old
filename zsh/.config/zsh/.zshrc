# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/
export TERM="xterm-256color"

# if [[ $TERM == xterm-termite ]]; then
#   . /etc/profile.d/vte.sh
#   __vte_osc7
# fi

if [ "$TERM" = "linux" ]; then
  _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
  for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
    echo -en "$i"
  done
  clear
fi

# # dirstack
#
# DIRSTACKFILE="$HOME/.cache/zsh/dirs"
# if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
#   dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#   [[ -d $dirstack[1] ]] && cd $dirstack[1]
# fi
# chpwd() {
#   print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
# }
#
# DIRSTACKSIZE=20
#
# setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
#
# ## Remove duplicate entries
# setopt PUSHD_IGNORE_DUPS
#
# ## This reverts the +/- operators.
# setopt PUSHD_MINUS



# DISABLE_UPDATE_PROMPT=true

# set cursor color
echo -ne "\033]12;#0080ff\007"

# Set name of the theme to load.
# Look in ~/.config/oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$XDG_CONFIG_HOME/oh-my-zsh/custom/

# Which plugins would you like to load? (plugins can be found in ~/.config/oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.config/oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"


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
# Example aliases
# alias zshconfig="mate ~/.config/zsh/.zshrc"
# alias ohmyzsh="mate ~/.config/oh-my-zsh"

export DEFAULT_USER="kendall"

eval "$(thefuck --alias)"
eval "$(thefuck --alias shit)"

autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svn
autoload -Uz run-help-svk
unalias run-help
alias help=run-help
autoload -Uz compinit
compinit

# alias sup="su -c zsh"

zstyle ':completion:*' rehash true

ZSH_CACHE_DIR=$XDG_CACHE_HOME/oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source /usr/share/doc/pkgfile/command-not-found.zsh

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

timer_show=0
function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    unset timer
  fi
}

# custom_status() {
#   if [[ "$RETVAL" -ne 0 ]]; then
#     echo -n "$1_prompt_segment" "$0_ERROR" "$2" "001" "016" "$RETVAL" 'FAIL_ICON'
#   fi
#   # else
#   #   "$1_prompt_segment" "$0" "$2" "000" "007" '%h'
#   # fi
# }
#
# POWERLEVEL9K_CUSTOM_STATUS="custom_status"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(my_root_icon rbenv vcs background_jobs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(dir my_time my_status)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_MY_STATUS_OK_BACKGROUND='004'
POWERLEVEL9K_MY_STATUS_OK_FOREGROUND='015'
POWERLEVEL9K_MY_STATUS_ERROR_BACKGROUND='001'
POWERLEVEL9K_MY_STATUS_ERROR_FOREGROUND='015'
POWERLEVEL9K_MY_TIME_BACKGROUND='000'
POWERLEVEL9K_MY_TIME_FOREGROUND='010'
POWERLEVEL9K_MY_ROOT_ICON_DEFAULT_BACKGROUND='004'
POWERLEVEL9K_MY_ROOT_ICON_DEFAULT_FOREGROUND='015'
POWERLEVEL9K_MY_ROOT_ICON_ROOT_BACKGROUND='001'
POWERLEVEL9K_MY_ROOT_ICON_ROOT_FOREGROUND='015'
POWERLEVEL9K_MY_ROOT_ICON_FORBIDDEN_BACKGROUND='005'
POWERLEVEL9K_MY_ROOT_ICON_FORBIDDEN_FOREGROUND='015'
POWERLEVEL9K_DIR_HOME_BACKGROUND='004'
POWERLEVEL9K_DIR_HOME_FOREGROUND='015'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='004'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='015'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='004'
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='015'
# POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND='000'
# POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='009'
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND='001'
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND='015'
# POWERLEVEL9K_OS_ICON_BACKGROUND='012'
# POWERLEVEL9K_OS_ICON_FOREGROUND='016'
# POWERLEVEL9K_TIME_BACKGROUND='012'
# POWERLEVEL9K_TIME_FOREGROUND='016'
# POWERLEVEL9K_HISTORY_BACKGROUND='000'
# POWERLEVEL9K_HISTORY_FOREGROUND='007'
POWERLEVEL9K_VCS_BACKGROUND='002'
POWERLEVEL9K_VCS_FOREGROUND='015'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='003'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='015'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='002'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='015'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='006'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='015'

alias l="LC_COLLATE=C ls -lAh --group-directories-first"
alias sup="sudo -E -s"
alias calc="bc -lq"
