select building.name, count(*)
from 
	locationobservation, locationsensor, loadobservation, loadsensor,
	objectrecognitionobservation, objectrecognitionsensor, wastebin,
    building
where 
	-- Join the observations with the sensors that generated them
	locationobservation.sensor_id = locationsensor.sensor_id and
	loadobservation.sensor_id = loadsensor.sensor_id and
    objectrecognitionobservation.sensor_id = objectrecognitionsensor.sensor_id and
    
    -- Join the observations that occured at the same time
    locationobservation.timestamp = loadobservation.timestamp and
    locationobservation.timestamp = objectrecognitionobservation.timestamp and
    loadobservation.timestamp = objectrecognitionobservation.timestamp and
    
    -- Join the wastebin sensors with the wastebin they are associated with
    loadsensor.waste_bin_id = wastebin.waste_bin_id and
    objectrecognitionsensor.waste_bin_id = wastebin.waste_bin_id and
    
    -- Join location observations with locations of wastebins
    locationobservation.X = wastebin.X and
    locationobservation.Y = wastebin.Y and
    
    -- Join wastebins that are inside the buildings
    wastebin.X >= building.boxLowX and wastebin.X <= building.boxUpperX and 
    wastebin.Y >= building.boxLowY and wastebin.Y <= building.boxUpperY

group by building.name
order by building.name