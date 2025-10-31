local terrain_m = {}
local maze_table ={}

function terrain_m.terrain_generator(t_depth, t_length)
    for i = 0, t_depth, 1 do
        maze_table[i] = {}
        for j = 0, t_length, 1 do
            maze_table[i][j] = "?"
        end
    end
    return maze_table
end

function terrain_m.bomb_generator()
    for i = 3, #maze_table, 1 do
        for j = 0, #maze_table, 1 do
            local num = math.random(20)
            if num <= 4 and maze_table[i][j+1] ~= 0 and maze_table[i][j-1] ~= 0 then
                maze_table[i][j] = 0
            end
        end
    end
end

function terrain_m.terrain_display()
    for i = 1, #maze_table, 1 do
        for j = 1, #maze_table[i], 1 do
            io.write(maze_table[i][j] .." ")
        end
        io.write("\n")
    end

end

return terrain_m



