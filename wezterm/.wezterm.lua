local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.default_domain = 'WSL:Ubuntu'
-- config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe' }
config.color_scheme = 'iceberg-dark'

-- font
config.font = wezterm.font_with_fallback {
  'Cascadia Code',
  'BIZ UDGothic',
}
config.font_size = 9

-- window
config.initial_rows = 35
config.initial_cols = 120
config.window_background_opacity = 0.9
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- config.window_decorations = 'RESIZE'

-- window title
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end
  return index .. 'WezTerm'
end)

-- tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = true
local act = wezterm.action
config.keys = {
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

return config

