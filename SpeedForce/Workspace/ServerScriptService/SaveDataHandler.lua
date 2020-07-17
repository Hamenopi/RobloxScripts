local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local SaveDataStore = DataStoreService:GetDataStore("SaveData")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Common = require(ReplicatedStorage.Common)
local Constants = require(ReplicatedStorage.Constants)

local function SavePlayerData(player)

	local success,errormsg = pcall(function()

		local SaveData = {}
		-- visible
		for i,ldrstats in pairs(player.leaderstats:GetChildren()) do
			SaveData[ldrstats.Name] = ldrstats.Value
			-- print(ldrstats.Name,ldrstats.Value) -- Debug
		end -- for

		-- not visible
		for i,hdnstats in pairs(player.hiddenstats:GetChildren()) do
			SaveData[hdnstats.Name] = hdnstats.Value
			-- print(hdnstats.Name,hdnstats.Value) -- Debug
		end -- for

		SaveDataStore:SetAsync(player.UserId,SaveData)
	end) -- pcall

	if not success then
		return errormsg
	end -- not success
end -- SavePlayerData

-- When player logs in
Players.PlayerAdded:Connect(function(player)

	-- Gets SavaData from DataStore
	local data = SaveDataStore:GetAsync(player.UserId)
	
	-- Wait for character to load in
	local character = player.Character or player.CharacterAdded:wait()
	
	-- create \leaderstats\Steps
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local steps = Instance.new("IntValue")
	steps.Name = "Steps"
	steps.Parent = leaderstats
	steps.Value = Constants.MinSteps
	
	-- Logic
	steps.Changed:Connect(function(newStepCount)
		
		-- Give player boost each 1000 steps
		if steps.Value % 1000 == 0 then
			local humanoid = character:WaitForChild("Humanoid")
			Common.SetSpeed(humanoid.WalkSpeed +1)
			Common.SetJump(humanoid.WalkSpeed +1)
		end -- if steps.Value
	end) -- steps.Changed

	-- creates \hiddenstats\Speed
	local hiddenstats = Instance.new("Folder")
	hiddenstats.Name = "hiddenstats"
	hiddenstats.Parent = player

	local speed = Instance.new("IntValue")
	speed.Name = "Speed"
	speed.Parent = hiddenstats
	speed.Value = Constants.MinSpeed
	
	-- Logic
	speed.Changed:Connect(function(newSpeed)
		--print("Speed is now "..newSpeed)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.WalkSpeed = newSpeed
	end) -- speed.Changed

	-- creates \hiddenstats\Jump
	local jump = Instance.new("IntValue")
	jump.Name = "Jump"
	jump.Parent = hiddenstats
	jump.Value = Constants.MinJump
	
	-- Logic
	jump.Changed:Connect(function(newJump)
		--print("Jump is now "..newJump)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.JumpPower = newJump
	end) -- jump.Changed

	-- Load SaveData
	if data then

		-- load plater stats
		for i, ldrstats in pairs(leaderstats:GetChildren()) do
			ldrstats.Value = data[ldrstats.Name]
			--print(ldrstats.Name,ldrstats.Value)
		end -- leaderstats

		-- load hidden plater stats
		for i, hdnstats in pairs(hiddenstats:GetChildren()) do
			hdnstats.Value = data[hdnstats.Name]
			--print(hdnstats.Name,hdnstats.Value)
		end -- hiddenstats

	end -- if data

	print(player.Name .. " has " .. steps.Value .. " Steps.")
	print(player.Name .. " has " .. speed.Value .. " Speed.")
	print(player.Name .. " has " .. jump.Value .. " Jump Power.")

end) -- Players.PlayerAdded

-- save data on player exit
Players.PlayerRemoving:Connect(function(player)
	local errormsg = SavePlayerData(player)
	if errormsg then
		warn(errormsg)
	end -- if errormsg
end) -- Players.PlayerRemoving

-- save all Players data on game close
game:BindToClose(function()
	-- for any players left in game
	for i, player in pairs(Players:GetPlayers()) do
		local errormsg = SavePlayerData(player)
		if errormsg then
			warn(errormsg)
		end -- if
	end -- for
	-- allow save before game close
	wait(1)
end)
