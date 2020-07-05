local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local SaveDataStore = DataStoreService:GetDataStore("SaveData")
 
 -- Sets SaveData
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
 
 -- creates \leaderstats\Stage
Players.PlayerAdded:Connect(function(player)
   
    local Stats = Instance.new("Folder")
    Stats.Name = "leaderstats"
    Stats.Parent = player
   
    local Stage = Instance.new("IntValue")
    Stage.Name = "Stage"
    Stage.Parent = Stats
    Stage.Value = 1
   
   -- Get's table from SavaData
    local Data = SaveDataStore:GetAsync(player.UserId)
   
   -- Load player data
    if Data then
           
        --print(Data.Stage)
       
        for i,stats in pairs(Stats:GetChildren()) do
           
            stats.Value = Data[stats.Name]     
        end        
        
    else       
        
        -- Ne wplayer
        print(player.Name .. " has no data.")          
        
    end
   
   -- on character model load
    player.CharacterAdded:Connect(function(character)
       
        local Humanoid = character:WaitForChild("Humanoid")
        local Torso = character:WaitForChild("HumanoidRootPart")
       
        wait()
       
        if Torso and Humanoid then
            if Stage.Value ~= 0 then
               
                local StagePart = workspace.Stages:FindFirstChild(Stage.Value)
								Torso.CFrame = StagePart.CFrame + Vector3.new(0,3,0)                   
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
    for i,player in pairs(Players:GetPlayers()) do       
      -- save player's stage
        local errormsg = SavePlayerData(player)
        if errormsg then
            warn(errormsg)
        end        
    end
    wait(0.1)
end)
