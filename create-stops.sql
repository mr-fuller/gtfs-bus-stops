drop table if exists tarta_stops;
create table tarta_stops as (
select *,
	ST_makepoint(stop_lon, stop_lat) as geom
from stops
)