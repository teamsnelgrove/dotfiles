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

-- config.window_decorations = "NONE"
-- Tab styling
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

config.keys = {
    -- Allows for quick swithing between tabs
    {
        key = 't',
        mods = 'CMD|SHIFT',
        action = act.ShowTabNavigator,
    },
    -- Fn to rename tabs
    {
        key = 'R',
        mods = 'CMD|SHIFT',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, _, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
    {
        key = 'w',
        mods = 'CMD',
        action = act.CloseCurrentPane { confirm = true },
    },
    {
        key = 'i',
        mods = 'CTRL|ALT|CMD',
        action = act.SplitHorizontal {
            domain =  'CurrentPaneDomain' ,
        },
    },
    {
        key = 'o',
        mods = 'CTRL|ALT|CMD',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'p',
        mods = 'CTRL|ALT|CMD',
        action = act.RotatePanes 'CounterClockwise',
    },
    {
        key = 'n',
        mods = 'CTRL|ALT|CMD',
        action = act.RotatePanes 'Clockwise'
    },
    {
        key = 'h',
        mods = 'CTRL|ALT|CMD',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'CTRL|ALT|CMD',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'k',
        mods = 'CTRL|ALT|CMD',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'CTRL|ALT|CMD',
        action = act.ActivatePaneDirection 'Down',
    },
    -- Quickly open the wezterm config file
    {
        key = ',',
        mods = 'CMD',
        action = act.SpawnCommandInNewTab {
            cwd = os.getenv('WEZTERM_CONFIG_DIR'),
            args = {
                '/usr/local/bin/nvim',
                os.getenv('WEZTERM_CONFIG_FILE'),
            },
        },
    },
}

-- and finally, return the configuration to wezterm
return config
