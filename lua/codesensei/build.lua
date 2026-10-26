local M = {}

-- Use Neovim's compiler parsers and shell-escaped filename modifiers (:S).
local profiles = {
    c = { compiler = "gcc", command = "gcc -o %:p:r:S.o %:p:S" },
    cpp = { compiler = "gcc", command = "g++ -std=c++17 -o %:p:r:S.o %:p:S" },
    rust = { compiler = "rustc", command = "cargo build --release" },
    go = { compiler = "go", command = "go build -o %:p:r:S.o %:p:S" },
    zig = { compiler = "gcc", command = "zig build -freference-trace" },
    nim = { compiler = "nim", command = "nim c --listFullPaths:on %:p:S" },
    java = { compiler = "javac", command = "javac %:p:S" },
    hare = { compiler = "hare", command = "hare build" },
    odin = {
        command = "odin build %:p:S -file",
        errorformat = "%f(%l:%c) %t%*[^:]: %m,%f:%l:%c: %m",
    },
}

function M.configure()
    local profile = profiles[vim.bo.filetype]
    if not profile then
        return false
    end
    if profile.compiler then
        vim.cmd.compiler(profile.compiler)
    else
        vim.bo.errorformat = profile.errorformat
    end
    vim.bo.makeprg = profile.command
    vim.b.codesensei_build_filetype = vim.bo.filetype
    return true
end

function M.run(command)
    if vim.bo.buftype ~= "" then
        vim.notify("Run the build from a source buffer", vim.log.levels.WARN)
        return false
    end

    if vim.b.codesensei_build_filetype ~= vim.bo.filetype then
        local configured = M.configure()
        if not configured and not command then
            vim.notify("No build command for filetype: " .. vim.bo.filetype, vim.log.levels.WARN)
            return false
        end
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local original = vim.bo[bufnr].makeprg
    local makeprg = command or original
    if (vim.bo.modified or makeprg:find("%%")) and vim.api.nvim_buf_get_name(bufnr) == "" then
        vim.notify("Save the buffer to a file before building", vim.log.levels.WARN)
        return false
    end

    -- Conform's BufWritePre hook finishes before the compiler reads the file.
    vim.cmd.update()
    vim.bo[bufnr].makeprg = makeprg

    -- :make captures output with POSIX redirection. Use sh for this invocation
    -- even when the user's interactive shell is Nushell, then restore it.
    local shell_options = {
        { "shell", "/bin/sh" },
        { "shellcmdflag", "-c" },
        { "shellquote", "" },
        { "shellxquote", "" },
        -- Direct redirection preserves the compiler's exit code (unlike tee).
        { "shellpipe", ">%s 2>&1" },
    }
    local saved = {}
    for _, option in ipairs(shell_options) do
        saved[option[1]] = vim.o[option[1]]
    end
    for _, option in ipairs(shell_options) do
        vim.o[option[1]] = option[2]
    end
    local ok, err = pcall(vim.cmd.make, { bang = true })
    local exit_code = vim.v.shell_error
    for _, option in ipairs(shell_options) do
        vim.o[option[1]] = saved[option[1]]
    end
    vim.bo[bufnr].makeprg = original
    if not ok then
        error(err)
    end

    if exit_code ~= 0 then
        -- Preserve unparsed output too (for example, a missing compiler).
        vim.cmd.copen()
    else
        vim.cmd.cwindow()
    end
    return exit_code == 0
end

function M.setup()
    local group = vim.api.nvim_create_augroup("CodesenseiBuild", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = vim.tbl_keys(profiles),
        callback = function()
            M.configure()
        end,
        desc = "Configure native :make and quickfix for this language",
    })
    -- Also support sourcing the config in an already-open source buffer.
    M.configure()
end

return M
