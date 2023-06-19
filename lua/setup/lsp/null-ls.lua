local M = {}

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

function M.common_capabilities()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status_ok then
        return cmp_nvim_lsp.default_capabilities()
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    }

    return capabilities
end

function M.setup_document_highlight(client, bufnr)
    local status_ok, highlight_supported = pcall(function()
        return client.supports_method "textDocument/documentHighlight"
    end)
    if not status_ok or not highlight_supported then
        return
    end
    local group = "lsp_document_highlight"
    local hl_events = { "CursorHold", "CursorHoldI" }

    local ok, hl_autocmds = pcall(vim.api.nvim_get_autocmds, {
        group = group,
        buffer = bufnr,
        event = hl_events,
    })
    if ok and #hl_autocmds > 0 then
        return
    end
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(hl_events, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

function M.setup_codelens_refresh(client, bufnr)
    local status_ok, codelens_supported = pcall(function()
        return client.supports_method "textDocument/codeLens"
    end)
    if not status_ok or not codelens_supported then
        return
    end
    local group = "lsp_code_lens_refresh"
    local cl_events = { "BufEnter", "InsertLeave" }
    local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
        group = group,
        buffer = bufnr,
        event = cl_events,
    })
    if ok and #cl_autocmds > 0 then
        return
    end
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(cl_events, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
    })
end

function M.setup_document_symbols(client, bufnr)
    vim.g.navic_silence = false -- can be set to true to suppress error
    local symbols_supported = client.supports_method "textDocument/documentSymbol"
    if not symbols_supported then
        return
    end
    local status_ok, navic = pcall(require, "nvim-navic")
    if status_ok then
        navic.attach(client, bufnr)
    end
end

M.configuration = {
    buffer_mappings = {
        normal_mode = {
            ["H"] = { vim.lsp.buf.hover, "Show hover" },
            ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
            ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
            ["gr"] = { vim.lsp.buf.references, "Goto references" },
            ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
            ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
        },
        insert_mode = {},
        visual_mode = {},
    },
    buffer_options = {
        --- enable completion triggered by <c-x><c-o>
        omnifunc = "v:lua.vim.lsp.omnifunc",
        --- use gq for formatting
        formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:499})",
    },
}

function M.add_lsp_buffer_keybindings(bufnr)
    local mappings = {
        normal_mode = "n",
        insert_mode = "i",
        visual_mode = "v",
    }

    for mode_name, mode_char in pairs(mappings) do
        for key, remap in pairs(M.configuration.buffer_mappings[mode_name]) do
            local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
            vim.keymap.set(mode_char, key, remap[1], opts)
        end
    end
end

function M.add_lsp_buffer_options(bufnr)
    for k, v in pairs(M.configuration.buffer_options) do
        vim.api.nvim_buf_set_option(bufnr, k, v)
    end
end

function M.common_on_attach(client, bufnr)
    M.setup_document_highlight(client, bufnr)
    M.setup_codelens_refresh(client, bufnr)
    M.add_lsp_buffer_keybindings(bufnr)
    M.add_lsp_buffer_options(bufnr)
    M.setup_document_symbols(client, bufnr)
end

function M.setup()
    null_ls.setup({
        on_attach = M.common_on_attach,
        capabilities = M.common_capabilities(),
        debug = false,
        sources = {
            null_ls.builtins.formatting.black.with({ extra_args = { "--fast", "-l", "79", "-t", "py311" } }),
            null_ls.builtins.formatting.google_java_format,
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.yamlfix,
            null_ls.builtins.formatting.yamlfmt,
        },
    })
end

return M
