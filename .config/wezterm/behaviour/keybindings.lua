local wezterm = require("wezterm")
local act = wezterm.action
local projects = require("menus.projects")

local keybindings = {}

function keybindings.apply_to_config(config)
    local projects_input_selector = projects.get_input_selector()
    config.disable_default_key_bindings = true
    config.leader = { key = "b", mods = "CTRL" }

    ---------------------------------------------------------------
    --- keybinds
    ---------------------------------------------------------------
    config.keys = {
        -- { key = "b", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x02" }) },
        { key = "t", mods = "CMD", action = act({ SpawnTab = "CurrentPaneDomain" }) },
        { key = "w", mods = "CMD", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
        -- { key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
        {
            key = "m",
            mods = "CTRL|ALT|CMD",
            action = wezterm.action.TogglePaneZoomState,
        },
        {
            key = "[",
            mods = "LEADER",
            action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.ActivateCopyMode, act.ClearSelection }),
        },
        {
            key = "p",
            mods = "LEADER",
            action = act.ActivateCommandPalette,
        },
        {
            key = "e",
            mods = "LEADER",
            action = act.InputSelector(projects_input_selector),
        },
        -- Reload config
        { key = "R", mods = "LEADER",       action = "ReloadConfiguration" },
        -- { key = "j", mods = "ALT|CTRL", action = act({ PasteFrom = "PrimarySelection" }) },
        -- Tab movement
        { key = "1", mods = "CMD",          action = act({ ActivateTab = 0 }) },
        { key = "2", mods = "CMD",          action = act({ ActivateTab = 1 }) },
        { key = "3", mods = "CMD",          action = act({ ActivateTab = 2 }) },
        { key = "4", mods = "CMD",          action = act({ ActivateTab = 3 }) },
        { key = "5", mods = "CMD",          action = act({ ActivateTab = 4 }) },
        { key = "6", mods = "CMD",          action = act({ ActivateTab = 5 }) },
        { key = "7", mods = "CMD",          action = act({ ActivateTab = 6 }) },
        { key = "8", mods = "CMD",          action = act({ ActivateTab = 7 }) },
        { key = "9", mods = "CMD",          action = act({ ActivateTab = 8 }) },
        -- Pane splitting
        { key = "o", mods = "CTRL|ALT|CMD", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
        {
            key = "i",
            mods = "CTRL|ALT|CMD",
            action = act({
                SplitHorizontal = { domain = "CurrentPaneDomain" } })
        },
        -- Pane movement
        { key = "h",          mods = "CTRL|ALT|CMD", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
        { key = "j",          mods = "CTRL|ALT|CMD", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
        { key = "k",          mods = "CTRL|ALT|CMD", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
        { key = "l",          mods = "CTRL|ALT|CMD", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
        -- Pane resizing
        -- TODO: not working at the moment
        { key = "LeftArrow",  mods = "CTRL|ALT|CMD", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
        { key = "DownArrow",  mods = "CTRL|ALT|CMD", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
        { key = "UpArrow",    mods = "CTRL|ALT|CMD", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
        { key = "RightArrow", mods = "CTRL|ALT|CMD", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
        -- Text navigation
        { key = "Enter",      mods = "ALT",          action = act.QuickSelect },
        { key = "/",          mods = "ALT",          action = act.Search("CurrentSelectionOrEmptyString") },
        { key = "c",          mods = "CMD",          action = act({ CopyTo = "Clipboard" }) },
        { key = "v",          mods = "CMD",          action = act({ PasteFrom = "Clipboard" }) },
        -- Font resizing
        { key = "=",          mods = "CMD|SHIFT",    action = "ResetFontSize" },
        { key = "+",          mods = "CMD",          action = "IncreaseFontSize" },
        { key = "-",          mods = "CMD",          action = "DecreaseFontSize" },
        -- Scrollback
        { key = "u",          mods = "CTRL|SHIFT",   action = act({ ScrollByPage = -1 }) },
        { key = "d",          mods = "CTRL|SHIFT",   action = act({ ScrollByPage = 1 }) },
        { key = "y",          mods = "CTRL|ALT|CMD", action = act({ EmitEvent = "trigger-nvim-with-scrollback" }) },
        { key = "w",          mods = "LEADER",       action = wezterm.action.ShowLauncher },
        { key = "g",          mods = "LEADER",       action = wezterm.action.ShowTabNavigator },
        {
            key = "r",
            mods = "LEADER",
            action = act({
                ActivateKeyTable = {
                    name = "resize_pane",
                    one_shot = false,
                    timeout_milliseconds = 3000,
                    replace_current = false,
                },
            }),
        },
        { key = "s", mods = "LEADER", action = act.PaneSelect({ alphabet = "1234567890" }) },
        { key = "d", mods = "LEADER", action = wezterm.action.ShowDebugOverlay },
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
    }

    config.key_tables = {
        resize_pane = {
            { key = "LeftArrow",  action = act({ AdjustPaneSize = { "Left", 1 } }) },
            { key = "h",          action = act({ AdjustPaneSize = { "Left", 1 } }) },
            { key = "RightArrow", action = act({ AdjustPaneSize = { "Right", 1 } }) },
            { key = "l",          action = act({ AdjustPaneSize = { "Right", 1 } }) },
            { key = "UpArrow",    action = act({ AdjustPaneSize = { "Up", 1 } }) },
            { key = "k",          action = act({ AdjustPaneSize = { "Up", 1 } }) },
            { key = "DownArrow",  action = act({ AdjustPaneSize = { "Down", 1 } }) },
            { key = "j",          action = act({ AdjustPaneSize = { "Down", 1 } }) },
            -- Cancel the mode by pressing escape
            { key = "Escape",     action = "PopKeyTable" },
        },
        copy_mode = {
            {
                key = "Escape",
                mods = "NONE",
                action = act.Multiple({
                    act.ClearSelection,
                    act.CopyMode("ClearPattern"),
                    act.CopyMode("Close"),
                }),
            },
            { key = "q",          mods = "NONE",  action = act.CopyMode("Close") },
            -- move cursor
            { key = "h",          mods = "NONE",  action = act.CopyMode("MoveLeft") },
            { key = "LeftArrow",  mods = "NONE",  action = act.CopyMode("MoveLeft") },
            { key = "j",          mods = "NONE",  action = act.CopyMode("MoveDown") },
            { key = "DownArrow",  mods = "NONE",  action = act.CopyMode("MoveDown") },
            { key = "k",          mods = "NONE",  action = act.CopyMode("MoveUp") },
            { key = "UpArrow",    mods = "NONE",  action = act.CopyMode("MoveUp") },
            { key = "l",          mods = "NONE",  action = act.CopyMode("MoveRight") },
            { key = "RightArrow", mods = "NONE",  action = act.CopyMode("MoveRight") },
            -- move word
            { key = "RightArrow", mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
            { key = "f",          mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
            { key = "\t",         mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
            { key = "w",          mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
            { key = "LeftArrow",  mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
            { key = "b",          mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
            { key = "\t",         mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
            { key = "b",          mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },
            {
                key = "e",
                mods = "NONE",
                action = act({
                    Multiple = {
                        act.CopyMode("MoveRight"),
                        act.CopyMode("MoveForwardWord"),
                        act.CopyMode("MoveLeft"),
                    },
                }),
            },
            -- move start/end
            { key = "0",  mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
            { key = "\n", mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },
            { key = "$",  mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
            { key = "$",  mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
            { key = "e",  mods = "CTRL",  action = act.CopyMode("MoveToEndOfLineContent") },
            { key = "m",  mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },
            { key = "^",  mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
            { key = "^",  mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
            { key = "a",  mods = "CTRL",  action = act.CopyMode("MoveToStartOfLineContent") },
            -- select
            { key = " ",  mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
            { key = "v",  mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
            {
                key = "v",
                mods = "SHIFT",
                action = act({
                    Multiple = {
                        act.CopyMode("MoveToStartOfLineContent"),
                        act.CopyMode({ SetSelectionMode = "Cell" }),
                        act.CopyMode("MoveToEndOfLineContent"),
                    },
                }),
            },
            -- copy
            {
                key = "y",
                mods = "NONE",
                action = act({
                    Multiple = {
                        act({ CopyTo = "ClipboardAndPrimarySelection" }),
                        act.CopyMode("Close"),
                    },
                }),
            },
            {
                key = "y",
                mods = "SHIFT",
                action = act({
                    Multiple = {
                        act.CopyMode({ SetSelectionMode = "Cell" }),
                        act.CopyMode("MoveToEndOfLineContent"),
                        act({ CopyTo = "ClipboardAndPrimarySelection" }),
                        act.CopyMode("Close"),
                    },
                }),
            },
            -- scroll
            { key = "G",        mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
            { key = "G",        mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
            { key = "g",        mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
            { key = "H",        mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
            { key = "H",        mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
            { key = "M",        mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
            { key = "M",        mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
            { key = "L",        mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
            { key = "L",        mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
            { key = "o",        mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
            { key = "O",        mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
            { key = "O",        mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
            { key = "PageUp",   mods = "NONE",  action = act.CopyMode("PageUp") },
            { key = "PageDown", mods = "NONE",  action = act.CopyMode("PageDown") },
            { key = "b",        mods = "CTRL",  action = act.CopyMode("PageUp") },
            { key = "f",        mods = "CTRL",  action = act.CopyMode("PageDown") },
            {
                key = "Enter",
                mods = "NONE",
                action = act.CopyMode("ClearSelectionMode"),
            },
            -- search
            { key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
            {
                key = "n",
                mods = "NONE",
                action = act.Multiple({
                    act.CopyMode("NextMatch"),
                    act.CopyMode("ClearSelectionMode"),
                }),
            },
            {
                key = "N",
                mods = "SHIFT",
                action = act.Multiple({
                    act.CopyMode("PriorMatch"),
                    act.CopyMode("ClearSelectionMode"),
                }),
            },
        },
        search_mode = {
            { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
            {
                key = "Enter",
                mods = "NONE",
                action = act.Multiple({
                    act.CopyMode("ClearSelectionMode"),
                    act.ActivateCopyMode,
                }),
            },
            { key = "p",      mods = "CTRL", action = act.CopyMode("PriorMatch") },
            { key = "n",      mods = "CTRL", action = act.CopyMode("NextMatch") },
            { key = "r",      mods = "CTRL", action = act.CopyMode("CycleMatchType") },
            { key = "/",      mods = "NONE", action = act.CopyMode("ClearPattern") },
            { key = "u",      mods = "CTRL", action = act.CopyMode("ClearPattern") },
        },
    }
end

return keybindings
