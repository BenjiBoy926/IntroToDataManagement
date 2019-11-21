select distinct name
from 
	objectrecognitionobservation, objectrecognitionsensor,
    loadobservation, loadsensor,
    locationobservation, locationsensor,
    wastebin,
    recyclebin, student, user
where
	-- CORRECT: tested in other queries
	-- Join observations with the sensors
    objectrecognitionobservation.sensor_id = objectrecognitionsensor.sensor_id and
    loadobservation.sensor_id = loadsensor.sensor_id and
    locationobservation.sensor_id = locationsensor.sensor_id and
    
    -- Join observations with the same timestamp
    objectrecognitionobservation.timestamp = loadobservation.timestamp and
    objectrecognitionobservation.timestamp = locationobservation.timestamp and
    loadobservation.timestamp = locationobservation.timestamp and
        
    -- Join location observations that occurred at a wastebin
    wastebin.X = locationobservation.X and 
    wastebin.Y = locationobservation.Y and
    
    -- Filter for the desired timestamp
    loadobservation.timestamp >= '2019-10-26 14:00:00' and
    loadobservation.timestamp <= '2019-10-26 15:00:00' and
    
    -- INCORRECT: the error must be somewhere below here
    -- Join for recycling bins
    wastebin.waste_bin_id = recyclebin.waste_bin_id and
    
    -- Join for location sensors owned by students
    locationsensor.user_id = student.user_id and
    locationsensor.user_id = user.user_id and
    
    -- Filter objects that were not of the recycling type
    (objectrecognitionobservation.trash_type = 'Compost' or
    objectrecognitionobservation.trash_type = 'Landfill')
	