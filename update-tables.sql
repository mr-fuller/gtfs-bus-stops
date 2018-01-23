drop table agency;
drop table calendar;
drop table calendar_dates;
drop table routes;
drop table shapes;
drop table stop_times;
drop table stops;
drop table trips;

create table agency (
  agency_id varchar,
  agency_name varchar,
  agency_url varchar,
  agency_timezone varchar,
  agency_lang varchar,
  agency_phone varchar,
  agency_fare_url varchar);
  
  \copy agency from '~/agency.txt' DELIMITER ',' CSV HEADER;
  
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
  end_date varchar);
  
  \copy calendar from '~/calendar.txt' DELIMITER ',' CSV HEADER;
  
create table calendar_dates (
  service_id numeric,
  date date,
  exception_type numeric);
  \copy calendar_dates from '~/calendar_dates.txt' DELIMITER ',' CSV HEADER;
  
create table routes (
  route_id numeric,
  agency_id varchar,
  route_short_name varchar,
  route_long_name varchar,
  route_desc varchar,
  route_type numeric,
  route_url varchar,
  route_color varchar,
  route_text_color varchar);
  
  
\copy routes from '~/routes.txt' DELIMITER ',' CSV HEADER;

create table shapes (
  shape_id numeric,
  shape_pt_lat double precision,
  shape_pt_lon double precision,
  shape_pt_sequence numeric,
  shape_dist_traveled double precision);
  
  
\copy shapes from '~/shapes.txt' DELIMITER ',' CSV HEADER;

create table stop_times (
  trip_id numeric,
  arrival_time time,
  departure_time time,
  stop_id numeric,
  stop_sequence numeric,
  stop_headsign varchar,
  pickup_type numeric,
  drop_off_type numeric,
  shape_dist_traveled double precision);
  
\copy stop_times from '~/stop_times.txt' DELIMITER ',' CSV HEADER;


create TABLE stops (
  stop_id numeric,
  stop_name varchar,
  stop_desc varchar,
  stop_lat double precision,
  stop_lon double precision,
  zone_id varchar, --this column seemed empty, so type doesn't necessarily matter
  stop_url varchar,
  location_type varchar,
  parent_station varchar,
  stop_timezone varchar,
  wheelchair_boarding numeric);
  
\copy stops from '~/stops.txt' DELIMITER ',' CSV HEADER;  
  
CREATE TABLE trips (
  route_id numeric,
  service_id numeric,
  trip_id numeric, --type should match trip_id from stop_times table
  trip_headsign varchar,
  trip_short_name varchar,
  direction_id numeric,
  block_id numeric,
  shape_id numeric,
  wheelchair_accessible numeric,
  bikes_allowed numeric);
  
\copy trips from '~/trips.txt' DELIMITER ',' CSV HEADER;  


  
