local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- GUI Erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MasterSpawnerHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Hauptfenster
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 440)
mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Titelleiste
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0.6, 0, 1, 0)
titleText.Position = UDim2.new(0.04, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "⚡ Master Spawner"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 15
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Scan/Refresh Button
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 65, 0, 24)
refreshBtn.Position = UDim2.new(0.77, 0, 0.18, 0)
refreshBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
refreshBtn.Text = "Scan"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.TextSize = 11
refreshBtn.Font = Enum.Font.GothamMedium
refreshBtn.Parent = titleBar

local refreshCorner = Instance.new("UICorner")
refreshCorner.CornerRadius = UDim.new(0, 5)
refreshCorner.Parent = refreshBtn

-- TAB BUTTONS (Navigation)
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0.92, 0, 0, 32)
tabFrame.Position = UDim2.new(0.04, 0, 0.11, 0)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = mainFrame

local vehiclesTab = Instance.new("TextButton")
vehiclesTab.Size = UDim2.new(0.48, 0, 1, 0)
vehiclesTab.Position = UDim2.new(0, 0, 0, 0)
vehiclesTab.BackgroundColor3 = Color3.fromRGB(0, 140, 255) -- Aktiv beim Start
vehiclesTab.Text = "🏎️ Fahrzeuge"
vehiclesTab.TextColor3 = Color3.fromRGB(255, 255, 255)
vehiclesTab.TextSize = 12
vehiclesTab.Font = Enum.Font.GothamBold
vehiclesTab.Parent = tabFrame

local vTabCorner = Instance.new("UICorner")
vTabCorner.CornerRadius = UDim.new(0, 6)
vTabCorner.Parent = vehiclesTab

local itemsTab = Instance.new("TextButton")
itemsTab.Size = UDim2.new(0.48, 0, 1, 0)
itemsTab.Position = UDim2.new(0.52, 0, 0, 0)
itemsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 48) -- Inaktiv
itemsTab.Text = "📦 Items"
itemsTab.TextColor3 = Color3.fromRGB(180, 180, 190)
itemsTab.TextSize = 12
itemsTab.Font = Enum.Font.GothamBold
itemsTab.Parent = tabFrame

local iTabCorner = Instance.new("UICorner")
iTabCorner.CornerRadius = UDim.new(0, 6)
iTabCorner.Parent = itemsTab

-- Scroll-Bereich
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.92, 0, 0.77, 0)
scrollFrame.Position = UDim2.new(0.04, 0, 0.20, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 6)

-- Status
local currentTab = "Vehicles"

-- Teleport / Spawn Logik
local function spawnObject(obj)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart

    if currentTab == "Vehicles" then
        -- Teleportiert das Fahrzeug/Modell direkt vor deinen Charakter
        if obj:IsA("Model") then
            if obj.PrimaryPart then
                obj:SetPrimaryPartCFrame(hrp.CFrame + (hrp.CFrame.LookVector * 8) + Vector3.new(0, 2, 0))
            else
                local part = obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    obj:MoveTo(hrp.Position + (hrp.CFrame.LookVector * 8))
                end
            end
        end
    else
        -- Items: Entweder Klonen ins Backpack oder Herbeiholen
        if obj:IsA("Tool") then
            local cloned = obj:Clone()
            if cloned then
                cloned.Parent = player:FindFirstChildOfClass("Backpack") or character
            else
                if obj:FindFirstChild("Handle") then
                    obj.Handle.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                end
            end
        end
    end
end

-- Scan-Funktion für die jeweilige Kategorie
local function scanCategory()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local foundObjects = {}
    local locations = {Workspace, ReplicatedStorage}

    for _, loc in pairs(locations) do
        for _, obj in pairs(loc:GetDescendants()) do
            local isValid = false

            if currentTab == "Vehicles" then
                -- Erkennt Fahrzeuge an VehicleSeat, Seats oder spezifischen Modellen
                if obj:IsA("Model") and (obj:FindFirstChildWhichIsA("VehicleSeat") or obj:FindFirstChild("DriveSeat") or obj.Name:lower():find("car") or obj.Name:lower():find("scooter") or obj.Name:lower():find("kukirin")) then
                    isValid = true
                end
            elseif currentTab == "Items" then
                -- Erkennt Werkzeuge und aufhebbare Items
                if obj:IsA("Tool") then
                    isValid = true
                end
            end

            if isValid and not foundObjects[obj.Name] then
                foundObjects[obj.Name] = obj

                local card = Instance.new("Frame")
                card.Size = UDim2.new(1, -6, 0, 36)
                card.BackgroundColor3 = Color3.fromRGB(36, 36, 44)
                card.BorderSizePixel = 0
                card.Parent = scrollFrame

                local cardCorner = Instance.new("UICorner")
                cardCorner.CornerRadius = UDim.new(0, 6)
                cardCorner.Parent = card

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0.65, 0, 1, 0)
                label.Position = UDim2.new(0.04, 0, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = obj.Name
                label.TextColor3 = Color3.fromRGB(220, 220, 230)
                label.TextSize = 13
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = card

                local actionBtn = Instance.new("TextButton")
                actionBtn.Size = UDim2.new(0, 75, 0, 24)
                actionBtn.Position = UDim2.new(0.72, 0, 0.16, 0)
                actionBtn.BackgroundColor3 = currentTab == "Vehicles" and Color3.fromRGB(0, 140, 255) or Color3.fromRGB(46, 180, 100)
                actionBtn.Text = currentTab == "Vehicles" and "Holen" or "Spawnen"
                actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                actionBtn.TextSize = 11
                actionBtn.Font = Enum.Font.GothamBold
                actionBtn.Parent = card

                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 5)
                btnCorner.Parent = actionBtn

                actionBtn.MouseButton1Click:Connect(function()
                    spawnObject(obj)
                end)
            end
        end
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end

-- Tab-Umschaltlogik
vehiclesTab.MouseButton1Click:Connect(function()
    currentTab = "Vehicles"
    vehiclesTab.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
    vehiclesTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    itemsTab.TextColor3 = Color3.fromRGB(180, 180, 190)
    scanCategory()
end)

itemsTab.MouseButton1Click:Connect(function()
    currentTab = "Items"
    itemsTab.BackgroundColor3 = Color3.fromRGB(46, 180, 100)
    itemsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    vehiclesTab.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    vehiclesTab.TextColor3 = Color3.fromRGB(180, 180, 190)
    scanCategory()
end)

refreshBtn.MouseButton1Click:Connect(function()
    scanCategory()
end)

-- Start-Scan
scanCategory()
