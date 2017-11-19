package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("galaxy")
require ("stringutility")
local PlanGenerator = require ("plangenerator")
local ShipUtility = require ("shiputility")
local TurretGenerator = require ("turretgenerator")

local config = require("player/cmd/bossConfig")
local timer = Timer()
local pastTime = 0

function initialize()
	Sector():registerCallback("onPlayerEntered", "bossTimer")
end

function bossInit ()
	welcomeText()
	local factionName = config.factionName
	local faction = Galaxy():findFaction(factionName)
	if Galaxy():findFaction(factionName) == nil then
	    faction = Galaxy():createFaction(factionName, 310, 0)
	    faction.initialRelations = 0
	    faction.initialRelationsToPlayer = -100000
	    faction.staticRelationsToPlayers = true
	end

	local plan = LoadPlanFromFile("data/plans/" .. config.shipXML)
	local pos = random():getVector(-1000, 1000)
    pos = MatrixLookUpPosition(-pos, vec3(0, 1, 0), pos)

	local ship = Sector():createShip(faction, "Astrayas Class", plan, pos) 
	ship.title = config.title
	ship.name = config.name
	ship.crew = ship.minCrew
	ship:addScript("ai/patrol.lua")
	ship:addScript("player/cmd/bossDeath.lua")

	TurretGenerator.initialize(random():createSeed())
	local turret = TurretGenerator.generateArmed(x, y)
	-- Number of turets gets reduced and replaced with a damage multiplier
	local numTurrets = config.turrets

	ShipUtility.addTurretsToCraft(ship, turret, numTurrets)
    Loot(ship.index):insert(InventoryTurret(TurretGenerator.generate(x, y, 0, Rarity(RarityType.Exotic), WeaponType.RepairBeam)))
end

function welcomeText ()
	local players = {Sector():getPlayers()}
    for _, player in pairs(players) do
    	player:sendChatMessage("Warning", 0, config.welcomeMessage)
    end
end

function bossTimer ()
	tellPlayers("The boss has been summoned: " .. timer.seconds ..  " ago")
	if timer.seconds < 1 then
		bossInit()
		timer:start()
	end
	if timer.seconds > config.respawnTime then
		timer:reset()
		bossInit()
	end
end

function tellPlayers (message)
	local players = {Sector():getPlayers()}
    for _, player in pairs(players) do
    	player:sendChatMessage("Server", 0, message)
    end
end