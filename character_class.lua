-- This class will contain character attributes. It will allow
-- the game to store character's status, information, attributes,
-- powers, and resources.

local character = {}
character.__index = character

-- Constructor
function character:new(data)
    local self = setmetatable({}, character)
    self.name = data.name or "unknown"
    self.age = data.age or 0
    self.wins = data.wins or 0
    self.loss = data.loss or 0

    -- Prize data
    self.prize_count = data.prize_count or 0
    -- Types of prizes
    self.shields = data.shields or 0
    self.bomb_scanner = data.bomb_scanner or 0
    self.digging_boost = data.digging_boost or 0
    return self
end


-- Save data

function character:save()
    local file = io.open("user_data.lua", "w")

    file:write("return {\n")
    file:write(string.format("  name = %q,\n", self.name))
    file:write(string.format("  age = %d,\n", self.age))

    file:write("      -- Main user attributes\n")
    file:write(string.format("  wins = %d,\n", self.wins))
    file:write(string.format("  loss = %d,\n", self.loss))

    file:write("      -- Prize data\n")
    file:write(string.format("  prize_count = %d,\n", self.prize_count))

    file:write("      -- Types of prizes\n")
    file:write(string.format("  shields = %d,\n", self.shields))
    file:write(string.format("  bomb_scanner = %d,\n", self.bomb_scanner))
    file:write(string.format("  digging_boost = %d,\n", self.digging_boost))
    file:write("}")
    file:close()

end


-- load data from disk
function character.load()
    local data = dofile("user_data.lua")
    return character:new(data)
end

-- User name setter and getter
function character:set_name(user_name)
    self.name = user_name
end

function character:get_name()
    return self.name
end


-- User age setter and getter
function character:set_age(user_age)
    self.age = user_age
end

function character:get_age()
    return self.age
end


-- Win increment and getter
function character:add_win()
    self.wins = self.wins + 1
end

function character:get_win()
    return self.wins
end


-- Loss increment and getter
function character:add_loss()
    self.loss = self.loss + 1
end

function character:get_loss()
    return self.loss
end


-- Prize increments and getters
function character:add_shield()
    print("Debug shield")
    self.shields = self.shields + 1
    self.prize_count = self.prize_count + 1
end

function character:add_boost()
    print("Debug boost")
    self.digging_boost = self.digging_boost + 1
    self.prize_count = self.prize_count + 1
end

function character:add_scanner()
    print("Debug scanner")
    self.bomb_scanner = self.bomb_scanner + 1
    self.prize_count = self.prize_count + 1
end


function character:get_shields()
    return self.shields
end

function character:get_boost()
    return self.digging_boost
end

function character:get_scanner()
    return self.bomb_scanner
end

function character:get_prizes()
    return self.prize_count
end

return character