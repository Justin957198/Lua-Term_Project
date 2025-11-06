local reward_system = require("reward_system")
local terrian_module = require("level_generator")

-- This is where ther movment metholds will go
local movement_m = {}

function movement_m.move_up(x_p, y_p, maze)
    if maze[x_p - 1] == nil or maze[x_p - 1][y_p] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p .. "\n")
        return x_p, y_p
    elseif maze[x_p - 1][y_p] == 0 then
        if reward_system.player_stats.shield then
            print("You hit a bomb but your shield saved you!")
            reward_system.player_stats.shield = false
            maze[x_p - 1][y_p] = "."
            return x_p - 1, y_p
        else
            io.write("you hit a bomb! Game over!\n")
          os.exit()
        end
    elseif maze[x_p - 1][y_p]  == 2 then
        reward_system.apply_reward(x_p - 1, y_p, maze)
        maze[x_p - 1][y_p] = "." -- reset tile
    else
        x_p = x_p - 1
    end

    if reward_system.player_stats.dig_power == 2 then
        x_p, y_p = movement_m.move_up(x_p,y_p,maze)
    end

    if reward_system.player_stats.bomb_scanner then
        terrian_module.reveal_bombs(maze)
    end

    reward_system.reset_turn_bonuses()
    return x_p, y_p
end

function movement_m.move_down(x_p, y_p, maze)
    if maze[x_p + 1] == nil  or maze[x_p + 1][y_p] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p .. "\n")
        return x_p, y_p
    elseif(maze[x_p + 1][y_p] == 0) then
        if reward_system.player_stats.shield then
            print("You hit a bomb but your shield saved you!")
            reward_system.player_stats.shield = false
            maze[x_p + 1][y_p] = "."
            return x_p + 1, y_p
        else
            io.write("you hit a bomb! Game over!\n")
            os.exit()
        end
    elseif maze[x_p + 1][y_p]  == 2 then
        reward_system.apply_reward(x_p + 1, y_p, maze)
        maze[x_p + 1][y_p] = "." -- reset tile
    else
        x_p = x_p + 1
    end

    if reward_system.player_stats.dig_power == 2 then
        x_p, y_p = movement_m.move_down(x_p,y_p,maze)
    end

    if reward_system.player_stats.bomb_scanner then
        terrian_module.reveal_bombs(maze)
    end

    reward_system.reset_turn_bonuses()
    return x_p, y_p
end

function movement_m.move_left(x_p, y_p, maze)
    if maze[x_p][y_p - 1] == nil or maze[y_p - 1] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p .. "\n")
        return x_p, y_p
    elseif maze[x_p][y_p - 1] == 0 then -- Bomb Detection
        if reward_system.player_stats.shield then
            print("You hit a bomb but your shield saved you!")
            reward_system.player_stats.shield = false
            maze[x_p][y_p - 1] = "."
            return x_p, y_p - 1
        else
            io.write("you hit a bomb! Game over!\n")
            os.exit()
        end
    elseif maze[x_p][y_p - 1]  == 2 then
        reward_system.apply_reward(x_p, y_p - 1, maze)
        maze[x_p][y_p + 1] = "." -- reset tile
    else
        y_p = y_p - 1
    end

    if reward_system.player_stats.dig_power == 2 then
        x_p, y_p = movement_m.move_left(x_p,y_p,maze)
    end

    if reward_system.player_stats.bomb_scanner then
        terrian_module.reveal_bombs(maze)
    end

    reward_system.reset_turn_bonuses()
    return x_p, y_p
end

function movement_m.move_right(x_p, y_p, maze)
    if maze[x_p][y_p + 1] == nil or maze[y_p + 1] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p .. "\n")
        return x_p, y_p
    elseif maze[x_p][y_p + 1] == 0 then
        if reward_system.player_stats.shield then
            print("You hit a bomb but your shield saved you!")
            reward_system.player_stats.shield = false
            maze[x_p][y_p + 1] = "."
            return x_p, y_p + 1
        else
            io.write("you hit a bomb! Game over!\n")
            os.exit()
        end
    elseif maze[x_p][y_p + 1] == 2 then
        reward_system.apply_reward(x_p, y_p + 1, maze)
        maze[x_p][y_p + 1] = "." -- reset tile
    else
        y_p = y_p + 1
    end

    if reward_system.player_stats.dig_power == 2 then
        x_p, y_p = movement_m.move_right(x_p,y_p,maze)
    end

    if reward_system.player_stats.bomb_scanner then
        terrian_module.reveal_bombs(maze)
    end

    reward_system.reset_turn_bonuses()
    return x_p, y_p
end


return movement_m