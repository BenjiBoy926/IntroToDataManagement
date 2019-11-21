select *
from ((((objectrecognitionobservation 
	join loadobservation on objectrecognitionobservation.timestamp = loadobservation.timestamp) 
	join locationobservation on loadobservation.timestamp = locationobservation.timestamp)
    join wastebin on locationobservation.X = wastebin.X and locationobservation.Y = wastebin.Y)
    join locationsensor on locationsensor.sensor_id = locationobservation.sensor_id)