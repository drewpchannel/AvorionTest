-- require empty space?
-- add upgrades
-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- atleast an example for dropping good like turret comps

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

function initialize()
    Sector():addScript("player/cmd/bossSector.lua")
	terminate()
end


