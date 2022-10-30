#define SOURCE_PORTAL 1
#define DESTINATION_PORTAL 2

/* Teleportation devices.
 * Contains:
 * Locator
 * Hand-tele
 */

/*
 * Locator
 */
/obj/item/locator
	name = "bluespace locator"
	desc = "Used to track portable teleportation beacons and targets with embedded tracking implants."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/temp = null
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=400)
	var/tracking_range = 20

/obj/item/locator/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BluespaceLocator", name)
		ui.open()

/obj/item/locator/ui_data(mob/user)
	var/list/data = list()

	data["trackingrange"] = tracking_range;

	// Get our current turf location.
	var/turf/sr = get_turf(src)

	if (sr)
		// Check every teleport beacon.
		var/list/tele_beacons = list()
		for(var/obj/item/beacon/W in GLOB.teleportbeacons)

			// Get the tracking beacon's turf location.
			var/turf/tr = get_turf(W)

			// Make sure it's on a turf and that its Z-level matches the tracker's Z-level
			if (tr && tr.z == sr.z)
				// Get the distance between the beacon's turf and our turf
				var/distance = max(abs(tr.x - sr.x), abs(tr.y - sr.y))

				// If the target is too far away, skip over this beacon.
				if(distance > tracking_range)
					continue

				var/beacon_name

				if(W.renamed)
					beacon_name = W.name
				else
					var/area/A = get_area(W)
					beacon_name = A.name

				var/D =  dir2text(get_dir(sr, tr))
				tele_beacons += list(list(name = beacon_name, direction = D, distance = distance))

		data["telebeacons"] = tele_beacons

		var/list/track_implants = list()

		for (var/obj/item/implant/tracking/W in GLOB.tracked_implants)
			if (!W.imp_in || !isliving(W.loc))
				continue
			else
				var/mob/living/M = W.loc
				if (M.stat == DEAD)
					if (M.timeofdeath + W.lifespan_postmortem < world.time)
						continue
			var/turf/tr = get_turf(W)
			var/distance = max(abs(tr.x - sr.x), abs(tr.y - sr.y))

			if(distance > tracking_range)
				continue

			var/D =  dir2text(get_dir(sr, tr))
			track_implants += list(list(name = W.imp_in.name, direction = D, distance = distance))
		data["trackimplants"] = track_implants
	return data

#define PORTAL_LOCATION_DANGEROUS "portal_location_dangerous"
#define PORTAL_DANGEROUS_EDGE_LIMIT 8

/*
 * Hand-tele
 */
/obj/item/hand_tele
	name = "hand tele"
	desc = "A portable item using blue-space technology. One of the buttons opens a portal, the other re-opens your last destination."
	icon = 'icons/obj/device.dmi'
	icon_state = "hand_tele"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=10000)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 30, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/list/active_portal_pairs
	var/max_portal_pairs = 3

	/**
	 * Represents the last place we teleported to, for making quick portals.
	 * Can be in the following states:
	 * - null, meaning either this hand tele hasn't been used yet, or the last place it was portalled to was removed.
	 * - PORTAL_LOCATION_DANGEROUS, meaning the last place it teleported to was the "None (Dangerous)" location.
	 * - A weakref to a /obj/machinery/computer/teleporter, meaning the last place it teleported to was a pre-setup location.
	*/
	var/last_portal_location

/obj/item/hand_tele/Initialize()
	. = ..()
	active_portal_pairs = list()

/obj/item/hand_tele/pre_attack(atom/target, mob/user, params)
	if(try_dispel_portal(target, user))
		return TRUE
	return ..()

/obj/item/hand_tele/proc/try_dispel_portal(atom/target, mob/user)
	if(is_parent_of_portal(target))
		qdel(target)
		to_chat(user, span_notice("You dispel [target] with \the [src]!"))
		return TRUE
	return FALSE

/obj/item/hand_tele/afterattack(atom/target, mob/user)
	try_dispel_portal(target, user)
	. = ..()

/obj/item/hand_tele/pre_attack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	var/portal_location = last_portal_location

	if (isweakref(portal_location))
		var/datum/weakref/last_portal_location_ref = last_portal_location
		portal_location = last_portal_location_ref.resolve()

	if (isnull(portal_location))
		to_chat(user, span_warning("[src] flashes briefly. No target is locked in."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	try_create_portal_to(user, portal_location)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/hand_tele/attack_self(mob/user)
	if (!can_teleport_notifies(user))
		return

	var/list/locations = list()
	for(var/obj/machinery/computer/teleporter/computer in GLOB.machines)
		var/atom/target = computer.target_ref?.resolve()
		if(!target)
			computer.target_ref = null
			continue
		var/area/computer_area = get_area(target)
		if(!computer_area || (computer_area.area_flags & NOTELEPORT))
			continue
		if(computer.power_station?.teleporter_hub && computer.power_station.engaged)
			locations["[get_area(target)] (Active)"] = computer
		else
			locations["[get_area(target)] (Inactive)"] = computer

	locations["None (Dangerous)"] = PORTAL_LOCATION_DANGEROUS

	var/teleport_location_key = input(user, "Please select a teleporter to lock in on.", "Hand Teleporter") as null|anything in locations
	if (!teleport_location_key || user.get_active_held_item() != src || user.incapacitated())
		return

	// Not always a datum, but needed for IS_WEAKREF_OF to cast properly.
	var/datum/teleport_location = locations[teleport_location_key]
	if (!try_create_portal_to(user, teleport_location))
		return

	if (teleport_location == PORTAL_LOCATION_DANGEROUS)
		last_portal_location = PORTAL_LOCATION_DANGEROUS
	else if (!IS_WEAKREF_OF(teleport_location, last_portal_location))
		if (isweakref(teleport_location))
			var/datum/weakref/about_to_replace_location_ref = last_portal_location
			var/obj/machinery/computer/teleporter/about_to_replace_location = about_to_replace_location_ref.resolve()
			if (about_to_replace_location)
				UnregisterSignal(about_to_replace_location, COMSIG_TELEPORTER_NEW_TARGET)

		RegisterSignal(teleport_location, COMSIG_TELEPORTER_NEW_TARGET, .proc/on_teleporter_new_target)

		last_portal_location = WEAKREF(teleport_location)

/// Takes either PORTAL_LOCATION_DANGEROUS or an /obj/machinery/computer/teleport/computer.
/obj/item/hand_tele/proc/try_create_portal_to(mob/user, teleport_location)
	if (active_portal_pairs.len >= max_portal_pairs)
		user.show_message(span_notice("[src] is recharging!"))
		return

	var/atom/teleport_target

	if (teleport_location == PORTAL_LOCATION_DANGEROUS)
		var/list/dangerous_turfs = list()
		for(var/turf/dangerous_turf in urange(10, orange=1))
			if(dangerous_turf.x > world.maxx - PORTAL_DANGEROUS_EDGE_LIMIT || dangerous_turf.x < PORTAL_DANGEROUS_EDGE_LIMIT)
				continue //putting them at the edge is dumb
			if(dangerous_turf.y > world.maxy - PORTAL_DANGEROUS_EDGE_LIMIT || dangerous_turf.y < PORTAL_DANGEROUS_EDGE_LIMIT)
				continue
			var/area/dangerous_area = dangerous_turf.loc
			if(dangerous_area.area_flags & NOTELEPORT)
				continue
			dangerous_turfs += dangerous_turf

		teleport_target = pick(dangerous_turfs)
	else
		var/obj/machinery/computer/teleporter/computer = teleport_location
		var/atom/target = computer.target_ref?.resolve()
		if(!target)
			computer.target_ref = null
		teleport_target = target

	if (teleport_target == null)
		to_chat(user, span_notice("[src] vibrates, then stops. Maybe you should try something else."))
		return

	var/area/teleport_area = get_area(teleport_target)
	if (teleport_area.area_flags & NOTELEPORT)
		to_chat(user, span_notice("[src] is malfunctioning."))
		return

	if (!can_teleport_notifies(user))
		return

	var/list/obj/effect/portal/created = create_portal_pair(get_turf(user), get_teleport_turf(get_turf(teleport_target)), 300, 1, null)
	if(LAZYLEN(created) != 2)
		return

	var/obj/effect/portal/portal1 = created[1]
	var/obj/effect/portal/portal2 = created[2]

	RegisterSignal(portal1, COMSIG_PARENT_QDELETING, .proc/on_portal_destroy)
	RegisterSignal(portal2, COMSIG_PARENT_QDELETING, .proc/on_portal_destroy)

	var/turf/check_turf = get_turf(get_step(user, user.dir))
	if(check_turf.CanPass(user, get_dir(check_turf, user)))
		portal1.forceMove(check_turf)
	active_portal_pairs[portal1] = portal2

	investigate_log("was used by [key_name(user)] at [AREACOORD(user)] to create a portal pair with destinations [AREACOORD(portal1)] and [AREACOORD(portal2)].", INVESTIGATE_PORTAL)
	add_fingerprint(user)

	user.show_message(span_notice("Locked in."), MSG_AUDIBLE)

	return TRUE

/obj/item/hand_tele/proc/can_teleport_notifies(mob/user)
	var/turf/current_location = get_turf(user)
	var/area/current_area = current_location.loc
	if (!current_location || (current_area.area_flags & NOTELEPORT) || is_away_level(current_location.z) || !isturf(user.loc))
		to_chat(user, span_notice("[src] is malfunctioning."))
		return FALSE

	return TRUE

/obj/item/hand_tele/proc/on_teleporter_new_target(datum/source)
	SIGNAL_HANDLER

	if (IS_WEAKREF_OF(source, last_portal_location))
		last_portal_location = null
		UnregisterSignal(source, COMSIG_TELEPORTER_NEW_TARGET)

/obj/item/hand_tele/proc/on_portal_destroy(obj/effect/portal/P)
	SIGNAL_HANDLER

	active_portal_pairs -= P //If this portal pair is made by us it'll be erased along with the other portal by the portal.

/obj/item/hand_tele/proc/is_parent_of_portal(obj/effect/portal/P)
	if(!istype(P))
		return FALSE
	if(active_portal_pairs[P])
		return SOURCE_PORTAL
	for(var/i in active_portal_pairs)
		if(active_portal_pairs[i] == P)
			return DESTINATION_PORTAL
	return FALSE

/obj/item/hand_tele/suicide_act(mob/user)
	if(iscarbon(user))
		user.visible_message(span_suicide("[user] is creating a weak portal and sticking [user.p_their()] head through! It looks like [user.p_theyre()] trying to commit suicide!"))
		var/mob/living/carbon/itemUser = user
		var/obj/item/bodypart/head/head = itemUser.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			head.drop_limb()
			var/list/safeLevels = SSmapping.levels_by_any_trait(list(ZTRAIT_SPACE_RUINS, ZTRAIT_LAVA_RUINS, ZTRAIT_STATION, ZTRAIT_MINING))
			head.forceMove(locate(rand(1, world.maxx), rand(1, world.maxy), pick(safeLevels)))
			itemUser.visible_message(span_suicide("The portal snaps closed taking [user]'s head with it!"))
		else
			itemUser.visible_message(span_suicide("[user] looks even further depressed as they realize they do not have a head...and suddenly dies of shame!"))
		return (BRUTELOSS)

#undef PORTAL_LOCATION_DANGEROUS
#undef PORTAL_DANGEROUS_EDGE_LIMIT

/*
 * Syndicate Teleporter
 */

/obj/item/teleporter
	name = "syndicate teleporter"
	desc = "A Syndicate reverse-engineered version of the Nanotrasen portable handheld teleporter. It uses bluespace technology to translocate users, but lacks the advanced safety features of its counterpart. Warranty voided if exposed to an electromagnetic pulse."
	icon = 'icons/obj/device.dmi'
	icon_state = "syndi_tele"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 4
	throw_range = 10

	var/charges = 4
	var/max_charges = 4
	var/minimum_teleport_distance = 4
	var/maximum_teleport_distance = 8
	var/saving_throw_distance = 3
	var/recharge_time = 200 //20 Seconds
	var/recharging = FALSE

/obj/item/teleporter/examine(mob/user)
	. = ..()
	. += span_notice("[src] has [charges] out of [max_charges] charges left.")

/obj/item/teleporter/attack_self(mob/user)
	..()
	attempt_teleport(user, FALSE)

/obj/item/teleporter/proc/check_charges()
	if(recharging)
		return
	if(charges < max_charges)
		addtimer(CALLBACK(src, .proc/recharge), recharge_time)
		recharging = TRUE

/obj/item/teleporter/proc/recharge()
	charges++
	recharging = FALSE
	check_charges()

/obj/item/teleporter/emp_act(severity)
	if(prob(50 / severity))
		if(istype(loc, /mob/living/carbon/human))
			var/mob/living/carbon/human/user = loc
			to_chat(user, span_danger("[src] buzzes and activates!"))
			attempt_teleport(user, TRUE) //EMP Activates a teleport with no safety.
		else
			visible_message(span_warning("[src] activates and blinks out of existence!"))
			do_sparks(2, 1, src)
			qdel(src)

/obj/item/teleporter/proc/attempt_teleport(mob/user, EMP_D = FALSE)
	if(!charges)
		to_chat(user, span_warning("[src] is still recharging."))
		return

	var/turf/current_location = get_turf(user)
	var/area/current_area = current_location.loc
	if(!current_location || !(current_area.area_flags & NOTELEPORT) || is_away_level(current_location.z) || is_centcom_level(current_location.z) || !isturf(user.loc))//If turf was not found or they're on z level 2 or >7 which does not currently exist. or if user is not located on a turf
		to_chat(user, span_notice("\The [src] is malfunctioning."))
		return

	var/mob/living/carbon/C = user
	var/teleport_distance = rand(minimum_teleport_distance,maximum_teleport_distance)
	var/turf/destination = get_teleport_loc(current_location,C,teleport_distance,0,0,0,0,0,0)
	var/list/bagholding = user.GetAllContents(/obj/item/storage/backpack/holding)

	if(isclosedturf(destination))
		if(!EMP_D && !(bagholding.len))
			panic_teleport(user, destination) //We're in a wall, engage emergency parallel teleport.
		else
			get_fragged(user, destination) //EMP teleported you into a wall? Wearing a BoH? You're dead.
	else
		telefrag(destination, user)
		do_teleport(C, destination, channel = TELEPORT_CHANNEL_FREE)
		charges--
		check_charges()
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(current_location)
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(destination)
		playsound(destination, 'sound/effects/phasein.ogg', 25, 1)
		playsound(destination, "sparks", 50, 1)

/obj/item/teleporter/proc/panic_teleport(mob/user, turf/destination)
	var/mob/living/carbon/C = user
	var/turf/mobloc = get_turf(C)
	var/turf/emergency_destination = get_teleport_loc(destination,C,0,0,1,saving_throw_distance,0,0,0)

	if(emergency_destination)
		telefrag(emergency_destination, user)
		do_teleport(C, emergency_destination, channel = TELEPORT_CHANNEL_FREE)
		charges--
		check_charges()
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(mobloc)
		new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(emergency_destination)
		playsound(emergency_destination, 'sound/effects/phasein.ogg', 25, 1)
		playsound(emergency_destination, "sparks", 50, 1)
	else //We tried to save. We failed. Death time.
		get_fragged(user, destination)

/obj/item/teleporter/proc/get_fragged(mob/user, turf/destination)
	var/turf/mobloc = get_turf(user)
	user.forceMove(destination)
	playsound(mobloc, "sparks", 50, TRUE)
	new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(mobloc)
	new /obj/effect/temp_visual/teleport_abductor/syndi_teleporter(destination)
	playsound(destination, "sparks", 50, TRUE)
	playsound(destination, "sound/magic/disintegrate.ogg", 50, TRUE)
	to_chat(user, span_userdanger("You teleport into the wall, the teleporter tries to save you, but-"))
	destination.ex_act(2) //Destroy the wall
	if (iscarbon(user))
		var/mob/living/carbon/cuser = user
		cuser.gib(FALSE,FALSE,FALSE,FALSE)

/obj/item/teleporter/proc/telefrag(turf/fragging_location, mob/user)
	for(var/mob/living/M in fragging_location)//Hit everything in the turf
		M.apply_damage(20, BRUTE)
		M.Paralyze(30)
		to_chat(M, span_userdanger("[user] teleports into you, knocking you to the floor with the bluespace wave!"))

/obj/item/paper/teleporter
	name = "Teleporter Guide"
	icon_state = "paper"
	info = {"<b>Instructions on your new prototype syndicate teleporter:</b><br>
	<br>
	This experimental teleporter will teleport the user 4-8 meters in the direction they are facing. Anything you are pulling will not be teleported with you.<br>
	<br>
	It has 4 charges, and will recharge over time. No, sticking the teleporter into the tesla, an APC, a microwave, or an electrified door will not make it charge faster.<br>
	<br>
	<b>Warning:</b> Teleporting into walls will activate a failsafe teleport parallel up to 3 meters, but the user will be ripped apart and gibbed in the wall if it fails to find a safe location.<br>
	<br>
	Do not expose the teleporter to electromagnetic pulses, or possess a bag of holding while operating it. Unwanted malfunctions may occur.
"}
/obj/item/storage/box/syndie_kit/teleporter
	name = "syndicate teleporter kit"

/obj/item/storage/box/syndie_kit/teleporter/PopulateContents()
	new /obj/item/teleporter(src)
	new /obj/item/paper/teleporter(src)

/obj/effect/temp_visual/teleport_abductor/syndi_teleporter
	duration = 5

/obj/item/teleporter/admin
	charges = 999
	max_charges = 999
