game.Players.PlayerAdded:Connect(function(Player)
  -- leaderstats Folder
  local leaderstats = Instance.new("Folder")
  leaderstats.Name = "leaderstats"
  leaderstats.Parent = Player
  
  -- stage intVal
  local stage = Instance.new("IntValue")
  stage.Name = "Stage"
  stage.Value = 1
  
  
  Player.CharacterAdded:Connect(function(Character
    -- wait for Char to load
    repeat wait() until Player.Character ~= nil
    
    -- get Stage(stage.Value)
    local thisStage = workspace.Stage:FindFirstChild(stage.Value)
    
    -- move to Stage(stage.Value)
    Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(thisStage.Position _ Vector3.new(0,2,0))
  end)
end)
