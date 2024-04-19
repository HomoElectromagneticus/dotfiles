# Profile file, runs on login. Environmental variables are set here.

if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# needed for microchip's IDE to work
export PATH="$PATH:"/Applications/microchip/xc8/v2.32/bin""

# add /usr/local/sbin to $PATH
export PATH="/usr/local/sbin:$PATH"

# zsh config should be found in .config
export ZDOTDIR="$HOME/.config/zsh"

# prevent homebrew from sending any analytics data
export HOMEBREW_NO_ANALYTICS=1

# set the default editor to vim
export EDITOR=/usr/local/bin/vim
export VISUAL="$EDITOR"

# tell wezterm to find its config within the .config folder
export WEZTERM_CONFIG_FILE=$HOME/.config/wezterm/wezterm.lua
