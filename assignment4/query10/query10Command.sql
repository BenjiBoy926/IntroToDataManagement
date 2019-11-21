select user_id
from 
	locationobservation, locationsensor, loadobservation, loadsensor,
	objectrecognitionobservation, objectrecognitionsensor, wastebin,
    compostbin
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
    
    -- Join wastebins with compost bins
    wastebin.waste_bin_id = compostbin.waste_bin_id
    
group by user_id
order by count(*) desc