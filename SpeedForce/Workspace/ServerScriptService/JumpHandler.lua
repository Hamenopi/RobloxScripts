--[[
Handles when SetSpeed in invoked
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = ReplicatedStorage.Constants
local Common = ReplicatedStorage.Common
local Players = game:GetService("Players") 

Players.PlayerAdded:Connect(function(player)

	 player.CharacterAdded:Connect(function(character)

		local humanoid = character:WaitForChild("Humanoid")

		while true do

			wait(Constants.Duration)

			if Common.IsMoving(humanoid) then

				local newJump = Common.SetJump(player.hiddenstats.Jump.Value + 1)

				player.hiddenstats.Jump.Value = newJump

			end -- if
		end -- while
	end) -- player.CharacterAdded
end) -- Players.PlayerAdded
