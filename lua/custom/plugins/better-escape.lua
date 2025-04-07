return {
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        timeout = 200,
        default_mappings = true,
        mappings = {
          i = {
            j = {
              k = '<Esc>',
            },
          },
        },
      }
    end,
  },
}
