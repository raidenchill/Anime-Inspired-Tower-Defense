local Players=game:GetService("Players")
local Lighting=game:GetService("Lighting")
local player=Players.LocalPlayer
local function part(parent,name,size,pos,material,transparency)
 local p=Instance.new("Part");p.Name=name;p.Size=size;p.Position=pos;p.Anchored=true;p.Material=material or Enum.Material.Neon;p.Transparency=transparency or 0;p.Parent=parent;return p
end
local function text(parent,value)
 local gui=Instance.new("BillboardGui");gui.Size=UDim2.fromOffset(320,80);gui.StudsOffset=Vector3.new(0,4,0);gui.AlwaysOnTop=true;gui.Parent=parent
 local t=Instance.new("TextLabel");t.Size=UDim2.fromScale(1,1);t.BackgroundTransparency=1;t.Text=value;t.TextScaled=true;t.Font=Enum.Font.GothamBlack;t.TextStrokeTransparency=.35;t.Parent=gui
end
local function build()
 local lobby=workspace:FindFirstChild("UntitledLobby") or Instance.new("Folder");lobby.Name="UntitledLobby";lobby.Parent=workspace
 for _,v in ipairs(lobby:GetChildren()) do v:Destroy() end
 local bloom=Lighting:FindFirstChild("UntitledBloom") or Instance.new("BloomEffect");bloom.Name="UntitledBloom";bloom.Intensity=1.2;bloom.Size=32;bloom.Threshold=.8;bloom.Parent=Lighting
 Lighting.ClockTime=20;Lighting.Brightness=2
 part(lobby,"Floor",Vector3.new(130,2,100),Vector3.new(0,-1,0),Enum.Material.Slate)
 part(lobby,"Plaza",Vector3.new(75,1,55),Vector3.new(0,0,0),Enum.Material.Glass,.15)
 local title=part(lobby,"Title",Vector3.new(1,1,1),Vector3.new(0,5,-35),Enum.Material.Neon,1);text(title,"UNTITLED TOWER DEFENSE")
 for _,s in ipairs({{"STORY",-32,0},{"INFINITE",0,0},{"SUMMON",32,0},{"TRAITS",0,28}}) do local pad=part(lobby,s[1].."Pad",Vector3.new(20,1,16),Vector3.new(s[2],0,s[3]),Enum.Material.Neon,.1);text(pad,s[1]);local light=Instance.new("PointLight");light.Range=18;light.Brightness=3;light.Parent=pad end
 for i=-2,2 do local pillar=part(lobby,"Pillar",Vector3.new(2,14,2),Vector3.new(i*18,7,35),Enum.Material.Neon);local light=Instance.new("PointLight");light.Range=20;light.Brightness=2;light.Parent=pillar end
end
build();player.CharacterAdded:Connect(function() task.wait(1);build() end)
