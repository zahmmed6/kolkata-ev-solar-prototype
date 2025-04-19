-- Minetest Lua script for Kolkata EV and Solar Integration Prototype
-- This script creates the basic structures and elements for the Kolkata city model

-- Define materials
local function register_materials()
    -- Building materials
    minetest.register_node("kolkata:red_brick", {
        description = "Kolkata Red Brick",
        tiles = {"default_brick.png^[colorize:#8B4513:80"},
        groups = {cracky = 3},
        is_ground_content = false,
    })
    
    -- Road materials
    minetest.register_node("kolkata:asphalt", {
        description = "Kolkata Road Asphalt",
        tiles = {"default_stone.png^[colorize:#333333:200"},
        groups = {cracky = 2},
        is_ground_content = false,
    })
    
    -- Solar panel
    minetest.register_node("kolkata:solar_panel", {
        description = "Advanced Solar Panel",
        tiles = {"default_obsidian_glass.png^[colorize:#000080:120"},
        groups = {cracky = 3},
        is_ground_content = false,
        light_source = 5,
    })
    
    -- EV charging station
    minetest.register_node("kolkata:ev_charger", {
        description = "EV Charging Station",
        tiles = {"default_steel_block.png^[colorize:#00FF00:80"},
        groups = {cracky = 2},
        is_ground_content = false,
        light_source = 10,
    })
end

-- Create Park Street area
local function build_park_street(pos)
    local width = 50
    local length = 120
    local height = 1
    
    -- Create main road
    for x = pos.x, pos.x + length do
        for z = pos.z - 5, pos.z + 5 do
            minetest.set_node({x=x, y=pos.y, z=z}, {name="kolkata:asphalt"})
        end
    end
    
    -- Create buildings on both sides of the road
    for i = 1, 10 do
        -- North side buildings
        local building_pos_n = {x = pos.x + i * 10, y = pos.y + 1, z = pos.z + 10}
        build_commercial_building(building_pos_n, 8, 8, math.random(3, 5))
        
        -- South side buildings
        local building_pos_s = {x = pos.x + i * 10, y = pos.y + 1, z = pos.z - 10}
        build_commercial_building(building_pos_s, 8, 8, math.random(3, 5))
        
        -- Add EV charging stations
        if i % 3 == 0 then
            minetest.set_node({x = building_pos_n.x, y = pos.y + 1, z = pos.z + 7}, {name="kolkata:ev_charger"})
            minetest.set_node({x = building_pos_s.x, y = pos.y + 1, z = pos.z - 7}, {name="kolkata:ev_charger"})
        end
    end
    
    -- Add bus stops with solar panels
    for i = 1, 4 do
        local bus_stop_pos = {x = pos.x + i * 30, y = pos.y + 1, z = pos.z + 6}
        build_bus_stop(bus_stop_pos)
    end
    
    return {x = pos.x + length, y = pos.y, z = pos.z} -- Return end position
end

-- Create Victoria Memorial area
local function build_victoria_memorial(pos)
    local size = 40
    
    -- Create the main building (simplified)
    for x = pos.x - size/2, pos.x + size/2 do
        for z = pos.z - size/2, pos.z + size/2 do
            -- Create foundation
            minetest.set_node({x=x, y=pos.y, z=z}, {name="default:stone"})
            
            -- Create walls
            if x == pos.x - size/2 or x == pos.x + size/2 or z == pos.z - size/2 or z == pos.z + size/2 then
                for y = pos.y + 1, pos.y + 10 do
                    minetest.set_node({x=x, y=y, z=z}, {name="default:sandstone"})
                end
            end
        end
    end
    
    -- Create dome
    for y = 1, 15 do
        local radius = 15 - y/2
        for x = -radius, radius do
            for z = -radius, radius do
                if x*x + z*z <= radius*radius then
                    minetest.set_node({x=pos.x+x, y=pos.y+10+y, z=pos.z+z}, {name="default:sandstone"})
                end
            end
        end
    end
    
    -- Create surrounding gardens
    for x = pos.x - size, pos.x + size do
        for z = pos.z - size, pos.z + size do
            if not (x >= pos.x - size/2 and x <= pos.x + size/2 and z >= pos.z - size/2 and z <= pos.z + size/2) then
                minetest.set_node({x=x, y=pos.y, z=z}, {name="default:dirt_with_grass"})
                
                -- Add some trees and plants randomly
                if math.random(1, 20) == 1 then
                    minetest.place_schematic({x=x, y=pos.y+1, z=z}, minetest.get_modpath("default").."/schematics/tree.mts", "random", nil, false)
                end
            end
        end
    end
    
    -- Add solar-powered EV charging stations in the parking area
    for i = 1, 5 do
        local charger_pos = {x = pos.x - size - 5, y = pos.y + 1, z = pos.z - size/2 + i * 10}
        minetest.set_node(charger_pos, {name="kolkata:ev_charger"})
        
        -- Add solar panel above charger
        minetest.set_node({x = charger_pos.x, y = charger_pos.y + 3, z = charger_pos.z}, {name="kolkata:solar_panel"})
    end
    
    return {x = pos.x, y = pos.y, z = pos.z + size + 10} -- Return position for next area
end

-- Create Alipore Zoo area
local function build_alipore_zoo(pos)
    local width = 80
    local length = 100
    
    -- Create zoo grounds
    for x = pos.x - width/2, pos.x + width/2 do
        for z = pos.z, pos.z + length do
            minetest.set_node({x=x, y=pos.y, z=z}, {name="default:dirt_with_grass"})
        end
    end
    
    -- Create zoo entrance
    for x = pos.x - 5, pos.x + 5 do
        for z = pos.z - 2, pos.z do
            minetest.set_node({x=x, y=pos.y, z=z}, {name="default:stonebrick"})
        end
    end
    
    -- Create entrance arch
    for x = pos.x - 5, pos.x + 5 do
        for y = pos.y + 1, pos.y + 5 do
            minetest.set_node({x=x, y=y, z=pos.z}, {name="default:stonebrick"})
        end
    end
    
    -- Create animal enclosures
    for i = 1, 5 do
        local enclosure_pos_x = pos.x - width/3 + (i % 3) * 25
        local enclosure_pos_z = pos.z + 20 + math.floor(i/3) * 40
        build_animal_enclosure({x=enclosure_pos_x, y=pos.y, z=enclosure_pos_z}, 20, 20)
    end
    
    -- Create administrative building with solar roof
    local admin_pos = {x = pos.x + width/3, y = pos.y + 1, z = pos.z + length - 20}
    build_admin_building(admin_pos, 15, 10, 3)
    
    -- Add solar-powered zoo transport stations
    for i = 1, 3 do
        local station_pos = {x = pos.x - width/3, y = pos.y + 1, z = pos.z + i * 30}
        build_transport_station(station_pos)
    end
    
    return {x = pos.x, y = pos.y, z = pos.z + length + 10} -- Return position for next area
end

-- Helper function to build a commercial building with solar panels
local function build_commercial_building(pos, width, length, height)
    -- Create building structure
    for x = pos.x, pos.x + width do
        for z = pos.z, pos.z + length do
            for y = pos.y, pos.y + height do
                if y == pos.y + height then
                    -- Roof with solar panels
                    minetest.set_node({x=x, y=y, z=z}, {name="kolkata:solar_panel"})
                elseif x == pos.x or x == pos.x + width or z == pos.z or z == pos.z + length then
                    -- Walls
                    minetest.set_node({x=x, y=y, z=z}, {name="kolkata:red_brick"})
                    
                    -- Add windows
                    if (x == pos.x or x == pos.x + width) and z > pos.z and z < pos.z + length and y > pos.y and y < pos.y + height and y % 2 == 0 then
                        minetest.set_node({x=x, y=y, z=z}, {name="default:glass"})
                    end
                    if (z == pos.z or z == pos.z + length) and x > pos.x and x < pos.x + width and y > pos.y and y < pos.y + height and y % 2 == 0 then
                        minetest.set_node({x=x, y=y, z=z}, {name="default:glass"})
                    end
                end
            end
        end
    end
    
    -- Add door
    minetest.set_node({x=pos.x + width/2, y=pos.y, z=pos.z}, {name="air"})
    minetest.set_node({x=pos.x + width/2, y=pos.y + 1, z=pos.z}, {name="air"})
end

-- Helper function to build a bus stop with solar roof
local function build_bus_stop(pos)
    -- Create platform
    for x = pos.x - 2, pos.x + 2 do
        for z = pos.z, pos.z + 4 do
            minetest.set_node({x=x, y=pos.y, z=z}, {name="default:stonebrick"})
        end
    end
    
    -- Create supports
    minetest.set_node({x=pos.x - 2, y=pos.y + 1, z=pos.z}, {name="default:steel_block"})
    minetest.set_node({x=pos.x - 2, y=pos.y + 2, z=pos.z}, {name="default:steel_block"})
    minetest.set_node({x=pos.x + 2, y=pos.y + 1, z=pos.z}, {name="default:steel_block"})
    minetest.set_node({x=pos.x + 2, y=pos.y + 2, z=pos.z}, {name="default:steel_block"})
    
    -- Create solar panel roof
    for x = pos.x - 2, pos.x + 2 do
        for z = pos.z, pos.z + 3 do
            minetest.set_node({x=x, y=pos.y + 3, z=z}, {name="kolkata:solar_panel"})
        end
    end
    
    -- Add EV charging point
    minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z + 1}, {name="kolkata:ev_charger"})
end

-- Helper function to build an animal enclosure
local function build_animal_enclosure(pos, width, length)
    -- Create fence
    for x = pos.x, pos.x + width do
        for z = pos.z, pos.z + length do
            if x == pos.x or x == pos.x + width or z == pos.z or z == pos.z + length then
                minetest.set_node({x=x, y=pos.y + 1, z=z}, {name="default:fence_wood"})
            end
        end
    end
    
    -- Create some terrain features inside
    for i = 1, 5 do
        local feature_x = pos.x + math.random(2, width - 2)
        local feature_z = pos.z + math.random(2, length - 2)
        
        -- Either a tree or a water hole
        if math.random(1, 2) == 1 then
            minetest.place_schematic({x=feature_x, y=pos.y+1, z=feature_z}, minetest.get_modpath("default").."/schematics/tree.mts", "random", nil, false)
        else
            for dx = -1, 1 do
                for dz = -1, 1 do
                    minetest.set_node({x=feature_x + dx, y=pos.y, z=feature_z + dz}, {name="default:water_source"})
                end
            end
        end
    end
end

-- Helper function to build an administrative building with solar roof
local function build_admin_building(pos, width, length, height)
    -- Create building structure
    for x = pos.x, pos.x + width do
        for z = pos.z, pos.z + length do
            for y = pos.y, pos.y + height do
                if y == pos.y + height then
                    -- Roof with solar panels
                    minetest.set_node({x=x, y=y, z=z}, {name="kolkata:solar_panel"})
                elseif x == pos.x or x == pos.x + width or z == pos.z or z == pos.z + length then
                    -- Walls
                    minetest.set_node({x=x, y=y, z=z}, {name="default:stonebrick"})
                    
                    -- Add windows
                    if (x == pos.x or x == pos.x + width) and z > pos.z and z < pos.z + length and y > pos.y and y < pos.y + height and y % 2 == 0 then
                        minetest.set_node({x=x, y=y, z=z}, {name="default:glass"})
                    end
                    if (z == pos.z or z == pos.z + length) and x > pos.x and x < pos.x + width and y > pos.y and y < pos.y + height and y % 2 == 0 then
                        minetest.set_node({x=x, y=y, z=z}, {name="default:glass"})
                    end
                end
            end
        end
    end
    
    -- Add door
    minetest.set_node({x=pos.x + width/2, y=pos.y, z=pos.z}, {name="air"})
    minetest.set_node({x=pos.x + width/2, y=pos.y + 1, z=pos.z}, {name="air"})
    
    -- Add sign
    minetest.set_node({x=pos.x + width/2, y=pos.y + 2, z=pos.z - 1}, {name="default:sign_wall_wood"})
    local meta = minetest.get_meta({x=pos.x + width/2, y=pos.y + 2, z=pos.z - 1})
    meta:set_string("text", "Zoo Administration\nSolar Powered")
end

-- Helper function to build a transport station
local function build_transport_station(pos)
    -- Create platform
    for x = pos.x - 2, pos.x + 2 do
        for z = pos.z - 2, pos.z + 2 do
            minetest.set_node({x=x, y=pos.y, z=z}, {name="default:stonebrick"})
        end
    end
    
    -- Create solar panel roof
    for x = pos.x - 2, pos.x + 2 do
        for z = pos.z - 2, pos.z + 2 do
            minetest.set_node({x=x, y=pos.y + 3, z=z}, {name="kolkata:solar_panel"})
        end
    end
    
    -- Create supports
    minetest.set_node({x=pos.x - 2, y=pos.y + 1, z=pos.z - 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x - 2, y=pos.y + 2, z=pos.z - 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x + 2, y=pos.y + 1, z=pos.z - 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x + 2, y=pos.y + 2, z=pos.z - 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x - 2, y=pos.y + 1, z=pos.z + 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x - 2, y=pos.y + 2, z=pos.z + 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x + 2, y=pos.y + 1, z=pos.z + 2}, {name="default:steel_block"})
    minetest.set_node({x=pos.x + 2, y=pos.y + 2, z=pos.z + 2}, {name="default:steel_block"})
    
    -- Add EV transport vehicle (simplified)
    minetest.set_node({x=pos.x, y=pos.y + 1, z=pos.z}, {name="kolkata:ev_charger"})
    
    -- Add sign
    minetest.set_node({x=pos.x, y=pos.y + 2, z=pos.z - 3}, {name="default:sign_wall_wood"})
    local meta = minetest.get_meta({x=pos.x, y=pos.y + 2, z=pos.z - 3})
    meta:set_string("text", "Solar-Powered\nZoo Transport")
end

-- Main function to create the entire city
local function create_kolkata_city()
    -- Starting position
    local start_pos = {x = 0, y = 0, z = 0}
    
    -- Register custom materials
    register_materials()
    
    -- Create flat terrain base
    for x = -100, 300 do
        for z = -100, 300 do
            minetest.set_node({x=x, y=-1, z=z}, {name="default:dirt"})
            minetest.set_node({x=x, y=0, z=z}, {name="default:dirt_with_grass"})
        end
    end
    
    -- Build Park Street
    local park_street_end = build_park_street(start_pos)
    
    -- Build Victoria Memorial
    local victoria_pos = {x = park_street_end.x + 50, y = park_street_end.y, z = park_street_end.z - 50}
    local victoria_end = build_victoria_memorial(victoria_pos)
    
    -- Build Alipore Zoo
    local zoo_pos = {x = victoria_end.x - 100, y = victoria_end.y, z = victoria_end.z + 30}
    local zoo_end = build_alipore_zoo(zoo_pos)
    
    -- Connect areas with roads
    -- Park Street to Victoria Memorial
    for x = park_street_end.x, victoria_pos.x do
        for z = park_street_end.z - 3, park_street_end.z + 3 do
            minetest.set_node({x=x, y=park_street_end.y, z=z}, {name="kolkata:asphalt"})
        end
    end
    
    -- Victoria Memorial to Alipore Zoo
    for x = math.min(victoria_pos.x, zoo_pos.x), math.max(victoria_pos.x, zoo_pos.x) do
        for z = victoria_end.z - 3, victoria_end.z + 3 do
            minetest.set_node({x=x, y=victoria_end.y, z=z}, {name="kolkata:asphalt"})
        end
    end
    
    -- Add solar-powered street lights along roads
    for i = 1, 20 do
        -- Park Street to Victoria Memorial
        local light_pos_x = park_street_end.x + i * 10
        if light_pos_x <= victoria_pos.x then
            minetest.set_node({x=light_pos_x, y=park_street_end.y + 1, z=park_street_end.z + 4}, {name="default:mese_post_light"})
            minetest.set_node({x=light_pos_x, y=park_street_end.y + 4, z=park_street_end.z + 4}, {name="kolkata:solar_panel"})
        end
        
        -- Victoria Memorial to Alipore Zoo
        if i <= 10 then
            local light_pos_x = victoria_pos.x - i * 10
            minetest.set_node({x=light_pos_x, y=victoria_end.y + 1, z=victoria_end.z + 4}, {name="default:mese_post_light"})
            minetest.set_node({x=light_pos_x, y=victoria_end.y + 4, z=victoria_end.z + 4}, {name="kolkata:solar_panel"})
        end
    end
    
    -- Add information signs
    local info_pos = {x = start_pos.x + 10, y = start_pos.y + 1, z = start_pos.z - 10}
    minetest.set_node(info_pos, {name="default:sign_wall_wood"})
    local meta = minetest.get_meta(info_pos)
    meta:set_string("text", "Kolkata EV & Solar\nIntegration Project\nSandbox CCU 2025")
    
    -- Add project explanation sign
    local explanation_pos = {x = start_pos.x + 15, y = start_pos.y + 1, z = start_pos.z - 10}
    minetest.set_node(explanation_pos, {name="default:sign_wall_wood"})
    local meta = minetest.get_meta(explanation_pos)
    meta:set_string("text", "This prototype demonstrates\nEV and solar integration\nto reduce pollution in Kolkata")
end

-- Register initialization
minetest.register_on_mapgen_init(function(mgparams)
    minetest.set_mapgen_params({mgname = "singlenode"})
end)

-- Create city when game starts
minetest.register_on_generated(function(minp, maxp, seed)
    if minp.x == 0 and minp.y == 0 and minp.z == 0 then
        minetest.after(1, create_kolkata_city)
    end
end)
