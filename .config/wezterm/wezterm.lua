-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- Set color scheme
config.color_scheme = 'Solarized (light) (terminal.sexy)'

-- Font settings
config.font = wezterm.font 'Berkeley Mono'
config.font_size = 16.0

-- Window settings
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}

-- Honor kitty keyboard protocol: https://sw.kovidgoyal.net/kitty/keyboard-protocol/
config.enable_kitty_keyboard = true

-- Cursor settings
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Keyboard shortcuts
-- this is needed to make wezterm happy with my US-International layout
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
-- other key settings 
config.keys = {
-- Enabling editing the config file quickly from CMD+, like many Mac programs
  {
    key = ',', mods = 'CMD',
    action = act.SpawnCommandInNewTab {
      cwd = os.getenv('WEZTERM_CONFIG_DIR'),
      set_environment_variables = {
        TERM = 'screen-256color',
      },
      args = {
        '/usr/local/bin/vim',
        os.getenv('WEZTERM_CONFIG_FILE'),
      },
    },
  },
  -- assigning some readline movement commands to the "standard" MacOS shotcuts
  -- for details, see http://www.math.utah.edu/docs/info/features_7.html#SEC45
  -- and https://wezfurlong.org/wezterm/config/lua/keyassignment/SendKey.html
  -- and https://apple.stackexchange.com/questions/12997/can-home-and-end-keys-be-mapped-when-using-terminal
  -- go to beginning of line
  { 
    key = 'LeftArrow', mods = 'CMD', 
    action = act.SendKey { key = 'a', mods = 'CTRL'}
  },
  -- go to end of line
  { 
    key = 'RightArrow', mods = 'CMD', 
    action = act.SendKey { key = 'e', mods = 'CTRL'}
  }, 
  -- go to beginning of previous word
  { 
    key = 'LeftArrow', mods = 'ALT', 
    action = act.SendKey { key = 'b', mods = 'ALT'}
  },
  -- go to beginning of next word
  { 
    key = 'RightArrow', mods = 'ALT', 
    action = act.SendKey { key = 'f', mods = 'ALT'}
  }, 
  -- undo the last thing you did (besides filling the line with a previous 
  -- command...)
  { 
    key = 'z', mods = 'CMD', 
    action = act.SendKey { key = '_', mods = 'CTRL'}
  }, 
  -- Turn off the default CMD-t "make new tab" actions, because i do not like
  -- tabs
  {
    key = 't',mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 't',mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'T',mods = 'CMD|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- and finally, return the configuration to wezterm
return config
