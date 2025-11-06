local terrain_module = require("level_generator")
local movement_module = require("movement_controls")

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

local maze = terrain_module.terrain_generator(depth, length)
terrain_module.bomb_generator()
terrain_module.treasure_generator()
terrain_module.terrain_display()

-- Player Starting Position
local player_x, player_y = 1, 1
maze[player_x][player_y] = "P"

while true do
    os.execute("clear") -- clear terminal

    terrain_module.terrain_display()
    print("\nUse w/a/s/d to move:")
    local move = io.read()

    maze[player_x][player_y] = "?"
    if move == "w" then
        player_x, player_y = movement_module.move_up(player_x, player_y, maze)
    elseif move == "s" then
        player_x, player_y = movement_module.move_down(player_x, player_y, maze)
    elseif move == "a" then
        player_x, player_y = movement_module.move_left(player_x, player_y, maze)
    elseif move == "d" then
        player_x, player_y = movement_module.move_right(player_x, player_y, maze)
    end
    maze[player_x][player_y] = "P"
end
