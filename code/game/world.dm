

/world
	fps = 60        // Update rate of the server
	icon_size = 64  // Every tile is 64x64,and sprites will be scaled accordingly

	view = "8x8"    //Because of how ISOMETRIC_MAP works, this will always be widescreen proportions
	map_format = ISOMETRIC_MAP //yeah we gay keep scrollin
	mob = /mob/player
	movement_mode = TILE_MOVEMENT_MODE

//TODO: I'm ambitious, and I want to have 8 directions for every tile and entity (this is a lot of work, i know)
//However, your client will crash if the facing direction is bicardinal (like facing northeast)
//I'm not sure how I'm going to fight this just yet, it'd probably be dumb as hell but I would really enjoy it if it worked

/world/New()
	. = ..()
	while(TRUE)
		for(var/i in 1 to length(g_AllClients))
			var/k = g_AllClients[i]
			var/client/C = g_AllClients[k]
			C.keyLoop()
		sleep(tick_lag)
