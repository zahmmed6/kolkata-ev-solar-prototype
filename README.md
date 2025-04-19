# Kolkata EV and Solar Integration Prototype - README

## Project Overview
This Minetest prototype simulates the deployment of high-capacity electric vehicles (EVs) and advanced solar panel technologies in Kolkata's transportation system to address the city's pollution issues. The prototype is part of the Sandbox CCU 2025 challenge hosted by Make Calcutta Relevant Again.

## Key Features

### 1. Famous Kolkata Landmarks
- **Park Street**: Commercial hub with EV bus stations, solar-powered charging points, and dedicated EV lanes
- **Victoria Memorial**: Historical landmark featuring solar-powered tourist EVs and heritage-sensitive solar panel integration
- **Alipore Zoo**: Recreational area with solar-powered zoo transport and educational displays about EV and solar technology

### 2. EV Transportation System
- High-capacity electric buses connecting major areas
- Electric tram lines utilizing existing infrastructure
- EV charging stations at strategic locations
- Solar-powered street lighting along transportation routes

### 3. Solar Panel Integration
- Rooftop solar arrays on commercial and residential buildings
- Solar canopies over parking areas and bus stops
- Solar-powered street lighting
- Educational displays showing benefits of solar energy

## Installation Instructions

### Prerequisites
- Minetest 5.4.0 or higher
- Required mods:
  - worldedit
  - basic_materials
  - mesecons

### Setup
1. Install Minetest:
   ```
   sudo apt-get update && sudo apt-get install -y minetest minetest-mod-worldedit minetest-mod-basic-materials minetest-mod-mesecons
   ```

2. Clone this repository:
   ```
   git clone https://github.com/zahmmed6/kolkata-ev-solar-prototype.git
   ```

3. Copy the world folder to your Minetest worlds directory:
   ```
   cp -r kolkata-ev-solar-prototype/worlds/kolkata_ev_solar ~/.minetest/worlds/
   ```

4. Launch Minetest and select the "kolkata_ev_solar" world

## Usage Guide

### Navigation
- Use WASD keys to move around
- Space to jump
- Shift to sneak/slow down
- Mouse to look around

### Key Points of Interest
1. **Park Street** (coordinates: 0,0,0)
   - Observe the EV bus stations with solar-powered charging points
   - Notice the solar panels on commercial building rooftops

2. **Victoria Memorial** (coordinates: 50,0,-50)
   - Explore the solar-powered tourist EV stations
   - See how solar panels are integrated with heritage-sensitive design

3. **Alipore Zoo** (coordinates: -50,0,80)
   - Visit the solar-powered zoo transport stations
   - Read the educational displays about EV and solar technology

### Educational Elements
- Information signs throughout the prototype explain the technologies
- Comparative displays show before/after pollution levels
- Cost-benefit analysis displays demonstrate economic advantages

## Technical Implementation

The prototype is built using Minetest's Lua API and includes:

- Custom nodes for EVs, charging stations, and solar panels
- Automated building generation for Kolkata's distinctive architecture
- Simulated transportation network with EV integration
- Solar power generation and distribution system

## Project Context

This prototype is part of a comprehensive solution addressing Kolkata's pollution issues through:

1. Identifying major pollution sources ("Drunk Elephants"):
   - Aging diesel vehicles
   - Ad-hoc diesel generators
   - Brick kilns
   - Water-pump sets

2. Proposing realistic solutions:
   - High-capacity electric vehicles for public transportation
   - Advanced solar panel technologies for clean energy generation
   - Integration of EV charging infrastructure with solar power

## Credits

Developed for the Sandbox CCU 2025 challenge hosted by Make Calcutta Relevant Again.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
