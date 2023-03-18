M = {}

local opt = {
    symbols = {
        Class = { icon = "", hl = "@type" },
        Constructor = { icon = "", hl = "@constructor" },
        Constant = { icon = "", hl = "@constant" },
        Enum = { icon = "", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
    }
}
M.setup = function()
    require("symbols-outline").setup(opt)
end

return M
