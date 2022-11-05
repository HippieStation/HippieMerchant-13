/datum/job/svsblue_admiral
	title = "Blue Team Admiral"
	faction = FACTION_SVS
	total_positions = 1
	spawn_positions = 1
	supervisors = "Yourself"
	selection_color = "#0000ff"

	outfit = /datum/outfit/job/svs/blue/admiral

/datum/job/svsred_admiral
	title = "Red Team Admiral"
	faction = FACTION_SVS
	total_positions = 1
	spawn_positions = 1
	supervisors = "Yourself"
	selection_color = "#ff0000"

	outfit = /datum/outfit/job/svs/red/admiral

/datum/outfit/job/svs/blue/admiral
	name = "SVS Blue Admiral Outfit"
	uniform = /obj/item/clothing/under/rank/civilian/head_of_personnel
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	jobtype = /datum/job/svsblue_admiral
	id = /obj/item/card/id/advanced/gold
	id_trim = /datum/id_trim/job/captain/admiral/blue

/datum/outfit/job/svs/red/admiral
	name = "SVS Red Admiral Outfit"
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt
	suit = /obj/item/clothing/suit/armor/hos
	jobtype = /datum/job/svsred_admiral
	id = /obj/item/card/id/advanced/gold
	id_trim = /datum/id_trim/job/captain/admiral/red

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
