local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Traits = require(ReplicatedStorage:WaitForChild("TraitDefinitions"))

local REROLL_COST = 1
local REROLL_CURRENCY = "TraitRerolls"

local function weightedRoll()
    local total = 0
    for _, trait in pairs(Traits) do
        total += trait.Chance
    end

    local roll = math.random() * total
    local cursor = 0
    for name, trait in pairs(Traits) do
        cursor += trait.Chance
        if roll <= cursor then
            return name
        end
    end

    return "Basic"
end

local function getTraitFolder(player)
    local folder = player:FindFirstChild("UnitTraits")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "UnitTraits"
        folder.Parent = player
    end
    return folder
end

local function setTrait(player, unitName, traitName)
    if not Traits[traitName] then return false end
    local folder = getTraitFolder(player)
    local value = folder:FindFirstChild(unitName)
    if not value then
        value = Instance.new("StringValue")
        value.Name = unitName
        value.Parent = folder
    end
    value.Value = traitName
    return true
end

local remote = ReplicatedStorage:FindFirstChild("TraitReroll")
if not remote then
    remote = Instance.new("RemoteFunction")
    remote.Name = "TraitReroll"
    remote.Parent = ReplicatedStorage
end

remote.OnServerInvoke = function(player, unitName)
    if typeof(unitName) ~= "string" or unitName == "" then
        return false, "Invalid unit."
    end

    local stats = player:FindFirstChild("leaderstats")
    local rerolls = stats and stats:FindFirstChild(REROLL_CURRENCY)
    if not rerolls or rerolls.Value < REROLL_COST then
        return false, "Not enough Trait Rerolls."
    end

    rerolls.Value -= REROLL_COST
    local traitName = weightedRoll()
    setTrait(player, unitName, traitName)
    return true, traitName
end

Players.PlayerAdded:Connect(function(player)
    getTraitFolder(player)
end)
