drop table if exists tarta_stops;
create table tarta_stops as (
select *,
	ST_SetSRID(ST_Point(stop_lon, stop_lat),4326) as geom
from stops
)
