fx_version 'cerulean'

games { 
	'gta5' 
}

lua54 "yes"

name 'ngRing'
author 'Niklas Gschaider <niklas.gschaider@gschaider-systems.at>'
description 'Allows the users to send predefined message into a discord channel via webhooks11'
version 'v1.0.0'

dependencies {
	"es_extended",
}

escrow_ignore {
	"config.lua",
	"locales/*.lua",
}

client_scripts {
	'@es_extended/locale.lua',
	"locales/*.lua",
	"config.lua",
	"client.lua",
}

server_scripts {
	'@es_extended/locale.lua',
	"locales/*.lua",
	"config.lua",
	"server.lua",
}