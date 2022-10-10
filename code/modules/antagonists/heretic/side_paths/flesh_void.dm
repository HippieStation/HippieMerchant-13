/datum/eldritch_knowledge/void_cloak
	name = "Void Cloak"
	desc = "Allows you to transmute a glass shard, a bedsheet, and any outer clothing item (such as armor or a suit jacket) \
		to create a Void Cloak. While the hood is down, the cloak functions as a focus, \
		and while the hood is up, the cloak is completely invisible. It also provide decent armor and \
		has pockets which can hold one of your blades, various ritual components (such as organs), and small heretical trinkets."
	gain_text = "Owl is the keeper of things that quite not are in practice, but in theory are."
	cost = 1
	next_knowledge = list(/datum/eldritch_knowledge/limited_amount/flesh_ghoul,/datum/eldritch_knowledge/cold_snap)
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/void)
	required_atoms = list(
		/obj/item/shard = 1,
		/obj/item/clothing/suit = 1,
		/obj/item/bedsheet = 1,
		)
	route = PATH_SIDE

/datum/eldritch_knowledge/spell/blood_siphon
	name = "Blood Siphon"
	gain_text = "No matter the man, we bleed all the same. That's what the Marshal told me."
	desc = "You gain a spell that drains health from your enemies to restores your own."
	cost = 1
	spell_to_add = /obj/effect/proc_holder/spell/pointed/blood_siphon
	next_knowledge = list(/datum/eldritch_knowledge/summon/stalker,/datum/eldritch_knowledge/spell/void_pull)
	route = PATH_SIDE

/datum/eldritch_knowledge/spell/cleave
	name = "Blood Cleave"
	gain_text = "At first I didn't understand these instruments of war, but the priest told me to use them regardless. Soon, he said, I would know them well."
	desc = "Gives AOE spell that causes heavy bleeding and blood loss."
	cost = 1
	spell_to_add = /obj/effect/proc_holder/spell/pointed/cleave
	next_knowledge = list(/datum/eldritch_knowledge/spell/entropic_plume,/datum/eldritch_knowledge/spell/flame_birth)
	route = PATH_SIDE
