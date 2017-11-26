function initialize ()
	print("DB Trying to get ents: ")
	local sector = Sector()
	local foundStation
	local entityFinder = sector:getEntitiesByType(EntityType.Station)
	for _, entity in pairs({sector:getEntitiesByType(EntityType.Station)}) do
		if entity.title == "Military Outpost" then
			foundStation = entity
		end
    end
    print("DB I found " .. foundStation.title)
    bulletin = createMission(foundStation)
    foundStation:invokeFunction("bulletinboard", "postBulletin", bulletin)
end

function createMission (foundStation)
	local specs = SectorSpecifics()
	local x, y = Sector():getCoordinates()
	local coords = specs.getShuffledCoordinates(random(), x, y, 2, 15)
	local serverSeed = Server().seed
	local target = nil
	local destinations = specs.getRegularStationSectors()

	for _, coord in pairs(coords) do
	    local regular, offgrid, blocked, home = specs:determineContent(coord.x, coord.y, serverSeed)

	    if offgrid and not blocked then
	        specs:initialize(coord.x, coord.y, serverSeed)

	        if specs.generationTemplate.path == "sectors/pirateasteroidfield" then
	            if not Galaxy():sectorExists(coord.x, coord.y) then
	                target = coord
	                break
	            end
	        end
	    end
	end

	if not target then return end

	local description = "A nearby sector has been occupied by pirates and they have been attacking our convoys and traders.\nWe cannot let that scum do whatever they like. We need someone to take care of them.\n\nSector: (${x} : ${y})"%_t

	reward = 50000 * Balancing.GetSectorRichnessFactor(Sector():getCoordinates())

	local bulletin =
	{
	    brief = "Player attached mission"%_t,
	    description = description,
	    difficulty = "Medium /*difficulty*/"%_t,
	    reward = "$${reward}",
	    script = "missions/clearsector.lua",
	    arguments = {foundStation.index, target.x, target.y, reward},
	    formatArguments = {x = target.x, y = target.y, reward = createMonetaryString(reward)},
	    msg = "Their location is \\s(%i:%i)."%_T,
	    entityTitle = foundStation.title,
	    entityTitleArgs = foundStation:getTitleArguments(),
	    onAccept = [[
	        local self, player = ...
	        local title = self.entityTitle % self.entityTitleArgs
	        player:sendChatMessage(title, 0, self.msg, self.formatArguments.x, self.formatArguments.y)
	    ]]
	}

	return bulletin
end