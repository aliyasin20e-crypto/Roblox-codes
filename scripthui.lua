local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Multiplikator für die echte Physik-Geschwindigkeit (z. B. 2.0 = doppelt so schnell)
local boostMultiplier = 2.0
local isBoostActive = false

-- GUI-Button auf dem Bildschirm erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PhysicalBoostGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "BoostButton"
button.Size = UDim2.new(0, 160, 0, 50)
button.Position = UDim2.new(0.05, 0, 0.4, 0)
button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Text = "Physik-Boost: AUS"
button.Parent = screenGui

-- Button-Klick zum Ein-/Ausschalten
button.MouseButton1Click:Connect(function()
    isBoostActive = not isBoostActive
    if isBoostActive then
        button.Text = "Physik-Boost: AN"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    else
        button.Text = "Physik-Boost: AUS"
        button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end
end)

-- Kontinuierlicher Physik-Schub bei Bewegung
RunService.RenderStepped:Connect(function()
    if isBoostActive then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local currentVelocity = hrp.AssemblyLinearVelocity
            
            -- Prüft, ob du dich bereits vorwärts bewegst
            local flatVelocity = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)
            if flatVelocity.Magnitude > 2 then
                -- Drückt die Physik nach vorne, ohne den Sturz/Sprung (Y-Achse) zu verfälschen
                hrp.AssemblyLinearVelocity = Vector3.new(
                    currentVelocity.X * boostMultiplier,
                    currentVelocity.Y,
                    currentVelocity.Z * boostMultiplier
                )
            end
        end
    end
end)
