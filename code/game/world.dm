

/world
	fps = 12        // Update rate of the server
	icon_size = 64  // Every icon in this game is 64x64

	view = "8x8"    //Because of how ISOMETRIC_MAP works, this will always be widescreen proportions
	map_format = ISOMETRIC_MAP //yeah we gay keep scrollin
	mob = /mob/player
	movement_mode = TILE_MOVEMENT_MODE

//TODO: I'm ambitious, and I want to have 8 directions for every tile and entity (this is a lot of work, i know)
//However, your client will crash if the facing direction is bicardinal (like facing northeast)
//I'm not sure how I'm going to fight this just yet, it'd probably be dumb as hell but I would really enjoy it if it worked

/obj
	step_size = 16

/obj/player_start

/turf
	icon = 'icons/tiles.dmi'

/turf/wall
	icon_state = "wall"
	density = TRUE
