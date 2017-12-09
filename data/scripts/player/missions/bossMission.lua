-- add in death message to give out ship credits
-- add timer to player command to check if another mission should be spawned

package.path = package.path .. ";data/scripts/lib/?.lua"

require ("galaxy")
require ("stringutility")
require("mission")
local PlanGenerator = require ("plangenerator")
local ShipUtility = require ("shiputility")
local TurretGenerator = require ("turretgenerator")
local UpgradeGenerator = require ("upgradegenerator")
local config = require("player/cmd/bossMissionConfig")
local saveX = 0
local saveY = 0
local distanceFromCenter = 1000
local newConfig = {
    factionName = "Atronians",
    --ship plans should be saved to data/plans
    shipXML = "Idk3.xml",
    title = "something",
    name = "something2",
    --sets the amount of damage
    turrets = 3000,
    deathMessage = "Thank you",
    reward = 270000
}

function initialize(giverIndex, x, y, reward)
    print("new init -----------------------------------------")
    if giverIndex == nil then 
    else
        saveX = x 
        saveY = y
        distanceFromCenter = length(vec2(Sector():getCoordinates()))
        for k in pairs(config) do
            if distanceFromCenter < config[k].distance then
                print("trying to setup config from center: " .. config[k].shipXML)
                createShipConfig(config[k])
                break
            end
        end
        Player():registerCallback("onSectorEntered", "makeBoss")
    end
end

function makeBoss()
    if sectorCheck(saveX, saveY) then
        local factionName = newConfig.factionName
        local faction = Galaxy():findFaction(factionName)
        if Galaxy():findFaction(factionName) == nil then
            faction = Galaxy():createFaction(factionName, 310, 0)
            faction.initialRelations = 0
            faction.initialRelationsToPlayer = -100000
            faction.staticRelationsToPlayers = true
        end

        local plan = LoadPlanFromFile("data/plans/" .. newConfig.shipXML)
        local pos = random():getVector(-1000, 1000)
        pos = MatrixLookUpPosition(-pos, vec3(0, 1, 0), pos)

        local ship = Sector():createShip(faction, "Astrayas Class", plan, pos) 
        ship.title = newConfig.title
        ship.name = newConfig.name
        ship.crew = ship.minCrew
        ship:addScript("ai/patrol.lua")
        ship:addScript("player/cmd/bossDeath.lua", newConfig.deathMessage, newConfig.reward)
        --ship:registerCallback("onDestroyed", "bossDead")
        createLoot(ship.index)

        TurretGenerator.initialize(random():createSeed())
        local turret = TurretGenerator.generateArmed(x, y)
        local numTurrets = newConfig.turrets

        ShipUtility.addTurretsToCraft(ship, turret, numTurrets)
        
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

function createShipConfig(configk)
    for k, v in pairs(configk) do
        newConfig[k] = v
    end
end

function bossDead()
    print("new script boss died")
    local players = {Sector():getPlayers()}
    for _, player in pairs(players) do
        print("trying to send reward: " .. newConfig.reward)
        player:sendChatMessage("Human Federation", 0, config.deathMessage)
        -- DB 3 This should work but I have not tested it yet 
        player:receive(config.reward)
    end
end 

function createLoot(shipIndex)
    print("trying to create loot ------- ")
    local upgrades =
    {
        {rarity = Rarity(RarityType.Legendary), dist = 150},
        {rarity = Rarity(RarityType.Exotic), dist = 200},
        {rarity = Rarity(RarityType.Exceptional), dist = 250},
        {rarity = Rarity(RarityType.Rare), dist = 300},
        {rarity = Rarity(RarityType.Uncommon), dist = 350},
        {rarity = Rarity(RarityType.Common), dist = 400},
    }

    local turrets =
    {
        {rarity = Rarity(RarityType.Legendary), dist = 150},
        {rarity = Rarity(RarityType.Exotic), dist = 200},
        {rarity = Rarity(RarityType.Exceptional), dist = 250},
        {rarity = Rarity(RarityType.Rare), dist = 300},
        {rarity = Rarity(RarityType.Uncommon), dist = 350},
        {rarity = Rarity(RarityType.Common), dist = 400},
    }

    UpgradeGenerator.initialize(random():createSeed())

    for _, p in pairs(upgrades) do
        print(p.dist .. " original : dfc " .. distanceFromCenter)
        if p.dist > distanceFromCenter then

            print("gen upgrade loot, dist: " .. distanceFromCenter .. " rarity " .. p.rarity)
            Loot(boss.index):insert(UpgradeGenerator.generateSystem(p.rarity))
            break
        end
    end

    for _, p in pairs(turrets) do
        if p.dist > distanceFromCenter then
            print("gen turret loot, dist: " .. distanceFromCenter .. " rarity " .. p.rarity)
            Loot(boss.index):insert(InventoryTurret(TurretGenerator.generate(x, y, 0, p.rarity)))
            break
        end
    end
end