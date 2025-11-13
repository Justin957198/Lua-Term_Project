local terrain_module = require("level_generator")
local movement_module = require("movement_controls")
local reward_system = require("reward_system")

local player_Moved = "."
local player_Symbol = "P"

-- Check player position function
local function player_Location(player_x, player_y, maze)
    local bomb, treasure, blank, win = movement_module.check_player(player_x, player_y, maze)
    local shield = reward_system.player_stats.shield
    if bomb == true and shield == false then
        io.write("Bomb hit, Game Over\n")
        return false
    elseif bomb == true and shield == true then
        io.write("Bomb hit, but your shield saved you\n")
        reward_system.player_stats.shield = false
    elseif treasure == true then 
        io.write("Item found\n")
        reward_system.apply_reward(player_x, player_y, maze)
    elseif win == true then
        io.write("Congrats! You won!\n")
        os.exit()
    else
        io.write("Nothing here\n")
    end
    return true
end

print("Sample Terrain making tool") -- temp

local numleng
local numdep

print("Input terrain length")
numdep = io.read()
local depth = tonumber(numdep)
print("Input terrain depth")
numleng = io.read()
local length = tonumber(numleng)

--print(depth .. " and " .. length)

local maze = terrain_module.terrain_generator(depth, length)
terrain_module.bomb_generator()
terrain_module.treasure_generator()

io.write("Test maze, length: " .. #maze .. " width: " .. #maze[1] .. "\n")

-- Player Starting Position
local player_x, player_y = 1, math.random(1, numdep)
maze[player_x][player_y] = player_Symbol

local win_x, win_y = length, math.random(1, numdep)
terrain_module.generate_win(win_y, win_x)

local continue_Game = true

while continue_Game do
    if reward_system.player_stats.bomb_scanner == true then
        terrain_module.reveal_bombs(maze)
        reward_system.reset_turn_bonuses()
    else
        terrain_module.terrain_display()
    end
    print("\nUse w/a/s/d to move or q to exit:")
    local move = io.read()

    maze[player_x][player_y] = player_Moved
    if move == "w" then
        if maze[player_x] and maze[player_x][player_y] then
            if reward_system.player_stats.dig_power ~= 1 then
               player_x, player_y = movement_module.move_up(player_x, player_y, maze) 
               player_x, player_y = movement_module.move_up(player_x, player_y, maze)
               maze[player_x + 1][player_y] = player_Moved
               reward_system.reset_turn_bonuses()
            else
                player_x, player_y = movement_module.move_up(player_x, player_y, maze)
            end
            continue_Game = player_Location(player_x, player_y, maze)
        else
            print("Your out of bounds\n")
        end
    elseif move == "s" then
        if maze[player_x] and maze[player_x][player_y] then
            if reward_system.player_stats.dig_power ~= 1 then
                player_x, player_y = movement_module.move_down(player_x, player_y, maze)
                player_x, player_y = movement_module.move_down(player_x, player_y, maze)
                maze[player_x - 1][player_y] = player_Moved
                reward_system.reset_turn_bonuses()
            else
                player_x, player_y = movement_module.move_down(player_x, player_y, maze)
            end
            continue_Game = player_Location(player_x, player_y, maze)
        else
            print("Your out of bounds\n")
        end
    elseif move == "a" then
        if maze[player_x] and maze[player_x][player_y] then
            if reward_system.player_stats.dig_power ~= 1 then
                player_x, player_y = movement_module.move_left(player_x, player_y, maze)
                player_x, player_y = movement_module.move_left(player_x, player_y, maze)
                maze[player_x][player_y + 1] = player_Moved
                reward_system.reset_turn_bonuses()
            else
                player_x, player_y = movement_module.move_left(player_x, player_y, maze)
            end
            continue_Game = player_Location(player_x, player_y, maze)
        else
            print("Your out of bounds\n")
        end
    elseif move == "d" then
        if maze[player_x] and maze[player_x][player_y] then
            if reward_system.player_stats.dig_power ~= 1 then
                player_x, player_y = movement_module.move_right(player_x, player_y, maze)
                player_x, player_y = movement_module.move_right(player_x, player_y, maze)
                maze[player_x][player_y - 1] = player_Moved
                reward_system.reset_turn_bonuses()
            else
                player_x, player_y = movement_module.move_right(player_x, player_y, maze)
            end
            continue_Game = player_Location(player_x, player_y, maze)
        else
            print("Your out of bounds\n")
        end
    elseif move == "q" then
        print("Exiting game...")
        break
    end

    if maze[player_x] and maze[player_x][player_y] then
        maze[player_x][player_y] = player_Symbol 
    end
end
