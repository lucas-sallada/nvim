local null_ls = require("null-ls")

local opts = {
	sources = {
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.eslint,
	}
}

return opts
