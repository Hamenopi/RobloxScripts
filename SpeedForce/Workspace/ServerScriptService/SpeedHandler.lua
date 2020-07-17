--[[
Handles when SetSpeed in invoked
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Constants)
local Common = require(ReplicatedStorage.Common)
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)

	 player.CharacterAdded:Connect(function(character)

		local humanoid = character:WaitForChild("Humanoid")

		while true do

			wait(Constants.Duration)

			if Common.IsMoving(humanoid) then

				local newSpeed = Common.SetSpeed(player.hiddenstats.Speed.Value + 1)

				player.hiddenstats.Speed.Value = newSpeed

			end -- if
		end -- while
	end) -- player.CharacterAdded
end) -- Players.PlayerAdded
