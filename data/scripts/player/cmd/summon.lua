-- require empty space?
-- add upgrades
-- bounty?
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
	local str = "Testing ship summon"
	local lastSector = {}
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
	ship:registerCallback("onEntityDestroyed", "onShipDestroyed")

	TurretGenerator.initialize(random():createSeed())
	local turret = TurretGenerator.generateArmed(x, y)
	-- Number of turets gets reduced and replaced with a damage multiplier
	local numTurrets = 3000

	ShipUtility.addTurretsToCraft(ship, turret, numTurrets)

	--this is validation found in the4 script that i didn't want to mess with 
	-- make sure this is all happening in the same sector
    local x, y = Sector():getCoordinates()
    if lastSector.x ~= x or lastSector.y ~= y then
        -- this must be set in order to drop the loot
        -- if the sector changed, simply unset it
        lastPosition = nil
    end
    lastSector.x = x
    lastSector.y = y

    Loot(ship.index):insert(InventoryTurret(TurretGenerator.generate(x, y, 0, Rarity(RarityType.Exotic), WeaponType.RepairBeam)))

	terminate()
end

function onShipDestroyed(shipIndex)
	player:sendChatMessage("Debug", 0, "ondestroyed hits")

    ships[shipIndex.string] = nil

    local ship = Entity(shipIndex) 
    local damagers = {ship:getDamageContributorPlayers()}
    for i, v in pairs(damagers) do
        participants[v] = v
        player:sendChatMessage("Human Alliance", 0, "Thank you for destoying this beast.")
    	player:receive(3000000)
    end

    -- if they're all destroyed, the event ends
end

end
