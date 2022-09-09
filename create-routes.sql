drop table if exists tarta_routes;
create table tarta_routes as (
SELECT shapes.shape_id,
ST_MakeLine(ST_SetSRID(ST_Point(shape_pt_lon,shape_pt_lat),4326) order by shape_pt_sequence) as geom,
	--trips.shape_id,
	trips.route_id,
	trips.service_id,
	trips.trip_headsign,
	trips.wheelchair_accessible,
	trips.bikes_allowed,
	--routes.route_id,
	routes.agency_id,
	routes.route_short_name,
	routes.route_long_name,
	--calendar.service_id,
	case  
		when (
			calendar.monday = 1 and
	        calendar.tuesday = 1 and
	        calendar.wednesday = 1 and
	        calendar.thursday = 1 and
	        calendar.friday = 1) then 'weekday'
	    when(
	        calendar.saturday = 1 or
	        calendar.sunday = 1) then 'weekend'
	    else ''
		end daytype,
	calendar.start_date,
	calendar.end_date
FROM shapes 
join trips 
on trips.shape_id = shapes.shape_id
	join routes
	on trips.route_id = routes.route_id
		join calendar
		on trips.service_id = calendar.service_id
group by shapes.shape_id, 
  trips.route_id, 
  trips.trip_headsign, 
  trips.wheelchair_accessible, 
  trips.bikes_allowed,
  routes.route_id,
  routes.agency_id,
  routes.route_short_name,
  routes.route_long_name,
  trips.service_id,
  calendar.service_id,
  calendar.monday,
	calendar.tuesday,
	calendar.wednesday,
	calendar.thursday,
	calendar.friday,
	calendar.saturday,
	calendar.sunday,
	calendar.start_date,
	calendar.end_date
)
--JOIN ____
--ON
