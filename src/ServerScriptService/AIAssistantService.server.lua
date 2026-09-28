local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local UnitDefinitions = require(ReplicatedStorage:WaitForChild("UnitDefinitions"))
local TraitDefinitions = require(ReplicatedStorage:WaitForChild("TraitDefinitions"))
local PortalDefinitions = require(ReplicatedStorage:WaitForChild("PortalDefinitions"))
local BannerDefinitions = require(ReplicatedStorage:WaitForChild("BannerDefinitions"))
local StageDefinitions = require(ReplicatedStorage:WaitForChild("StageDefinitions"))
local Config = require(ReplicatedStorage:WaitForChild("AIAssistantConfig"))

local ask = Instance.new("RemoteFunction")
ask.Name = "RaidenChillAsk"
ask.Parent = ReplicatedStorage

local lastAsk = {}

local function clean(s)
    s = tostring(s or "")
    s = s:gsub("[%c]", " ")
    if #s > Config.MaxMessageLength then
        s = s:sub(1, Config.MaxMessageLength)
    end
    return s
end

local function lower(s)
    return string.lower(s)
end

local function findUnit(q)
    for id, data in pairs(UnitDefinitions) do
        local n = lower(data.DisplayName or id)
        if string.find(q, lower(id), 1, true) or string.find(q, n, 1, true) then
            return id, data
        end
    end
end

local function unitAnswer(id, data)
    local extra = ""
    if data.Income then
        extra = string.format(" It costs %d and generates %d income.", data.Cost, data.Income)
    else
        extra = string.format(" It costs %d, deals %s damage, has %s range, and a %.2fs cooldown.", data.Cost, tostring(data.Damage), tostring(data.Range), data.Cooldown)
    end
    return string.format("%s is a %s unit from %s.%s", data.DisplayName, data.Role, data.Anime, extra)
end

local function answer(player, message)
    local q = lower(clean(message))

    if q == "" then
        return "Ask me anything about the game—units, banners, traits, portals, stages, costs, odds, or where things are in the lobby."
    end

    if q:find("where", 1, true) or q:find("find", 1, true) then
        if q:find("summon", 1, true) or q:find("banner", 1, true) then
            return "The SUMMON area is the glowing portal section in the lobby. Use a banner or portal there to spend Gems on pulls."
        elseif q:find("infinite", 1, true) then
            return "The INFINITE portal is the large portal in the lobby. Enter it to start the Anime Rift Infinite mode."
        elseif q:find("trait", 1, true) or q:find("reroll", 1, true) then
            return "The TRAITS area is in the lobby. Select a unit there and use a Trait Reroll to roll a new trait."
        elseif q:find("story", 1, true) or q:find("stage", 1, true) then
            return "The STORY area is the story-stage entrance in the lobby. Chapters unlock as your level requirements are met."
        elseif q:find("secret", 1, true) then
            return "Secret portals can be awarded from Infinite milestones. Their inventory items can then be used to access their special portal content."
        end
    end

    if q:find("ichigo", 1, true) then
        local d = UnitDefinitions.Ichigo
        return unitAnswer("Ichigo", d) .. " Banner 1 lists Ichigo at a 0.01% featured chance."
    end

    local id, data = findUnit(q)
    if id then
        return unitAnswer(id, data)
    end

    if q:find("trait", 1, true) then
        local names = {}
        for name, t in pairs(TraitDefinitions) do
            table.insert(names, name)
        end
        table.sort(names)
        return "Traits currently include " .. table.concat(names, ", ") .. ". Traits can modify stats such as damage, cooldown, range, and money generation."
    end

    if q:find("portal", 1, true) or q:find("summon", 1, true) or q:find("pull", 1, true) then
        return "The game has summon portals and banners. Standard pulls use Gems, and 10-pulls are discounted on the defined portals. Infinite can also award secret portal items at milestones."
    end

    if q:find("banner", 1, true) or q:find("odds", 1, true) or q:find("chance", 1, true) then
        local b = BannerDefinitions.Banner1
        return "Banner 1 costs 50 Gems per pull or 450 for ten. Its featured unit is Ichigo, listed at 0.01%; Gojo is 1%, Goku is 2%, and the remaining pool contains Luffy, Naruto, Tanjiro, Nami, Bulma, and Speedwagon."
    end

    if q:find("infinite", 1, true) then
        return "Anime Rift Infinite starts at wave 1 and continues without a fixed maximum. Every 10 waves it can roll a portal reward, including the game's secret-portal system."
    end

    if q:find("stage", 1, true) or q:find("chapter", 1, true) then
        local names = {}
        for id, s in pairs(StageDefinitions.Story) do
            table.insert(names, string.format("%s: %s (Level %d)", id, s.Name, s.LevelRequired))
        end
        table.sort(names)
        return "Story chapters: " .. table.concat(names, " | ")
    end

    if q:find("money", 1, true) or q:find("cash", 1, true) then
        return "Money units generate income while placed. Current money-focused units include Speedwagon, Bulma, and Nami."
    end

    if q:find("help", 1, true) or q:find("what can you", 1, true) or q:find("what do you", 1, true) then
        return "I'm RaidenChill, the in-game assistant. Ask about units, stats, traits, banners, summon odds, stages, portals, Infinite, rewards, costs, or where to find things."
    end

    return "I can help with the game's units, stats, traits, banners, portals, stages, Infinite mode, rewards, costs, and lobby locations. Try asking a specific question, like “Where do I find Infinite?” or “How do I get Ichigo?”"
end

ask.OnServerInvoke = function(player, message)
    local now = os.clock()
    if lastAsk[player] and now - lastAsk[player] < Config.CooldownSeconds then
        return "Slow down for a second and ask me again."
    end
    lastAsk[player] = now
    return answer(player, message)
end

Players.PlayerRemoving:Connect(function(player)
    lastAsk[player] = nil
end)
