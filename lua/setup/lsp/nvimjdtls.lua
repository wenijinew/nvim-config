local M = {}
local log = require('utils.log')

function M.setup()
    log.info("setup jdtls by nvim-jdtls", "Ok")
    local data_path = vim.fn.stdpath("data")
    log.info(data_path, "Ok")
    local jdtls = require("plenary.path"):new { data_path, "lsp_servers", "jdtls", "bin", "jdtls" }:absolute()
    log.info(jdtls)
    local config = {
        cmd = jdtls,
        root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    }
    require('lspconfig.server_configurations.jdtls').setup(config)
end

return M
