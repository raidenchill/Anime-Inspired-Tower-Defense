local Players=game:GetService("Players")
local function pay(player,unit)
 local income=unit:GetAttribute("Income")
 if not income or income<=0 then return end
 local multiplier=unit:GetAttribute("MoneyMultiplier") or 1
 local stats=player:FindFirstChild("leaderstats")
 local cash=stats and stats:FindFirstChild("Cash")
 if cash then cash.Value+=math.floor(income*multiplier) end
end
while true do
 task.wait(10)
 for _,player in ipairs(Players:GetPlayers()) do
  local placed=player:FindFirstChild("PlacedUnits")
  if placed then
   for _,unit in ipairs(placed:GetChildren()) do
    if unit:IsA("Model") then pay(player,unit) end
   end
  end
 end
end
