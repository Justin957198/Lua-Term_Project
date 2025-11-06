-- This is where ther movment metholds will go
local movement_m = {}

function movement_m.move_up(x_p, y_p, maze)
    local x_value = x_p
    local y_value = y_p

    if maze[x_value - 1][y_value] == nil or maze[x_value - 1][y_value] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p)
        return x_p, y_p
    elseif maze[x_value - 1][y_value] == 0 then
        io.write("you hit a bomb! Game over!\n")
        os.exit()
    else
        x_p = x_p -1
        return x_p, y_p
    end

end

function movement_m.move_down(x_p, y_p, maze)
    local x_value = x_p
    local y_value = y_p

    if maze[x_value + 1] == nil  or maze[x_value + 1][y_value] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p)
        return x_p, y_p
    elseif(maze[x_value + 1][y_value] == 0) then
        io.write("You hit a bomb! Gave over!\n")
        os.exit()
    else
        x_p = x_p + 1
        return x_p, y_p
    end
end

function movement_m.move_left(x_p, y_p, maze)
    local x_value = x_p
    local y_value = y_p

    if maze[x_value][y_value - 1] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p)
        return x_p, y_p
    elseif maze[x_value][y_value - 1] == 0 then -- Bomb Detection
        io.write("You hit a bomb! Game Over!\n")
        os.exit()
    else
        y_p = y_p - 1
        return x_p, y_p
    end
end

function movement_m.move_right(x_p, y_p, maze)
    local x_value = x_p
    local y_value = y_p

    if maze[x_value][y_value + 1] == nil then
        io.write("***Out of bounds***\n Player still on " .. x_p .. "," .. y_p)
        return x_p, y_p
    elseif maze[x_value][y_value + 1] == 0 then
        io.write("You hit a bomb! Gamne Over!\n")
        os.exit()
    else
        y_p = y_p + 1
        return x_p, y_p
    end
end


return movement_m