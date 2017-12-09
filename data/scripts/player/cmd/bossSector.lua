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
local remove = false

function initialize(...)
	parseCommand(sector, ...)
end

function bossInit ()
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
	ship:addScript("player/cmd/bossDeath.lua", config.deathMessage, config.deathRewards)

	TurretGenerator.initialize(random():createSeed())
	local turret = TurretGenerator.generateArmed(x, y)
	local numTurrets = config.turrets

	ShipUtility.addTurretsToCraft(ship, turret, numTurrets)
    Loot(ship.index):insert(InventoryTurret(TurretGenerator.generate(x, y, 0, Rarity(RarityType.Exotic), WeaponType.RepairBeam)))
end

function welcomeText ()
	local players = {Sector():getPlayers()}
    for _, player in pairs(players) do
    	player:sendChatMessage("Warning"%_t, 3, "Enemies have been seen patrolling this sector for " .. timer.seconds .. " seconds."%_t)
    end
end

function bossTimer ()
	welcomeText()
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
	local remove = false
	config = originalConfig
	for _, customValue in pairs({...}) do
		if customValue == "remove" then
			remove = true
		end
		if customValue == nil or customValue == "m" then
			i = i + 1
		else
			if tonumber(config[config.index[i]]) and tonumber(customValue) then
				config[config.index[i]] = customValue
			elseif not tonumber(config[config.index[i]]) then
				config[config.index[i]] = customValue
			else
				print("a number was expected for " .. i .. " custom value, which was: " .. customValue)
			end
			i = i + 1
		end
	end
	if remove then 
		tellPlayers("Stopping the rogue ships from patrolling this sector.")
		local sector = Sector()
		sector:unregisterCallback("onPlayerEntered", "bossTimer")
		sector:removeScript("player/cmd/bossSector.lua")
		terminate()
	else
		local sector = Sector()
		tellPlayers("Rogue ships are now patrolling this sector.")
		sector:registerCallback("onPlayerEntered", "bossTimer")
	end
end