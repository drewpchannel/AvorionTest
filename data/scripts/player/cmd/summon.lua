package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("galaxy")
require ("stringutility")
local PlanGenerator = require ("plangenerator")
local ShipUtility = require ("shiputility")
local TurretGenerator = require ("turretgenerator")

if onServer() then

function initialize()
	player = Player()
	local str = "Testing ship summon"
	player:sendChatMessage("Debug", 0, str)

	--local faction = Galaxy():createRandomFaction(Sector():getCoordinates())
	--DB 1 changing faction name to make nme 
	local factionName = "Astrayanians 44"
	local faction = Galaxy():findFaction(factionName)
	if Galaxy():findFaction(factionName) == nil then
		player:sendChatMessage("Debug", 0, "I made a new faction")
	    faction = Galaxy():createFaction(factionName, 310, 0)
	    faction.initialRelations = 0
	    faction.initialRelationsToPlayer = -100000
	    faction.staticRelationsToPlayers = true
	end
	--local plan = PlanGenerator.makeFreighterPlan(Faction())
	local plan = LoadPlanFromFile("data/plans/AstrayasClass.xml")

	local pos = random():getVector(-1000, 1000)
    pos = MatrixLookUpPosition(-pos, vec3(0, 1, 0), pos)

	local ship = Sector():createShip(faction, "Astrayas Class", plan, pos) 
	ship.title = "something"
	ship.name = "something2"
	ship.crew = ship.minCrew
	ship:addScript("ai/patrol.lua")

	TurretGenerator.initialize(random():createSeed())
	local turret = TurretGenerator.generateArmed(x, y)
	local numTurrets = math.max(2, Balancing_GetEnemySectorTurrets(x, y) * 0.75)

	ShipUtility.addTurretsToCraft(ship, turret, numTurrets)

	terminate()
end
end
