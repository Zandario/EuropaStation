/obj/item/weapon/grenade/spawnergrenade
	desc = "It is set to detonate in 5 seconds. It will unleash unleash an unspecified anomaly into the vicinity."
	name = "delivery grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "delivery"
	item_state = "flashbang"
	var/spawner_type = null // must be an object path
	var/deliveryamt = 1 // amount of type to deliver
	var/list/newvars

/obj/item/weapon/grenade/spawnergrenade/detonate()
	if(spawner_type && deliveryamt)
		var/turf/T = get_turf(src)
		playsound(T, 'sound/effects/phasein.ogg', 100, 1)
		for(var/mob/living/carbon/human/M in viewers(T, null))
			if(M.eyecheck() < FLASH_PROTECTION_MODERATE)
				M.flash_eyes()
		for(var/i=1, i<=deliveryamt, i++)
			var/atom/movable/x = new spawner_type
			if(newvars && length(newvars))
				for(var/v in newvars)
					x.vars[v] = newvars[v]
			x.dropInto(loc)
			if(prob(50))
				for(var/j = 1, j <= rand(1, 3), j++)
					step(x, pick(NORTH,SOUTH,EAST,WEST))
		qdel(src)
