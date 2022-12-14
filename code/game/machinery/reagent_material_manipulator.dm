/obj/machinery/reagent_material_manipulator
	name = "\proper the material manipulation machine"
	desc = "A high tech machine that can both analyse material traits and combine material traits with each other."
	icon_state = "circuit_imprinter"
	icon = 'icons/obj/machines/research.dmi'
	density = TRUE
	anchored = TRUE
	use_power = IDLE_POWER_USE
	var/obj/item/loaded
	var/analyse_only = FALSE
	var/datum/reagent/synthesis
	var/datum/reagent/reagent_analyse
	var/list/special_traits
	var/is_bullet = FALSE//because bullets are the snowflakes


/obj/machinery/reagent_material_manipulator/Initialize()
	. = ..()
	create_reagents(100)

/obj/machinery/reagent_material_manipulator/attackby(obj/item/I, mob/living/carbon/human/user)
	if(!user.istate.harm)
		return ..()

	if(panel_open)
		to_chat(user, span_warning("You can't load the [I] while it's opened!"))
		return

	var/obj/item/forged/R //since all forged weapons have the same vars/procs this lets it compile as the actual type is assigned at runtime during this proc
	special_traits = list()

	if(istype(I, /obj/item/reagent_containers/glass/beaker))
		var/obj/item/reagent_containers/glass/beaker/W = I
		if(LAZYLEN(W.reagents.reagent_list) == 1)
			for(var/X in W.reagents.reagent_list)
				var/datum/reagent/S = X

				if(!S.can_forge)
					to_chat(user, span_warning("[S] cannot be added!"))
					return

				if(synthesis && S.type != synthesis.type)
					to_chat(user, span_warning("[src] already has a reagent of a different type, remove it before adding something else!"))
					return

				if(W.reagents.total_volume && reagents.total_volume < reagents.maximum_volume)
					to_chat(user, span_notice("You add [S] to the machine."))
					W.reagents.trans_to(src, W.reagents.total_volume)
					for(var/RS in reagents.reagent_list)
						synthesis = RS
					return
		else
			to_chat(user, span_warning("[src] only accepts one type of reagent at a time!"))
			return


	else if(istype(I, /obj/item/stack/sheet/mineral/reagent))
		R = I
		analyse_only = TRUE

	else if(istype(I, /obj/item/forged))
		R = I

	else if(istype(I, /obj/item/twohanded/forged))
		R = I

	else if(istype(I, /obj/item/ammo_casing/forged))
		R = I
		var/obj/item/ammo_casing/forged/F = I
		if(!F.loaded_projectile)//this has no bullet
			return

		if(!F.caliber)
			to_chat(user, span_warning("[I] needs to be shaped to a caliber before it can be added!"))
			return

		var/obj/projectile/bullet/forged/FB = F.loaded_projectile
		special_traits = FB.special_traits
		is_bullet = TRUE

	if(loaded)
		to_chat(user, span_warning("[src] is full!"))
		return

	if(R && R.reagent_type)//we move it out of their hands and store it as a 'ghost' object
		user.dropItemToGround(R)
		R.forceMove(get_turf(src))
		R.invisibility = INVISIBILITY_ABSTRACT
		R.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		R.anchored = TRUE
		loaded = R
		reagent_analyse = R.reagent_type
		if(analyse_only)//used by ingots and other non weapons without their own seperate list of instantiated traits
			for(var/D in reagent_analyse.special_traits)
				var/datum/special_trait/S = new D
				LAZYADD(special_traits, S)
		else if(!is_bullet)
			special_traits = R.special_traits

	else
		..()

/obj/machinery/reagent_material_manipulator/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		if(synthesis)
			. += "There's [synthesis.volume] units of [synthesis.name] in it."
		if(synthesis && synthesis.special_traits)
			for(var/D in synthesis.special_traits)
				var/datum/special_trait/S = new D
				. += "The [synthesis.name] has the [S.name] trait. [S.desc]"
		if(loaded)
			. += "There's a [loaded.name] inside of the machine."


/obj/machinery/reagent_material_manipulator/interact(mob/user)
	. = ..()
	var/warning = tgui_alert(user, "How would you like to operate the machine?","Operate Reagent Manipulator", list("Eject Weapon", "Flash freeze reagents", "Add Trait"))
	switch(warning)
		if("Eject Weapon")
			if(loaded)
				loaded.forceMove(get_turf(usr))
				loaded.invisibility = initial(loaded.invisibility)
				loaded.mouse_opacity = initial(loaded.mouse_opacity)
				loaded.anchored = initial(loaded.anchored)
				to_chat(usr, span_notice("You eject [loaded]."))
				loaded = null
				reagent_analyse = null
				special_traits = null
				analyse_only = FALSE
				is_bullet = FALSE
				return TRUE
		if("Flash freeze reagents")
			if(synthesis)
				synthesis.reagent_state = SOLID
				var/obj/item/reagent_containers/food/solid_reagent/Sr = new /obj/item/reagent_containers/food/solid_reagent(src.loc)
				Sr.reagents.add_reagent(synthesis.type, synthesis.volume)
				Sr.reagent_type = synthesis.type
				Sr.name = "solidified [synthesis.name]"
				Sr.add_atom_colour(color, FIXED_COLOUR_PRIORITY)
				Sr.color = synthesis.color
				to_chat(usr, span_notice("[synthesis] is flash frozen and dispensed out of the machine in the form of a solid bar!"))
				synthesis = null
				reagents.clear_reagents()
				return TRUE

		if("Add Trait")
			if(loaded && synthesis && reagent_analyse)
				if(reagents.total_volume < 50)
					to_chat(usr, span_warning("You need at least [SPECIAL_TRAIT_ADD_COST] units of [synthesis] to add a trait!"))
					return

				if(analyse_only)
					to_chat(usr, span_warning("The machine is locked in analyse only mode, perhaps you are trying to modify the traits of a reagent directly?"))
					return

				if(LAZYLEN(special_traits) >= SPECIAL_TRAIT_MAXIMUM)
					to_chat(usr, span_warning("[loaded] has too many special traits already!"))
					return

				var/obj/item/forged/R
				if(istype(loaded, /obj/item/forged))
					R = loaded

				else if(istype(loaded, /obj/item/twohanded/forged))
					R = loaded

				else if(istype(loaded, /obj/item/ammo_casing/forged))
					var/obj/item/ammo_casing/forged/F = loaded
					if(!F.loaded_projectile)//this has no bullet
						return
					R = F.loaded_projectile

				if(!R)
					return
				for(var/I in synthesis.special_traits)
					var/datum/special_trait/D = new I
					if(locate(D) in R.special_traits)
						to_chat(usr, span_warning("[R] already has the [D] trait!"))
					else
						R.special_traits += D//doesn't work with lazyadd due to type mismatch (it checks for an explicitly initialized list)
						R.speed += SPECIAL_TRAIT_ADD_SPEED_DEBUFF
						D.on_apply(R, R.identifier)
						reagents.remove_any(SPECIAL_TRAIT_ADD_COST)
						to_chat(usr, span_notice("You add the trait [D] to [R]."))
