\i '/home/mike/Documents/repos/gtfs-bus-stops/update-tables.sql'
\i '/home/mike/Documents/repos/gtfs-bus-stops/create-routes.sql'
\i '/home/mike/Documents/repos/gtfs-bus-stops/create-stops.sql'

grant all privileges on table tarta_routes to gtfsadmin;
grant all privileges on table tarta_stops to gtfsadmin;
