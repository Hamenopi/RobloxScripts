--[[
Increments Step Count when player is moving
--]] 
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Common = require(ReplicatedStorage.Common)

-- Faster characters need more steps
local function GetSpeedModifier(speed)
	if speed < 50 then
		return 1
	elseif speed < 100 then
		return 2
	elseif speed < 150 then
	 	return 4
	elseif speed < 200 then
		return 8
	else
		return 16
	end
end -- GetSpeedModifier

Players.PlayerAdded:Connect(function(player) -- When player logs in

	 player.CharacterAdded:Connect(function(character)-- When character is loaded
	
		local humanoid = character:WaitForChild("Humanoid") -- Preload char
		
		while true do

			wait(.2)

			if Common.IsMoving(humanoid) then 

				local speedModifier = GetSpeedModifier(player.hiddenstats.Speed.Value)

				local newSteps = player.leaderstats.Steps.Value + (1 * speedModifier)
	
				player.leaderstats.Steps.Value = newSteps

				-- print("Step Handler set steps to "..newSteps) -- Debug

			end -- if IsMoving
		end -- while true
	end) -- CharacterAdded
end) -- PlayerAdded

