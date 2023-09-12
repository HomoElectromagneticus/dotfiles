-- Pull in the wezterm API
local wezterm = require 'wezterm'

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

-- Cursor settings
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Enabling editing the config file quickly from CMD+, like many Mac programs
local act = wezterm.action

config.keys = {
  {
    key = ',',
    mods = 'CMD',
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
  -- other keys
}

-- and finally, return the configuration to wezterm
return config
