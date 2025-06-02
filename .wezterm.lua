local wezterm = require 'wezterm'
-- local act = wezterm.action

return {
  -- color_scheme = "deep",
  color_scheme = "Elementary",
  colors = {
    cursor_bg = '#d9d9d9',
    cursor_fg = 'black',
    cursor_border = 'white',
    -- background = 'rgba(0% 0% 0% 90%)'
  },
  -- window_background_image = '/Users/barretthelms/Documents/term-wallpaper.jpg',
  -- window_background_image_hsb = {
  --   brightness = 0.03,
  --   -- hue = 0.5,
  --   -- saturation = 0.5,
  -- },
  -- inactive_pane_hsb = {
  --   saturation = 0.9,
  --   brightness = 0.2,
  -- },
  font = wezterm.font {
    -- family = 'JetBrains Mono',
    family = 'Hack',
    weight = 'Medium',
    harfbuzz_features = { 'liga=0', 'clig=0', 'calt=0' } -- disable ligatures
  },
  font_size = 16.0,
  line_height = 0.95, -- JetBrains Mono
  -- line_height = 1.0, -- JetBrains Mono
}
