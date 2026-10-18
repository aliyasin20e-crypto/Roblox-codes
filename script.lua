local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local driveKukirinEvent = ReplicatedStorage:WaitForChild("DriveKukirinEvent")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local speedSettings = {
    Speed = 50,
    BoostSpeed = 100,
    BoostDuration = 5
}

local isBoosting = false
local boostTimer = 0

driveKukirinEvent.OnClientEvent:Connect(function(speedMultiplier)
    if speedMultiplier == 1 then
        humanoid.WalkSpeed = speedSettings.Speed
    elseif speedMultiplier == 2 then
        if not isBoosting then
            isBoosting = true
            boostTimer = 0
            humanoid.WalkSpeed = speedSettings.BoostSpeed
        end
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if isBoosting then
        boostTimer = boostTimer + dt
        if boostTimer >= speedSettings.BoostDuration then
            isBoosting = false
            humanoid.WalkSpeed = speedSettings.Speed
        end
    end
end)
