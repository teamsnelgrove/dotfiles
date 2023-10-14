local windows = {}

function windows.apply_to_config(config)
    -- config.window_decorations = "NONE"
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_bar_at_bottom = true

    config.window_padding = {
        left = 10,
        right = 10,
        top = 0,
        bottom = 0,
    }
    config.adjust_window_size_when_changing_font_size = false
end

return windows
