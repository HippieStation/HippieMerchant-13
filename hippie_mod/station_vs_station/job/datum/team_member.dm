/datum/job/svsblue
	title = "Blue Team Member"
	department_head = list("Blue Team Admiral")
	departments = DEPARTMENT_ENGINEERING | DEPARTMENT_SECURITY
	faction = FACTION_SVS
	total_positions = 9999 // hacky, but eh
	spawn_positions = 9999
	supervisors = "The Blue Team Admiral"
	selection_color = "#0000ff"
	display_order = JOB_DISPLAY_ORDER_BLUE_TEAM_MEMBER

	paycheck = PAYCHECK_ASSISTANT
	paycheck_department = ACCOUNT_BLUE
	outfit = /datum/outfit/job/svs/blue
	plasmaman_outfit = /datum/outfit/plasmaman
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

/datum/job/svsred
	title = "Red Team Member"
	department_head = list("Red Team Admiral")
	departments = DEPARTMENT_ENGINEERING | DEPARTMENT_SECURITY
	faction = FACTION_SVS
	total_positions = 9999
	spawn_positions = 9999
	supervisors = "The Red Team Admiral"
	selection_color = "#ff0000"
	display_order = JOB_DISPLAY_ORDER_RED_TEAM_MEMBER

	paycheck = PAYCHECK_ASSISTANT
	paycheck_department = ACCOUNT_RED
	outfit = /datum/outfit/job/svs/red
	plasmaman_outfit = /datum/outfit/plasmaman
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

/datum/outfit/job/svs
	name = "Station Versus Station Base Outfit"
	ears = /obj/item/radio/headset
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/svs/blue
	name = "SVS Blue Team Outfit"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	head = /obj/item/clothing/head/redcoat
	jobtype = /datum/job/svsblue
	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/blue_team_member

/datum/outfit/job/svs/red
	name = "SVS Red Team Outfit"
	uniform = /obj/item/clothing/under/rank/security/officer
	head = /obj/item/clothing/head/redcoat
	jobtype = /datum/job/svsred
	id = /obj/item/card/id/advanced/silver
	id_trim = /datum/id_trim/job/red_team_member

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
