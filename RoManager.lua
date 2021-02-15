return function(connectionInfo)
	if game:GetService('RunService'):IsStudio() then
		warn('[RoManager] Cannot connect to RoManager in Studio sessions.')
		return
	end
	
	-- Allow users to supply a custom baseUrl - default to RoManager's public API
	local apiBaseUrl = connectionInfo.API_BASE_URL or 'https://game.romanager.jaydenn.dev/';
	
	print('[RoManager] Connecting to', apiBaseUrl)
	
	local Connection = require(script.Connection);
	local client = Connection.new();
	
	client:connect(apiBaseUrl .. 'socket', {
		Authorization = connectionInfo.INTEGRATION_KEY,
		['roblox-job-id'] = game.JobId
	});
	
	client:on('kick', function(username)
		local plr = game:GetService('Players'):FindFirstChild(username)
		print('[RoManager] Got kick request for '.. username)
		if plr then
			plr:Kick()
			print('[RoManager] Kicked '.. username ..' from request.')
		end
	end)

	game:BindToClose(function()
		client:disconnect();
	end)
end
