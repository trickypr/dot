return {
  { "wakatime/vim-wakatime" },
  {
    "ObserverOfTime/nvimcord",
    config = function()
      require("nvimcord").setup({ autostart = true })
    end,
  },
}
