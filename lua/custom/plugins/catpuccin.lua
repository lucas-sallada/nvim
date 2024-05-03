return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",    -- latte, frappe, macchiato, mocha
			transparent_background = true,
			show_end_of_buffer = false
		})
	end,
	init = function()
		vim.cmd("colorscheme catppuccin")
	end,
}

