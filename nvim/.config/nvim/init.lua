vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.keymap.set('n','<M-z>',':set wrap!<Cr>')
vim.opt.linebreak = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
-- vim.opt.winborder = ""

vim.opt.statuscolumn = "%l   "
vim.opt.colorcolumn = "105"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.scrolloff = 12
vim.opt.ignorecase = true

vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.inccommand = "split"
vim.opt.foldmethod = "manual"
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

vim.o.completeopt = "menu,preview,fuzzy,menuone,noselect"
vim.opt.pumblend = 20
vim.opt.pumheight = 10
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/.vim/undodir"
vim.opt.termguicolors = true
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.formatoptions:remove "o"
vim.g.markdown_recommended_style = 0
-- vim.opt.more = false


vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/craftzdog/solarized-osaka.nvim" },
  -- { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/numToStr/Comment.nvim" },
  {
    src = "https://github.com/saghen/blink.cmp",
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/mbbill/undotree" },
  -- { src = "https://github.com/OXY2DEV/markview.nvim" },
})

require("nvim-autopairs").setup()
require("blink.cmp").setup()
require("Comment").setup()
require("oil").setup()
require("mason").setup()
require("mason-lspconfig").setup()
-- require("undotree").setup() -- it can directly be used as it is written in vimscript not in luascript so(gives error)
-- require "nvim-treesitter".setup({ highlight = { enable = true } })
-- define function
local function enable_my_lsps()
  vim.lsp.enable({ "lua_ls", "jdtls", "tsserver", "render-markdown","bash-langauge-server" })
  print("LSPs enabled for this buffer")
end
vim.keymap.set("n", "<leader>lsp", enable_my_lsps, { desc = "Enable LSPs" })
vim.keymap.set("n", "<localleader>lsp","<Cmd>LspStop<Cr>" , { desc = "Disable LSPs" })

vim.diagnostic.config({
  -- virtual_lines = true,
  virtual_text = true,
  signs = true,
})


--   capabilities = capabilities
-- })

local term_win = nil
local term_buf = nil

function ToggleTerm()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    -- Hide window
    vim.api.nvim_win_hide(term_win)
    term_win = nil
  else
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      -- Reopen existing buffer in a new window
      vim.cmd("botright split")
      vim.api.nvim_win_set_height(0, 10)
      vim.api.nvim_win_set_buf(0, term_buf)
      term_win = vim.api.nvim_get_current_win()
    else
      -- Create new terminal buffer
      vim.cmd("botright 10split | term")
      term_win = vim.api.nvim_get_current_win()
      term_buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd("startinsert")
  end
end

-- KEYMAPS FOR NEOVIM
local map = vim.keymap.set
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map({ "n", "v", "x" }, "<localleader><localleader>", '"+')
map("n", "<leader>lf", vim.lsp.buf.format)
map("i", "<C-c>", "<Esc>")
map("t", "<C-[>", "<C-\\><C-n>")
vim.keymap.set("n", "<localleader>cn",
function ()
 vim.cmd((vim.fn.expand("%:p") == vim.fn.expand("~/.config/nvim/init.lua"))
    and "edit #"
    or "edit ~/.config/nvim/init.lua")
end)
map({ "n", "t", "i" }, "<localleader>t", ToggleTerm, { noremap = true, silent = true })
map("n", "<localleader>d", ":lua vim.diagnostic.setqflist()<CR>:q<CR>")
map({ "i" }, "jk", "<C-[>l")
map("n","<leader>uu", vim.cmd.UndotreeToggle)
vim.keymap.set("", "<F11>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "<F12>", "<Nop>", { noremap = true, silent = true })

vim.cmd([[ hi @function.builtin guifg = yellow ]])
vim.cmd("colorscheme solarized-osaka")
vim.cmd(":hi statusline guibg=#111101") -- cmd used for vimscript/Ex commands
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#abb2bf" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5c6370", fg = "#e5c07b" })
-- vim.g.fzf_binary = "sk"  -- tell fzf-lua to use skim instead of fzf
--
-- require("fzf-lua").setup({
--   fzf_bin = "sk",   -- use skim
-- })

-- plugin focused keymaps
map({ "n", "v", "x" }, "-", "<Cmd>Oil<CR>")
map({ "n" }, "<leader>ff", "<Cmd>FzfLua builtin<CR>")
map({ "n" }, "<leader>fe", "<Cmd>lua require('fzf-lua').files({cwd = vim.fn.expand('%:h')})<CR>")
map(
  "n",
  "<leader>fp",
  ':<C-u>lua require("fzf-lua").git_files({cwd = vim.fn.systemlist("git -C " .. vim.fn.fnameescape(vim.fn.expand("%:h")) .. " rev-parse --show-toplevel 2>/dev/null")[1]})<CR><CR>',
  { desc = "FzfLua local git files search" }
)
map("n","<leader>fc","<Cmd>lua require('fzf-lua').files({cwd = '~/Dotfiles/'})<CR>")
map({ "n" }, "<leader>fo", "<Cmd>FzfLua oldfiles<CR>")
map({ "n" }, "<leader>fg", "<Cmd>FzfLua blines<CR>")
map("n","<leader>x","<cmd>!chmod +x %<Cr> ")
map({ "n" }, "<leader>fG", "<Cmd>FzfLua grep_project<CR>")

vim.cmd [[packadd journex]]

vim.keymap.set("n", "<localleader>jt", function()
  require("journex").openToday()
end)

vim.keymap.set("n", "<localleader>jn", function()
  require("journex").openNext()
end)

vim.keymap.set("n", "<localleader>jp", function()
  require("journex").openPrev()
end)

map({ "n" }, "<leader>f:", "<Cmd>FzfLua command_history<CR>")

-- THE END [[[[[[[[[[[[[[[[[[[ [ NVIM ADVANCED CONFIG ] ]]]]]]]]]]]]]]]]]]
vim.api.nvim_create_user_command("Biome", function()
  local filepath = vim.fn.expand("%:p")
  vim.fn.jobstart({ "biome", "format", "--write", filepath }, { -- note it also save the file
    --vim.fn.jobstart runs asynchronously so we used on_exit means after exiting by biome
    on_exit = function()
      vim.cmd("edit!") -- reload file after formatting
    end,
  })
end, {})
map("n", "<leader>Lf", "<cmd>Biome<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd('TextChangedI', {
--   pattern = '*', -- works in all buffers
--   callback = function()
--     if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
--       return
--     end
--     vim.api.nvim_feedkeys(vim.keycode('<C-x><C-o>'), 'm', false)
--   end
-- })
-- vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost" }, {
--   pattern = "*",
--   command = "mkview"
-- })
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   pattern = "*",
--   command = "loadview"
-- })

local group = vim.api.nvim_create_augroup("autosave_view", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype == "" then
      vim.cmd("silent! mkview")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  pattern = "*",
  callback = function(args)
    local bt = vim.bo[args.buf].buftype
    if bt == "" then -- only normal files
      pcall(function() vim.cmd("loadview") end)
    end
  end
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = group,
--   pattern = "*",
--   command = [[%s/\s\+$//e]],
-- })

map("n", "<leader>ls", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("split | terminal live-server " .. file)
end, { desc = "Live-server current file" })
