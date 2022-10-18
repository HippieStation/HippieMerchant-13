/mob/living/simple_animal/hostile/retaliate/clowndola
	name = "clowndola"
	real_name = "clowndola"
	desc = "Clowndola is the noisy walker. Having no hands he embodies the Taoist principle of honk (HonkMother) while his smiling facial expression shows his utter and complete acceptance of the world as it is. Its hide is extremely valuable."
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "kicks"
	icon_state = "clowndola"
	icon_living = "clowndola"
	icon_dead = "clowndola_dead"
	icon = 'icons/mob/gondolas.dmi'
	//Clowndolas aren't affected by cold.
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1000
	maxHealth = 100
	health = 100
	attack_sound = list('sound/items/airhorn2.ogg', 'sound/items/airhorn.ogg', 'sound/items/carhorn.ogg', 'sound/items/bikehorn.ogg')
	speak_chance = 20
	turns_per_move = 1
	maxHealth = 80
	health = 80
	butcher_results = list(/obj/effect/decal/cleanable/blood/gibs, /obj/item/stack/sheet/animalhide/gondola = 1, /obj/item/food/meat/slab/clowndola = 2)
	obj_damage = 0
	harm_intent_damage = 1
	melee_damage_lower = 1
	melee_damage_upper = 1.5
	attack_same = 0
	attack_verb_simple = "honks at"
	faction = list("clowndola")
	environment_smash = ENVIRONMENT_SMASH_NONE
	mouse_opacity = MOUSE_OPACITY_ICON
	vision_range = 13
	speed = 0
	robust_searching = 1
	unique_name = 1
	speak_emote = list("honk!", "Honk?", "HONK HONK")
	deathmessage = "honked for the last time..."
	rapid_melee = 3
	var/poison_per_bite = 0.5
	var/poison_type = /datum/reagent/drug/happiness

/mob/living/simple_animal/hostile/retaliate/clowndola/Initialize()
	. = ..()
	if(poison_per_bite)
		AddElement(/datum/element/venomous, poison_type, poison_per_bite)

/mob/living/simple_animal/hostile/retaliate/clowndola/Life()
	if(health <= maxHealth/2)		//If life is inferior as 50%, becomes angry, otherwise is happy
		poison_type = /datum/reagent/consumable/superlaughter
		poison_per_bite = 1
		speed = -5
		harm_intent_damage = 1
	else
		poison_type = /datum/reagent/drug/happiness
		poison_per_bite = 0.5
		speed = 0
		harm_intent_damage = 0.5

/mob/living/simple_animal/hostile/retaliate/clowndola/examine(mob/user)
	. = ..()
	if(health >= maxHealth)
		. += "<span class='info'>It looks healthy and smile for no apparent reason.</span>"
	else
		. += "<span class='info'>It looks like it's been roughed up.</span>"

/mob/living/simple_animal/hostile/retaliate/clowndola/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if(!retreat_distance && prob(20))
		retreat_distance = 5
		addtimer(CALLBACK(src, .proc/stop_retreat), 20)
	. = ..()

/mob/living/simple_animal/hostile/retaliate/clowndola/proc/stop_retreat()
	retreat_distance = null
