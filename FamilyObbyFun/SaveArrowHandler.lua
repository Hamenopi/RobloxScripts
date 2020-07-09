local Stages = workspace:WaitForChild("Stages") -- Spawn Locations
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- Contains DownArrow part
local Module = require(game.ServerScriptService.ModuleScript) -- Contains isHuman logic
 
for i,stage in pairs(Stages:GetChildren()) do       
    stage.Touched:Connect(function(otherPart)        
        if Module.IsHuman(otherPart) then
			RemoveArrow()
			PlaceNextArrow(tonumber(stage.Name) + 1)
        end
    end)
end

function RemoveArrow()
  local arrow = Stages:FindFirstChild("DownArrow")
  if (arrow) then
    arrow:Destroy()
  end
end

function PlaceNextArrow(nextStageName)  
  local nextStage = Stages:FindFirstChild(nextStageName)  
  if (nextStage) then
    local nextArrow = ReplicatedStorage.DownArrow:Clone()
    nextArrow.Position = nextStage.Position + Vector3.new(0,5,0)
    nextArrow.Parent = Stages
  end
end
