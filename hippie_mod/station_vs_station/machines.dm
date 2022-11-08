/obj/machinery/svs


/obj/machinery/svs/nexus
	name = "Nexus"
	desc = "A nexus for one of the teams. If this is destroyed, it will net the opposing team a point."
	icon = 'icons/obj/device.dmi'
	icon_state = "syndbeacon"
	max_integrity = 600
	density = TRUE

/obj/machinery/svs/nexus/red
	name = "Red Nexus"
	desc = "Red Team's nexus. If it is destroyed, Blue Team will earn a point."

/obj/machinery/svs/nexus/blue
	name = "Blue Nexus"
	desc = "Blue Team's nexus. If it is destroyed, Red Team will earn a point."
	icon_state = "bluebeacon"
