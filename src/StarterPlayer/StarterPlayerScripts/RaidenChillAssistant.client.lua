local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local ask = ReplicatedStorage:WaitForChild("RaidenChillAsk")
local config = require(ReplicatedStorage:WaitForChild("AIAssistantConfig"))

local gui = Instance.new("ScreenGui")
gui.Name = "RaidenChillChat"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(420, 500)
frame.Position = UDim2.new(1, -440, 1, -520)
frame.BackgroundTransparency = 0.08
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 55)
title.Position = UDim2.fromOffset(10, 8)
title.BackgroundTransparency = 1
title.Text = "RAIDENCHILL  •  AI ASSISTANT"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local log = Instance.new("TextLabel")
log.Size = UDim2.new(1, -20, 1, -145)
log.Position = UDim2.fromOffset(10, 65)
log.BackgroundTransparency = 1
log.TextWrapped = true
log.TextYAlignment = Enum.TextYAlignment.Top
log.TextXAlignment = Enum.TextXAlignment.Left
log.Text = "Ask me anything about the game.\n\n"
log.Font = Enum.Font.Gotham
log.TextSize = 16
log.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -105, 0, 45)
box.Position = UDim2.new(0, 10, 1, -60)
box.PlaceholderText = "Ask RaidenChill..."
box.ClearTextOnFocus = false
box.Text = ""
box.Parent = frame

local send = Instance.new("TextButton")
send.Size = UDim2.fromOffset(85, 45)
send.Position = UDim2.new(1, -95, 1, -60)
send.Text = "ASK"
send.Font = Enum.Font.GothamBold
send.TextSize = 16
send.Parent = frame

local function askQuestion(q)
    if q == "" then return end
    log.Text = log.Text .. "You: " .. q .. "\n"
    local ok, reply = pcall(function()
        return ask:InvokeServer(q)
    end)
    if ok then
        log.Text = log.Text .. "RaidenChill: " .. tostring(reply) .. "\n\n"
    else
        log.Text = log.Text .. "RaidenChill: I couldn't answer that right now.\n\n"
    end
end

local function submit()
    local q = box.Text
    box.Text = ""
    askQuestion(q)
end

send.Activated:Connect(submit)
box.FocusLost:Connect(function(enter)
    if enter then submit() end
end)

local prompt = workspace:WaitForChild("RaidenChillAssistant", 15)
if prompt then
    local p = prompt:FindFirstChildWhichIsA("ProximityPrompt", true)
    if p then
        p.Triggered:Connect(function()
            frame.Visible = true
            box:CaptureFocus()
        end)
    end
end
