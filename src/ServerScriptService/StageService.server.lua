local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Stages=require(ReplicatedStorage:WaitForChild("StageDefinitions"))
local start=Instance.new("RemoteFunction")
start.Name="StartStage";start.Parent=ReplicatedStorage
local function grantPortal(player,name)
 local inv=player:FindFirstChild("Inventory") or Instance.new("Folder");inv.Name="Inventory";inv.Parent=player
 local p=inv:FindFirstChild(name) or Instance.new("IntValue");p.Name=name;p.Parent=inv;p.Value+=1
end
start.OnServerInvoke=function(player,mode,id,wave)
 if mode=="Story" then for _,stage in ipairs(Stages.Story) do if stage.Id==id then player:SetAttribute("CurrentStage",stage.Id);player:SetAttribute("CurrentWave",0);return true,stage.Name,stage.Waves end end
 elseif mode=="Infinite" then player:SetAttribute("CurrentStage","INFINITE");player:SetAttribute("CurrentWave",math.max(1,tonumber(wave) or 1));return true,Stages.Infinite.Name,math.huge end
 return false,"Invalid stage"
end
local waveEvent=Instance.new("BindableFunction");waveEvent.Name="InfiniteWaveReward";waveEvent.Parent=ReplicatedStorage
waveEvent.OnInvoke=function(player,wave)
 if player:GetAttribute("CurrentStage")~="INFINITE" or wave%Stages.Infinite.PortalEveryWaves~=0 then return nil end
 if math.random()>=Stages.Infinite.PortalChance then return nil end
 local list=Stages.Infinite.SecretPortals;local portal=list[math.random(1,#list)];grantPortal(player,portal);return portal
end
