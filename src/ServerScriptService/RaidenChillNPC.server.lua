local ReplicatedStorage = game:GetService("ReplicatedStorage")

local old = workspace:FindFirstChild("RaidenChillAssistant")
if old then old:Destroy() end

local model = Instance.new("Model")
model.Name = "RaidenChillAssistant"
model.Parent = workspace

local function part(name, size, pos, material, transparency)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.Position = pos
    p.Anchored = true
    p.CanCollide = false
    p.Material = material or Enum.Material.Neon
    p.Transparency = transparency or 0
    p.Parent = model
    return p
end

local root = part("HologramRoot", Vector3.new(3, 5, 3), Vector3.new(0, 5, 0), Enum.Material.ForceField, 0.45)
local head = part("Head", Vector3.new(2.2, 2.2, 2.2), Vector3.new(0, 8.2, 0), Enum.Material.Neon, 0.2)
local core = part("Core", Vector3.new(1.1, 1.1, 1.1), Vector3.new(0, 5.8, 0), Enum.Material.Neon, 0.05)

local light = Instance.new("PointLight")
light.Brightness = 3
light.Range = 18
light.Parent = core

local prompt = Instance.new("ProximityPrompt")
prompt.ActionText = "Talk to RaidenChill"
prompt.ObjectText = "AI Assistant"
prompt.HoldDuration = 0
prompt.MaxActivationDistance = 14
prompt.RequiresLineOfSight = false
prompt.Parent = root

local gui = Instance.new("BillboardGui")
gui.Name = "RaidenChillName"
gui.Size = UDim2.fromOffset(260, 70)
gui.StudsOffset = Vector3.new(0, 4.5, 0)
gui.AlwaysOnTop = true
gui.Parent = head

local label = Instance.new("TextLabel")
label.Size = UDim2.fromScale(1, 1)
label.BackgroundTransparency = 1
label.Text = "RAIDENCHILL\nAI ASSISTANT"
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextStrokeTransparency = 0.5
label.Parent = gui
