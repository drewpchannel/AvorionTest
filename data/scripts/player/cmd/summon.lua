-- require empty space?
-- add upgrades
-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- atleast an example for dropping good like turret comps

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
	local factionName = "Astrayanians 44"
	local faction = Galaxy():findFaction(factionName)
	if Galaxy():findFaction(factionName) == nil then
	    faction = Galaxy():createFaction(factionName, 310, 0)
	    faction.initialRelations = 0
	    faction.initialRelationsToPlayer = -100000
	    faction.staticRelationsToPlayers = true
	end

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
	-- Number of turets gets reduced and replaced with a damage multiplier
	local numTurrets = 3000

	ShipUtility.addTurretsToCraft(ship, turret, numTurrets)
    Loot(ship.index):insert(InventoryTurret(TurretGenerator.generate(x, y, 0, Rarity(RarityType.Exotic), WeaponType.RepairBeam)))

	terminate()
end

end
