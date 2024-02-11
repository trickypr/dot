-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function filetype(pattern, ft)
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = pattern,
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(buf, "filetype", ft)
    end,
  })
end

filetype("*.vert", "glsl")
filetype("*.tesc", "glsl")
filetype("*.frag", "glsl")
filetype("*.geom", "glsl")
filetype("*.comp", "glsl")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.htmx",
  callback = function()
    if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(buf, "filetype", "gotmpl")
      vim.api.nvim_buf_set_option(buf, "filetype", "htmx")
      vim.api.nvim_buf_set_option(buf, "filetype", "html")
    end
  end,
})
