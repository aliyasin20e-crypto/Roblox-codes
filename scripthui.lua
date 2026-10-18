local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Einstellungen für den Physik-Boost
local boostMultiplier = 2.5 -- Wie viel schneller der Scooter fahren soll (z. B. 2.5x)
local isBoostActive = false

-- GUI auf dem Bildschirm erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScooterBoostGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "BoostButton"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.05, 0, 0.4, 0)
button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Text = "Scooter Boost: OFF"
button.Parent = screenGui

-- Button-Klick Umschalter
button.MouseButton1Click:Connect(function()
    isBoostActive = not isBoostActive
    if isBoostActive then
        button.Text = "Scooter Boost: ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    else
        button.Text = "Scooter Boost: OFF"
        button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end
end)

-- Physik-Loop für den Schub
RunService.RenderStepped:Connect(function()
    if isBoostActive then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            -- Findet das Hauptteil des E-Scooters (RootPart)
            local vehiclePart = hrp.Parent:IsA("Model") and hrp.Parent.PrimaryPart or hrp
            
            -- Drückt das Fahrzeug in Blickrichtung nach vorne
            if vehiclePart then
                vehiclePart.AssemblyLinearVelocity = vehiclePart.AssemblyLinearVelocity * Vector3.new(boostMultiplier, 1, boostMultiplier)
            end
        end
    end
end)
