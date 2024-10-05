local status, dap = pcall(require, 'dap')
if (not status) then return end

local port = 3982

dap.adapters.codelldb = {
	type = 'server',
	host = '127.0.0.1',
	port = port,
	executable = {
		command = 'codelldb',
		args = { "--port", "${port}" },
		detached = false,
	}
}
