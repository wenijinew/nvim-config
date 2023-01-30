local M = {}

function M.setup()
    require('colorizer').setup({
        filetypes = { "lua" },
    })
end

return M
