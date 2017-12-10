# Avorion Workshop Ship Spawner
## Contribution

### What does this mod do?
This mod allows players to type in a command to add missions to the military outposts.  This adds difficult bosses that multiple people can fight.

Sectors can also be edited to create a missions area.  Just by entering the area, players can fight a custom ship.  This is geared towards servers with mods or a need for new content.

### General note
Adding the /summon command to admins \ moderators will let them setup a trigger in the sector that they are currently in.  Players who enter this sector will trigger the boss to spawn in and he will be hostile.

### Installation
Original files do not need to be edited for this mod to work!

data/scripts/plans gets the say.lua (the file without path at the top)
data/scripts/player/cmd gets the boss*.lua files and the other summon.lua
data/scripts/player/missions/bossMission.lua
data/plans gets your workshop ship plans (you can sub to the ship, use it in game, save it and find it in your appdata/roaming/avorion folder)
in that same appdata folder you will find your admin.xml where you will need to add in the summon command and the bossPlayerTrigger (or else you will get unknown command)

### Config File
server/data/scripts/player/cmd/bossConfig

### In game
Added a playaer command that only need to be entered 1 time /bossPlayerTrigger.  This will trigger missions to be spawned on military outposts for the player.

bossMissionConfig checks the distance from the center and picks the appropriate mission.  To setup a new mission, pick a new name like distanceC. Paste it into the config file where the shortest distance gets picked first.  So distance  425 would have to go between 350 and 450 in the bossMissionConfig file.  More turrets will just create more damage.

	distanceC = {
		distance = 425,
		factionName = "Warpers",
		shipXML	= "zygonian.xml",
		turrets = 2000,
		title = "something",
		name = "something2"
	},

Fly to a sector, do /summon.  When you fly out and back in you will see a boss and a message warning you about the boss
do /summon remove to stop the boss from summoning in the future

To set custom values (space is not working yet, so the messages might be tough)

	so /summon Empire deathstar.xml StarDestroyer DarthBuydioer 3000 m m 4000000 7200
	This would spawn a stardestroyer with the empire faction ect.  welcomeMessage would be skipped because I put m in there.  You can skip any of these values and it will get the information from the bossConfig.lua.  Also doing just /summon Empire, would only change the empire (the rest will be skipped automaticly)

	"factionName",
	"shipXML",
	"title",
	"name",
	"turrets",
	"welcomeMessage",
	"deathMessage",
	"deathRewards",
	"respawnTime"

### Bugs

I need to add a timer to the Rogue ship missions, Rogue missions would need to be edited manually

