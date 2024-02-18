local refs = require 'cmp-pandoc-references.references'
local M = {}

local opts = {
  filetypes = {'pandoc', 'markdown', 'rmd', 'quarto'},
  bib_path = nil
}

function M.setup(user_opts)
  opts = vim.tbl_extend('force', opts, user_opts or {})
end

function M.is_available()
  return vim.tbl_contains(opts.filetype, vim.bo.filetype)
end

function M.get_keyword_pattern()
	return '[@][^[:blank:]]*'
end

function M.complete(self, params, callback)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local entries = refs.get_entries(lines, opts.bib_path)

  callback(entries)
end

return M
