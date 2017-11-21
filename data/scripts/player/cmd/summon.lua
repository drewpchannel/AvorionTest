-- add upgrades
-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- DB 8 set server keyv to check what sectors have the script?  or check sector? or addonce?
-- DB 9 check if ... needs a saved variable

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
local configSetup = require("player/cmd/bossConfig")

function initialize(...)
	local players = {Sector():getPlayers()}
	for _, player in pairs(players) do
		player:sendChatMessage("Server", 0, "This sector will now spawn a boss upon entry")
	end
    Sector():addScriptOnce("player/cmd/bossSector.lua", ...)
	terminate()
end