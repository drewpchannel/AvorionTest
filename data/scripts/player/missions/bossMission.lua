package.path = package.path .. ";data/scripts/lib/?.lua"

require ("galaxy")
require ("stringutility")
require("mission")
local PlanGenerator = require ("plangenerator")
local ShipUtility = require ("shiputility")
local TurretGenerator = require ("turretgenerator")
local originalConfig = require("player/cmd/bossConfig")
local saveX = 0
local saveY = 0

function initialize(giverIndex, x, y, reward)
    if giverIndex == nil then 
    else
        saveX = x
        saveY = y
        Player():registerCallback("onSectorEntered", "makeBoss")
    end
end

function makeBoss()
    if sectorCheck(saveX, saveY) then
        config = originalConfig
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
        local numTurrets = config.turrets

        ShipUtility.addTurretsToCraft(ship, turret, numTurrets)
        Loot(ship.index):insert(InventoryTurret(TurretGenerator.generate(x, y, 0, Rarity(RarityType.Exotic), WeaponType.RepairBeam)))
        terminate()
    end
end

function sectorCheck (saveX, saveY)
    local x, y = Sector():getCoordinates()
    if x == saveX and y == saveY then
        return true
    else 
        return false
    end
end