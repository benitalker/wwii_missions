CREATE TABLE mission (
    mission_id INTEGER PRIMARY KEY,                 -- Mission ID, auto-incremented primary key
    mission_date DATE,                             -- Mission Date, a date field
    theater_of_operations VARCHAR(100),            -- Theater of Operations, assuming text data
    country VARCHAR(100),                          -- Country, assuming text data
    air_force VARCHAR(100),                        -- Air Force, assuming text data
    unit_id VARCHAR(100),                          -- Unit ID, assuming text data
    aircraft_series VARCHAR(100),                  -- Aircraft Series, assuming text data
    callsign VARCHAR(100),                         -- Callsign, assuming text data
    mission_type VARCHAR(100),                     -- Mission Type, assuming text data
    takeoff_base VARCHAR(255),                     -- Takeoff Base, assuming larger text data
    takeoff_location VARCHAR(255),                 -- Takeoff Location, assuming larger text data
    takeoff_latitude VARCHAR(15),               -- Takeoff Latitude, assuming GPS latitude
    takeoff_longitude NUMERIC(10, 6),              -- Takeoff Longitude, assuming GPS longitude
    target_id VARCHAR(100),                        -- Target ID, assuming text or unique identifier
    target_country VARCHAR(100),                   -- Target Country, assuming text data
    target_city VARCHAR(100),                      -- Target City, assuming text data
    target_type VARCHAR(100),                      -- Target Type, assuming text data
    target_industry VARCHAR(255),                  -- Target Industry, assuming text data
    target_priority VARCHAR(5),                       -- Target Priority, assuming numerical data
    target_latitude NUMERIC(10, 6),                -- Target Latitude, assuming GPS latitude
    target_longitude NUMERIC(10, 6),               -- Target Longitude, assuming GPS longitude
    altitude_hundreds_of_feet NUMERIC(7, 2),             -- Altitude in hundreds of feet, assuming numerical data
    airborne_aircraft NUMERIC(4, 1),                     -- Airborne Aircraft, assuming numerical data
    attacking_aircraft INTEGER,                    -- Attacking Aircraft, assuming numerical data
    bombing_aircraft INTEGER,                      -- Bombing Aircraft, assuming numerical data
    aircraft_returned INTEGER,                     -- Aircraft Returned, assuming numerical data
    aircraft_failed INTEGER,                       -- Aircraft Failed, assuming numerical data
    aircraft_damaged INTEGER,                      -- Aircraft Damaged, assuming numerical data
    aircraft_lost INTEGER,                         -- Aircraft Lost, assuming numerical data
    high_explosives VARCHAR(255),                  -- High Explosives, assuming text
    high_explosives_type VARCHAR(255),             -- High Explosives Type, assuming text data
    high_explosives_weight_pounds VARCHAR(25),  -- High Explosives Weight in Pounds, assuming decimal data
    high_explosives_weight_tons NUMERIC(10, 2),    -- High Explosives Weight in Tons, assuming decimal data
    incendiary_devices VARCHAR(255),               -- Incendiary Devices, assuming text data
    incendiary_devices_type VARCHAR(255),          -- Incendiary Devices Type, assuming text data
    incendiary_devices_weight_pounds NUMERIC(10, 2), -- Incendiary Devices Weight in Pounds, assuming decimal data
    incendiary_devices_weight_tons NUMERIC(10, 2),   -- Incendiary Devices Weight in Tons, assuming decimal data
    fragmentation_devices VARCHAR(255),            -- Fragmentation Devices, assuming text data
    fragmentation_devices_type VARCHAR(255),       -- Fragmentation Devices Type, assuming text data
    fragmentation_devices_weight_pounds NUMERIC(10, 2), -- Fragmentation Devices Weight in Pounds, assuming decimal data
    fragmentation_devices_weight_tons NUMERIC(10, 2),   -- Fragmentation Devices Weight in Tons, assuming decimal data
    total_weight_pounds NUMERIC(10, 2),            -- Total Weight in Pounds, assuming decimal data
    total_weight_tons NUMERIC(10, 2),              -- Total Weight in Tons, assuming decimal data
    time_over_target VARCHAR(8),                         -- Time Over Target, assuming time data
    bomb_damage_assessment VARCHAR(255),           -- Bomb Damage Assessment, assuming text data
    source_id VARCHAR(100)                         -- Source ID, assuming text or unique identifier
);
