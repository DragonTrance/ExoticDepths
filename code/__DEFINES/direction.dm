#define _NORTH "NORTH"
#define _SOUTH "SOUTH"
#define _EAST "EAST"
#define _WEST "WEST"
#define _NORTHEAST "NORTHEAST"
#define _NORTHWEST "NORTHWEST"
#define _SOUTHEAST "SOUTHEAST"
#define _SOUTHWEST "SOUTHWEST"

//Some generic flags for proc/GetClockwiseDirection
#define CF_COUNTERCLOCKWISE (1<<0)
#define CF_CARDINALS (1<<1)
#define CF_BICARDINALS (1<<2)
#define CF_ALLDIRS (CF_CARDINALS | CF_BICARDINALS)


var/list/g_dir_by_name = list(
	_NORTH = NORTH,
	_SOUTH = SOUTH,
	_EAST = EAST,
	_WEST = WEST,
	_NORTHWEST = NORTH|WEST,
	_NORTHEAST = NORTH|EAST,
	_SOUTHWEST = SOUTH|WEST,
	_SOUTHEAST = SOUTH|EAST
)

var/list/g_cardinals = list(NORTH, SOUTH, EAST, WEST)
var/list/g_bicardinals = list(NORTH|EAST, SOUTH|EAST, NORTH|WEST, SOUTH|WEST)
var/list/g_all_dirs = g_cardinals + g_bicardinals

var/list/g_clockwise_cardinals = list(NORTH, EAST, SOUTH, WEST)
var/list/g_clockwise_bicardinals = list(NORTH|EAST, SOUTH|EAST, SOUTH|WEST, NORTH|WEST)
var/list/g_all_clockwise_dirs = list(NORTH, NORTH|EAST, EAST, SOUTH|EAST, SOUTH, SOUTH|WEST, WEST, NORTH|WEST)
