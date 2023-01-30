local lsp_installer_servers = require "nvim-lsp-installer.servers"
local log = require('utils.log')

local M = {}

function M._lsp_installer_setup(servers, options)
    for server_name, _ in pairs(servers) do
        local server_available, server = lsp_installer_servers.get_server(server_name)

        if server_available then
            server:on_ready(function()
                local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})
                server:setup(opts)
            end)
            if not server:is_installed() then
                server:install()
            end
        else
            log.error(server)
        end
    end
end

function M._masan_setup(servers, user_config)
    for server_name, _ in pairs(servers) do
        pcall(function()
            local command = user_config.cmd
                or (function()
                    local default_config = require("lspconfig.server_configurations." .. server_name).default_config
                    return default_config.cmd
                end)()
            -- some servers have dynamic commands defined with on_new_config
            if type(command) == "table" and type(command[1]) == "string" and vim.fn.executable(command[1]) ~= 1 then
                log:debug(string.format("[%q] is either not installed, missing from PATH, or not executable.",
                    server_name))
                return
            end
            require("lspconfig")[server_name].setup(user_config)
            local bufnr = vim.api.nvim_get_current_buf()
            require("lspconfig")[server_name].manager.try_add_wrapper(bufnr)
        end)
    end
end

function M.setup(servers, config)
    M._lsp_installer_setup(servers, config)
    -- TODO: investigate how to use mason to config jdtls
    -- M._masan_setup(servers, config)
end

return M
