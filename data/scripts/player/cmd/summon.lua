-- require empty space?
-- add upgrades
-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- atleast an example for dropping good like turret comps

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

function initialize()
	print("DB 5 trying to set sector with command")
    Sector():addScript("player/cmd/bossSector.lua")
	terminate()
end


