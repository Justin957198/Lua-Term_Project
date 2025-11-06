local reward_system = {}

reward_system.player_stats = {
    shield = false, -- Whether a player can survive a bomb
    dig_power = 1, -- How many tiles the player can dig
    bomb_scanner = false, -- Amounts of bombs destroyed
}

function reward_system.apply_reward(x, y, maze)
    local reward_Type = math.random(1, 3) -- To give a random reward
    
    if reward_Type == 1 then
        print("Bomb Scanner! Bomb locations revealed this turn!")
        reward_system.player_stats.bomb_scanner = true
    elseif reward_Type == 2 then
        print("You got a shield! One bomb hit will not kill you.")
        reward_system.player_stats.shield = true
    elseif reward_Type == 3 then
        print("Digging Boost! You can dig through two tiles now.")
        reward_system.player_stats.dig_power = 2
    end

    return reward_system.player_stats
end

function reward_system.reset_turn_bonuses()
    reward_system.player_stats.bomb_scanner = false
    reward_system.player_stats.dig_power = 1
end

return reward_system