local keybindings = require("behaviour.keybindings")

local behaviour = {}

function behaviour.apply_to_config(config)
    config.default_prog = { "zsh" }
    config.automatically_reload_config = false

    require("behaviour.eventhandlers")
    keybindings.apply_to_config(config)
end

return behaviour
