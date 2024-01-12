function setcolors(color) 
    vim.cmd("colorscheme base16-onedark")
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd("hi normal guibg=NONE")
end

setcolors()
