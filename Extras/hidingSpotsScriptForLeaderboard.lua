local Locations = {} -- variable named Locations set to empty list
local Model = script.Parent -- variable named Model set to whatever the script is in

--Stuff for leaderboard
local Players = game:GetService("Players")

for i, P in pairs(Model:children()) do -- for every object in model
    if( P:IsA('BasePart') ) then -- if its a part of any kind, do the following code
        P.Anchored = true -- anchor the part so it wont be affected by physics
        P.Transparency = 1 -- make the part invisible
        P.CanCollide = false -- disable the part colliding with other parts
        table.insert(Locations, P) -- add the part to the Locations list
    end
end

if #Locations <= 1 then -- if the amount of things in the list is less than or equal to 1
    return error("You need more than one Part in the model!") -- don't continue, we need atleast 2 spots
end

local Orb = Instance.new('Part', workspace) -- create a part in the workspace
Orb.Anchored = true -- anchor it so it doesnt fall down
Orb.Material = 'Neon' -- make it glow
Orb.Shape = 'Ball' -- make it a sphere
Orb.Size = Vector3.new(3,3,3) -- make it 3x3x3
Orb.CanCollide = false -- disable part colliding with other parts

local Light = Instance.new('PointLight', Orb)

local Spot -- make an empty variable called Spot

-- chooseSpot will choose the new random spot to hide the Orb
function chooseSpot() -- define a function called chooseSpot
    local chosenSpot = Spot -- set variable called chosenSpot to the current Spot
    while chosenSpot == Spot do -- while the chosenSpot is the current Spot, do the next line
        chosenSpot = Locations[math.random(1, #Locations)] -- choose a random spot from the list
    end
    return chosenSpot -- return the chosen spot
end

-- spawnOrb will move the orb somewhere else
function spawnOrb() -- define a function called spawnOrb
    Spot = chooseSpot() -- set Spot equal to the value of running chooseSpot function
    Orb.CFrame = Spot.CFrame -- move the orb to the new spot
    Orb.Transparency = 0.1 -- make the orb visible
end

-- fadeOrbOut will make the orb slowly disappear
function fadeOrbOut() -- define a new function called fadeOrbOut
    for i=.1, 1, .025 do -- from the number .1 to 1 in incrememts of 0.025, do the following
        Orb.Transparency = i -- set the orb's transparency to the number
        wait() -- wait 1/30th of a second
    end
    Orb.Transparency = 1 -- make the orb invisible
end

local Debounce = false -- define a variable called debounce to false


local function onTouch(otherPart)
    if(Debounce)then -- if the Debounce variable is true
        return -- stop immediately, don't do anything
    end
    Debounce = true -- set debounce to true

    local partParent = otherPart.Parent
    local humanoid = partParent:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        -- Update the player's leaderboard stat
        local player = Players:GetPlayerFromCharacter(partParent)
        local leaderstats = player.leaderstats
        local orbsStat = leaderstats and leaderstats:FindFirstChild("Orbs")
        if orbsStat then
            orbsStat.Value = orbsStat.Value + 1
        end
    end

    fadeOrbOut() -- Call the fadeOrbOut function
    wait(2) -- wait 2 seconds after it fades out
    spawnOrb() -- move it somewhere else
    Debounce = false -- set debounce to false
end

Orb.Touched:connect(onTouch)

spawnOrb() -- run the spawnOrb function



