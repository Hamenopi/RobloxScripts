local Stages = workspace:WaitForChild("Stages")
local Module = require(game.ServerScriptStorage.ModuleScript)

for i,stage in pairs(Stages:GetChildren()) do

    stage.Touched:Connect(function(otherPart)

    if Module.IsHuman(otherPart) then

		local player = game.Players:GetPlayerFromCharacter(otherPart.Parent)           
		local playerStage = player.leaderstats.Stage.Value

		if tonumber(stage.Name) == playerStage + 1 then
			-- increment stage               
			player.leaderstats.Stage.Value = player.leaderstats.Stage.Value + 1

        elseif tonumber(stage.Name) > playerStage + 1 then
			-- kill toucher               
            otherPart.Health = 0

        end -- if next stage
      end -- if humanoid
    end) -- connect
end -- forloop
