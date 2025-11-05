local terrain_module = require("level_generator")

print("Sample Terrain making tool") -- temp


local numleng
local numdep

print("Input terrain depth")
numdep = io.read()
local depth = tonumber(numdep)
print("Input terrain length")
numleng = io.read()
local length = tonumber(numleng)

--print(depth .. " and " .. length)

terrain_module.terrain_generator(depth, length)
terrain_module.bomb_generator()
terrain_module.treasure_generator()
terrain_module.terrain_display()
