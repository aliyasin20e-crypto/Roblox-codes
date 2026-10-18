local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI Erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TitanHubV3"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------
-- 1. ANIMIERTES LOGIN SYSTEM (Key: 2580)
----------------------------------------------------
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 320, 0, 220)
loginFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
loginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 14)
local lStroke = Instance.new("UIStroke", loginFrame)
lStroke.Color = Color3.fromRGB(0, 255, 128)
lStroke.Thickness = 2.5

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Size = UDim2.new(1, 0, 0, 50)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "🪐 TITAN HUB V3"
loginTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextSize = 22

local keyInput = Instance.new("TextBox", loginFrame)
keyInput.Size = UDim2.new(0.8, 0, 0, 40)
keyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Passwort (2580)..."
keyInput.Font = Enum.Font.GothamMedium
keyInput.Text = ""
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local loginBtn = Instance.new("TextButton", loginFrame)
loginBtn.Size = UDim2.new(0.8, 0, 0, 40)
loginBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
loginBtn.Text = "SYSTEM ENTSPERREN"
loginBtn.TextColor3 = Color3.fromRGB(15, 15, 22)
loginBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------
-- 2. HAUPTFENSTER (TITAN DASHBOARD)
----------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 550, 0, 400)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(0, 255, 128)
mStroke.Thickness = 2

-- Titelleiste
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)
local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.5, 0, 1, 0)
titleText.Position = UDim2.new(0.02, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🪐 TITAN HUB - ULTIMATE EDITION"
titleText.TextColor3 = Color3.fromRGB(0, 255, 128)
titleText.Font = Enum.Font.GothamBlack
titleText.TextSize = 15
titleText.TextXAlignment = Enum.TextXAlignment.Left

-- Minimieren Button
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(0.92, 0, 0.1, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minBtn.Text = "─"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
openBtn.Text = "🪐"
openBtn.TextSize = 24
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(0, 255, 128)

minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; openBtn.Visible = false end)

----------------------------------------------------
-- 3. SIDEBAR NAVIGATION
----------------------------------------------------
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0.25, 0, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 2
local sLayout = Instance.new("UIListLayout", sidebar)
sLayout.Padding = UDim.new(0, 2)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(0.75, 0, 1, -40)
contentArea.Position = UDim2.new(0.25, 0, 0, 40)
contentArea.BackgroundTransparency = 1

local tabs = {
    "🌐 Universal", 
    "👁️ Visuals & TP", 
    "🛠️ Admin & B-Tools", 
    "🎮 10.000 Games", 
    "🏙️ Brookhaven / RP", 
    "🏎️ Hamburg / Drive", 
    "💸 Pls Donate / Tycoon", 
    "📦 Lucky Blocks / Uff"
}
local tabBtns, tabPages = {}, {}

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(18, 18, 26)
    btn.Text = "  " .. tab
    btn.TextColor3 = i == 1 and Color3.fromRGB(15, 15, 22) or Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtns[tab] = btn

    local page = Instance.new("ScrollingFrame", contentArea)
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 128)
    page.Visible = (i == 1)
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 8)
    tabPages[tab] = page
end

for name, btn in pairs(tabBtns) do
    btn.MouseButton1Click:Connect(function()
        for tName, page in pairs(tabPages) do
            page.Visible = (tName == name)
            tabBtns[tName].BackgroundColor3 = (tName == name) and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(18, 18, 26)
            tabBtns[tName].TextColor3 = (tName == name) and Color3.fromRGB(15, 15, 22) or Color3.fromRGB(200, 200, 200)
        end
    end)
end

----------------------------------------------------
-- UI HELPER (Buttons erstellen)
----------------------------------------------------
local function createBtn(parent, text, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

----------------------------------------------------
-- INHALTE FÜLLEN
----------------------------------------------------

-- TAB 1: UNIVERSAL (Klappt in jedem Spiel)
createBtn(tabPages["🌐 Universal"], "🚀 Speed Hack (Walkspeed)", nil, function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
createBtn(tabPages["🌐 Universal"], "🦘 Moon Jump", nil, function() LocalPlayer.Character.Humanoid.JumpPower = 150 end)
createBtn(tabPages["🌐 Universal"], "👻 Noclip (Durch Wände)", nil, function()
    RunService.Stepped:Connect(function()
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end)
end)
createBtn(tabPages["🌐 Universal"], "☁️ Infinite Jump", nil, function()
    UserInputService.JumpRequest:Connect(function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
end)

-- TAB 2: VISUALS & TELEPORT
createBtn(tabPages["👁️ Visuals & TP"], "🔴 Player ESP (Wallhack)", Color3.fromRGB(180, 40, 40), function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local h = Instance.new("Highlight", plr.Character) h.FillColor = Color3.fromRGB(255,0,0) h.FillTransparency = 0.5
        end
    end
end)
createBtn(tabPages["👁️ Visuals & TP"], "☀️ Fullbright (Keine Nacht)", nil, function() Lighting.Ambient = Color3.new(1,1,1) Lighting.GlobalShadows = false end)
createBtn(tabPages["👁️ Visuals & TP"], "🖱️ Klick-Teleport aktivieren", Color3.fromRGB(40, 100, 180), function()
    Mouse.Button1Down:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Mouse.Hit then
            LocalPlayer.Character.HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 3, 0)
        end
    end)
end)

-- TAB 3: ADMIN & B-TOOLS (Die wichtigsten Hacker-Werkzeuge)
createBtn(tabPages["🛠️ Admin & B-Tools"], "⚙️ Lade INFINITE YIELD (200+ Commands)", Color3.fromRGB(200, 0, 0), function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
createBtn(tabPages["🛠️ Admin & B-Tools"], "🔨 Lade F3X B-Tools (Ganzes Spiel umbauen)", Color3.fromRGB(200, 100, 0), function()
    loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)
createBtn(tabPages["🛠️ Admin & B-Tools"], "🖐️ Gib Admin HopperBins (Clone/Destroy)", nil, function()
    local b1 = Instance.new("HopperBin", LocalPlayer.Backpack) b1.BinType = Enum.BinType.Clone
    local b2 = Instance.new("HopperBin", LocalPlayer.Backpack) b2.BinType = Enum.BinType.Hammer
    local b3 = Instance.new("HopperBin", LocalPlayer.Backpack) b3.BinType = Enum.BinType.Grab
end)

-- TAB 4: 10.000 GAMES
createBtn(tabPages["🎮 10.000 Games"], "⚡ Lade Universal Game Hub (DarkHub)", Color3.fromRGB(80, 0, 150), function()
    -- Lädt ein externes Multi-Game Skript
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RandomScript/Universal/main/Load"))()
end)
createBtn(tabPages["🎮 10.000 Games"], "🚗 Alle unbesetzten Autos spawnen", nil, function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") and not obj.Occupant then
            local model = obj:FindFirstAncestorOfClass("Model")
            if model then model:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position) end
        end
    end
end)

-- TAB 5: BROOKHAVEN / RP
createBtn(tabPages["🏙️ Brookhaven / RP"], "🏠 Lade Brookhaven Admin Panel (IceHub)", Color3.fromRGB(0, 150, 255), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))()
end)
createBtn(tabPages["🏙️ Brookhaven / RP"], "🔥 Alle Items & Props geben", nil, function()
    -- Universeller Tool-Finder für RP Spiele
    for _, tool in pairs(ReplicatedStorage:GetDescendants()) do
        if tool:IsA("Tool") then tool:Clone().Parent = LocalPlayer.Backpack end
    end
end)

-- TAB 6: NOTRUF HAMBURG & DRIVE KUKIRIN & EMPIRE
createBtn(tabPages["🏎️ Hamburg / Drive"], "🏎️ A-Chassis Auto-Tuning (Top Speed)", Color3.fromRGB(255, 50, 50), function()
    -- Sucht A-Chassis und modifiziert lokale Werte
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ModuleScript") and obj.Name == "Tune" then
            local tune = require(obj)
            if tune.Horsepower then tune.Horsepower = 5000 end
            if tune.TopSpeed then tune.TopSpeed = 500 end
        end
    end
end)
createBtn(tabPages["🏎️ Hamburg / Drive"], "💰 Drive Kukirin / Empire Auto-Farm Start", Color3.fromRGB(50, 200, 50), function()
    -- Teleportiert das Auto immer wieder vorwärts für Meilen-Geld
    RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart then
            local car = char.Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
            if car and car.PrimaryPart then
                car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame * CFrame.new(0, 0, -10))
            end
        end
    end)
end)

-- TAB 7: PLS DONATE & TYCOONS
createBtn(tabPages["💸 Pls Donate / Tycoon"], "💸 Pls Donate: Fake Donation (Visuell)", Color3.fromRGB(255, 200, 0), function()
    game.StarterGui:SetCore("SendNotification", {Title = "Spende", Text = "Jemand hat dir 100.000 Robux gespendet!", Duration = 5})
    LocalPlayer.leaderstats.Raised.Value = LocalPlayer.leaderstats.Raised.Value + 100000
end)
createBtn(tabPages["💸 Pls Donate / Tycoon"], "🏭 Tycoon Auto-Collect Drops", nil, function()
    while task.wait(1) do
        for _, part in pairs(Workspace:GetDescendants()) do
            if part.Name == "Drop" or part.Name == "Cash" or part:IsA("TouchTransporter") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, part, 1)
            end
        end
    end
end)

-- TAB 8: LUCKY BLOCKS / VERSTECKEN / UFF
createBtn(tabPages["📦 Lucky Blocks / Uff"], "🎲 Auto-Open Lucky Blocks", Color3.fromRGB(200, 50, 200), function()
    for _, block in pairs(Workspace:GetDescendants()) do
        if block.Name:lower():find("lucky") and block:IsA("BasePart") then
            block.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            task.wait(0.1)
            fireclickdetector(block:FindFirstChildWhichIsA("ClickDetector"))
        end
    end
end)
createBtn(tabPages["📦 Lucky Blocks / Uff"], "👀 Verstecken (Hide & Seek) ESP", nil, function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local tag = Instance.new("BillboardGui", plr.Character.Head)
            tag.Size = UDim2.new(0, 100, 0, 40)
            tag.AlwaysOnTop = true
            local text = Instance.new("TextLabel", tag)
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = "Versteckt: " .. plr.Name
            text.TextColor3 = Color3.fromRGB(255, 255, 0)
            text.TextScaled = true
        end
    end
end)

----------------------------------------------------
-- LOGIN LOGIK & START
----------------------------------------------------
loginBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "2580" then
        TweenService:Create(loginFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -160, 1.5, 0)}):Play()
        task.wait(0.5)
        loginFrame.Visible = false
        mainFrame.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -275, 0.5, -200)}):Play()
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "FEHLER: Falscher Code!"
    end
end)
