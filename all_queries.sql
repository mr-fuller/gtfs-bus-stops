\i './update-tables.sql'
\i './create-routes.sql'
\i './create-stops.sql'

grant all privileges on table tarta_routes to gtfsuser;
grant all privileges on table tarta_stops to gtfsuser;
