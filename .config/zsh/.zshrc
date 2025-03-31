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
# use a "rolling" history
setopt APPEND_HISTORY
# history is shared across sessions
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

# bind "fn + delete" to forward-delete like it normally is on a mac
bindkey "^[[3~" delete-char

# binding some keys to zle shortcuts (zle is like readline, but for zsh)
bindkey -e                          #"emacs" keybindings for zle, the vi ones
                                    #are confusing
bindkey "\e[1;3D" backward-word     # ⌥+←
bindkey "\e[1;3C" forward-word      # ⌥+→
bindkey "^[[1;9D" beginning-of-line # cmd+← (kind of like "home"
bindkey "^[[1;9C" end-of-line       # cmd+→ (kind of like "end")

# allow <CTRL+x> then <e> to open what's currently on the command line into the
# editor specified by $VISUAL. this is very similar to the "standard" bash
# keybinding
autoload edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# allow fzf's keybindings, but disable ALT+C since it kind of screws up the
# international keyboard layout thing that I use
export FZF_ALT_C_COMMAND='source <(fzf --zsh)'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
source <(fzf --zsh)

# allow "cd on quit" for lf
LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

# load aliases file if it exists
[ -f "$HOME/.config/aliasesrc" ] && source "$HOME/.config/aliasesrc"

# load syntax highlighting in the zsh shell (should be the last thing in the 
# file)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
