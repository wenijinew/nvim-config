local M = {}

local opt = {
    use_diagnostic_sign = true
}

M.setup = function()
    require("trouble").setup(opt)
end

return M
