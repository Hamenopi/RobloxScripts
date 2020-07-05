local Stages = workspace:WaitForChild("Stages")  -- contains spawn locations
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- contains downarrow

for i,Stage in pairs(Stages:GetChildren()) do
      
  Stage.Touched:Connect(function(touch)
    
    -- verify touch
    local humanoid       
    if touch.Parent:FindFirstChild("Humanoid") then           
        humanoid = touch.Parent.Humanoid
    end
       
    if touch.Parent and touch.Parent.Parent:FindFirstChild("Humanoid") then           
        humanoid = touch.Parent.Parent.Humanoid
    end
    
    if humanoid then
      RemoveArrow()
      PlaceNextArrow(tonumber(Stage.Name) + 1)			  
    end
  end)
end

function RemoveArrow()
  local arrow = Stages:FindFirstChild("DownArrow")
  if (arrow) then
    arrow:Destroy()
  end
end

function PlaceNextArrow(stageName)  
  local nextStage = Stages:FindFirstChild(nextStageName)  
  if (nextStage) then
    local nextArrow = ReplicatedStorage.DownArrow:Clone()
    nextArrow.Position = nextStage.Position + Vector3.new(0,5,0)
    nextArrow.Parent = Stages
  end
end
