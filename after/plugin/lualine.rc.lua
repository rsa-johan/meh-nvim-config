local status, lualine = pcall(require, 'lualine')

if (not status)	then return end


lualine.setup {
  options = {
      icons_enabled = true,
      theme = 'solarized_dark',
      section_separators = { left = '', right = ''},
      component_separators = { left = '', right = ''},
      inactive_sections = {},
      lualine_x = {
      { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
        hint = ' ' } },
      'encoding',
      'filetype'
    }
  }
}
