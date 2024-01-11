/turf
	icon = 'icons/tiles.dmi'

/turf/floor
	icon_state = "plating"

/turf/wall
	icon_state = "r-wall"
	density = TRUE

/turf/wall/window
	icon = 'icons/wall_window.dmi'
	icon_state = "east_west"

/turf/wall/window/New()
	. = ..()
	overlays += image('icons/wall_window.dmi', icon_state = "[icon_state]-o")

/turf/wall/window/two
	icon_state = "north_south"

/turf/floor/alien_rocks
	icon_state = "alien_ground_light"

/turf/floor/alien_rocks/New()
	. = ..()
	if(rand() < 0.77) return

	overlays += image('icons/tiles.dmi', icon_state = "alien-o-[rand(1, 4)]")

/turf/wall/rock
	icon_state = "mysterious_rock"
	base_icon_state = "rock-"

/turf/wall/rock/New()
	. = ..()
	if(rand() < 0.3) return
	overlays += image(icon, icon_state = "[base_icon_state][rand(1, 3)]")

/obj/mushroom
	icon = 'icons/mushroom.dmi'
	bound_height = 96
