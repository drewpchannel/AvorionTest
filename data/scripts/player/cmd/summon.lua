-- require empty space?
-- add upgrades
-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- atleast an example for dropping good like turret comps
-- DB 7 adding script in 2 places, timer in the boss script and here
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
    Sector():addScript("player/cmd/bossSector.lua", ...)
	terminate()
end