local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local SaveDataStore = DataStoreService:GetDataStore("SaveData")
 
 -- Saves Stage data to DataStore
local function SavePlayerData(player)
   
    local success,errormsg = pcall(function()   
        local SaveData = {}       
        for i,stats in pairs(player.leaderstats:GetChildren()) do           
            SaveData[stats.Name] = stats.Value
        end        
        SaveDataStore:SetAsync(player.UserId,SaveData)
    end)
   
    if not success then
        return errormsg
    end        
end

-- When player logs in
Players.PlayerAdded:Connect(function(player)
       
    -- Gets SavaData from DataStore
    local data = SaveDataStore:GetAsync(player.UserId)

    -- creates \leaderstats\stage
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local stage = Instance.new("IntValue")
    stage.Name = "Stage"
    stage.Parent = leaderstats
    stage.Value = 1
  
    -- Load SaveData
    if data then           
      print(player.Name .. " is on stage " .. data.Stage)       
      -- future proofing
      for i, stats in pairs(leaderstats:GetChildren()) do           
            stats.Value = data[stats.Name]     
      end        
        
    else        
      -- Newplayer
      print(player.Name .. " is on stage 1")          
        
    end
   
   -- on character model load
    player.CharacterAdded:Connect(function(character)
       
        local humanoid = character:WaitForChild("Humanoid")
        local torso = character:WaitForChild("HumanoidRootPart")
       
        wait()
       
        if torso and humanoid then
            if stage.Value ~= 0 then
               
                local stagePart = workspace.Stages:FindFirstChild(stage.Value)
								torso.CFrame = stagePart.CFrame + Vector3.new(0,5,0)                   
            end
        end
    end)       
end)
 
 -- save data on player exit
Players.PlayerRemoving:Connect(function(player)   
    -- save player's stage
    local errormsg = SavePlayerData(player)   
    if errormsg then   
        warn(errormsg)     
    end
end)
 
-- save data on game close
game:BindToClose(function()
    -- for any players left in game
    for i, player in pairs(Players:GetPlayers()) do       
      -- save player's stage
        local errormsg = SavePlayerData(player)
        if errormsg then
            warn(errormsg)
        end        
    end
    wait(1)
end)
