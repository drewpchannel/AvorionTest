-- gen and balance better end game turrets?  maybe guardian loot somewhat
-- DB 10 maybe add a warning when spawning in multi bosses to one sector?
-- might need to add timer to missions spawning in on mil outposts
-- good transport missions from smugglers
-- add in a command to check where the bosses are located for players
-- add mission popup text to mission start

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
local configSetup = require("player/cmd/bossConfig")

function initialize(...)
    Sector():addScript("player/cmd/bossSector.lua", ...)
	terminate()
end