#!/bin/bash

# Download TARTA's GTFS files, unzip, and create shapefiles
# this is designed to run as a cronjob
DATE=$(date -d today +%F)
DIR=/home/mike/Documents/repos/gtfs-bus-stops
PGUSER=gtfsadmin
PGPW=gtfsadminpass
DBNAME=gtfs
# download GTFS files
curl http://tarta.com/wp-content/uploads/gtfs/GTFS.zip > $DIR/tarta_gtfs.zip 

# unzip and organize files
unzip -o $DIR/tarta_gtfs.zip -d $DIR/tarta_gtfs

# Run query batch from the all_queries file to update the db,
# and create tables for routes and stops
sudo -u postgres psql -U postgres -d $DBNAME -f $DIR/all_queries.sql

# exit after queries run?
#exit

# use gdal to export the routes and stops to shapefiles
ogr2ogr -f "ESRI Shapefile" $DIR/tarta_routes_$DATE.shp PG:"host=localhost user=$PGUSER dbname=$DBNAME password=$PGPW" "tarta_routes"

ogr2ogr -f "ESRI Shapefile" $DIR/tarta_stops_$DATE.shp PG:"host=localhost user=$PGUSER dbname=$DBNAME password=$PGPW" "tarta_stops"

# zip the shapefiles?
zip $DIR/tarta_routes_$DATE.zip $DIR/tarta_routes_$DATE.*
zip $DIR/tarta_stops_$DATE.zip $DIR/tarta_stops_$DATE.*
