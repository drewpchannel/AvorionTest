-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- DB 10 maybe add a warning when spawning in multi bosses to one sector?
-- DB 11 remove command

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
local configSetup = require("player/cmd/bossConfig")

function initialize(...)
	local players = {Sector():getPlayers()}
	for _, player in pairs(players) do
		player:sendChatMessage("Server", 0, "This sector will now spawn a boss upon entry")
	end
    Sector():addScript("player/cmd/bossSector.lua", ...)
	terminate()
end