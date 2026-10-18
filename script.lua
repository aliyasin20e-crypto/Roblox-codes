local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Global State
local ESP_Enabled = false
local ESP_Objects = {}

-- GUI Screen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateHubMaster"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------
-- 1. LOGIN SYSTEM (Key: 2580)
----------------------------------------------------
local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginFrame"
loginFrame.Size = UDim2.new(0, 300, 0, 200)
loginFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
loginFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
loginFrame.BorderSizePixel = 0
loginFrame.Active = true
loginFrame.Draggable = true
loginFrame.Parent = screenGui

local loginCorner = Instance.new("UICorner")
loginCorner.CornerRadius = UDim.new(0, 12)
loginCorner.Parent = loginFrame

local loginStroke = Instance.new("UIStroke")
loginStroke.Color = Color3.fromRGB(0, 200, 255)
loginStroke.Thickness = 1.5
loginStroke.Parent = loginFrame

local loginTitle = Instance.new("TextLabel")
loginTitle.Size = UDim2.new(1, 0, 0, 45)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "🔒 Security Access"
loginTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loginTitle.TextSize = 16
loginTitle.Font = Enum.Font.GothamBold
loginTitle.Parent = loginFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0, 35)
keyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
keyInput.Text = ""
keyInput.PlaceholderText = "Key eingeben..."
keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.GothamMedium
keyInput.Parent = loginFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyInput

local loginBtn = Instance.new("TextButton")
loginBtn.Size = UDim2.new(0.8, 0, 0, 35)
loginBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
loginBtn.Text = "Login"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.TextSize = 14
loginBtn.Font = Enum.Font.GothamBold
loginBtn.Parent = loginFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = loginBtn

----------------------------------------------------
-- 2. HAUPTFENSTER (MAIN DASHBOARD)
----------------------------------------------------
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 480)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 220, 255)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Titlebar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(0.5, 0, 1, 0)
mainTitle.Position = UDim2.new(0.04, 0, 0, 0)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "⚡ Ultimate Hub v1.0"
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.TextSize = 15
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(0.9, -5, 0.15, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
minimizeBtn.Text = "─"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
minimizeBtn.TextSize = 14
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

-- Schwebeknopf
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
openBtn.Text = "⚡"
openBtn.TextSize = 22
openBtn.TextColor3 = Color3.fromRGB(0, 220, 255)
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(0, 220, 255)
openStroke.Thickness = 2
openStroke.Parent = openBtn

----------------------------------------------------
-- TAB NAVIGATION
----------------------------------------------------
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0.92, 0, 0, 36)
tabContainer.Position = UDim2.new(0.04, 0, 0.11, 0)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabContainer
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 6)

local tabs = {"Visuals", "Items", "Fahrzeuge", "Teleport"}
local tabButtons = {}
local tabPages = {}

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0.92, 0, 0.8, -15)
contentFrame.Position = UDim2.new(0.04, 0, 0.20, 5)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

for i, tabName in ipairs(tabs) do
    -- Tab Buttons
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.23, 0, 1, 0)
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(28, 28, 38)
    btn.Text = tabName
    btn.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 180)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabContainer

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 6)
    bCorner.Parent = btn

    tabButtons[tabName] = btn

    -- Tab Pages
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
    page.Visible = (i == 1)
    page.Parent = contentFrame

    local pLayout = Instance.new("UIListLayout")
    pLayout.Parent = page
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pLayout.Padding = UDim.new(0, 8)

    tabPages[tabName] = page
end

----------------------------------------------------
-- LOGIK & MODULE
----------------------------------------------------

-- 1. VISUALS (ESP & Wallhack)
local visualsPage = tabPages["Visuals"]

local function createToggle(parent, name, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -6, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 6)
    fCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.04, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 230, 240)
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 26)
    toggleBtn.Position = UDim2.new(0.78, 0, 0.17, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    toggleBtn.Text = "AUS"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 10
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 5)
    tCorner.Parent = toggleBtn

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.Text = state and "AN" or "AUS"
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(180, 40, 40)
        callback(state)
    end)
end

-- ESP Funktion
createToggle(visualsPage, "Spieler ESP (Wallhack)", function(state)
    ESP_Enabled = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.FillColor = Color3.fromRGB(255, 0, 80)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = plr.Character
            else
                if plr.Character:FindFirstChild("ESPHighlight") then
                    plr.Character.ESPHighlight:Destroy()
                end
            end
        end
    end
end)

-- 2. ITEM & FAHRZEUG SCANNER
local function populateList(page, filterFunc, actionFunc)
    for _, child in pairs(page:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local itemsFound = {}
    local locations = {Workspace, ReplicatedStorage}

    for _, loc in pairs(locations) do
        for _, obj in pairs(loc:GetDescendants()) do
            if filterFunc(obj) and not itemsFound[obj.Name] then
                itemsFound[obj.Name] = true

                local card = Instance.new("Frame")
                card.Size = UDim2.new(1, -6, 0, 38)
                card.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
                card.BorderSizePixel = 0
                card.Parent = page

                local cCorner = Instance.new("UICorner")
                cCorner.CornerRadius = UDim.new(0, 6)
                cCorner.Parent = card

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0.65, 0, 1, 0)
                label.Position = UDim2.new(0.04, 0, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = obj.Name
                label.TextColor3 = Color3.fromRGB(220, 220, 230)
                label.TextSize = 12
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextTruncate = Enum.TextTruncate.AtEnd
                label.Parent = card

                local actBtn = Instance.new("TextButton")
                actBtn.Size = UDim2.new(0, 75, 0, 26)
                actBtn.Position = UDim2.new(0.72, 0, 0.16, 0)
                actBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                actBtn.Text = "Holen"
                actBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                actBtn.TextSize = 11
                actBtn.Font = Enum.Font.GothamBold
                actBtn.Parent = card

                local aCorner = Instance.new("UICorner")
                aCorner.CornerRadius = UDim.new(0, 5)
                aCorner.Parent = actBtn

                actBtn.MouseButton1Click:Connect(function()
                    actionFunc(obj)
                end)
            end
        end
    end
end

-- Refresh Buttons
local function addScanButton(page, callback)
    local scan = Instance.new("TextButton")
    scan.Size = UDim2.new(1, -6, 0, 32)
    scan.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    scan.Text = "🔄 Scan Starten"
    scan.TextColor3 = Color3.fromRGB(255, 255, 255)
    scan.TextSize = 12
    scan.Font = Enum.Font.GothamBold
    scan.Parent = page

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = scan

    scan.MouseButton1Click:Connect(callback)
end

-- Items Tab Setup
addScanButton(tabPages["Items"], function()
    populateList(tabPages["Items"], function(obj)
        return obj:IsA("Tool")
    end, function(obj)
        local char = LocalPlayer.Character
        if char then
            local clone = obj:Clone()
            if clone then
                clone.Parent = LocalPlayer:FindFirstChildOfClass("Backpack") or char
            elseif obj:FindFirstChild("Handle") then
                obj.Handle.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
            end
        end
    end)
end)

-- Fahrzeuge Tab Setup
addScanButton(tabPages["Fahrzeuge"], function()
    populateList(tabPages["Fahrzeuge"], function(obj)
        return obj:IsA("Model") and (obj:FindFirstChildWhichIsA("VehicleSeat") or obj.Name:lower():find("scooter") or obj.Name:lower():find("car"))
    end, function(obj)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if obj.PrimaryPart then
                obj:SetPrimaryPartCFrame(char.HumanoidRootPart.CFrame + Vector3.new(0, 2, 5))
            else
                obj:MoveTo(char.HumanoidRootPart.Position + Vector3.new(0, 2, 5))
            end
        end
    end)
end)

-- Teleport Tab Setup
addScanButton(tabPages["Teleport"], function()
    populateList(tabPages["Teleport"], function(obj)
        return obj:IsA("Player") and obj ~= LocalPlayer
    end, function(targetPlayer)
        local char = LocalPlayer.Character
        if char and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 2)
        end
    end)
end)

----------------------------------------------------
-- INTERACTION EVENTS
----------------------------------------------------
loginBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "2580" then
        loginFrame.Visible = false
        mainFrame.Visible = true
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "Falscher Key!"
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openBtn.Visible = false
end)

-- Tab Switching
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for tName, page in pairs(tabPages) do
            page.Visible = (tName == name)
            tabButtons[tName].BackgroundColor3 = (tName == name) and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(28, 28, 38)
            tabButtons[tName].TextColor3 = (tName == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 180)
        end
    end)
end
