/datum/element/shelf
	var/list/gun
	var/datum/weakref/ammo_shelf
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
		ammo_shelf = source
		return

	for(var/each_gun in gun)
		var/obj/item/gun/ballistic/current_gun = each_gun

		if(!ispath(current_gun?.mag_type))
			return

		source.stored += new current_gun.mag_type

/datum/element/shelf/proc/get_armor(obj/structure/shelf/source, amount)
	SIGNAL_HANDLER

	for(var/i = 1 to amount)
		spawned_item = get_random_armor()
		source.stored += new spawned_item

/datum/element/shelf/proc/get_helmet(obj/structure/shelf/source, amount)
	SIGNAL_HANDLER

	for(var/i = 1 to amount)
		spawned_item = get_random_helmet()
		source.stored += new spawned_item
