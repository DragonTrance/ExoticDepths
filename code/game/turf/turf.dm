/turf
	icon = 'icons/tiles.dmi'

/turf/floor
	icon_state = "plating"

/turf/wall
	icon_state = "r-wall"

/turf/wall/window
	icon = 'icons/wall_window.dmi'
	icon_state = "east_west"

/turf/wall/window/New()
	. = ..()
	overlays += image('icons/wall_window.dmi', icon_state = icon_state + "-o")

/turf/wall/window/two
	icon_state = "north_south"
