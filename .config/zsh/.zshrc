# export LANG so that certain command-line programs respect your preferred
# language
export LANG=fr_fr.UTF-8

# the variable LS_COLORS is needed by zsh in order to colorize the tab
# completion stuff correctly. zsh doesn't understand the MacOS / BSD way of 
# doing terminal colors, so we must export the colors the way linux does. we 
# can use gdircolors if we have coreutils installed
if ! command -v gdircolors &> /dev/null
then
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
else
    eval "$(gdircolors -b)"
fi

## Autocompletion settings
autoload -U compinit
zstyle ':completion:*' menu select
# allow case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# allow the zsh completions to use the same colors as ls. note that we have to
# use LS_COLORS defined above instead of the default-to-MacOS LSCOLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
setopt MENU_COMPLETE

# save 1000s of lines of command history
HISTFILE=~/.cache/zsh/history
HISTSIZE=8000
SAVEHIST=6000
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# do stuff with the prompt. show the user, then the current directory (with an 
# ellipsis if the path is too long), then finally a # if the user is privileged
# and a % otherwise. note that % is the default zsh prompt character
PROMPT="%n %(5~|%-1~/…/%3~|%4~)%(!.#.%%) "

# show the date and time on the right of the prompt
RPROMPT="[%D{%F}|%D{%H:%M}]"
# do a cute trick to keep the time shown in the prompt up-to-date (will only 
# update when the window is focused)
TMOUT=30
TRAPALRM() {
    zle reset-prompt
}

# add zmv, which allows for nice file renaming etc with regex also set the 
# extended glob flag so we can use nicer glob patterns
autoload -Uz zmv
setopt extended_glob

# bind "fn + delete" to forward-delete like it normally is on a mac
bindkey "^[[3~" delete-char

# binding some keys to zle shortcuts (zle is like readline, but for zsh)
bindkey -e                          #"emacs" keybindings for zle, the vi ones
                                    #are confusing
bindkey '^[[1;3C' forward-word      #alt + right arrow
bindkey '^[[1;3D' backward-word     #alt + left arrow
bindkey '^[[F' end-of-line          #end key 
bindkey '^[[H' beginning-of-line    #home key 

# allow <CTRL+x> then <e> to open what's currently on the command line into the
# editor specified by $VISUAL. this is very similar to the "standard" bash
# keybinding
autoload edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# allow fzf's keybindings, but disable ALT+C since it kind of screws up the
# international keyboard layout thing that I use
FZF_ALT_C_COMMAND= eval "$(fzf --zsh)"

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

# load aliases file if it exists
[ -f "$HOME/.config/aliasesrc" ] && source "$HOME/.config/aliasesrc"

# load syntax highlighting in the zsh shell (should be the last thing in the 
# file)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
