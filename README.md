# gtfs-bus-stops
Queries for creating a line geometry layer of fixed bus routes and a point geometry layer of bus stop locations from a GTFS feed in Postgis
# How to Use

## Download GTFS Files
TARTA's files are available here: http://tarta.com/wp-content/uploads/gtfs/GTFS.zip

## Create Postgis Database

## Run Batch Query
Navigate to the directory where the GTFS files are saved then type the command
`psql -U <user> -d <dbname> -f "all_queries.sql"`. The all_queries file first runs "update-tables.sql", which adds all text files from the GTFS to the database. Then it runs "create-routes.sql", which creates the fixed line routes, in a new table called tarta_routes, from the latitude, longitude, sequence information in the text files. Finally,
it runs "create-stops.sql", which creates points, in a new table called tarta_stops, from the latitude and longitude in the stops.txt file.  
