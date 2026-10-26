local api = vim.api
local cmd = vim.cmd

local build = require("codesensei.build")
build.setup()

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
	odin = "odin run .",
}

local execute_commands = {
	odin = "%:p:r",
}

local test_commands = {
	zig = "zig test %:p:S",
}

local go_commands = {
	go = "go run .",
}

api.nvim_create_user_command("Build", function()
	build.run()
end, { desc = "Save, build, and collect compiler errors in quickfix" })

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

api.nvim_create_user_command("Execute", function()
	local filetype = vim.bo.filetype

	for file, command in pairs(execute_commands) do
		if filetype == file then
			vim.cmd("term " .. command)
			local keys = api.nvim_replace_termcodes("i", true, false, true)
			api.nvim_feedkeys(keys, "n", false)
			break
		end
	end
end, {})

api.nvim_create_user_command("Test", function()
	local command = test_commands[vim.bo.filetype]
	if command then
		build.run(command)
	else
		vim.notify("No test command for filetype: " .. vim.bo.filetype, vim.log.levels.WARN)
	end
end, { desc = "Save, test, and collect failures in quickfix" })

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
	build.run("just build")
end, { desc = "Run just build and collect errors in quickfix" })

api.nvim_create_user_command("Justrun", function()
	cmd("term just run")
end, {})

--Make file commands
api.nvim_create_user_command("Makefile", function()
	build.run("make build")
end, { desc = "Run make build and collect errors in quickfix" })

api.nvim_create_user_command("Makerun", function()
	cmd("term make run")
end, {})
