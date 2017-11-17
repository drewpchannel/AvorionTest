package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

local config = require("player/cmd/bossConfig")

function initialize()
	local testR = Entity():registerCallback("onDestroyed", "bossDead")
end

function bossDead()
	local players = {Sector():getPlayers()}
	for _, player in pairs(players) do
		player:sendChatMessage("Human Federation", 0, config.deathMessage)
		-- DB 3 This should work but I have not tested it yet 
	    player:receive(config.deathReward)
	end
end