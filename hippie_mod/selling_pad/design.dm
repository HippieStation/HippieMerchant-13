/datum/design/board/selling
	name = "Computer Design (Cargo Hold Control Terminal)"
	desc = "Allows for the construction of circuit boards used to build a Cargo Hold Control Terminal."
	id = "selling_console"
	build_path = /obj/item/circuitboard/computer/selling_pad_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/selling_pad
	name = "Machine Design (Cargo Hold Pad)"
	desc = "The circuit board for a Cargo Hold Pad."
	id = "selling_pad"
	build_path = /obj/item/circuitboard/machine/selling_pad
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO
