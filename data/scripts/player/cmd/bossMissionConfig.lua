-- mission will compare the players distance from center (smaller distance number = harder) and match them with the appropriate difficulty
-- I had to add another index, this lets you use the table's named keys I guess
-- The function will check the lowest value (closest to the center) first

local missionConfig = {
	distanceA = {
		distance = 350,
		factionName = "Warpers",
		shipXML	= "zygonian.xml",
		turrets = 2000,
		title = "something",
		name = "something2"
	},
	distanceB = {
		distance = 450,
		factionName = "Warpers",
		shipXML	= "ironnugget.xml",
		turrets = 500,
		title = "something",
		name = "something2"
	},
}
return missionConfig