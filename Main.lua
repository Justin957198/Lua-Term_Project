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

-- Player Starting Position
local player_x, player_y = 1, math.random(1, numdep)
local player_Symbol = "P"
maze[player_x][player_y] = player_Symbol

while true do
    terrain_module.terrain_display()
    print("\nUse w/a/s/d to move or q to exit:")
    local move = io.read()

    maze[player_x][player_y] = "."
    if move == "w" then
        if maze[player_x] and maze[player_x][player_y] then
            player_x, player_y = movement_module.move_up(player_x, player_y, maze)
        else
            print("Your out of bounds")
        end
    elseif move == "s" then
        if maze[player_x] and maze[player_x][player_y] then
            player_x, player_y = movement_module.move_down(player_x, player_y, maze)
        else
            print("Your out of bounds")
        end
    elseif move == "a" then
        if maze[player_x] and maze[player_x][player_y] then
            player_x, player_y = movement_module.move_left(player_x, player_y, maze)
        else
            print("Your out of bounds")
        end
    elseif move == "d" then
        if maze[player_x] and maze[player_x][player_y] then
            player_x, player_y = movement_module.move_right(player_x, player_y, maze)
        else
            print("Your out of bounds")
        end
    elseif move == "q" then
        print("Exiting game...")
        break
    end

    if maze[player_x] and maze[player_x][player_y] then
        maze[player_x][player_y] = player_Symbol 
    end
end
