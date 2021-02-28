import Connection from './Connection';

export = async (connectionInfo: { API_BASE_URL: string; INTEGRATION_KEY: string }) => {
	if (game.GetService('RunService').IsStudio()) {
		warn('[RoManager] Cannot connect to RoManager in Studio sessions.');
		return;
	}

	const apiBaseUrl = connectionInfo.API_BASE_URL ?? 'https://api.romanager.jaydenn.dev/game/';

	print('[RoManager] Connecting to', apiBaseUrl);

	const client = new Connection();

	client.connect(apiBaseUrl + 'socket', {
		Authorization: connectionInfo.INTEGRATION_KEY,
		'roblox-job-id': game.JobId,
	});

	client.on('kick', (username: string, reason: string) => {
		const plr = game.GetService('Players').FindFirstChild(username);
		if (plr?.IsA('Player')) plr.Kick(reason);
	});

	client.on('shutdown', (reason: string) => {
		game.GetService('Players')
			.GetPlayers()
			.forEach((player) => {
				player.Kick(reason);
			});
	});

	game.BindToClose(() => client.disconnect());
};
