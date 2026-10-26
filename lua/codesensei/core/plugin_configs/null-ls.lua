local null_ls = require("null-ls")

-- Diagnostics only. Conform owns manual formatting and format-on-save.
return {
    sources = {
        null_ls.builtins.diagnostics.mypy,
        -- Ruff diagnostics are handled by the ruff LSP server.
    },
}
