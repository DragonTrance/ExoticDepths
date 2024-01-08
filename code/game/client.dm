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

	if(movement_keys[_key])
		step(mob, movement_keys[_key])

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


/client/New(TopicData)
	if(connection != "seeker" && connection != "web") //invalid connection type
		return null
	. = ..()
	g_AllClients[key] = src
	SetMacros()

/client/Del()
	g_AllClients -= key
	return ..()

/client/Topic(href, href_list, hsrc, hsrc_command)
	if(!usr || !usr != mob) //stops us calling Topic for somebody else's client. Also helps prevent usr=null
		return
	if (lowertext(hsrc_command) == "_debug") //disable the integrated byond vv in the client side debugging tools since it doesn't respect vv read protections
		return

	..()
