-- mission will compare the players distance from center (smaller distance number = harder) and match them with the appropriate difficulty
-- I had to add another index, this lets you use the table's named keys I guess
-- The function will check the lowest value (closest to the center) first

local missionConfig = {
	distanceA = {
		distance = 250,
		factionName = "Warpers",
		shipXML	= "zygonian.xml",
		turrets = 4000,
		title = "something",
		name = "something2",
		deathRewards = 275000,
		deathMessage = "These titanium fighters can be tough!  Good job!",
	},
	distanceB = {
		distance = 300,
		factionName = "Eidolon Security",
		shipXML	= "EarlyNaoSolNovus.xml",
		turrets = 1500,
		title = "Destroyer",
		name = "Sol Novus",
		deathRewards = 255000,
		deathMessage = "Thank you captain.  We will have more work in the future!",
	},	
	distanceC = {
		distance = 450,
		factionName = "Warpers",
		shipXML	= "ironnugget.xml",
		turrets = 500,
		title = "something",
		name = "something2",
		deathRewards = 255000,
		deathMessage = "Slowly we can remove this filth from the area.",
	},
}
return missionConfig