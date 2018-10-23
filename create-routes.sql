drop table tarta_routes;
create table tarta_routes as (
SELECT shapes.shape_id,
ST_MakeLine(ST_MakePoint(shape_pt_lon,shape_pt_lat) order by shape_pt_sequence) as geom,
	--trips.shape_id,
	trips.route_id,
	trips.trip_headsign,
	trips.wheelchair_accessible,
	trips.bikes_allowed,
	--routes.route_id,
	routes.agency_id,
	routes.route_short_name,
	routes.route_long_name
FROM shapes 
join trips 
on trips.shape_id = shapes.shape_id
	join routes
	on trips.route_id = routes.route_id
group by shapes.shape_id, trips.route_id, trips.trip_headsign, trips.wheelchair_accessible, trips.bikes_allowed,routes.route_id,
	routes.agency_id,
	routes.route_short_name,
	routes.route_long_name
)
--JOIN ____
--ON
