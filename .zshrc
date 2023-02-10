## these are my zsh configurations
# enable ansi command-line colors
export CLICOLOR=1

# this variable is needed by zsh. in order to colorize the tab
# completion stuff correctly. zsh doesn't understand the MacOS /
# BSD way of doing terminal colors, so we must export the colors
# the way linux does
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# during completion, display a list with selectable options, and
# also let the completion be case-insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
zstyle ':completion:*' menu select 
   
# during completion, hitting tab once will show the menu in most
# cases (notably if the case doesn't match)
setopt MENU_COMPLETE

# enable the completion system (should be done after completion
# settings are configured)
autoload -Uz compinit
compinit

# save 1000 lines of command history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# allow the zsh completions to use the same colors as ls.
# note that we have to use the LS_COLORS variable defined
# above instead of the default-to-MacOS "LSCOLORS"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# do stuff with the prompt. show the user, then the current
# directory (with an ellipsis if the path is too long), then
# finally a # if the user is privileged and a % otherwise.
# note that % is the default zsh prompt character
PROMPT="%n %(5~|%-1~/…/%3~|%4~)%(!.#.%%) "

# add zmv, which allows for nice file renaming etc with regex
# also set the extended glob flag so we can use nicer glob
# patterns
autoload -Uz zmv
setopt extended_glob
 
# alias "ll" to run "ls -alh"
alias ll="ls -lah"

# alias "grep" to run "grep --color"
alias grep="grep --color"

# bind "fn + delete" to forward-delete like it normally is on a mac
bindkey "^[[3~" delete-char

# bind the home and end keys
bindkey '\e[H'  beginning-of-line
bindkey '\e[F'  end-of-line

# for the mac "move by words" thing with the option key
bindkey '\e[1;3D' backward-word         # option left 
bindkey '\e[1;3C' forward-word          # option right
# and the end / beginning of line thing with command
bindkey '^[[1;9D' beginning-of-line     # cmd left 
bindkey '^[[1;9C' end-of-line           # cmd right

# add /usr/local/sbin to $PATH
export PATH="/usr/local/sbin:$PATH"
