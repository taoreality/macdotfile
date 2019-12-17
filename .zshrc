# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=/Users/takahito/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit

export TERM="xterm-256color"
#export PATH=~/pebble-dev/PebbleSDK-3.6.2/bin:$PATH
export PATH=$PATH:"/usr/bin"
export PATH=$PATH:"/usr/local/sbin"
#export PATH=$PATH:"/Users/takahito/depot_tools"
export PATH=$PATH:"/Users/takahito/node_modules"
export PATH=$PATH:"/usr/local/lib/node_modules"
export PATH=$PATH:"/usr/local/Cellar"
# PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="~/Library/Frameworks/Python.framework/Versions/3.7:$PATH"
#
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Set name of the theme to load.
source /usr/local/Cellar/powerlevel9k/0.6.7/powerlevel9k.zsh-theme





# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_MODE="nerdfont-complete"

prompt_zsh_showStatus () {
	local color='%F{white}'
  state=`osascript -e 'tell application "Spotify" to player state as string'`;
  if [ $state = "playing" ]; then
    artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
    track=`osascript -e 'tell application "Spotify" to name of current track as string'`;

      echo -n "%{$color%}  $artist - $track " ;

  fi
}

zsh_wifi_signal(){
     local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
     local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{yellow}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{yellow}'

                [[ $speed -gt 100 ]] && color='%F{green}'
                [[ $speed -lt 50 ]] && color='%F{red}'

                echo -n "%{$color%}$ssid $speed Mb/s%{%f%}"
        fi
}

prompt_zsh_battery_level() {
    local percentage=`pmset -g ps  |  sed -n 's/.*[[:blank:]]+*\(.*%\).*/\1/p'`
    local percentage=`echo "${percentage//\%}"`
    local color='%F{red}'
    local symbol="\uf00d"
if [ $(bc <<< "scale=2 ; $percentage<25") = '1' ]
    then symbol="\uf244" ; color='%F{red}' ;
        #Less than 25
        fi

if [ $(bc <<< "scale=2 ; $percentage>=25") = '1' ] && [ $(bc <<< "scale=2 ; $percentage<50") = '1' ]
    then symbol='\uf243' ; color='%F{red}' ;
    #25%
    fi
if [ $(bc <<< "scale=2 ; $percentage>=50") = '1' ] && [ $(bc <<< "scale=2 ; $percentage<75") = '1' ]
     then symbol="\uf242" ; color='%F{yellow}' ;
     #50%
     fi
if [ $(bc <<< "scale=2 ; $percentage>=75") = '1' ] && [ $(bc <<< "scale=2 ; $percentage<100") = '1' ]
        then symbol="\uf241" ; color='%F{blue}' ;
        #75%
        fi

if [ $(bc <<< "scale=2 ; $percentage>99") = '1' ]
        then symbol="\uf240" ; color='%F{green}' ;
        #100%
        fi
pmset -g ps | grep "discharging" >& /dev/null
if [ $? -eq 0 ]; then
    true;
else ;
   color='%F{green}' ;
fi
echo -n "%{$color%}$symbol" ;
}

#POWERLEVEL9K_CUSTOM_SPOTIFY="prompt_zsh_showStatus"
POWERLEVEL9K_CUSTOM_BATTERY_STATUS="prompt_zsh_battery_level"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ADD_NEWLINE=true
POWERLEVEL9K=truncate_beginning
POWERLEVEL9K_SHOW_CHANGESET=true
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=’red’
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B0"
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{white}╭─%F{white}'
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}╰%f '
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir ssh vcs newline host dir_writable root_indicator ip public_ip)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status load background_jobs custom_wifi_signal custom_battery_status time)
#
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "

# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi

#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  autojump
# emacs
# zsh-autosuggestions
  zsh-syntax-highlighting
  command-not-found
  common-aliases
  git
  history
  wd
  web-search
  thefuck
# tmux
  z
# fzy
  revolver
  htop
  incr
)



# User configuration





# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias mysql='/usr/local/opt/mysql/bin/mysql'
alias mysqladmin='/usr/local/opt/mysql/bin/mysqladmin'
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias vi="vim"
#alias vim="nvim"
alias tmux="tmux -2"
alias ssh="ssh -X"
alias df="df -h"
alias mv="mv -i"
alias slink="link -s"
alias lt="ls -lhtrF"
alias grep="grep --color=auto"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias zb="cat /dev/urandom | hexdump -C | grep --color=auto \"ca fe\""
alias mtr="/usr/local/bin/mtr"
alias pro="proxychains4"
alias gb="go build"

#CLI alias
# alias emacs="/usr/local/Cellar/emacs/26.2/Emacs.app/Contents/MacOS/Emacs -nw"
alias apm="apm-beta"
alias speed="speedtest-cli"
alias cat="pygmentize -g"
alias pipes="pipes.sh"
alias reddit="rtv"
#system alias
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
#weather
alias weather="ansiweather -l Hsinchu,TW -u metric -a true -w true -h true -p true -d true -s true"
alias forecast="ansiweather -l Hsinchu,TW -u metric -a true -f 5 -w true -s true"
#googler
alias g='googler -n 7 -c tw'
alias define='googler -n 4 define'
# SETOPT
# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol
setopt auto_menu

unset GEM_HOME
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Run Selecta in the current working directory, appending the selected path, if
# any, to the current command, followed by a space.
#function insert-selecta-path-in-command-line() {
 #   local selected_path
    # Print a newline or we'll clobber the old prompt.
  #  echo
    # Find the path; abort if the user doesn't select anything.
  #  selected_path=$(find * -type f | selecta) || return
    # Append the selection to the current command buffer.
  #  eval 'LBUFFER="$LBUFFER$selected_path "'
    # Redraw the prompt since Selecta has drawn several new lines of text.
  #  zle reset-prompt
#}
# Create the zle widget
# zle -N insert-selecta-path-in-command-line
# Bind the key to the newly created widget
# bindkey "^S" "insert-selecta-path-in-command-line"


# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


#function command_not_found_handle() {
#  /usr/bin/python /usr/lib/command-not-found -- $1
#}

# Load zsh-syntax-highlighting.
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Load zsh-autosuggestions.
#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Enable autosuggestions automatically.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
#source /usr/local/share/incr/incr0.2.zsh

#echo $PS1

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
eval $(shell_logger --configure)

####EVAL PART####

## weather forecast
eval ansiweather -l Hsinchu,TW -u metric -a true -w true -h true -p true -d false -s true
eval ansiweather -l Hsinchu,TW -u metric -a true -f 3 -w true -s true
## weather forecast

eval $(thefuck --alias)

###Zplugin

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# Plugin history-search-multi-word loaded with tracking.
zplugin load zdharma/history-search-multi-word

# regular plugins loaded without tracking.

zplugin light zdharma/fast-syntax-highlighting
# zplugin ice wait blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions
zplugin light momo-lab/zsh-abbrev-alias
# zplugin light nvbn/thefuck
zplugin light fcambus/ansiweather
zplugin light zpm-zsh/ls
zplugin light chrissicool/zsh-256color
zplugin light zpm-zsh/dircolors-material

# Load the pure theme, with zsh-async library that's bundled with it.
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin snippet OMZ::plugins/tmux/tmux.plugin.zsh
# zplugin snippet OMZ::plugins/z/z.plugin.zsh
zplugin load zsh-users/zsh-autosuggestions
zplugin load aperezdc/zsh-fzy
zplugin load denisidoro/navi

#zplugin ice from"gh"
#zplugin load bhilburn/powerlevel9k
zplugin ice depth=1; zplugin light romkatv/powerlevel10k
# autoload -U compinit
# compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
