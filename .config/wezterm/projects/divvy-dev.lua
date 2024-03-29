local M = {}

function M.startup(wezterm, workspace_name)
    local mux = wezterm.mux
    local project_dir = wezterm.home_dir .. "/code/divvy-dev"

    -- divvy-dev (Nvim pane)
    local first_tab, first_pane, proj_window = mux.spawn_window({
        workspace = workspace_name,
        cwd = project_dir,
    })

    first_tab:set_title("divvy-dev")
    first_pane:send_text("nvim\r")

    -- Terminal tab
    local second_tab, second_pane, _ = proj_window:spawn_tab({})

    second_tab:set_title("procs")

    mux.set_active_workspace(workspace_name)
end

return M
