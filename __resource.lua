resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua',
	'config.lua'
}

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	'config.lua',
	'client.lua'
}