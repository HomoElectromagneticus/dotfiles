## these are my zsh configurations
# enable ansi command-line colors
export CLICOLOR=1

# the variable LS_COLORS is needed by zsh in order to colorize the tab
# completion stuff correctly. zsh doesn't understand the MacOS / BSD way
# of doing terminal colors, so we must export the colors the way linux
# does. we can use gdircolors if we have coreutils installed
if ! command -v gdircolors &> /dev/null
then
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
else
    eval "$(gdircolors -b)"
fi

# during completion, display a list with selectable options, and also
# let the completion be case-insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
zstyle ':completion:*' menu select 
   
# during completion, hitting tab once will show the menu in most cases
# (notably if the case doesn't match)
setopt MENU_COMPLETE

# enable the completion system (should be done after completion settings
# are configured)
autoload -Uz compinit
compinit

# save 1000 lines of command history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# allow the zsh completions to use the same colors as ls. note that we
# have to use the LS_COLORS variable defined above instead of the
# default-to-MacOS "LSCOLORS"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# do stuff with the prompt. show the user, then the current directory
# (with an ellipsis if the path is too long), then finally a # if the
# user is privileged and a % otherwise. note that % is the default zsh
# prompt character
PROMPT="%n %(5~|%-1~/…/%3~|%4~)%(!.#.%%) "

# add zmv, which allows for nice file renaming etc with regex also set
# the extended glob flag so we can use nicer glob patterns
autoload -Uz zmv
setopt extended_glob

# alias "ls" to run "gls --color --group-directories-first" (note that 
# this assumes gls is available on mac via brew coreutils)
alias ls="gls --color --group-directories-first"

# alias "ll" to run "ls -alh"
alias ll="ls -lah"

# alias "grep" to run "grep --color"
alias grep="grep --color"

# bind "fn + delete" to forward-delete like it normally is on a mac
bindkey "^[[3~" delete-char

# bind the home and end keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# add /usr/local/sbin to $PATH
export PATH="/usr/local/sbin:$PATH"

# prevent homebrew from sending any analytics data
export HOMEBREW_NO_ANALYTICS=1

# set the default editor to vim
export EDITOR=/usr/local/bin/vim

# tell wezterm to find its config within the .config folder
export WEZTERM_CONFIG_FILE=$HOME/.config/wezterm/wezterm.lua

# allow bash-like <CTRL+x> and then <e> to open what's currently on the 
# command line into the editor specified by $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# allow fzf's keybindings
source /usr/local/Cellar/fzf/0.42.0/shell/key-bindings.zsh
# this mac uses a "us international" keyboard layout with dead keys (for accent
# marks etc), so pressing ALT+c produces the c with a tail: ç. I personally 
# write this character by typing an apostrophe and then typing c  (as in, using
# the dead keys), so we can just bind this character to the fzf ALT+c function:
# Note: this means that you cannot type ç in the terminal without calling the 
# fzf widget! In practice this doesn't really matter since CTRL + t is better.
# If you really want to call the cd widget, you can type ESC + c.
# bindkey '^[c' fzf-cd-widget

# allow "cd on quit" for lf
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
# alias lfcd to just lfc so we can type a bit less
alias lfc=lfcd
