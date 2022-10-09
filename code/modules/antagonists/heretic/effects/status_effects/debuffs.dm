//RUST
/datum/status_effect/corrosion_curse
	id = "corrosion_curse"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	tick_interval = 1 SECONDS

/datum/status_effect/corrosion_curse/on_creation(mob/living/new_owner, ...)
	. = ..()
	to_chat(owner, span_danger("Your feel your body starting to break apart..."))

/datum/status_effect/corrosion_curse/tick()
	. = ..()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	var/chance = rand(0,100)
	switch(chance)
		if(0 to 19)
			H.vomit()
		if(20 to 29)
			H.Dizzy(10)
		if(30 to 39)
			H.adjustOrganLoss(ORGAN_SLOT_LIVER,5)
		if(40 to 49)
			H.adjustOrganLoss(ORGAN_SLOT_HEART,5)
		if(50 to 59)
			H.adjustOrganLoss(ORGAN_SLOT_STOMACH,5)
		if(60 to 69)
			H.adjustOrganLoss(ORGAN_SLOT_EYES,10)
		if(70 to 79)
			H.adjustOrganLoss(ORGAN_SLOT_EARS,10)
		if(80 to 89)
			H.adjustOrganLoss(ORGAN_SLOT_LUNGS,10)
		if(90 to 99)
			H.adjustOrganLoss(ORGAN_SLOT_TONGUE,10)
		if(100)
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN,20)

/datum/status_effect/cloudstruck
	id = "cloudstruck"
	status_type = STATUS_EFFECT_REPLACE
	duration = 3 SECONDS
	on_remove_on_mob_delete = TRUE
	///This overlay is applied to the owner for the duration of the effect.
	var/mutable_appearance/mob_overlay

/datum/status_effect/cloudstruck/on_creation(mob/living/new_owner, set_duration)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()

/datum/status_effect/cloudstruck/on_apply()
	mob_overlay = mutable_appearance('icons/effects/eldritch.dmi', "cloud_swirl", ABOVE_MOB_LAYER)
	owner.overlays += mob_overlay
	owner.update_appearance()
	ADD_TRAIT(owner, TRAIT_BLIND, STATUS_EFFECT_TRAIT)
	return TRUE

/datum/status_effect/cloudstruck/on_remove()
	. = ..()
	if(QDELETED(owner))
		return
	REMOVE_TRAIT(owner, TRAIT_BLIND, STATUS_EFFECT_TRAIT)
	if(owner)
		owner.overlays -= mob_overlay
		owner.update_appearance()

/datum/status_effect/cloudstruck/Destroy()
	. = ..()
	QDEL_NULL(mob_overlay)

// AMOK
/datum/status_effect/amok
	id = "amok"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	duration = 10 SECONDS
	tick_interval = 1 SECONDS

/datum/status_effect/amok/on_apply(mob/living/afflicted)
	. = ..()
	to_chat(owner, span_boldwarning("You feel filled with a rage that is not your own!"))

/datum/status_effect/amok/tick()
	. = ..()
	var/prev_combat_mode = owner.combat_mode
	owner.set_combat_mode(TRUE)

	var/list/mob/living/targets = list()
	for(var/mob/living/potential_target in oview(owner, 1))
		if(IS_HERETIC_OR_MONSTER(potential_target))
			continue
		targets += potential_target
	if(LAZYLEN(targets))
		owner.log_message(" attacked someone due to the amok debuff.", LOG_ATTACK) //the following attack will log itself
		owner.ClickOn(pick(targets))
	owner.set_combat_mode(prev_combat_mode)
