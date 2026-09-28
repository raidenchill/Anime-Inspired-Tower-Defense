local Players = game:GetService("Players")
local Config = require(script.Parent.GameConfig)

Players.PlayerAdded:Connect(function(player)
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    stats.Parent = player

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = Config.StartingCash
    cash.Parent = stats

    local gems = Instance.new("IntValue")
    gems.Name = "Gems"
    gems.Value = Config.StartingGems
    gems.Parent = stats

    local rerolls = Instance.new("IntValue")
    rerolls.Name = "TraitRerolls"
    rerolls.Value = 5
    rerolls.Parent = stats

    local inventory = Instance.new("Folder")
    inventory.Name = "Inventory"
    inventory.Parent = player

    local traits = Instance.new("Folder")
    traits.Name = "UnitTraits"
    traits.Parent = player
end)
