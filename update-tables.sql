drop table if exists agency;

create table agency (
  agency_id varchar,
  agency_name varchar,
  agency_url varchar,
  agency_timezone varchar,
  agency_lang varchar,
  agency_phone varchar,
  agency_fare_url varchar,
  agency_email varchar 
  );

  \copy agency from './tarta_gtfs/agency.txt' DELIMITER ',' CSV HEADER;

drop table if exists calendar;
create table calendar (
  service_id numeric,
  monday numeric,
  tuesday numeric,
  wednesday numeric,
  thursday numeric,
  friday numeric,
  saturday numeric,
  sunday numeric,
  start_date varchar,
  end_date varchar,
  service_name varchar,
  eta_schedule_id varchar 
  );

  \copy calendar from './tarta_gtfs/calendar.txt' DELIMITER ',' CSV HEADER;

drop table if exists calendar_dates;
--create table calendar_dates (
  --service_id numeric,
  --date date,
  --exception_type numeric);
  --\copy calendar_dates from './tarta_gtfs/calendar_dates.txt' DELIMITER ',' CSV HEADER;

drop table if exists routes;
create table routes (
  route_id varchar,
  agency_id varchar,
  route_short_name varchar,
  route_long_name varchar,
  route_desc varchar,
  route_type numeric,
  route_url varchar,
  route_color varchar,
  route_text_color varchar,
  route_sort_order varchar,
  eta_corridor_id varchar
  );


\copy routes from './tarta_gtfs/routes.txt' DELIMITER ',' CSV HEADER;

drop table if exists shapes;
create table shapes (
  shape_id varchar,
  shape_pt_lat double precision,
  shape_pt_lon double precision,
  shape_pt_sequence numeric,
  shape_dist_traveled double precision,
  eta_pattern_id varchar
  );


\copy shapes from './tarta_gtfs/shapes.txt' DELIMITER ',' CSV HEADER;

drop table if exists stop_times;
create table stop_times (
  trip_id numeric,
  stop_id varchar,
  stop_sequence numeric,
  arrival_time time,
  departure_time time,
  --pickup_type numeric,
  drop_off_type numeric,
  shape_dist_traveled double precision,
  timepoint numeric,
  stop_headsign varchar
  );

\copy stop_times from './tarta_gtfs/stop_times.txt' DELIMITER ',' CSV HEADER;

drop table if exists stops;
create TABLE stops (
  stop_id varchar,
  stop_name varchar,
  stop_lat double precision,
  stop_lon double precision,
  stop_code varchar,
  stop_desc varchar,
  zone_id varchar, --this column seemed empty, so type doesn't necessarily matter
  stop_url varchar,
  location_type varchar,
  parent_station varchar,
  stop_timezone varchar,
  wheelchair_boarding numeric,
  eta_station_id varchar
  );

\copy stops from './tarta_gtfs/stops.txt' WITH (FORMAT csv, DELIMITER ',', HEADER);

drop table if exists trips;
CREATE TABLE trips (
  route_id varchar,
  service_id numeric,
  trip_id numeric, --type should match trip_id from stop_times table
  shape_id varchar,
  trip_headsign varchar,
  trip_short_name varchar,
  direction_id numeric,
  block_id numeric,
  wheelchair_accessible numeric,
  bikes_allowed numeric,
  eta_train_id varchar,
  block_service_id varchar,
  block_name varchar
  );

\copy trips from './tarta_gtfs/trips.txt' DELIMITER ',' CSV HEADER;
