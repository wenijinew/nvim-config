local H = {}
local P = require('config.theme.palette')

H.__no_color = 'NONE'

-- properties could be override by other module
H.fg_normal = P.colors.pale_blue
H.bg_normal = P.colors.deep_grayish_blue
H.fg_normal_dark = P.colors.grayish_blue
H.bg_normal_dark = P.colors.black_grayish_blue
H.fg_highlight = P.colors.light_yellow
H.bg_highlight = P.colors.dark_red
H.fg_inactive = P.colors.strong_grayish_blue
H.bg_inactive = P.colors.dark_gray

H.fg_tabline_active = H.fg_highlight
H.bg_tabline_active = H.bg_highlight
H.fg_tabline_inactive = H.fg_inactive
H.bg_tabline_inactive = H.bg_inactive

H.fg_lualine_active = H.fg_normal_dark
H.bg_lualine_active = H.bg_normal_dark
H.fg_lualine_highlight = P.colors.grayish_blue
H.bg_lualine_highlight = P.colors.dark_grayish_blue
H.fg_lualine_insert_highlight = P.colors.grayish_green
H.bg_lualine_insert_highlight = P.colors.dark_grayish_green
H.fg_lualine_visual_highlight = P.colors.grayish_orange
H.bg_lualine_visual_highlight = P.colors.dark_grayish_orange
H.fg_lualine_inactive = H.fg_inactive
H.bg_lualine_inactive = H.bg_inactive

H.border_color = P.colors.dark_grayish_orange

H.setup = function()
    local hl = vim.api.nvim_set_hl
    hl(0, 'Normal', { fg = H.fg_normal, bg = H.bg_normal })
    hl(0, 'Visual', { fg = H.fg_highlight, bg = H.bg_highlight })
    hl(0, 'Title', { fg = H.fg_highlight, bg = H.bg_normal })
    hl(0, 'Winbar', { fg = P.colors.light_blue, bg = H.bg_normal })
    hl(0, 'TabLine', { fg = P.colors.light_blue, bg = P.colors.strong_gray })
    hl(0, 'TabLineFill', { fg = P.colors.light_blue, bg = H.bg_normal })
    hl(0, 'TabLineSel', { fg = P.colors.light_blue, bg = H.bg_highlight })
    hl(0, 'LineNr', { fg = P.colors.heavy_grayish_blue, bg = H.__no_color })
    hl(0, 'CursorLine', { fg = H.__no_color, bg = P.colors.dark_grayish_blue })
    hl(0, 'CursorLineNr', { fg = P.colors.orange, bg = H.__no_color })
    hl(0, 'Cursor', { fg = P.colors.light_blue, bg = H.bg_normal })
    hl(0, 'ColorColumn', { fg = H.__no_color, bg = P.colors.dark_grayish_blue })
    hl(0, 'SignColumn', { fg = P.colors.strong_grayish_blue, bg = H.__no_color })
    hl(0, 'VertSplit', { fg = H.border_color, bg = H.__no_color })
    hl(0, 'FoldColumn', { fg = H.__no_color, bg = P.colors.dark_yellow })
    hl(0, 'StatusLine', { fg = H.fg_highlight, bg = H.bg_highlight })
    hl(0, 'StatusLineNC', { fg = P.colors.strong_gray, bg = P.colors.gray })
    hl(0, 'ModeMsg', { fg = P.colors.orange, bg = H.bg_normal })
    hl(0, 'MsgArea', { fg = P.colors.strong_grayish_green, bg = H.bg_normal })
    hl(0, 'EndOfBuffer', { fg = P.colors.light_blue, bg = H.bg_normal })
    hl(0, 'Directory', { fg = P.colors.grayish_blue, bg = H.__no_color })
    -- popup menu
    hl(0, 'Pmenu', { fg = P.colors.light_blue, bg = P.colors.dark_grayish_blue })
    hl(0, 'PmenuSel', { fg = H.__no_color, bg = H.bg_normal_dark })
    hl(0, 'PmenuSbar', { fg = P.colors.light_blue, bg = H.bg_normal_dark })
    hl(0, 'PmenuThumb', { fg = P.colors.light_blue, bg = P.colors.strong_grayish_blue })
    -- /////////////////////////////////////////////////////////////////
    -- syntax groups (start) (refer to ':h group-name')
    -- /////////////////////////////////////////////////////////////////
    hl(0, 'Comment', { fg = P.colors.heavy_grayish_blue, bg = H.__no_color })
    hl(0, 'SpecialComment', { fg = P.colors.strong_grayish_blue, bg = H.__no_color })
    hl(0, 'pythonDocstring', { link = 'Comment' })

    hl(0, 'Constant', { fg = P.colors.lime_green, bg = H.__no_color })
    hl(0, 'String', { fg = P.colors.strong_grayish_lime_green, bg = H.__no_color })
    hl(0, 'Character', { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, 'Number', { fg = P.colors.light_lime_green, bg = H.__no_color })
    hl(0, 'Float', { link = 'Number' })
    hl(0, 'Boolean', { fg = P.colors.light_lime_green, bg = H.__no_color })

    hl(0, 'Identifier', { fg = P.colors.cyan, bg = H.__no_color })
    hl(0, 'Function', { fg = P.colors.grayish_blue, bg = H.__no_color })
    --hl(0, 'Function', { fg = P.colors.strong_grayish_cyan, bg = H.__no_color })
    hl(0, 'Variable', { link = 'Identifier' })
    hl(0, 'Parameter', { link = 'Variable' })
    hl(0, 'ClassVariable', { link = 'Variable' })
    hl(0, 'cshShellVariables', { link = 'Variable' })
    hl(0, 'tcshShellVar', { link = 'Variable' })
    hl(0, 'shVariable', { link = 'Variable' })
    hl(0, 'shShellVariables', { link = 'Variable' })
    hl(0, 'shFunction', { link = 'Function' })
    hl(0, 'shFunctionName', { link = 'Function' })
    hl(0, 'shFunctionKey', { link = 'Function' })

    hl(0, 'Statement', { fg = P.colors.light_violet, bg = H.__no_color })
    hl(0, 'Keyword', { fg = P.colors.orange, bg = H.__no_color })
    --hl(0, 'Keyword', { fg = P.colors.violet, bg = H.__no_color })
    hl(0, 'StorageClass', { link = 'Statement' })
    hl(0, 'Conditional', { link = 'Keyword' })
    hl(0, 'Repeat', { link = 'Keyword' })
    hl(0, 'shLoop', { link = 'Repeat' })
    hl(0, 'Label', { link = 'Keyword' })
    hl(0, 'Operator', { fg = P.colors.grayish_violet, bg = H.__no_color })
    hl(0, 'shPosnParm', { link = 'Operator' })
    hl(0, 'shCmdSubRegion', { link = 'Operator' })
    hl(0, 'shArithRegion', { link = 'Operator' })

    hl(0, 'PreProc', { fg = P.colors.strong_grayish_green, bg = H.__no_color })
    hl(0, 'Include', { fg = P.colors.orange, bg = H.__no_color })
    hl(0, 'Define', { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, 'Macro', { fg = P.colors.grayish_orange, bg = H.__no_color })
    hl(0, 'PreCondit', { fg = P.colors.light_grayish_orange, bg = H.__no_color })

    hl(0, 'Type', { fg = P.colors.light_cyan, bg = H.__no_color })
    hl(0, 'Typedef', { fg = P.colors.grayish_cyan, bg = H.__no_color })
    --hl(0, 'StorageClass', { fg = P.colors.strong_cyan, bg = H.__no_color })
    hl(0, 'Structure', { fg = P.colors.dark_grayish_cyan, bg = H.__no_color })
    hl(0, 'shDeref', { fg = P.colors.strong_grayish_cyan, bg = H.__no_color })

    hl(0, 'Special', { fg = P.colors.strong_grayish_blue, bg = H.__no_color })
    hl(0, 'SpecialChar', { fg = P.colors.grayish_blue, bg = H.__no_color })
    hl(0, 'Tag', { fg = P.colors.dark_grayish_blue, bg = H.__no_color })
    hl(0, 'Delimiter', { link = 'SpecialChar' })
    hl(0, 'xmlTag', { link = 'SpecialChar' })
    hl(0, 'xmlTagEnd', { link = 'SpecialChar' })
    hl(0, 'xmlTagName', { link = 'Typedef' })
    hl(0, 'xmlAttrib', { link = 'Statement' })
    hl(0, 'htmlTag', { link = 'SpecialChar' })
    hl(0, 'htmlEndTag', { link = 'SpecialChar' })
    hl(0, 'htmlTagName', { link = 'Typedef' })
    hl(0, 'MatchParen', { fg = P.colors.light_violet, bg = H.__no_color })

    hl(0, 'Ignore', { fg = P.colors.light_blue, bg = H.__no_color })

    hl(0, 'Error', { fg = P.colors.red, bg = H.__no_color })
    hl(0, 'Exception', { fg = P.colors.grayish_red, bg = H.__no_color })
    hl(0, 'WarningMsg', { fg = P.colors.strong_grayish_yellow, bg = H.__no_color })
    hl(0, 'Debug', { fg = P.colors.strong_grayish_red, bg = H.__no_color })
    hl(0, 'debugPC', { link = 'Debug' })
    hl(0, 'debugBreakpoint', { link = 'Debug' })
    hl(0, 'Whitespace', { fg = P.colors.strong_grayish_red, bg = P.colors.light_grayish_red })

    hl(0, 'TODO', { fg = P.colors.strong_yellow, bg = H.__no_color })

    hl(0, 'Search', { fg = P.colors.strong_blue, bg = P.colors.light_blue })

    hl(0, 'DiagnosticError', { fg = P.colors.light_red, bg = H.__no_color })
    hl(0, 'DiagnosticWarn', { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, 'DiagnosticInfo', { fg = P.colors.light_cyan, bg = H.__no_color })
    hl(0, 'DiagnosticHint', { fg = P.colors.cyan, bg = H.__no_color })
    hl(0, 'PymodeW', { link = 'DiagnosticWarn' })
    hl(0, 'PymodeD', { link = 'DiagnosticHint' })
    hl(0, 'PymodeC', { link = 'DiagnosticWarn' })
    hl(0, 'PymodeR', { link = 'DiagnosticInfo' })
    hl(0, 'PymodeE', { link = 'DiagnosticError' })
    hl(0, 'PymodeI', { link = 'DiagnosticHint' })
    hl(0, 'PymodeF', { link = 'DiagnosticInfo' })
    -- /////////////////////////////////////////////////////////////////
    -- syntax groups (end)
    -- /////////////////////////////////////////////////////////////////
    -- gitgutter plugin
    hl(0, 'GitGutterAdd', { fg = P.colors.green, bg = H.__no_color })
    hl(0, 'GitGutterDelete', { fg = P.colors.red, bg = H.__no_color })
    hl(0, 'GitGutterChange', { fg = P.colors.violet, bg = H.__no_color })
    hl(0, 'GitGutterAddLine', { bg = P.colors.dark_green })
    hl(0, 'GitGutterDeleteLine', { bg = P.colors.dark_red })
    hl(0, 'GitGutterChangeLine', { bg = P.colors.dark_cyan })
    hl(0, 'GitGutterChangeDeleteLine', { bg = P.colors.strong_violet })
    hl(0, 'GitGutterAddLineNr', { link = 'GitGutterAdd' })
    hl(0, 'GitGutterDeleteLineNr', { link = 'GitGutterDelete' })
    hl(0, 'GitGutterChangeLineNr', { link = 'GitGutterChange' })
    hl(0, 'GitGutterChangeDeleteLineNr', { link = 'GitGutterChangeDeleteLine' })
    -- navic (breadcrumbs)
    hl(0, "NavicIconsFile", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsModule", { fg = P.colors.light_yellow, bg = H.__no_color })
    hl(0, "NavicIconsNamespace", { fg = H.fg_normal, bg = H.__no_color })
    hl(0, "NavicIconsPackage", { fg = H.fg_normal, bg = H.__no_color })
    hl(0, "NavicIconsClass", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsMethod", { fg = P.colors.light_blue, bg = H.__no_color })
    hl(0, "NavicIconsProperty", { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, "NavicIconsField", { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, "NavicIconsConstructor", { fg = P.colors.orange, bg = H.__no_color })
    hl(0, "NavicIconsEnum", { fg = P.colors.orange, bg = H.__no_color })
    hl(0, "NavicIconsInterface", { fg = P.colors.orange, bg = H.__no_color })
    hl(0, "NavicIconsFunction", { fg = P.colors.light_blue, bg = H.__no_color })
    hl(0, "NavicIconsVariable", { fg = P.colors.violet, bg = H.__no_color })
    hl(0, "NavicIconsConstant", { fg = P.colors.violet, bg = H.__no_color })
    hl(0, "NavicIconsString", { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, "NavicIconsNumber", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsBoolean", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsArray", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsObject", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsKey", { fg = P.colors.violet, bg = H.__no_color })
    hl(0, "NavicIconsKeyword", { fg = P.colors.violet, bg = H.__no_color })
    hl(0, "NavicIconsNull", { fg = P.colors.orange, bg = H.__no_color })
    hl(0, "NavicIconsEnumMember", { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, "NavicIconsStruct", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsEvent", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NavicIconsOperator", { fg = H.fg_normal, bg = H.__no_color })
    hl(0, "NavicIconsTypeParameter", { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, "NavicText", { fg = P.colors.light_blue, bg = H.__no_color })
    hl(0, "NavicSeparator", { fg = P.colors.light_blue, bg = H.__no_color })
    -- indent-blankline
    hl(0, 'IndentBlanklineChar', { fg = P.colors.heavy_grayish_blue })
    -- links
    hl(0, 'WinSeparator', { link = 'VertSplit' })
    hl(0, 'SpecialKey', { link = 'Special' })
    hl(0, 'ErrorMsg', { link = 'Error' })
    hl(0, 'DiffAdd', { link = 'GitGutterAdd' })
    hl(0, 'DiffDelete', { link = 'GitGutterDelete' })
    hl(0, 'DiffChange', { link = 'GitGutterChange' })
    hl(0, 'DiffText', { link = 'GitGutterChange' })
    hl(0, 'IncSearch', { link = 'Search' })
    -- telescope highlight groups such as 'TelescopePromptCounter' links to NonText
    hl(0, 'NonText', { link = 'Ignore' })
    hl(0, 'TelescopeBorder', { fg = P.colors.strong_grayish_blue })
    -- links for python highlight groups
    hl(0, 'pythonParam', { link = 'Parameter' })
    hl(0, 'pythonVars', { link = 'Variable' })
    hl(0, 'pythonClassVars', { link = 'ClassVariable' })
    hl(0, 'pythonConstant', { link = 'Constant' })
    hl(0, 'pythonBuiltin', { link = 'Keyword' })
    hl(0, 'pythonRawEscape', { link = 'SpecialChar' })
    hl(0, 'pythonExtraOperatorpythonStatement', { link = 'Statement' })
    -- links for java highlight groups
    hl(0, 'javaParen', { link = 'Operator' })
    hl(0, 'javaVarArg', { link = 'Parameter' })
    hl(0, 'javaC_', { link = 'Type' })
    hl(0, 'javaClassDecl', { link = 'Type' })
    hl(0, 'javaLangObject', { link = 'Type' })
    -- nvim-treesitter needs nvim-0.8 or higher version
    -- if version is lower than 0.8, then return with debug message
    -- TODO: print current nvim version in logging message
    if vim.fn.has "nvim-0.8" == 1 then
        -- Treesitter
        hl(0, "@comment", { link = 'Comment' })
        hl(0, "@none", { fg = 'NONE', bg = H.__no_color })
        hl(0, "@preproc", { link = 'PreProc' })
        hl(0, "@define", { link = 'Define' })
        hl(0, "@operator", { link = 'Operator' })
        hl(0, "@punctuation.delimeter", { link = 'Delimiter' })
        hl(0, "@punctuation.bracket", { fg = P.colors.light_blue, bg = H.__no_color })
        hl(0, "@punctuation.special", { link = 'Delimiter' })
        hl(0, "@string", { link = 'String' })
        hl(0, "@string.regex", { link = 'String' })
        hl(0, "@string.escape", { link = 'SpecialChar' })
        hl(0, "@string.special", { link = 'SpecialChar' })
        hl(0, "@character", { link = 'Character' })
        hl(0, "@character.special", { link = 'SpecialChar' })
        hl(0, "@boolean", { link = 'Boolean' })
        hl(0, "@number", { link = 'Number' })
        hl(0, "@float", { link = 'Float' })
        hl(0, "@function", { link = 'Function' })
        hl(0, "@function.builtin", { link = 'Special' })
        hl(0, "@function.call", { link = 'Function' })
        hl(0, "@function.macro", { link = 'Macro' })
        hl(0, "@method", { link = 'Function' })
        hl(0, "@method.call", { link = 'Function' })
        hl(0, "@constructor", { link = 'Special' })
        hl(0, "@parameter", { fg = P.colors.yellow, bg = H.__no_color })
        hl(0, "@keyword", { link = 'Keyword' })
        hl(0, "@keyword.function", { link = 'Keyword' })
        hl(0, "@keyword.operator", { link = 'Keyword' })
        hl(0, "@keyword.return", { link = 'Keyword' })
        hl(0, "@conditional", { link = 'Conditional' })
        hl(0, "@repeat", { link = 'Repeat' })
        hl(0, "@debug", { link = 'Debug' })
        hl(0, "@label", { link = 'Label' })
        hl(0, "@include", { link = 'Include' })
        hl(0, "@exception", { link = 'Exception' })
        hl(0, "@type", { link = 'Type' })
        hl(0, "@type.builtin", { link = 'Type' })
        hl(0, "@type.definition", { link = 'Typedef' })
        hl(0, "@type.qualifier", { link = 'Type' })
        hl(0, "@storageclass", { link = 'StorageClass' })
        hl(0, "@attribute", { link = 'PreProc' })
        hl(0, "@field", { fg = P.colors.green, bg = H.__no_color })
        hl(0, "@property", { fg = P.colors.green, bg = H.__no_color })
        hl(0, "@variable", { link = 'Variable' })
        hl(0, "@variable.builtin", { fg = P.colors.red, bg = H.__no_color })
        hl(0, "@constant", { link = 'Constant' })
        hl(0, "@constant.builtin", { link = 'Special' })
        hl(0, "@constant.macro", { link = 'Define' })
        hl(0, "@namespace", { link = 'Include' })
        hl(0, "@symbol", { link = 'Identifier' })
        hl(0, "@text", { link = 'None' })
        hl(0, "@text.strong", { link = 'Bold' })
        hl(0, "@text.emphasis", { link = 'Italic' })
        hl(0, "@text.underline", { link = 'Underlined' })
        hl(0, "@text.strike", { fg = 'NONE', bg = H.__no_color, strikethrough = true, })
        hl(0, "@text.title", { link = 'Title' })
        hl(0, "@text.literal", { link = 'String' })
        hl(0, "@text.uri", { link = 'Underlined' })
        hl(0, "@text.math", { link = 'Special' })
        hl(0, "@text.environment", { link = 'Macro' })
        hl(0, "@text.environment.name", { link = 'Type' })
        hl(0, "@text.reference", { link = 'Constant' })
        hl(0, "@text.todo", { link = 'Todo' })
        hl(0, "@text.note", { link = 'SpecialComment' })
        hl(0, "@text.warning", { link = 'Todo' })
        hl(0, "@text.danger", { link = 'WarningMsg' })
        hl(0, "@tag", { link = 'Tag' })
        hl(0, "@tag.attribute", { link = 'Identifier' })
        hl(0, "@tag.delimiter", { fg = P.colors.light_cyan, bg = H.__no_color })
    end

    -- NvimTree
    hl(0, "NvimTreeFolderIcon", { link = 'Directory' })
    hl(0, "NvimTreeIndentMarker", { fg = P.colors.light_blue, bg = H.__no_color })
    hl(0, "NvimTreeNormal", { fg = H.fg_normal_dark, bg = H.bg_normal_dark })
    hl(0, "NvimTreeNormalNC", { fg = H.fg_normal_dark, bg = H.bg_normal_dark })
    hl(0, "NvimTreeVertSplit", { fg = H.fg_normal_dark, bg = H.fg_normal_dark })
    hl(0, "NvimTreeWinSeparator", { fg = H.border_color, bg = H.bg_normal })
    hl(0, "NvimTreeFolderName", { link = 'NvimTreeFolderIcon' })
    hl(0, "NvimTreeOpenedFolderName", { fg = P.colors.light_blue, bg = H.__no_color })
    hl(0, "NvimTreeEmptyFolderName", { link = 'Comment' })
    hl(0, "NvimTreeOpenedFile", { fg = H.__no_color, bg = P.colors.bg_highlight })
    hl(0, "NvimTreeGitIgnored", { link = 'Comment' })
    hl(0, "NvimTreeImageFile", { fg = H.fg_normal_dark, bg = H.__no_color })
    hl(0, "NvimTreeSpecialFile", { fg = P.colors.purple, bg = H.__no_color, underline = true, })
    hl(0, "NvimTreeEndOfBuffer", { fg = H.bg_normal_dark, bg = H.__no_color })
    hl(0, "NvimTreeCursorLine", { link = 'CursorLine' })
    hl(0, "NvimTreeGitStaged", { fg = P.colors.light_green, bg = H.__no_color })
    hl(0, "NvimTreeGitNew", { fg = P.colors.grayish_green, bg = H.strong_grayish_blue })
    hl(0, "NvimTreeGitRenamed", { fg = P.colors.grayish_orange, bg = H.__no_color })
    hl(0, "NvimTreeGitDeleted", { fg = P.colors.red, bg = H.__no_color })
    hl(0, "NvimTreeGitMerge", { fg = P.colors.strong_green, bg = H.__no_color })
    hl(0, "NvimTreeGitDirty", { fg = P.colors.light_orange, bg = H.__no_color })
    hl(0, "NvimTreeSymlink", { fg = P.colors.cyan, bg = H.__no_color })
    hl(0, "NvimTreeRootFolder", { fg = P.colors.light_blue, bg = H.__no_color, bold = true, })
    hl(0, "NvimTreeExecFile", { fg = P.colors.strong_lime_green, bg = H.__no_color, })

    -- NvimCmp
    hl(0, "CmpItemAbbr", { fg = P.colors.light_blue, bg = H.__no_color, })
    hl(0, "CmpItemAbbrDeprecated", { fg = P.colors.strong_gray, bg = H.__no_color, })
    hl(0, "CmpItemAbbrMatch", { fg = P.colors.light_grayish_blue, bg = H.__no_color, })
    hl(0, "CmpItemAbbrMatchFuzzy", { fg = P.colors.light_grayish_green, bg = H.__no_color, })
    hl(0, "CmpItemKind", { fg = P.colors.light_lime_green, bg = H.__no_color, })
    hl(0, "CmpItemKindEnum", { fg = P.colors.light_grayish_red, bg = H.__no_color, })
    hl(0, "CmpItemKindVariable", { fg = P.colors.light_cyan, bg = H.__no_color, })
    hl(0, "CmpItemKindMethod", { fg = P.colors.pale_violet, bg = H.__no_color, })
    hl(0, "CmpItemKindModule", { fg = P.colors.pale_orange, bg = H.__no_color, })
    hl(0, "CmpItemKindInterface", { fg = P.colors.light_violet, bg = H.__no_color, })
    hl(0, "CmpItemMenu", { fg = P.colors.light_orange, bg = H.__no_color, })

    -- Gitsigns
    hl(0, "GitSignsCurrentLineBlame", { link = 'SpecialComment' })
end

return H
