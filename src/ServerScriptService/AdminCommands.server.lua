local Players = game:GetService("Players")

-- This admin system is for the developer's own Roblox experience.
-- It is restricted by UserId, not display name.
local ADMIN_USER_IDS = {
    [334811058] = true, -- raidenchill
}

local VALID_ITEMS = {
    Cash = true,
    Gems = true,
    EmberSwordsman = true,
    StormArcher = true,
    VoidMage = true,
}

local function isAdmin(player)
    return ADMIN_USER_IDS[player.UserId] == true
end

local function giveItem(player, item, amount)
    if not VALID_ITEMS[item] then return false end
    amount = math.clamp(tonumber(amount) or 1, 1, 1000000)

    local stats = player:FindFirstChild("leaderstats")
    if item == "Cash" or item == "Gems" then
        local value = stats and stats:FindFirstChild(item)
        if value then value.Value += amount return true end
    end

    local inventory = player:FindFirstChild("Inventory")
    if inventory then
        local value = inventory:FindFirstChild(item)
        if not value then
            value = Instance.new("IntValue")
            value.Name = item
            value.Parent = inventory
        end
        value.Value += amount
        return true
    end
    return false
end

local function execute(player, message)
    if not isAdmin(player) then return end
    local args = string.split(message, " ")
    local command = string.lower(args[1] or "")

    if command == "/give" then
        local item = args[2]
        local amount = args[3] or 1
        if item then giveItem(player, item, amount) end
    elseif command == "/giveall" then
        for item in pairs(VALID_ITEMS) do
            giveItem(player, item, 1)
        end
    elseif command == "/cash" then
        local stats = player:FindFirstChild("leaderstats")
        local cash = stats and stats:FindFirstChild("Cash")
        if cash then cash.Value += math.clamp(tonumber(args[2]) or 0, 0, 1000000) end
    elseif command == "/gems" then
        local stats = player:FindFirstChild("leaderstats")
        local gems = stats and stats:FindFirstChild("Gems")
        if gems then gems.Value += math.clamp(tonumber(args[2]) or 0, 0, 1000000) end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        execute(player, message)
    end)
end)
