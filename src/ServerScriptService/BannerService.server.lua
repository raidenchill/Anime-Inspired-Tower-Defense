local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Banners=require(ReplicatedStorage:WaitForChild("BannerDefinitions"))
local summon=Instance.new("RemoteFunction");summon.Name="BannerSummon";summon.Parent=ReplicatedStorage
local function roll(pool)
 local total=0;for _,e in ipairs(pool) do total+=e.Chance end
 local pick=math.random()*total;local running=0
 for _,e in ipairs(pool) do running+=e.Chance;if pick<=running then return e.Unit end end
 return pool[#pool].Unit
end
local function add(player,name)
 local inv=player:FindFirstChild("Inventory") or Instance.new("Folder");inv.Name="Inventory";inv.Parent=player
 local v=inv:FindFirstChild(name) or Instance.new("IntValue");v.Name=name;v.Parent=inv;v.Value+=1
end
summon.OnServerInvoke=function(player,bannerName,amount)
 amount=math.clamp(math.floor(tonumber(amount) or 1),1,10);local banner=Banners[bannerName];if not banner then return false,"Invalid banner" end
 local stats=player:FindFirstChild("leaderstats");local gems=stats and stats:FindFirstChild("Gems");if not gems then return false,"Currency unavailable" end
 local cost=amount==10 and banner.TenPullCost or banner.Cost*amount;if gems.Value<cost then return false,"Not enough Gems" end
 gems.Value-=cost;local results={};for _=1,amount do local unit=roll(banner.Pool);add(player,unit);table.insert(results,unit) end
 return true,results
end
