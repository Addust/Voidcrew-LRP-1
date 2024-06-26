/obj/item/gun/ballistic/rifle
	name = "Bolt Rifle"
	desc = "Some kind of bolt-action rifle. You get the feeling you shouldn't have this."
	icon = 'icons/obj/guns/48x32guns.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "hunting"
	item_state = "hunting"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	bolt_wording = "bolt"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/weapons/gun/rifle/bolt_in.ogg'
	tac_reloads = FALSE
	weapon_weight = WEAPON_MEDIUM
	pickup_sound =  'sound/items/handling/rifle_pickup.ogg'

	spread = -1
	recoil = -3

/obj/item/gun/ballistic/rifle/update_overlays()
	. = ..()
	. += "[icon_state]_bolt[bolt_locked ? "_locked" : ""]"

/obj/item/gun/ballistic/rifle/rack(mob/user = null)
	if (bolt_locked == FALSE)
		to_chat(user, "<span class='notice'>You open the bolt of \the [src].</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE)
		bolt_locked = TRUE
		update_icon()
		return
	drop_bolt(user)

/obj/item/gun/ballistic/rifle/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	return ..()

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_locked ? "open" : "closed"]."

///////////////////////
// BOLT ACTION RIFLE //
///////////////////////

/obj/item/gun/ballistic/rifle/boltaction
	name = "\improper Mosin Nagant"
	desc = "This piece of junk looks like something that could have been used 700 years ago. It feels slightly moist."
	sawn_desc = "An extremely sawn-off Mosin Nagant, popularly known as an \"obrez\". There was probably a reason it wasn't manufactured this short to begin with."
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	icon = 'icons/obj/guns/48x32guns.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	icon_state = "moistnugget"
	item_state = "moistnugget"
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	can_bayonet = TRUE
	knife_x_offset = 27
	knife_y_offset = 13
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/rifle/boltaction/enchanted
	name = "enchanted bolt action rifle"
	desc = "Careful not to lose your head."
	var/guns_left = 30
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enchanted
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/enchanted/arcane_barrage
	name = "arcane barrage"
	desc = "Pew Pew Pew."
	fire_sound = 'sound/weapons/emitter.ogg'
	pin = /obj/item/firing_pin/magic
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "arcane_barrage"
	item_state = "arcane_barrage"
	slot_flags = null
	can_bayonet = FALSE
	item_flags = NEEDS_PERMIT | DROPDEL | ABSTRACT | NOBLUDGEON
	flags_1 = NONE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enchanted/arcane_barrage

/obj/item/gun/ballistic/rifle/boltaction/enchanted/dropped()
	. = ..()
	guns_left = 0

/obj/item/gun/ballistic/rifle/boltaction/enchanted/proc/discard_gun(mob/living/user)
	user.throw_item(pick(oview(7,get_turf(user))))

/obj/item/gun/ballistic/rifle/boltaction/enchanted/arcane_barrage/discard_gun(mob/living/user)
	qdel(src)

/obj/item/gun/ballistic/rifle/boltaction/enchanted/attack_self()
	return

/obj/item/gun/ballistic/rifle/boltaction/enchanted/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(guns_left)
		var/obj/item/gun/ballistic/rifle/boltaction/enchanted/gun = new type
		gun.guns_left = guns_left - 1
		discard_gun(user)
		user.swap_hand()
		user.put_in_hands(gun)
	else
		user.dropItemToGround(src, TRUE)

/obj/item/gun/ballistic/rifle/illestren
	name = "\improper HP Illestren"
	desc = "A sturdy and conventional bolt-action rifle. One of Hunter's Pride's most successful firearms, the Illestren is popular among colonists, pirates, snipers, and countless others. Chambered in 8x50mmR."
	sawn_desc = "An Illestren rifle sawn down to a ridiculously small size. There was probably a reason it wasn't made this short to begin with, but it still packs a punch."
	eject_sound = 'sound/weapons/gun/rifle/vickland_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/vickland_unload.ogg'
	icon_state = "illestren"
	item_state = "illestren"
	internal_magazine = FALSE
	mag_type = /obj/item/ammo_box/magazine/illestren_a850r
	eject_sound_vary = FALSE
	can_be_sawn_off = TRUE

/obj/item/gun/ballistic/rifle/illestren/sawoff(mob/user)
	. = ..()
	if(.)
		spread = 36
		can_bayonet = FALSE
		item_state = "illestren_sawn"
		mob_overlay_state = item_state
		weapon_weight = WEAPON_MEDIUM //you can fire it onehanded, makes it worse than worse than useless onehanded, but you can

/obj/item/gun/ballistic/rifle/illestren/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/rifle/illestren/factory
	desc = "A sturdy and conventional bolt-action rifle. One of Hunter's Pride's most successful firearms, this example has been kept in excellent shape and may as well be fresh out of the workshop. Chambered in 8x50mmR."
	icon_state = "illestren_factory"
	item_state = "illestren_factory"

/obj/item/gun/ballistic/rifle/illestren/sawoff(mob/user)
	. = ..()
	if(.)
		item_state = "illestren_factory_sawn"
		mob_overlay_state = item_state

/obj/item/gun/ballistic/rifle/solgov
	name = "SSG-669C"
	desc = "A bolt-action sniper rifle used by Solarian troops. Beloved for its rotary design and accuracy. Chambered in 8x58mm Caseless."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	icon_state = "ssg669c"
	item_state = "ssg669c"
	fire_sound = 'sound/weapons/gun/rifle/ssg669c.ogg'
	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	spread = -5
	recoil = 0
/obj/item/gun/ballistic/rifle/scout
	name = "HP Scout"
	desc = "A powerful bolt-action rifle usually given to mercenary hunters of the Saint-Roumain Militia, equally suited for taking down big game or two-legged game. Chambered in .300 Magnum."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/smile
	fire_sound = 'sound/weapons/gun/rifle/scout.ogg'

	rack_sound = 'sound/weapons/gun/rifle/scout_bolt_out.ogg'
	bolt_drop_sound = 'sound/weapons/gun/rifle/scout_bolt_in.ogg'
	icon_state = "scout"
	item_state = "scout"
	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

/obj/item/gun/ballistic/rifle/illestren/enchanted
	name = "enchanted bolt-action rifle"
	desc = "Careful not to lose your head."
	var/guns_left = 30
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enchanted
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/illestren/enchanted/arcane_barrage
	name = "arcane barrage"
	desc = "Pew Pew Pew."
	fire_sound = 'sound/weapons/emitter.ogg'
	pin = /obj/item/firing_pin/magic
	icon = 'icons/obj/guns/projectile.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "arcane_barrage"
	item_state = "arcane_barrage"
	slot_flags = null
	can_bayonet = FALSE
	item_flags = NEEDS_PERMIT | DROPDEL | ABSTRACT | NOBLUDGEON
	flags_1 = NONE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enchanted/arcane_barrage

/obj/item/gun/ballistic/rifle/illestren/enchanted/dropped()
	. = ..()
	guns_left = 0

/obj/item/gun/ballistic/rifle/illestren/enchanted/proc/discard_gun(mob/living/user)
	user.throw_item(pick(oview(7,get_turf(user))))

/obj/item/gun/ballistic/rifle/illestren/enchanted/arcane_barrage/discard_gun(mob/living/user)
	qdel(src)

/obj/item/gun/ballistic/rifle/illestren/enchanted/attack_self()
	return

/obj/item/gun/ballistic/rifle/illestren/enchanted/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(guns_left)
		var/obj/item/gun/ballistic/rifle/illestren/enchanted/gun = new type
		gun.guns_left = guns_left - 1
		discard_gun(user)
		user.swap_hand()
		user.put_in_hands(gun)
	else
		user.dropItemToGround(src, TRUE)

/obj/item/gun/ballistic/rifle/polymer
	name = "polymer survivor rifle"
	desc = "A bolt-action rifle made of scrap, desperation, and luck. Likely to shatter at any moment. Chambered in .300 Blackout."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "crackhead_rifle"
	item_state = "crackhead_rifle"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/polymer
	can_be_sawn_off = FALSE
