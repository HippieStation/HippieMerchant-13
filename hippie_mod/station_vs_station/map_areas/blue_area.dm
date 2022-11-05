/area/svs
	has_gravity = TRUE

/area/svs/blue/engine
	ambience_index = AMBIENCE_ENGI
	airlock_wires = /datum/wires/airlock/engineering
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/svs/blue/engine/engineering
	name = "Blue Engineering"
	icon_state = "engine"

/area/svs/blue/engine/atmos
	name = "Blue Atmospherics"
	icon_state = "atmos"
	flags_1 = NONE

/area/svs/blue/engine/engine_room
	name = "Blue Atmospherics Engine"
	icon_state = "atmos_engine"

/area/svs/blue/engine/storage
	name = "Blue Engineering Storage"
	icon_state = "engi_storage"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/svs/blue/security
	name = "Blue Security"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/blue/security/armory
	name = "Blue Armory"
	icon_state = "armory"
	ambience_index = AMBIENCE_DANGER
	airlock_wires = /datum/wires/airlock/security

/area/svs/blue/security/vault
	name = "Blue Vault"
	icon_state = "nuke_storage"
	airlock_wires = /datum/wires/airlock/command

/area/svs/blue/security/vault/ore
	name = "Blue ORM"

/area/svs/blue/security/vault/server
	name = "Blue Server Room"

/area/svs/blue/command
	name = "Blue Command"
	icon_state = "Bridge"
	ambientsounds = list('sound/ambience/signal.ogg')
	airlock_wires = /datum/wires/airlock/command
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/blue/command/bridge
	name = "Blue Bridge"
	icon_state = "bridge"

/area/svs/blue/command/bridge/admiral
	name = "Blue Admiral's Quarters"

/area/svs/blue/science
	name = "Blue Science Division"
	icon_state = "science"
	airlock_wires = /datum/wires/airlock/science
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/blue/science/lab
	name = "Blue Research and Development"
	icon_state = "toxlab"

/area/svs/blue/cargo
	name = "Blue Cargo Bay"
	icon_state = "cargo_bay"
	airlock_wires = /datum/wires/airlock/service
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/svs/blue/hallway
	name = "Primary Hallway"
	icon_state = "hallC"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/svs/blue/break_room
	name = "Blue Break Room"
	icon_state = "fitness"

/area/svs/blue/nexus
	name = "Blue Nexus"
	icon_state = "bridge"
