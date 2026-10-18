local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local isBoostActive = false
local boostSpeed = 60 -- Zielgeschwindigkeit in km/h-Äquivalent

-- GUI-Button erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ForceBoostGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "BoostButton"
button.Size = UDim2.new(0, 160, 0, 50)
button.Position = UDim2.new(0.05, 0, 0.4, 0)
button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Text = "Echter Boost: AUS"
button.Parent = screenGui

-- Toggle-Funktion
button.MouseButton1Click:Connect(function()
    isBoostActive = not isBoostActive
    if isBoostActive then
        button.Text = "Echter Boost: AN"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    else
        button.Text = "Echter Boost: AUS"
        button.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end
end)

-- Physikalischer Schub-Loop
RunService.Stepped:Connect(function()
    if isBoostActive then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            -- Prüft, ob du dich vorwärts bewegst (Gas gibst)
            if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                -- Drückt dich direkt in deine aktuelle Blick-/Fahrrichtung
                hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * (boostSpeed / 30))
            end
        end
    end
end)
