fx_version 'adamant'
game 'gta5'

author 'Terror Kobold'
description 'ws_bank'
version '1.0'

lua54 'yes'

shared_script {
	'@ox_lib/init.lua',
    'shared/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'ox_lib'
}