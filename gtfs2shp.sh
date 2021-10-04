#!/bin/bash

# Download TARTA's GTFS files, unzip, and create shapefiles
# this is designed to run as a cronjob

conda activate gtfs-bus-stops
cd /home/fullerm/repos/gtfs-bus-stops

DATE=$(date -d today +%F)
CREDS="./credentials.json"
DIR=$(jq .loc $CREDS -r )
PGUSER=$(jq .pg_user $CREDS -r )
PGPW=$(jq .pg_pw $CREDS -r)
DBNAME=$(jq .pg_db $CREDS -r)
# download GTFS files
wget -O ./GTFS.zip http://tarta.com/wp-content/uploads/gtfs/GTFS.zip 

# unzip and organize files
unzip -o $DIR/GTFS.zip -d $DIR/tarta_gtfs

# Run query batch from the all_queries file to update the db,
# and create tables for routes and stops
sudo -u postgres psql -d $DBNAME -f $DIR/all_queries.sql

# exit after queries run?
#exit

# use gdal to export the routes and stops to shapefiles
ogr2ogr -f "GeoJSON" $DIR/tarta_routes.geojson PG:"host=localhost user=$PGUSER dbname=$DBNAME password=$PGPW" "tarta_routes"

ogr2ogr -f "GeoJSON" $DIR/tarta_stops.geojson PG:"host=localhost user=$PGUSER dbname=$DBNAME password=$PGPW" "tarta_stops"

# zip the shapefiles?
zip $DIR/tarta_routes.zip $DIR/tarta_routes.*
zip $DIR/tarta_stops.zip $DIR/tarta_stops.*

python main.py

