local speedBoost = script.Parent

local function steppedOn(part)
    local parent = part.Parent
    if game.Players:GetPlayerFromCharacter(parent)then
        parent.Humanoid.WalkSpeed = 30
        wait(4)
        parent.Humanoid.WalkSpeed = 16
    end
end

speedBoost.Touched:connect(steppedOn)