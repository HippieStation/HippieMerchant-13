/datum/job/svsblue
	title = "Blue Team Member"
	department_head = list("Blue Team Admiral")
	departments = DEPARTMENT_ENGINEERING | DEPARTMENT_SECURITY
	faction = FACTION_SVS
	total_positions = 9999 // hacky, but eh
	spawn_positions = 9999
	supervisors = "The Blue Team Admiral"
	selection_color = "#0000ff"

	outfit = /datum/outfit/job/svs/blue

/datum/job/svsred
	title = "Red Team Member"
	department_head = list("Red Team Admiral")
	departments = DEPARTMENT_ENGINEERING | DEPARTMENT_SECURITY
	faction = FACTION_SVS
	total_positions = 9999
	spawn_positions = 9999
	supervisors = "The Red Team Admiral"
	selection_color = "#ff0000"

	outfit = /datum/outfit/job/svs/red

/datum/outfit/job/svs
	name = "Station Versus Station Base Outfit"
	ears = /obj/item/radio/headset
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/svs/blue
	name = "SVS Blue Team Outfit"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	jobtype = /datum/job/svsblue
	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/team_member/blue

/datum/outfit/job/svs/red
	name = "SVS Red Team Outfit"
	uniform = /obj/item/clothing/under/rank/security/officer
	jobtype = /datum/job/svsred
	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/team_member/red

/datum/outfit/job/svs/blue/post_equip(mob/living/carbon/human/H)
	..()
	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CTF_BLUE)
	R.freqlock = TRUE
	R.independent = TRUE

/datum/outfit/job/svs/red/post_equip(mob/living/carbon/human/H)
	..()
	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CTF_RED)
	R.freqlock = TRUE
	R.independent = TRUE
