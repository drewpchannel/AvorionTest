function execute(sender, commandName, ...)
	Player(sender):addScriptOnce("cmd/summon.lua", ...)
    return 0, "", ""
end

function getDescription()
    return "Summons a workshop ship"
end

function getHelp()
    return "Summons a workshop ship /summon"
end
