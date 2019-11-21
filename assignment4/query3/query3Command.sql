select distinct wastebin.waste_bin_id, X, Y
from wastebin natural join (loadobservation natural join loadsensor)
where timestamp >= '2019-10-26 13:00:00' and Weight >= capacity