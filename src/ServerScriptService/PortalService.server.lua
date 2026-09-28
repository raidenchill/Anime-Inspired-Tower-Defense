local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Portals=require(ReplicatedStorage:WaitForChild("PortalDefinitions"))
local summon=Instance.new("RemoteFunction")
summon.Name="PortalSummon"
summon.Parent=ReplicatedStorage

local function roll(pool)
 local total=0
 for _,e in ipairs(pool) do total+=e.Chance end
 local pick=math.random()*total
 local running=0
 for _,e in ipairs(pool) do
  running+=e.Chance
  if pick<=running then return e.Unit end
 end
 return pool[#pool].Unit
end

local function addUnit(player,name)
 local inv=player:FindFirstChild("Inventory") or Instance.new("Folder")
 inv.Name="Inventory"
 inv.Parent=player
 local v=inv:FindFirstChild(name) or Instance.new("IntValue")
 v.Name=name
 v.Value=(v.Value or 0)+1
 v.Parent=inv
end

summon.OnServerInvoke=function(player,portalName,amount)
 if typeof(portalName)~="string" then return false,"Invalid portal" end
 amount=math.clamp(math.floor(tonumber(amount) or 1),1,10)
 local portal=Portals[portalName]
 if not portal then return false,"Invalid portal" end
 local stats=player:FindFirstChild("leaderstats")
 local gems=stats and stats:FindFirstChild("Gems")
 if not gems then return false,"Currency unavailable" end
 local cost=(amount==10 and portal.TenPullCost) or (portal.Cost*amount)
 if gems.Value<cost then return false,"Not enough Gems" end
 gems.Value-=cost
 local results={}
 for _=1,amount do
  local unit=roll(portal.Pool)
  addUnit(player,unit)
  table.insert(results,unit)
 end
 return true,results
end
