-- Pull in the wezterm API
local wezterm = require 'wezterm'
local menus = require("menus")
local behaviour = require("behaviour")
local ui = require("ui")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end


-- Custom Config
ui.apply_to_config(config)
behaviour.apply_to_config(config)
menus.apply_to_config(config)

return config
