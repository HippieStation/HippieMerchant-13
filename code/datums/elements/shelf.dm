/datum/element/shelf
	var/list/gun
	var/list/armor
	var/datum/weakref/ammo_shelf
	var/datum/weakref/helmet_shelf
	var/spawned_item

/datum/element/shelf/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_GUN_SHELF, .proc/get_gun)
	RegisterSignal(target, COMSIG_AMMO_SHELF, .proc/get_ammo)
	RegisterSignal(target, COMSIG_ARMOR_SHELF, .proc/get_armor)
	RegisterSignal(target, COMSIG_HELMET_SHELF, .proc/get_helmet)


/datum/element/shelf/Detach(datum/target)
	UnregisterSignal(target,\
		list(
			COMSIG_GUN_SHELF,
			COMSIG_AMMO_SHELF,
			COMSIG_ARMOR_SHELF,
			COMSIG_HELMET_SHELF
			))
	return ..()

/datum/element/shelf/proc/get_gun(obj/structure/shelf/source, amount)
	SIGNAL_HANDLER

	for(var/i = 1 to amount)
		spawned_item = get_random_gun()
		source.stored += new spawned_item

	gun += source.stored

	if(!ammo_shelf)
		return

	get_ammo(ammo_shelf.resolve())

/datum/element/shelf/proc/get_ammo(obj/structure/shelf/source)
	SIGNAL_HANDLER

	if(!gun)
		ammo_shelf = WEAKREF(source)
		return

	for(var/each_gun in gun)
		var/obj/item/gun/ballistic/current_gun = each_gun

		if(!ispath(current_gun?.mag_type))
			return
		spawned_item = match_ammo(current_gun)
		source.stored += new spawned_item
		source.stored += new spawned_item

	source.update_icon_state()

/datum/element/shelf/proc/get_armor(obj/structure/shelf/source, amount)
	SIGNAL_HANDLER

	for(var/i = 1 to amount)
		spawned_item = get_random_vest()
		source.stored += new spawned_item

	armor += source.stored

	if(!helmet_shelf)
		return

	get_helmet(helmet_shelf.resolve())

/datum/element/shelf/proc/get_helmet(obj/structure/shelf/source)
	SIGNAL_HANDLER

	if(!armor)
		helmet_shelf = WEAKREF(source)
		return

	for(var/each_armor in armor)
		var/obj/item/clothing/suit/armor/vest/current_armor = each_armor

		spawned_item = match_helmet(current_armor)
		source.stored += new spawned_item

	source.update_icon_state()

/datum/element/shelf/proc/match_helmet(obj/item/clothing/suit/armor/vest/current_armor)
	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/alt))
		return /obj/item/clothing/head/helmet/alt

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/marine))
		if(istype(current_armor, /obj/item/clothing/suit/armor/vest/marine/engineer))
			return /obj/item/clothing/head/helmet/marine/engineer

		if(istype(current_armor, /obj/item/clothing/suit/armor/vest/marine/medic))
			return /obj/item/clothing/head/helmet/marine/medic

		if(istype(current_armor, /obj/item/clothing/suit/armor/vest/marine/security))
			return /obj/item/clothing/head/helmet/marine/security

		return /obj/item/clothing/head/helmet/marine

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/old))
		return /obj/item/clothing/head/helmet/old

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/blueshirt))
		return /obj/item/clothing/head/helmet/blueshirt

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/warden))
		return /obj/item/clothing/head/warden

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/capcarapace))
		return /obj/item/clothing/head/caphat

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/det_suit))
		return /obj/item/clothing/head/fedora/det_hat

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/infiltrator))
		return /obj/item/clothing/head/helmet/infiltrator

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/durathread))
		return /obj/item/clothing/head/helmet/durathread

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/russian))
		return /obj/item/clothing/head/helmet/rus_helmet

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/kevlar))
		return /obj/item/clothing/head/helmet/rus_ushanka

	if(istype(current_armor, /obj/item/clothing/suit/armor/vest/russian_coat))
		return /obj/item/clothing/head/ushanka

	return /obj/item/clothing/head/helmet

/datum/element/shelf/proc/match_ammo(obj/item/gun/ballistic/current_gun)
	if(istype(current_gun, /obj/item/gun/ballistic/bow))
		return /obj/item/ammo_casing/caseless/arrow

	if(istype(current_gun, /obj/item/gun/ballistic/revolver/nagant))
		return /obj/item/ammo_box/n762

	if(istype(current_gun, /obj/item/gun/ballistic/revolver/detective))
		return /obj/item/ammo_box/c38

	if(istype(current_gun, /obj/item/gun/ballistic/rifle))
		return /obj/item/ammo_box/a762

	if(istype(current_gun, /obj/item/gun/ballistic/rocketlauncher))
		return /obj/item/ammo_casing/caseless/rocket

	if(istype(current_gun, /obj/item/gun/ballistic/shotgun))
		if(istype(current_gun, /obj/item/gun/ballistic/shotgun/automatic) || istype(current_gun, /obj/item/gun/ballistic/shotgun/lethal))
			return /obj/item/storage/box/lasershot

		if(istype(current_gun, /obj/item/gun/ballistic/shotgun/doublebarrel) || istype(current_gun, /obj/item/gun/ballistic/shotgun/toy) || istype(current_gun, /obj/item/gun/ballistic/shotgun/sc_pump))
			return /obj/item/storage/box/beanbag

		if(istype(current_gun, /obj/item/gun/ballistic/shotgun/riot))
			return /obj/item/storage/box/disablershots

		if(istype(current_gun, /obj/item/gun/ballistic/shotgun/hook))
			return /obj/item/storage/box/hookshots

	return current_gun.mag_type
