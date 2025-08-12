local M = {}

-- Your preferred themes
M.dark_theme = "catppuccin-mocha"
M.light_theme = "catppuccin-latte"

-- Detect macOS dark mode
function M.is_dark_mode()
  local handle = io.popen(
    "defaults read -g AppleInterfaceStyle 2>/dev/null"
  )
  local result = handle:read("*a")
  handle:close()
  return result:match("Dark") ~= nil
end

function M.apply_theme()
  -- Ensure truecolor is enabled
  vim.opt.termguicolors = true

  -- Clear highlights and reset syntax
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  -- Set background based on macOS mode
  if M.is_dark_mode() then
    vim.opt.background = "dark"
    vim.cmd.colorscheme(M.dark_theme)
  else
    vim.opt.background = "light"
    vim.cmd.colorscheme(M.light_theme)
  end
end

-- Start background watcher
function M.start_watcher()
  local cmd = [[
    osascript -e '
    on run
      tell application "System Events"
        repeat
          delay 1
          set darkMode to dark mode of appearance preferences
          if darkMode is true then
            do shell script "nvim --server /tmp/nvim.sock --remote-send \":lua require\\\"theme_auto_switch\\\".apply_theme()<CR>\""
          else
            do shell script "nvim --server /tmp/nvim.sock --remote-send \":lua require\\\"theme_auto_switch\\\".apply_theme()<CR>\""
          end if
        end repeat
      end tell
    end run
    '
  ]]
  vim.fn.jobstart(cmd, { detach = true })
end

-- Setup function
function M.setup(opts)
  if opts then
    M.dark_theme = opts.dark or M.dark_theme
    M.light_theme = opts.light or M.light_theme
  end

  -- Apply theme on startup
  M.apply_theme()

  -- Start watcher only on macOS
  if vim.loop.os_uname().sysname == "Darwin" then
    M.start_watcher()
  end
end

return M
