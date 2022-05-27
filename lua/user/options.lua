-- :help options
return {
  opt = {
    foldenable = false,
    foldexpr = "nvim_treesitter#foldexpr()",        -- set Treesitter based folding
    foldmethod = "expr",
    linebreak = true,                               -- linebreak soft wrap at words
    list = true,                                    -- show whitespace characters
    listchars = {
      tab = "│→",
      extends = "⟩",
      precedes = "⟨",
      trail = "·",
      nbsp = "␣"
    },
    shortmess = vim.opt.shortmess + { I = true },
    showbreak = "↪ ",
    -- spellfile = "~/.config/nvim/lua/user/spell/en.utf-8.add",
    -- thesaurus = "~/.config/nvim/lua/user/spell/mthesaur.txt",
    wrap = false,                                    -- soft wrap lines
    expandtab = true,                                -- convert tabs to spaces
    relativenumber = false,
  },
}
