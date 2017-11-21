package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

require ("galaxy")
require ("stringutility")
local PlanGenerator = require ("plangenerator")
local ShipUtility = require ("shiputility")
local TurretGenerator = require ("turretgenerator")
local originalConfig = require("player/cmd/bossConfig")
local config = {}
local timer = Timer()
local pastTime = 0

function initialize(...)
	parseCommand(...)
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

function parseCommand(...)
	local i = 1
	config = originalConfig
	for _, customValue in pairs({...}) do
		if customValue == nil or customValue == "m" then
			i = i + 1
		else
			print(config[config.index[i]] .. " is set to: " .. customValue)
			config[config.index[i]] = customValue
			i = i + 1
		end
	end
end

--[[ DB 9 ref to config
varrs.factionName = "Atronians"
--ship plans should be saved to data/plans
varrs.shipXML = "Idk3.xml"
varrs.title = "something"
varrs.name = "something2"
--sets the amount of damage
varrs.turrets = 3000
varrs.welcomeMessage = "An enemy fighter has been spotted patrolling this sector"
varrs.deathMessage = "Thank you for destroying this outlaw"
--should go to every player in the sector
varrs.deathRewards = 3000000
--time in seconds to respawn boss
varrs.respawnTime = 3600
]]