type Connection = {
	connect(host: string, headers?: object, secure?: boolean): void;
	on(target: string, func: Callback): void;
	send(target: string, data: string): void;
	disconnect(): void;
};

interface ConnectionConstructor {
	new (): Connection;
}
declare const Connection: ConnectionConstructor;

export = Connection;
