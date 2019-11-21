select distinct user_id
from 
    loadobservation, loadsensor,
    locationobservation, locationsensor,
    wastebin, landfillbin
where 
	-- Join observations with the sensors
    loadobservation.sensor_id = loadsensor.sensor_id and
    locationobservation.sensor_id = locationsensor.sensor_id and
    
    -- Join observations with the same timestamp
    loadobservation.timestamp = locationobservation.timestamp and
    
    -- Join sensors with the wastebin they're set up on
    loadsensor.waste_bin_id = wastebin.waste_bin_id and
	
    -- Join location observations that occurred at a wastebin
    wastebin.X = locationobservation.X and 
    wastebin.Y = locationobservation.Y and
    
    -- Join wastebin with landfill bins
    wastebin.waste_bin_id = landfillbin.waste_bin_id
    
group by user_id
having count(*) >= 100
order by user_id