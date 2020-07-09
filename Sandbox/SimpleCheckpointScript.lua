--Add leaderstats/Stage to Player upon connect
game.Players.PlayerAdded:Connect(function(Player)
  
  -- leaderstats Folder (under Player)
  local leaderstats = Instance.new("Folder")
  leaderstats.Name = "leaderstats"
  leaderstats.Parent = Player
  
  -- stage intVal (under leaderstat folder)
  local stage = Instance.new("IntValue")
  stage.Name = "Stage"
  stage.Value = 1
  
  -- Teleport to Stage's spawn point
  Player.CharacterAdded:Connect(function(Character

    -- wait for characther model to load
    repeat wait() until Player.Character ~= nil
    
    -- get matching stage object from (stage.Value)
    local thisStage = workspace.Stage:FindFirstChild(stage.Value)
    
    -- move to character to above stage object(stage.Value)
    Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(thisStage.Position _ Vector3.new(0,2,0))
  end)
end)
