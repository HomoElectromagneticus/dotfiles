# Profile file, runs on login. Environmental variables are set here.

# needed to make homebrew happy
eval "$(/opt/homebrew/bin/brew shellenv)"

# add the user binary file directory to the path
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# needed for microchip's IDE to work
export PATH="$PATH:"/Applications/microchip/xc8/v2.32/bin""

# add /usr/local/sbin to $PATH
export PATH="/usr/local/sbin:$PATH"

# for software that respects XDG, we can ask that config files be put in the
# .config directory instead of home
export XDG_CONFIG_HOME="$HOME/.config"

# zsh config should be found in .config
export ZDOTDIR="$HOME/.config/zsh"

# zsh compilation caches can go in .cache
ZSH_COMPDUMP="$HOME/.cache/zsh/zcompcache"

# prevent homebrew from sending any analytics data
export HOMEBREW_NO_ANALYTICS=1

# set the default editor to vim
export EDITOR=/opt/homebrew/bin/vim
export VISUAL="$EDITOR"

# tell wezterm to find its config within the .config folder
export WEZTERM_CONFIG_FILE=$HOME/.config/wezterm/wezterm.lua

# tell notmuch to find its config file within the .config folder
export NOTMUCH_CONFIG=$HOME/.config/notmuch/notmuch-config

# tell less to store its history in .cache
export LESSHISTFILE=$HOME/.cache/less/lesshst
