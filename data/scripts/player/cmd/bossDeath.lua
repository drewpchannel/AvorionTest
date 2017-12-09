package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

local config = require("player/cmd/bossConfig")
local message = "Thank you!!"
local reward = 1000

function initialize(deathMessage, deathRewards)
	local testR = Entity():registerCallback("onDestroyed", "bossDead")
	reward = deathRewards
	message = deathMessage
end

function bossDead()
	local players = {Sector():getPlayers()}
	for _, player in pairs(players) do
		player:sendChatMessage("Human Federation", 0, message)
	    player:receive(reward)
	end
end