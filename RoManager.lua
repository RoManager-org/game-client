return function(connectionInfo)
	assert(connectionInfo.API_KEY, '[RoManager] Missing API_KEY!');

	-- Allow users to supply a custom baseUrl - default to RoManager's public API
	local apiBaseUrl = connectionInfo.API_BASE_URL or 'https://romanager.jaydensar.net/api/game';

	print(apiBaseUrl)

	local Connection = require(script.Connection);
	local client = Connection.new();

	client:connect(apiBaseUrl, {
		Authorization = connectionInfo.API_KEY,
		['roblox-job-id'] = game.JobId
	});

	game:BindToClose(function()
		client:disconnect();
	end)
end
