/mob
	var/atom/movable/focus

/mob/New()
	. = ..()
	focus = src

/mob/player
	icon = 'icons/player.dmi'


/mob/player/Login()
	. = ..()
	var/atom/start = locate(/obj/player_start)
	if(start) loc = start.loc

/mob/player/verb/Turn_View_Counterclockwise()
	var client/c = usr.client
	c.dir = GetClockwiseDirection(c.dir, CF_COUNTERCLOCKWISE | CF_CARDINALS)

/mob/player/verb/Turn_View_Clockwise()
	var client/c = usr.client
	c.dir = GetClockwiseDirection(c.dir, CF_CARDINALS)


/atom/movable/keyLoop(client/user)
	if(!user) return
	var/movement_dir = 0
	for(var/key in user.keys_held)
		movement_dir = movement_dir | user.movement_keys[key]

	// Sanity checks in case you hold left and right and up to make sure you only go up
	if((movement_dir & NORTH) && (movement_dir & SOUTH))
		movement_dir &= ~(NORTH|SOUTH)
	if((movement_dir & EAST) && (movement_dir & WEST))
		movement_dir &= ~(EAST|WEST)


	if(movement_dir) //If we're not moving, don't compensate, as byond will auto-fill dir otherwise
		movement_dir = turn(movement_dir, -dir2angle(user.dir)) //By doing this we ensure that our input direction is offset by the client (camera) direction

	user.Move(get_step(src, movement_dir), movement_dir)
