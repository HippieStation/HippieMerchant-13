/datum/job/svsblue_admiral
	title = "Blue Team Admiral"
	faction = FACTION_SVS
	total_positions = 1
	spawn_positions = 1
	supervisors = "Yourself"
	selection_color = "#0000ff"
	display_order = JOB_DISPLAY_ORDER_BLUE_TEAM_ADMIRAL

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_BLUE
	outfit = /datum/outfit/job/svs/blue/admiral
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

/datum/job/svsred_admiral
	title = "Red Team Admiral"
	faction = FACTION_SVS
	total_positions = 1
	spawn_positions = 1
	supervisors = "Yourself"
	selection_color = "#ff0000"
	display_order = JOB_DISPLAY_ORDER_RED_TEAM_ADMIRAL

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_RED
	outfit = /datum/outfit/job/svs/red/admiral
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

/datum/outfit/job/svs/blue/admiral
	name = "SVS Blue Admiral Outfit"
	uniform = /obj/item/clothing/under/rank/civilian/head_of_personnel
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	gloves = /obj/item/clothing/gloves/color/black
	glasses = /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/hopcap
	l_pocket = /obj/item/melee/transforming/energy/sword/saber/blue
	r_pocket = /obj/item/melee/classic_baton/telescopic
	suit_store = /obj/item/gun/energy/e_gun
	backpack_contents = list(/obj/item/melee/baton/stungun=1)
	jobtype = /datum/job/svsblue_admiral
	id = /obj/item/card/id/advanced/gold
	id_trim = /datum/id_trim/job/captain/blue_team_admiral

/datum/outfit/job/svs/red/admiral
	name = "SVS Red Admiral Outfit"
	uniform = /obj/item/clothing/under/rank/security/head_of_security
	suit = /obj/item/clothing/suit/armor/vest
	gloves = /obj/item/clothing/gloves/color/black
	glasses = /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/hos
	l_pocket = /obj/item/melee/transforming/energy/sword/saber/red
	r_pocket = /obj/item/melee/classic_baton/telescopic
	suit_store = /obj/item/gun/energy/e_gun
	backpack_contents = list(/obj/item/melee/baton/stungun=1)
	jobtype = /datum/job/svsred_admiral
	id = /obj/item/card/id/advanced/gold
	id_trim = /datum/id_trim/job/captain/red_team_admiral

/datum/outfit/job/svs/blue/admiral/post_equip(mob/living/carbon/human/H)
	..()
	var/obj/item/radio/R = H.ears
	R.use_command = TRUE
	R.command = TRUE

/datum/outfit/job/svs/red/admiral/post_equip(mob/living/carbon/human/H)
	..()
	var/obj/item/radio/R = H.ears
	R.use_command = TRUE
	R.command = TRUE
