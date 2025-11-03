return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { go = { "golangcilint" } },
      linters = {
        golangcilint = {
          -- Use nvim-lint's maintained JSON parser and current golangci-lint flags.
          condition = function(ctx)
            return vim.fn.executable("golangci-lint") == 1
              and vim.fs.find({ ".golangci.yml", ".golangci.yaml", ".golangci.toml", ".golangci.json" },
                { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },
}
