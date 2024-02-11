return {

  -- add glsl
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        glsl_analyzer = {
          cmd = { "glsl_analyzer" },
          filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
          single_file_support = true,
          capabilities = {},
        },
      },
    },
  },
}
