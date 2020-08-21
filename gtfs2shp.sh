#!/bin/bash

# Download TARTA's GTFS files, unzip, and create shapefiles
# this is designed to run as a cronjob
DATE=$(date -d today +%F)
CREDS="/media/mike/OS/Users/fullerm/source/repos/gtfs-bus-stops/credentials.json"
DIR=$(jq .loc $CREDS -r )
PGUSER=$(jq .pg_user $CREDS -r )
PGPW=$(jq .pg_pw $CREDS -r)
DBNAME=$(jq .pg_db $CREDS -r)
# download GTFS files
curl http://tarta.com/wp-content/uploads/gtfs/GTFS.zip > $DIR/tarta_gtfs.zip 

# unzip and organize files
unzip -o $DIR/tarta_gtfs.zip -d $DIR/tarta_gtfs

# Run query batch from the all_queries file to update the db,
# and create tables for routes and stops
sudo -u postgres psql -U postgres -d $DBNAME -P laskdjfhiweiofoies. -f $DIR/all_queries.sql

# exit after queries run?
#exit

# use gdal to export the routes and stops to shapefiles
ogr2ogr -f "ESRI Shapefile" $DIR/tarta_routes_$DATE.shp PG:"host=localhost user=$PGUSER dbname=$DBNAME password=$PGPW" "tarta_routes"

ogr2ogr -f "ESRI Shapefile" $DIR/tarta_stops_$DATE.shp PG:"host=localhost user=$PGUSER dbname=$DBNAME password=$PGPW" "tarta_stops"

# zip the shapefiles?
zip $DIR/tarta_routes_$DATE.zip $DIR/tarta_routes_$DATE.*
zip $DIR/tarta_stops_$DATE.zip $DIR/tarta_stops_$DATE.*
