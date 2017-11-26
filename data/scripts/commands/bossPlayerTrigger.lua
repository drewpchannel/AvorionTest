function execute(sender, commandName)
	Player(sender):addScriptOnce("cmd/bossPlayerTrigger.lua")
    return 0, "", ""
end

function getDescription()
    return "Used by the player one time to enable the boss missions"
end

function getHelp()
    return "Used by the player one time to enable the boss missions"
end