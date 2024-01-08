/atom/movable
	step_size = 64

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
