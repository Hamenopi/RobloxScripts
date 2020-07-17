local Constants = require(game:GetService("ReplicatedStorage").Constants)
local module = {}


function module.SetJump(jump)
	if jump > Constants.MaxJump then
		return Constants.MaxJump
	elseif jump	< Constants.MinJump then
		return Constants.MinJump
	else
		return jump
	end
end

function module.SetSpeed(speed)
	if speed > Constants.MaxSpeed then
		return Constants.MaxSpeed
	elseif speed < Constants.MinSpeed then
		return Constants.MinSpeed
	else
		return speed
	end
end

function module.IsMoving(humanoid)
	if humanoid.MoveDirection.Magnitude > 0 then
		return true
	else
		return false
	end
end

-- Returns human or nil
function module.GetHumanoid(part)
	local humanoid
       
    if part.Parent:FindFirstChild("Humanoid") then           
		humanoid = part.Parent.Humanoid
	end
       
	if part.Parent and part.Parent.Parent:FindFirstChild("Humanoid") then           
		humanoid = part.Parent.Parent.Humanoid
	end
		
	return humanoid
	
end

return module
