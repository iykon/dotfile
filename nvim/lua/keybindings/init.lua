vim.g.mapleader = ' '
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
local map = vim.api.nvim_set_keymap
local function current_function_node()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]
  local ok, parser = pcall(vim.treesitter.get_parser, 0)

  if not ok then
    return nil
  end

  local tree = parser:parse()[1]
  if not tree then
    return nil
  end

  local node = tree:root():descendant_for_range(row, col, row, col)
  local function_nodes = {
    arrow_function = true,
    function_declaration = true,
    function_definition = true,
    function_expression = true,
    function_item = true,
    function_statement = true,
    lambda = true,
    method_declaration = true,
    method_definition = true,
  }

  while node do
    if function_nodes[node:type()] then
      return node
    end
    node = node:parent()
  end
end

local function goto_current_function(edge)
  local node = current_function_node()

  if not node then
    vim.cmd('normal! ' .. (edge == 'start' and '[[' or ']]'))
    return
  end

  local start_row, start_col, end_row, end_col = node:range()

  if edge == 'start' then
    vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
    return
  end

  if end_col == 0 and end_row > start_row then
    end_row = end_row - 1
    end_col = #vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1]
  else
    end_col = math.max(end_col - 1, 0)
  end

  vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
end

map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})
vim.keymap.set('n', '[[', function()
  goto_current_function('start')
end, {noremap = true, silent = true, desc = 'Go to start of current function'})
vim.keymap.set('n', ']]', function()
  goto_current_function('end')
end, {noremap = true, silent = true, desc = 'Go to end of current function'})
vim.keymap.set('n', 'gs', function()
  require('telescope.builtin').grep_string({
    search = vim.fn.expand('<cword>'),
  })
end, {noremap = true, silent = true, desc = 'Search symbol under cursor'})

map('i', 'jk', '<ESC>', {noremap = true, silent = false})
map('n', '<space>e', ':NvimTreeToggle<CR>', {noremap = true, silent = false})

map('n', '<space>h', ':nohlsearch<CR>', {noremap = true, silent = false})

-- Delete with x without replacing the yank/clipboard register.
map('n', 'x', '"_x', {noremap = true, silent = false})
map('n', 'X', '"_X', {noremap = true, silent = false})
map('v', 'x', '"_x', {noremap = true, silent = false})
map('v', 'X', '"_X', {noremap = true, silent = false})
map('n', 's', '"_s', {noremap = true, silent = false})
map('n', 'S', '"_S', {noremap = true, silent = false})
map('v', 's', '"_s', {noremap = true, silent = false})
map('v', 'S', '"_S', {noremap = true, silent = false})

--move cursor
map('i', '<C-b>', '<Left>', {noremap = true, silent = false})
map('i', '<C-f>', '<Right>', {noremap = true, silent = false})
map('i', '<C-d>', '<Delete>', {noremap = true, silent = false})

--nvimtree
map('n', '+', ':NvimTreeResize +1<CR>', {noremap = true, silent = false})
map('n', '_', ':NvimTreeResize -1<CR>', {noremap = true, silent = false})
