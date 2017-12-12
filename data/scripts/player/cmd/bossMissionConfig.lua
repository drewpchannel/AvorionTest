-- mission will compare the players distance from center (smaller distance number = harder) and match them with the appropriate difficulty
-- I had to add another index, this lets you use the table's named keys I guess
-- The function will check the lowest value (closest to the center) first
-- DB 22 should I change the xml directory?  what do updates wipe
-- DB 23 check if shields are charged when the ship is made
-- DB 24 randomize messages and similar ships and mission name lol

local missionConfig = {
	distanceA = {
		distance = 120,
		factionName = "Baltasar",
		shipXML	= "AvorionK3Baltasar.xml",
		turrets = 6000,
		title = "Carrier",
		name = "K3",
		deathRewards = 675000,
		deathMessage = "The galaxy is a better place with that carrier destroyed.",
	},		
	distanceB = {
		distance = 200,
		factionName = "Tahas",
		shipXML	= "LowerOgoTahatoc.xml",
		turrets = 5000,
		title = "Carrier",
		name = "Tahaco",
		deathRewards = 575000,
		deathMessage = "The galaxy is a better place with that carrier destroyed.",
	},	
	distanceC = {
		distance = 250,
		factionName = "Zygonians",
		shipXML	= "UpperXanZygonian.xml",
		turrets = 4000,
		title = "Battleship",
		name = "ZenZynan",
		deathRewards = 475000,
		deathMessage = "That could not have been easy!  Excellent work!",
	},	
	distanceD = {
		distance = 280,
		factionName = "Isle of Man",
		shipXML	= "HorizonCarrierXan.xml",
		turrets = 1500,
		title = "Carrier",
		name = "Horizon Carrier",
		deathRewards = 400000,
		deathMessage = "That could not have been easy!  Excellent work!",
	},
	distanceE = {
		distance = 300,
		factionName = "Eidolon Security",
		shipXML	= "EarlyNaoSolNovus.xml",
		turrets = 200,
		title = "Destroyer",
		name = "Sol Novus",
		deathRewards = 355000,
		deathMessage = "Thank you captain.  We will have more work in the future!",
	},		
	distanceF = {
		distance = 400,
		factionName = "Beltulla",
		shipXML	= "TitaniumDestroyer.xml",
		turrets = 90,
		title = "Destroyer",
		name = "Titanium Brawler",
		deathRewards = 255000,
		deathMessage = "Thank you captain.  We will have more work in the future!",
	},	
	distanceG = {
		distance = 450,
		factionName = "Warpers",
		shipXML	= "ironnugget.xml",
		turrets = 50,
		title = "something",
		name = "Iron Nugget",
		deathRewards = 155000,
		deathMessage = "Slowly we can remove this filth from the area.",
	},	
	distanceH = {
		distance = 490,
		factionName = "Rusty Horde",
		shipXML	= "IronRocket.xml",
		turrets = 10,
		title = "Mantis Utility",
		name = "FleshBox Mobile",
		deathRewards = 100000,
		deathMessage = "Scavengers will steal anything.",
	},
}
return missionConfig