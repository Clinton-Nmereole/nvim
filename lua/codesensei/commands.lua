local api = vim.api
local cmd = vim.cmd

local build_commands = {
    c = "g++ -std=c++17 -o %:p:r.o %",
    cpp = "g++ -std=c++17 -o %:p:r.o %",
    rust = "cargo build --release",
    go = "go build -o %:p:r.o %",
    zig = "zig build -freference-trace",
    nim = "nim c %<",
    java = "javac %",
    hare = "hare build",
    odin = "odin build % -file",
}

local run_commands = {
    c = "%:p:r.o",
    cpp = "%:p:r.o",
    rust = "cargo run --release",
    go = "%:p:r.o",
    zig = "zig run % -freference-trace",
    nim = "%:p:r",
    python = "python3 %",
    java = "java %:p",
    hare = "hare run %",
    odin = "odin run ."
}

local test_commands = {
    zig = "zig test %",
}

local go_commands = {
    go = "go run .",
}



api.nvim_create_user_command("Build", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(build_commands) do
        if filetype == file then
            vim.cmd("!" .. command)
            break
        end
    end
end, {})

api.nvim_create_user_command("Run", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(run_commands) do
        if filetype == file then
            vim.cmd("term " .. command)
            local keys = api.nvim_replace_termcodes("i", true, false, true)
            api.nvim_feedkeys(keys, "n", false)
            break
        end
    end
end, {})

api.nvim_create_user_command("Test", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(test_commands) do
        if filetype == file then
            vim.cmd("term " .. command)
            local keys = api.nvim_replace_termcodes("i", true, false, true)
            api.nvim_feedkeys(keys, "n", false)
            break
        end
    end
end, {})

api.nvim_create_user_command("Go", function()
    local filetype = vim.bo.filetype

    for file, command in pairs(go_commands) do
        if filetype == file then
            vim.cmd("term " .. command)
            local keys = api.nvim_replace_termcodes("i", true, false, true)
            api.nvim_feedkeys(keys, "n", false)
            break
        end
    end
end, {})

--Just File commands
api.nvim_create_user_command("Justbuild", function()
    cmd("term just build")
end, {})

api.nvim_create_user_command("Justrun", function()
    cmd("term just run")
end, {})

--Make file commands
api.nvim_create_user_command("Makefile", function()
    cmd("term make build")
end, {})

api.nvim_create_user_command("Makerun", function()
    cmd("term make run")
end, {})
