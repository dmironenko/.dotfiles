return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    opts = { ensure_installed = {
      "astro", "cmake", "cpp", "css", "fish", "gitignore", "go", "graphql",
      "http", "java", "php", "python", "rust", "scss", "sql", "svelte",
    } },
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
