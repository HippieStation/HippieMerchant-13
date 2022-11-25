/datum/job/disc_jockey
	title = "Disc Jockey"
	department_head = list("Head of Personnel")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#bbe291"

	outfit = /datum/outfit/job/disc_jockey
	plasmaman_outfit = /datum/outfit/plasmaman/disc_jockey

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_DISC_JOCKEY
	bounty_types = CIV_JOB_RANDOM
	departments = DEPARTMENT_SERVICE

	family_heirlooms = list(/obj/item/clothing/head/bearpelt)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE


/datum/outfit/job/disc_jockey
	name = "Disc Jockey"
	head = /obj/item/clothing/head/helmet/daftpunk1
	jobtype = /datum/job/disc_jockey
	belt = /obj/item/pda/disc_jockey
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/disc_jockey/telvis
	shoes = /obj/item/clothing/shoes/funk
	id_trim = /datum/id_trim/job/disc_jockey
