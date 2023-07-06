local jumpBoost = script.Parent

local function steppedOn(part)
    local parent = part.Parent
    if game.Players:GetPlayerFromCharacter(parent) then
        parent.Humanoid.UseJumpPower = true
        parent.Humanoid.JumpPower = 150
        wait(2)
        parent.Humanoid.JumpPower = 50
    end
end

jumpBoost.Touched:connect(steppedOn)