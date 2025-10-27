local function maze_generator (num, maze_table)
    for i = 0, num, 1 do
        maze_table[i] = {}
        for j = 0, num, 1 do
            maze_table[i][j] = math.random(0,1)
        end
    end
end

local function maze_enterance_generator(maze_table)
    local enterence_chance = math.random(20)
    if enterence_chance <= 10 then
        for i = 0, 1, 1 do
            for j =0, #maze_table / 2, 1 do
                if maze_table[i][j] ~= 1 then
                    maze_table[i][j] = 11
                    return "The enterance is on row " .. i .. " and column " .. j 
                end
            end
        end
    else 
        for i = 0, 1, 1 do
            for j = #maze_table / 2, #maze_table, 1 do
                if maze_table[i][j] ~= 1 then
                    maze_table[i][j] = 11
                    return "The enterance is on row " .. i .. " and column " .. j
                end
            end
        end
    end
end

local function maze_exit_generator(maze_table)
    local exit_chance = math.random(10)
    if exit_chance <= 5 then
        for i = #maze_table, #maze_table, 1 do
            for j = 0, #maze_table / 2, 1 do
                if maze_table[i][j] ~= 1 then
                    maze_table[i][j] = 0.0
                    return "The exit is located on row " .. i .. " and column " .. j
                end
            end
        end
    else
        for i = #maze_table, #maze_table, 1 do
            for j = #maze_table / 2, #maze_table, 1 do
                if maze_table[i][j] ~= 1 then
                    maze_table[i][j] = 0.0
                    return "The exit is located on row " .. i .. " and column " .. j
                end
            end
        end
    end
end

local function maze_display(maze_table)
    for i = 0, #maze_table, 1 do
        for j = 0, #maze_table[i], 1 do
            io.write(maze_table[i][j] .." ")
        end
        io.write("\n")
    end

end

print("Sample Maze making tool")

local maze = {}
local num

print("Input maze size")
num = io.read()
local number = tonumber(num)

maze_generator(number, maze)
print(maze_enterance_generator(maze))
print(maze_exit_generator(maze))

maze_display(maze)



