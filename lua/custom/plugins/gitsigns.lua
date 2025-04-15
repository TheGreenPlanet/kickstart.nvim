return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local gitsigns = require 'gitsigns'

      gitsigns.setup {
        on_attach = function(bufnr)
          local function map(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
          end

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage Hunk')
          map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset Hunk')
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end)
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end)
          map('n', '<leader>hS', gitsigns.stage_buffer, 'Stage Buffer')
          map('n', '<leader>hR', gitsigns.reset_buffer, 'Reset Buffer')

          -- Commit current hunk with prompt
          map('n', '<leader>hc', function()
            gitsigns.stage_hunk()
            vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
              if msg and msg ~= '' then
                vim.fn.system { 'git', 'commit', '-m', msg }
                print('Committed hunk: ' .. msg)
              else
                print 'Aborted: no message entered'
              end
            end)
          end, 'Stage and commit hunk')

          -- Preview / diff / blame
          map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview Hunk')
          map('n', '<leader>hi', gitsigns.preview_hunk_inline)
          map('n', '<leader>hb', function()
            gitsigns.blame_line { full = true }
          end)
          map('n', '<leader>hd', gitsigns.diffthis)
          map('n', '<leader>hD', function()
            gitsigns.diffthis '~'
          end)

          -- Quickfix
          map('n', '<leader>hQ', function()
            gitsigns.setqflist 'all'
          end)
          map('n', '<leader>hq', gitsigns.setqflist)

          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>td', gitsigns.toggle_deleted)
          map('n', '<leader>tw', gitsigns.toggle_word_diff)

          -- Text object
          map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        end,
      }
    end,
  },
}
