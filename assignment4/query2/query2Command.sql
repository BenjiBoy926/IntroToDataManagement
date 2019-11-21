select name
from building, (wastebin natural join compostbin) 
where X >= boxLowX and X <= boxUpperX and Y >= boxLowY and Y <= boxUpperY