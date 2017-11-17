-- require empty space?
-- add upgrades
-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- atleast an example for dropping good like turret comps

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

function initialize()
	local players = {Sector():getPlayers()}
	for _, player in pairs(players) do
		player:sendChatMessage("Server", 0, "This sector will now spawn a boss upon entry")
	end
    Sector():addScript("player/cmd/bossSector.lua")
	terminate()
end