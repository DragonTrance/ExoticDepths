//Accepts an integer as input and returns a text version based on direction flags
proc/DirectionToString(direction)
	var/name = ""

	if(direction & SOUTH) name += "SOUTH"
	else if(direction & NORTH) name += "NORTH"

	if(direction & WEST) name += "WEST"
	else if(direction & EAST) name += "EAST"

	return name

proc/GetClockwiseDirection(starting_direction, use_flags)
	var/list/directions
	if((use_flags & CF_CARDINALS) && (use_flags & CF_BICARDINALS))
		directions = g_all_clockwise_dirs
	else if(use_flags & CF_CARDINALS)
		directions = g_clockwise_cardinals
	else if(use_flags & CF_BICARDINALS)
		directions = g_clockwise_bicardinals

	if(!directions) directions = g_clockwise_cardinals

	var/wanted_dir = 1
	if(use_flags & CF_COUNTERCLOCKWISE) wanted_dir = -1

	//Yeah, we made the thing, now find out which index to start at
	//This would be the main reason if your thing breaks (i.e. direction given was bicardinal, but you asked for cardinas)
	var/index = 1
	for(var/i in 1 to directions.len)
		if(starting_direction == directions[i])
			index = i
			break
	index += wanted_dir
	if(index <= 0) index = directions.len
	else if(index > directions.len) index = 1

	return directions[index]

proc/GetOppositeDirection(dir)
	var/new_dir = 0
	if(dir & SOUTH) new_dir = NORTH
	else if(dir & NORTH) new_dir = SOUTH
	if(dir & WEST) new_dir |= EAST
	else if(dir & EAST) new_dir |= WEST
	world << DirectionToString(new_dir)
	return new_dir
