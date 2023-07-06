local poisonTimers = {}

local function findPlayerFromCharacter(char)
    for i,v in pairs(game.Players:players())do
        if(v.Character == char)then return v;end;
    end
end

script.Parent.Touched:Connect(function(part)
    local h = part.Parent:findFirstChild('Humanoid');
    if(h)then
        local player = findPlayerFromCharacter(h.Parent);
        if(player)then
            if(poisonTimers[player])then
                poisonTimers[player] = os.time() + 5
            else
                poisonTimers[player] = os.time() + 5
                while(true)do
                    local t = poisonTimers[player]
                    if(t)then
                        if(os.time() < t)then
                            h:TakeDamage(8)
                        else poisonTimers[player] = nil end;
                    else break end
                    wait(1)
                end
            end
        end
    end
end)