-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- DB 10 maybe add a warning when spawning in multi bosses to one sector?
-- DB 11 remove command
-- might need to add timer to missions spawning in on mil outposts
-- good transport missions from smugglers

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
local configSetup = require("player/cmd/bossConfig")

function initialize(...)
	local sector = Sector()
    Sector():addScript("player/cmd/bossSector.lua", sector, ...)
	terminate()
end