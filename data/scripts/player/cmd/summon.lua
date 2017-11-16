package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("galaxy")
require ("stringutility")
local PlanGenerator = require ("plangenerator")
local ShipUtility = require ("shiputility")

if onServer() then

function initialize()
	player = Player()
	local str = "Testing ship summon"
	player:sendChatMessage("Price", 0, str)

	local faction = Galaxy():createRandomFaction(Sector():getCoordinates())
	--local plan = PlanGenerator.makeFreighterPlan(Faction())
	local plan = LoadPlanFromFile("data/plans/AstrayasClass.xml")

	local pos = random():getVector(-1000, 1000)
    pos = MatrixLookUpPosition(-pos, vec3(0, 1, 0), pos)

	local ship = Sector():createShip(faction, "test", plan, pos) 
	ship.title = "something"

	terminate()
end
end
