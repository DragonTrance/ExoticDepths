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
