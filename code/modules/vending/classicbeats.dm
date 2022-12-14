/obj/machinery/vending/classicbeats
	name = "\improper Cuban Pete's Classic Beats"
	desc = "music."
	icon_state = "classicbeats"
	icon_deny = "engi-deny"
	product_slogans = "Now you too can be the master of the rumba beat!"
	product_ads = "Chick-Chicky Boom,Chick-Chicky Boom!;Take a lesson from Cuban Pete!;Its very nice,So full of spice!;Singin a song,All the day long!"
	vend_reply = "Thank you for choosing Cuban Pete's"
	light_color = LIGHT_COLOR_SLIME_LAMP
	req_access = list(ACCESS_DISC_JOCKEY)
	products = list(/obj/item/instrument/violin=3,
					/obj/item/instrument/piano_synth=3,
					/obj/item/instrument/banjo=3,
					/obj/item/instrument/guitar=3,
					/obj/item/instrument/eguitar=3,
					/obj/item/instrument/glockenspiel=3,
					/obj/item/instrument/accordion=3,
					/obj/item/instrument/trumpet=3,
					/obj/item/instrument/saxophone=3,
					/obj/item/instrument/trombone=3,
					/obj/item/instrument/recorder=3,
					/obj/item/instrument/bikehorn=3)
	contraband = list(/obj/item/instrument/piano_synth/headphones/spacepods=1,
					/obj/item/instrument/saxophone/spectral=1,
					/obj/item/instrument/trumpet/spectral=1,
					/obj/item/instrument/violin/golden=1)
	premium = list(/obj/item/instrument/musicalmoth=1)

	refill_canister = /obj/item/vending_refill/classicbeats
	default_price = PAYCHECK_ASSISTANT
	extra_price = PAYCHECK_HARD
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/classicbeats
	machine_name = "Cuban Pete's Classic Beats"
	icon_state = "refill_engi"
