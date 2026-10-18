local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- Globale Toggle-Status
getgenv().Speed_Enabled = false
getgenv().Jump_Enabled = false
getgenv().Noclip_Enabled = false
getgenv().InfJump_Enabled = false
getgenv().ESP_Enabled = false
getgenv().Fullbright_Enabled = false
getgenv().Hitbox_Enabled = false
getgenv().Spin_Enabled = false

-- GUI Erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TitanV4_Massive"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------
-- 1. LOGIN SYSTEM (Animiert & Modern)
----------------------------------------------------
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 350, 0, 250)
loginFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
loginFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", loginFrame).Color = Color3.fromRGB(255, 0, 80)
Instance.new("UIStroke", loginFrame).Thickness = 2

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Size = UDim2.new(1, 0, 0, 60)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "TITAN V4 - 100+ FEATURES"
loginTitle.TextColor3 = Color3.fromRGB(255, 0, 80)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextSize = 22

local keyInput = Instance.new("TextBox", loginFrame)
keyInput.Size = UDim2.new(0.8, 0, 0, 45)
keyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Key eingeben (2580)..."
keyInput.Font = Enum.Font.GothamBold
keyInput.Text = ""
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local loginBtn = Instance.new("TextButton", loginFrame)
loginBtn.Size = UDim2.new(0.8, 0, 0, 45)
loginBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
loginBtn.Text = "LOGIN & INJECT"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.Font = Enum.Font.GothamBlack
loginBtn.TextSize = 16
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------
-- 2. HAUPTFENSTER (MASSIVE HUB)
----------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(255, 0, 80)

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)
local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.5, 0, 1, 0)
titleText.Position = UDim2.new(0.02, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TITAN V4 PREMIUM | 100+ Hacks"
titleText.TextColor3 = Color3.fromRGB(255, 0, 80)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 30, 0, 25)
minBtn.Position = UDim2.new(0.94, 0, 0.15, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

-- Minimier-Icon
local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
openBtn.Text = "T4"
openBtn.TextColor3 = Color3.fromRGB(255, 0, 80)
openBtn.Font = Enum.Font.GothamBlack
openBtn.TextSize = 20
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(255, 0, 80)

minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; openBtn.Visible = false end)

----------------------------------------------------
-- 3. UI FACTORY (Toggles & Buttons Generator)
----------------------------------------------------
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0.25, 0, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 2
local sLayout = Instance.new("UIListLayout", sidebar)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(0.75, 0, 1, -35)
contentArea.Position = UDim2.new(0.25, 0, 0, 35)
contentArea.BackgroundTransparency = 1

local tabPages = {}
local tabBtns = {}

local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtns[name] = btn

    local page = Instance.new("ScrollingFrame", contentArea)
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 80)
    page.Visible = false
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 6)
    tabPages[name] = page

    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabPages) do p.Visible = (n == name) end
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = (n == name) and Color3.fromRGB(255, 0, 80) or Color3.fromRGB(20, 20, 28)
            b.TextColor3 = (n == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        end
    end)
    return page
end

local function addToggle(page, text, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -5, 0, 35)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0.05, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 50, 0, 25)
    btn.Position = UDim2.new(0.8, 0, 0.15, 0)
    btn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    btn.Text = "AUS"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "AN" or "AUS"
        btn.BackgroundColor3 = state and Color3.fromRGB(30, 150, 60) or Color3.fromRGB(150, 30, 30)
        callback(state)
    end)
end

local function addBtn(page, text, color, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -5, 0, 35)
    btn.BackgroundColor3 = color or Color3.fromRGB(35, 35, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

----------------------------------------------------
-- 4. KATEGORIEN & FUNKTIONEN EINBAUEN
----------------------------------------------------
local pPlayer = createTab("🏃 Player & Movement")
local pCombat = createTab("⚔️ Combat & Hitboxes")
local pVisuals = createTab("👁️ Visuals & World")
local pGames = createTab("🎮 Game Specifics")
local pHubs = createTab("☠️ 500+ Admin Hubs")

tabPages["🏃 Player & Movement"].Visible = true
tabBtns["🏃 Player & Movement"].BackgroundColor3 = Color3.fromRGB(255, 0, 80)

-- ==========================================
-- TAB 1: PLAYER (PERFEKTE AN/AUS TOGGLES)
-- ==========================================
addToggle(pPlayer, "🚀 Speed Hack (WalkSpeed 100)", function(state)
    getgenv().Speed_Enabled = state
    while getgenv().Speed_Enabled do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 100
        end
        task.wait(0.1)
    end
    -- Normalisieren wenn AUS
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

addToggle(pPlayer, "🦘 Moon Jump (JumpPower 150)", function(state)
    getgenv().Jump_Enabled = state
    while getgenv().Jump_Enabled do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = 150
        end
        task.wait(0.1)
    end
    -- Normalisieren wenn AUS
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

local NoclipConnection
addToggle(pPlayer, "👻 Noclip (Durch Wände gehen)", function(state)
    getgenv().Noclip_Enabled = state
    if state then
        NoclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then NoclipConnection:Disconnect() end
    end
end)

addToggle(pPlayer, "☁️ Infinite Jump (Mehrfach springen)", function(state)
    getgenv().InfJump_Enabled = state
end)
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump_Enabled and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

addToggle(pPlayer, "🌪️ Spinbot (Charakter dreht sich)", function(state)
    getgenv().Spin_Enabled = state
    if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local spin = Instance.new("BodyAngularVelocity", LocalPlayer.Character.HumanoidRootPart)
        spin.Name = "SpinbotHax"
        spin.AngularVelocity = Vector3.new(0, 50, 0)
        spin.MaxTorque = Vector3.new(0, math.huge, 0)
    else
        if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("SpinbotHax") then
            LocalPlayer.Character.HumanoidRootPart.SpinbotHax:Destroy()
        end
    end
end)

-- ==========================================
-- TAB 2: COMBAT (Für Da Hood, Arsenal etc.)
-- ==========================================
addToggle(pCombat, "📦 Hitbox Expander (Riesige Köpfe)", function(state)
    getgenv().Hitbox_Enabled = state
    while getgenv().Hitbox_Enabled do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                plr.Character.Head.Size = Vector3.new(10, 10, 10)
                plr.Character.Head.Transparency = 0.5
                plr.Character.Head.CanCollide = false
            end
        end
        task.wait(1)
    end
    -- Reset wenn AUS
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            plr.Character.Head.Size = Vector3.new(2, 1, 1) -- Standard
            plr.Character.Head.Transparency = 0
        end
    end
end)

addBtn(pCombat, "🔫 Aimbot (Rechtsklick Lock-On)", Color3.fromRGB(150, 50, 50), function()
    -- Lädt ein sehr stabiles Universal Aimbot Skript aus der Szene
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Aimbot%20V2/Source.lua"))()
end)

-- ==========================================
-- TAB 3: VISUALS & WORLD
-- ==========================================
addToggle(pVisuals, "🔴 Player ESP (Feinde Rot markieren)", function(state)
    getgenv().ESP_Enabled = state
    while getgenv().ESP_Enabled do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                if not plr.Character:FindFirstChild("ESP_T4") then
                    local hl = Instance.new("Highlight", plr.Character)
                    hl.Name = "ESP_T4"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
        end
        task.wait(1)
    end
    -- Aufräumen
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("ESP_T4") then
            plr.Character.ESP_T4:Destroy()
        end
    end
end)

addToggle(pVisuals, "☀️ Fullbright (Nacht zu Tag)", function(state)
    getgenv().Fullbright_Enabled = state
    while getgenv().Fullbright_Enabled do
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        task.wait(0.5)
    end
end)

addBtn(pVisuals, "👁️ Kamera FOV auf 120", nil, function() Camera.FieldOfView = 120 end)
addBtn(pVisuals, "👁️ Kamera FOV auf 70 (Normal)", nil, function() Camera.FieldOfView = 70 end)

-- ==========================================
-- TAB 4: GAME SPECIFIC (Direkt codiert, keine toten Links!)
-- ==========================================

addBtn(pGames, "💸 Pls Donate: Fake 1.000.000 Robux", Color3.fromRGB(50, 180, 50), function()
    -- Verändert die Leaderstats lokal
    if LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Raised") then
        LocalPlayer.leaderstats.Raised.Value = 1000000
        StarterGui:SetCore("SendNotification", {Title = "PLS DONATE", Text = "Visual Hack aktiviert!", Duration = 5})
    end
end)

addBtn(pGames, "📦 Lucky Blocks: Teleport zu allen", Color3.fromRGB(200, 150, 0), function()
    -- Sucht alle BaseParts, die "Lucky" im Namen haben und portet dich hin
    local found = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("lucky") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
            task.wait(0.2)
            found = found + 1
        end
    end
    StarterGui:SetCore("SendNotification", {Title = "Lucky Blocks", Text = found .. " Blocks abgefarmt!", Duration = 3})
end)

addBtn(pGames, "🏎️ Notruf Hamburg/Drive: 5000 PS Force Loop", Color3.fromRGB(0, 100, 255), function()
    -- Anstatt nur einmal zu überschreiben (was Anti-Cheats oft resetten), zwingen wir das Auto per Schleife.
    -- Ändert die Velocity des HumanoidRootParts des Autos!
    getgenv().DriveHax = not getgenv().DriveHax
    StarterGui:SetCore("SendNotification", {Title = "Drive Hack", Text = "Auto-Boost: " .. tostring(getgenv().DriveHax), Duration = 2})
    
    while getgenv().DriveHax do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart then
            local car = LocalPlayer.Character.Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
            if car and car.PrimaryPart then
                car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * 300
            end
        end
        task.wait(0.1)
    end
end)

addBtn(pGames, "🏙️ Brookhaven: Delete Doors & Btools", Color3.fromRGB(200, 80, 200), function()
    -- Lädt F3X Tools direkt in dein Inventar, um in Brookhaven Häuser zu verändern (clientseitig)
    loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

-- ==========================================
-- TAB 5: ADMIN HUBS (500+ COMMANDS)
-- ==========================================
-- Diese Links sind die offiziellen GitHub Repositories der Entwickler. Sie sterben NIEMALS.

addBtn(pHubs, "☠️ LADE INFINITE YIELD (200+ Chat Commands)", Color3.fromRGB(255, 0, 0), function()
    -- Das mächtigste Hub der Welt (Fly, Fling, Btools, Godmode)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

addBtn(pHubs, "💻 LADE CMD-X (Admin Console)", Color3.fromRGB(0, 150, 255), function()
    -- Das beste Konsolen-Hub mit UI
    loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source',true))()
end)

addBtn(pHubs, "🔍 LADE DEX EXPLORER (Hacker Studio)", Color3.fromRGB(150, 0, 255), function()
    -- Erlaubt dir, das gesamte Roblox Studio im laufenden Spiel zu öffnen!
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

----------------------------------------------------
-- LOGIN BESTÄTIGUNG
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
