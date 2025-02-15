-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Set the terminal to wezterm (this requires a terminfo file
term = "wezterm"

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

-- set opacity
config.window_background_opacity = 0.97
config.text_background_opacity = 1

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

-- Do not ask for confirmation when closing WezTerm
config.window_close_confirmation = 'NeverPrompt'

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
  -- Disable the default binding to hide the application with CMD + h
  -- this is annoying, I accidentally hit this too often
  {
    key = 'h', mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
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
    key = 't', mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 't', mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'T', mods = 'CMD|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Use MacOS command + left to send the "home" key
  {
    key = 'LeftArrow', mods = 'CMD',
    action = wezterm.action.SendKey { key = 'Home'},
  },
  -- Use MacOS command + right to send the "end" key
  {
    key = 'RightArrow', mods = 'CMD',
    action = wezterm.action.SendKey { key = 'End'},
  }
}
-- and finally, return the configuration to wezterm
return config
