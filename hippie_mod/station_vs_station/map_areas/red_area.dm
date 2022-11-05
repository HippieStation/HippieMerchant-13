/area/svs
	has_gravity = TRUE

/area/svs/red/engine
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/svs/red/engine/engineering
	name = "Red Engineering"
	icon_state = "engine"

/area/svs/red/engine/atmos
	name = "Red Atmospherics"
	icon_state = "atmos"
	flags_1 = NONE

/area/svs/red/engine/engine_room
	name = "Red Atmospherics Engine"
	icon_state = "atmos_engine"

/area/svs/red/engine/storage
	name = "Red Engineering Storage"
	icon_state = "engi_storage"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/svs/red/security
	name = "Red Security"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/red/security/armory
	name = "Red Armory"
	icon_state = "armory"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security

/area/svs/red/security/vault
	name = "Red Vault"
	icon_state = "nuke_storage"
	airlock_wires = /datum/wires/airlock/command

/area/svs/red/security/vault/ore
	name = "Red ORM"

/area/svs/red/security/vault/server
	name = "Red Server Room"

/area/svs/red/command
	name = "Red Command"
	icon_state = "Bridge"
	ambientsounds = list('sound/ambience/signal.ogg')
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/red/command/bridge
	name = "Red Bridge"
	icon_state = "bridge"

/area/svs/red/command/bridge/admiral
	name = "Red Admiral's Quarters"

/area/svs/red/science
	name = "Red Science Division"
	icon_state = "science"
	airlock_wires = /datum/wires/airlock/science
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/red/science/lab
	name = "Red Research and Development"
	icon_state = "toxlab"

/area/svs/red/cargo
	name = "Red Cargo Bay"
	icon_state = "cargo_bay"
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/svs/red/hallway
	name = "Primary Hallway"
	icon_state = "hallC"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/red/break_room
	name = "Red Break Room"
	icon_state = "fitness"

/area/svs/red/nexus
	name = "Red Nexus"
	icon_state = "bridge"
