local Players = game:GetService("Players")

local function leaderboardSetup(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local points = Instance.new("IntValue")
    points.Name = "Orbs"
    points.Value = 0
    points.Parent = leaderstats

    player.CharacterAdded:Connect(function(char)
        char.Humanoid.Died:Connect(function()
            points.Value = 0
        end)
    end)
end

-- Connect the "leaderboardSetup()" function to the "PlayerAdded" event
Players.PlayerAdded:Connect(leaderboardSetup)