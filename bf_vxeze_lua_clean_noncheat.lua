-- bf_vxeze_lua_clean_noncheat.lua
-- Clean Lua / Roblox API utility version.
-- Intentionally excludes exploit, auto-hit, damage and attack RemoteEvent logic.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local Config = {
    Enabled = true,
    Debug = false,
    MaxDistance = 58,
}

local State = {
    Character = nil,
    Humanoid = nil,
    RootPart = nil,
}

local function debugLog(...)
    if Config.Debug then
        print("[CleanLua]", ...)
    end
end

local function getCharacter()
    local character = LocalPlayer and LocalPlayer.Character
    if not character or not character.Parent then
        return nil
    end
    return character
end

local function refreshCharacter()
    local character = getCharacter()

    State.Character = character
    State.Humanoid = character and character:FindFirstChildOfClass("Humanoid") or nil
    State.RootPart = character and character:FindFirstChild("HumanoidRootPart") or nil

    return character
end

local function isCharacterReady(character)
    if not character or not character.Parent then
        return false
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")

    return humanoid ~= nil
        and rootPart ~= nil
        and humanoid.Health > 0
end

local function getDistanceFromLocalPlayer(position)
    if typeof(position) ~= "Vector3" then
        return math.huge
    end

    if not State.RootPart or not State.RootPart.Parent then
        refreshCharacter()
    end

    if not State.RootPart then
        return math.huge
    end

    return (State.RootPart.Position - position).Magnitude
end

local function getPlayersInRange(maxDistance)
    maxDistance = tonumber(maxDistance) or Config.MaxDistance

    local result = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character

            if isCharacterReady(character) then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local distance = getDistanceFromLocalPlayer(rootPart.Position)

                if distance <= maxDistance then
                    table.insert(result, {
                        Player = player,
                        Character = character,
                        RootPart = rootPart,
                        Distance = distance,
                    })
                end
            end
        end
    end

    table.sort(result, function(a, b)
        return a.Distance < b.Distance
    end)

    return result
end

local function getEquippedTool()
    local character = getCharacter()
    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Tool")
end

local function getToolName()
    local tool = getEquippedTool()
    return tool and tool.Name or nil
end

local function characterAdded(character)
    State.Character = character
    State.Humanoid = character:WaitForChild("Humanoid", 5)
    State.RootPart = character:WaitForChild("HumanoidRootPart", 5)

    debugLog("Character ready:", character.Name)
end

if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(characterAdded)
    refreshCharacter()
end

-- Lightweight update loop. It only refreshes local state and does not
-- perform attacks, damage, exploit actions, or remote combat calls.
local heartbeatConnection
heartbeatConnection = RunService.Heartbeat:Connect(function()
    if not Config.Enabled then
        return
    end

    if not isCharacterReady(State.Character) then
        refreshCharacter()
    end
end)

local API = {}

function API.GetState()
    return {
        Character = State.Character,
        Humanoid = State.Humanoid,
        RootPart = State.RootPart,
    }
end

function API.GetEquippedTool()
    return getEquippedTool()
end

function API.GetToolName()
    return getToolName()
end

function API.GetPlayersInRange(maxDistance)
    return getPlayersInRange(maxDistance)
end

function API.GetDistance(position)
    return getDistanceFromLocalPlayer(position)
end

function API.Destroy()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

-- Expose only a harmless utility table.
return API
