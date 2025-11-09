-- This is where ther movment metholds will go
local movement_m = {}

function movement_m.check_player(x_pos, y_pos, maze)
    local on_bomb = false
    local on_treasure = false
    local on_nothing =false
    for i = 1, #maze, 1 do
        for j = 1, #maze[i], 1 do
            if maze[x_pos][y_pos] == 0 then 
                on_bomb = true 
                return on_bomb, on_treasure, on_nothing
            elseif maze[x_pos][y_pos] == 2 then
                on_treasure = true
                return on_bomb, on_treasure, on_nothing
            else
                on_nothing = true
                return on_bomb, on_treasure, on_nothing
            end
            
        end
    end
end

function movement_m.move_up(x_p, y_p, maze)
    local x_value = x_p
    local y_value = x_p

    if x_value - 1 < 1 then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p .."\n")
        return x_p, y_p
    else
        x_p = x_p - 1
        io.write("Player diggs to " .. x_p .. "," .. y_p.. "\n")
        return x_p, y_p
    end

end

function movement_m.move_down(x_p, y_p, maze)
    local x_value = x_p
    local y_value = x_p

    if x_value + 1 > #maze then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p .. "\n")
        return x_p, y_p
    else
        x_p = x_p + 1
        io.write("Player diggs to " .. x_p .. "," .. y_p.. "\n")
        return x_p, y_p
    end
end

function movement_m.move_left(x_p, y_p, maze)
    local x_value = x_p
    local y_value = y_p

    if y_value - 1 < 1 then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p.. "\n")
        return x_p, y_p
    else
        y_p = y_p - 1
        io.write("Player diggs to " .. x_p .. "," .. y_p.. "\n")
        return x_p, y_p
    end
end

function movement_m.move_right(x_p, y_p, maze)
    local x_value = x_p
    local y_value = y_p

    if y_value + 1 > #maze[1] then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p.. "\n")
        return x_p, y_p
    else
        y_p = y_p + 1
        io.write("Player diggs to " .. x_p .. "," .. y_p.. "\n")
        return x_p, y_p
    end
end


return movement_m