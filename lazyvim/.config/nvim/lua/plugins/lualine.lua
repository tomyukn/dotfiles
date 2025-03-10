return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.section_separators = ""
      opts.options.component_separators = { left = "|", right = "" }
      opts.options.globalstatus = true
      opts.options.colored = true
      --table.insert(opts.sections.lualine_x, 1, "fileformat")
      --table.insert(opts.sections.lualine_x, 1, "encoding")
      opts.sections.lualine_y = { "fileformat", "encoding" }
      opts.sections.lualine_z = { "progress", "location" }
    end,
  },
}
