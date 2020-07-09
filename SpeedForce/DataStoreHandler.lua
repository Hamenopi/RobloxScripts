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

    -- creates \leaderstats\steps
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local stage = Instance.new("IntValue")
    steps.Name = "Steps"
    steps.Parent = leaderstats
    steps.Value = 1
  
    -- Load SaveData
    if data then           
      print(player.Name .. " has taken " .. data.Steps .. " steps.")       
      
      -- future proofing
      for i, stats in pairs(leaderstats:GetChildren()) do           
            stats.Value = data[stats.Name]     
      end        
        
    else
    
      -- Newplayer
      print("Welcome " .. player.Name .. " to SpeedForce")          
        
    end
   
   -- on character model load
    player.CharacterAdded:Connect(function(character)
       
        local humanoid = character:WaitForChild("Humanoid")
        local torso = character:WaitForChild("HumanoidRootPart")
       
        wait()
        
        -- Character Loaded
        
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
      
      -- save player's step count
        local errormsg = SavePlayerData(player)        
        if errormsg then
            warn(errormsg)
        end        
    end
    
    -- allow save before game close
    wait(1)
end)
