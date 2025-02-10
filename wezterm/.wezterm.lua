local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.default_domain = 'WSL:ArchLinux'
-- config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe' }
config.color_scheme = 'iceberg-dark'

-- fonts
config.font = wezterm.font_with_fallback {
  'Cascadia Code',
  'BIZ UDGothic',
}
config.font_size = 9

-- window
config.initial_rows = 35
config.initial_cols = 120
config.window_background_opacity = 0.9
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- window title
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end
  return index .. activate_pane.title
end)

-- tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50

-- show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

-- pane related keymap functions
local function move_pane(key, direction)
  return {
    key = key,
    action = act.ActivatePaneDirection(direction),
  }
end

local function resize_pane(key, direction)
  return {
    key = key,
    action = act.AdjustPaneSize { direction, 1 },
  }
end

-- keys
config.leader = { key = 'q', mods = 'ALT', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'q',
    mods = 'LEADER|ALT',
    action = act.SendKey { key = 'q', mods = 'ALT' },
  },

  -- set tab name
  {
    key = 'e',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  -- search mode
  {
    key = 's',
    mods = 'LEADER',
    action = act.Search { CaseSensitiveString = '' },
  },

  -- quick select mode
  {
    key = 'Space',
    mods = 'LEADER',
    action = act.QuickSelect,
  },

  -- copy mode
  {
    key = 'c',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
  },

  -- activate pane
  {
    key = 'a',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'activate_pane',
      one_shot = false,
      timeout_milliseconds = 1000,
    },
  },

  -- resizing panes
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_panes',
      one_shot = false,
    },
  },
}

config.key_tables = {
  activate_pane = {
    move_pane('j', 'Down'),
    move_pane('k', 'Up'),
    move_pane('h', 'Left'),
    move_pane('l', 'Right'),
  },
  resize_panes = {
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('h', 'Left'),
    resize_pane('l', 'Right'),
    -- cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

return config

