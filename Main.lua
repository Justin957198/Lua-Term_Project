local terrain_module = require("level_generator")
local movement_module = require("movement_controls")
local reward_system = require("reward_system")
local character = require("character_class")

local player_Moved = "."
local player_Symbol = "P"
local user = character:load()

reward_system.set_user(user)

-- Check player position function
local function player_Location(player_x, player_y, maze)
    local bomb, treasure, blank, win = movement_module.check_player(player_x, player_y, maze)
    local shield = reward_system.player_stats.shield
    if bomb == true and shield == false then
        io.write("Bomb hit, Game Over\n")
        user:add_loss()
        user:save()
        return false
    elseif bomb == true and shield == true then
        io.write("Bomb hit, but your shield saved you\n")
        reward_system.player_stats.shield = false
    elseif treasure == true then 
        io.write("Item found\n")
        reward_system.apply_reward(player_x, player_y, maze)
    elseif win == true then
        io.write("Congrats! You won!\n")
        user:add_win()
        user:save()
        os.exit()
    else
        io.write("Nothing here\n")
    end
    return true
end

print("\n\n\n⭐⭐⭐Sample Terrain making tool⭐⭐⭐") -- temp

local char_name
local char_age

if user:get_name() ~= "" then
    print("\nWelcome,", user:get_name())
else
    print("\nHello, please enter user name:")
    local char_name = io.read()
    user:set_name(char_name)

    print("\nPlease enter user age:")
    local char_age = io.read()
    user:set_age(tonumber(char_age))  -- convert input to number

    user:save()

    print("\nCharacter created:", user:get_name(), user:get_age())
end

print("\n                                _____Main Menu_____")
print("\n                   Enter the coresspoding numbers to select options!\n\n1. Start game     2. Change Player Settings     3. Player Stats      4. Exit       5. RESET PLAYER!")
local useroption = tonumber(io.read())

if useroption == 1 then
    local numleng = 12
    local numdep = 12
    local Difficulty

    print("\nInput Icon")
    player_Symbol = io.read()
    local depth = tonumber(numdep)
    print("\nInput Difficulty: 1-3")
    Difficulty = io.read()
    local length = tonumber(numleng)

    --print(depth .. " and " .. length)

    local maze = terrain_module.terrain_generator(depth, length)
    terrain_module.bomb_generator(Difficulty)
    terrain_module.treasure_generator(Difficulty)

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

elseif useroption == 2 then

    print("\nPlease enter new user name:")
    local char_name = io.read()
    user:set_name(char_name)

    print("\nPlease enter new user age:")
    local char_age = io.read()
    user:set_age(tonumber(char_age))  -- convert input to number

    user:save()

    print("\nCharacter saved:", user:get_name(), user:get_age())

elseif useroption == 3 then

    print("\nPlayer Stats")
    user:getUserStats()

elseif useroption == 4 then
    print("\nThank you for playing!\n")

elseif useroption == 5 then
    user:reset()
    print("\nPlayer Data has been reset! Please launch application again to play!\n")
end
