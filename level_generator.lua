local terrain_m = {}
local maze_table ={}

local normal_Tiles = "?"
local reveal_Bomb_Tiles = "B"

local testing_Mode = true

function terrain_m.terrain_generator(t_depth, t_length)
    for i = 1, t_length do
        maze_table[i] = {}
        for j = 1, t_depth do
            maze_table[i][j] = normal_Tiles
        end
    end
    return maze_table
end

function terrain_m.bomb_generator(difficuty)
    local random_cap
    local bomb_count = 0
    if difficuty == "1" then
        random_cap = 25
    elseif difficuty == "2" then
        random_cap = 20
    elseif difficuty == "3" then
        random_cap = 15
    else
        io.write("Invalid difficuty, 1 auto selected\n")
        random_cap = 25
    end
    for i = 3, #maze_table, 1 do
        for j = 1, #maze_table[i], 1 do
            local num = math.random(random_cap)
            if num <= 5 and maze_table[i][j+1] ~= 0 and maze_table[i][j-1] ~= 0 then
                maze_table[i][j] = 0
                bomb_count = bomb_count + 1
            end
        end
    end
    io.write("Bombs generated: " .. bomb_count .. "\n")
end

function terrain_m.treasure_generator(difficuty)
    local treasure_count = 0
    for i = 3, #maze_table, 1 do
        for j = 1, #maze_table[i], 1 do
            local num = math.random(30)
            if num <= 4 and maze_table[i][j] ~= 0 then
                maze_table[i][j] = 2
                treasure_count = treasure_count + 1
            end
        end
    end
    io.write("Treasures generated: " .. treasure_count .. "\n")
end

function terrain_m.terrain_display()
    if testing_Mode then
        for i = 1, #maze_table, 1 do
            for j = 1, #maze_table[i], 1 do
                io.write(maze_table[i][j] .." ")
            end
            io.write("\n")
        end 
    else
        for i = 1, #maze_table, 1 do
            for j = 1, #maze_table[i], 1 do
                if maze_table[i][j] == 0 or maze_table[i][j] == 2 then
                    io.write("?" .." ")
                else
                    io.write(maze_table[i][j] .." ")
                end
            end
            io.write("\n")
        end 
    end
end

function terrain_m.generate_win(t_depth, t_length)
    maze_table[t_length][t_depth] = 4
end

function terrain_m.reveal_bombs(maze)
    for i = 1, #maze do
        for j = 1, #maze[i] do
            if maze[i][j] == 0 then
                io.write(reveal_Bomb_Tiles)
                io.write(" ")
            else
                if maze_table[i][j] == 2 then
                    io.write("?" .. " ")
                else
                    io.write(maze[i][j] .. " ")
                end
            end
        end
        io.write("\n")
    end
 end

return terrain_m



