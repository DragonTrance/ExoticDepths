// The game updates movemnt in this order: World -> Client -> Focus

/client
	var/list/keys_held = list()
	var/list/movement_keys = list(
		"W" = NORTH, "North" = NORTH,
		"A" = WEST,  "West" = WEST,
		"S" = SOUTH, "South" = SOUTH,
		"D" = EAST,  "East" = EAST

	)

var/list/macro_set = list(
	"Any" = "\"KeyDown \[\[*\]\]\"",
	"Any+UP" = "\"KeyUp \[\[*\]\]\"",
	"Back" = "\".winset \\\"input.text=\\\"\\\"\\\"\"",
	"Tab" = "\".winset \\\"input.focus=true?map.focus=true:input.focus=true\\\"\"",
)

/client/proc/SetMacros()
	for(var/k in 1 to length(macro_set))
		var/key = macro_set[k]
		var/command = macro_set[key]
		AddMacro(key, command)

/client/proc/AddMacro(key, command)
	winset(src, "default-[key]", "parent=default;name=[key];command=[command]")
/client/proc/DeleteMacro(key)
	winset(src, "default-[key]", "parent=")

/client/verb/keyDown(_key as text)
	set instant = TRUE
	set hidden = TRUE

	keys_held[_key] = world.time
	mob.focus?.keyDown(_key, src)

/client/verb/keyUp(_key as text)
	set instant = TRUE
	set hidden = TRUE

	if(!keys_held[_key]) return

	keys_held -= _key
	mob.focus?.keyUp(_key, src)

/client/proc/keyLoop()
	if(!mob.focus) return
	//for(var/k in 1 to length(keys_held))
	mob.focus.keyLoop(src)

/datum/proc/keyDown(key, client/C)
/datum/proc/keyUp(key, client/C)

/datum/proc/keyLoop(client/C)
	set waitfor = FALSE
	return


/atom/movable
	var/next_move = 0
	var/move_inc = 1

/atom/movable/Move(loc)
	. = ..()
	if (.)
		next_move = world.time + move_inc

/atom/movable/keyLoop(client/user)
	if(!user) return
	if(world.time < next_move) return

	var/movement_dir = 0
	for(var/key in user.keys_held)
		movement_dir = movement_dir | user.movement_keys[key]

	// Sanity checks in case you hold left and right and up to make sure you only go up
	if((movement_dir & NORTH) && (movement_dir & SOUTH))
		movement_dir &= ~(NORTH|SOUTH)
	if((movement_dir & EAST) && (movement_dir & WEST))
		movement_dir &= ~(EAST|WEST)


	if(movement_dir) //If we're not moving, don't compensate, as byond will auto-fill dir otherwise
		movement_dir = turn(GetClockwiseDirection(movement_dir, CF_COUNTERCLOCKWISE | CF_CARDINALS | CF_BICARDINALS), -dir2angle(user.dir)) //By doing this we ensure that our input direction is offset by the client (camera) direction

	user.Move(get_step(src, movement_dir), movement_dir)
