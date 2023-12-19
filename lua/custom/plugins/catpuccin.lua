return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",    -- latte, frappe, macchiato, mocha
			transparent_background = true, -- disables setting the background color.
		})
	end,
	init = function()
		vim.cmd("colorscheme catppuccin")
	end,
}

