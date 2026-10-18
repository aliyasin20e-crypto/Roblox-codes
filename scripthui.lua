local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- GUI erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ItemSpawnerHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Hauptfenster
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Auf dem Bildschirm verschiebbar
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Titel-Leiste
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0.04, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "📦 Item Spawner"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Refresh Button
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 70, 0, 26)
refreshBtn.Position = UDim2.new(0.74, 0, 0.18, 0)
refreshBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
refreshBtn.Text = "Scan"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.TextSize = 12
refreshBtn.Font = Enum.Font.GothamMedium
refreshBtn.Parent = titleBar

local refreshCorner = Instance.new("UICorner")
refreshCorner.CornerRadius = UDim.new(0, 6)
refreshCorner.Parent = refreshBtn

-- Scrollbereich für die Items
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.92, 0, 0.85, -10)
scrollFrame.Position = UDim2.new(0.04, 0, 0.12, 5)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 6)

-- Funktion zum Teleportieren / Klonen des Items
local function spawnItem(item)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    if item:IsA("Tool") then
        -- Versuche das Item zu klonen
        local cloned = item:Clone()
        if cloned then
            cloned.Parent = player:FindFirstChildOfClass("Backpack") or character
        else
            -- Falls Clonen fehlschlägt, das physische Item im Workspace zu dir teleportieren
            if item:FindFirstChild("Handle") then
                item.Handle.CFrame = character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
            end
        end
    elseif item:IsA("BasePart") or item:IsA("Model") then
        -- Teleportiert rumliegende Blöcke/Modelle direkt vor deine Nase
        local targetPart = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")) or item
        if targetPart then
            if item:IsA("Model") and item.PrimaryPart then
                item:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 3))
            elseif targetPart:IsA("BasePart") then
                targetPart.CFrame = character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 3)
            end
        end
    end
end

-- Scan-Funktion für alle Items im Spiel
local function scanForItems()
    -- Alte Buttons löschen
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local foundItems = {}
    local locations = {Workspace, ReplicatedStorage, Lighting}

    for _, location in pairs(locations) do
        for _, object in pairs(location:GetDescendants()) do
            -- Sucht nach Tools sowie nach physischen Modellen/Parts auf dem Boden
            if (object:IsA("Tool") or (object:IsA("Model") and object:FindFirstChild("Handle"))) and not foundItems[object.Name] then
                foundItems[object.Name] = object

                -- Container-Card erstellen
                local card = Instance.new("Frame")
                card.Size = UDim2.new(1, -6, 0, 36)
                card.BackgroundColor3 = Color3.fromRGB(36, 36, 44)
                card.BorderSizePixel = 0
                card.Parent = scrollFrame

                local cardCorner = Instance.new("UICorner")
                cardCorner.CornerRadius = UDim.new(0, 6)
                cardCorner.Parent = card

                local itemLabel = Instance.new("TextLabel")
                itemLabel.Size = UDim2.new(0.65, 0, 1, 0)
                itemLabel.Position = UDim2.new(0.04, 0, 0, 0)
                itemLabel.BackgroundTransparency = 1
                itemLabel.Text = object.Name
                itemLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
                itemLabel.TextSize = 13
                itemLabel.Font = Enum.Font.Gotham
                itemLabel.TextXAlignment = Enum.TextXAlignment.Left
                itemLabel.TextTruncate = Enum.TextTruncate.AtEnd
                itemLabel.Parent = card

                local spawnBtn = Instance.new("TextButton")
                spawnBtn.Size = UDim2.new(0, 70, 0, 24)
                spawnBtn.Position = UDim2.new(0.72, 0, 0.16, 0)
                spawnBtn.BackgroundColor3 = Color3.fromRGB(46, 180, 100)
                spawnBtn.Text = "Spawnen"
                spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                spawnBtn.TextSize = 11
                spawnBtn.Font = Enum.Font.GothamBold
                spawnBtn.Parent = card

                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 5)
                btnCorner.Parent = spawnBtn

                spawnBtn.MouseButton1Click:Connect(function()
                    spawnItem(object)
                end)
            end
        end
    end

    -- Canvas-Höhe automatisch an die Anzahl der Items anpassen
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end

-- Refresh-Button Event
refreshBtn.MouseButton1Click:Connect(function()
    scanForItems()
end)

-- Initialer Scan beim Start
scanForItems()
