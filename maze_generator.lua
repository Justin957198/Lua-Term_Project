local function terrain_generator(num, maze_table)
    for i = 0, num, 1 do
        maze_table[i] = {}
        for j = 0, num, 1 do
            maze_table[i][j] = "■"
        end
    end
end

local function bomb_generator(maze_table)
    for i = 0, #maze_table, 1 do
        for j = 0, #maze_table, 1 do
            local num = math.random(20)
            if num <= 4 and maze_table[i][j+1] ~= 0 and maze_table[i][j-1] ~= 0 then
                maze_table[i][j] = 0
            end
        end
    end
end

local function terrain_display(maze_table)
    for i = 1, #maze_table, 1 do
        for j = 1, #maze_table[i], 1 do
            io.write(maze_table[i][j] .." ")
        end
        io.write("\n")
    end

end

print("Sample Terrain making tool")

local maze = {}
local num

print("Input terrain size")
num = io.read()
local size = tonumber(num)

terrain_generator(size, maze)
bomb_generator(maze)
terrain_display(maze)



