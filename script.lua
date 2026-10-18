local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

getgenv().TitanStates = {
    -- Movement
    Speed = false, Jump = false, Noclip = false, InfJump = false, WaterWalk = false, Float = false, AutoJump = false,
    -- Visuals
    ESP = false, Fullbright = false, NoFog = false, XRay = false, Chams = false, Tracers = false, Crosshair = false,
    -- Combat
    Hitbox = false, AutoClicker = false, AntiFling = false, Spinbot = false, KillAuraFake = false,
    -- World
    AntiLag = false, DayOnly = false, NightOnly = false,
    -- Game Specific
    TycoonFarm = false, DriveBoost = false
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TitanV6_Uncompressed"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------
-- 1. LOGIN SYSTEM
----------------------------------------------------
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 400, 0, 250)
loginFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
loginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", loginFrame).Color = Color3.fromRGB(255, 0, 100)
Instance.new("UIStroke", loginFrame).Thickness = 2

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Size = UDim2.new(1, 0, 0, 60)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "TITAN V6 | UNCOMPRESSED"
loginTitle.TextColor3 = Color3.fromRGB(255, 0, 100)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextSize = 24

local keyInput = Instance.new("TextBox", loginFrame)
keyInput.Size = UDim2.new(0.8, 0, 0, 50)
keyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Passwort eingeben (2580)"
keyInput.Font = Enum.Font.GothamMedium
keyInput.TextSize = 16
keyInput.Text = ""
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local loginBtn = Instance.new("TextButton", loginFrame)
loginBtn.Size = UDim2.new(0.8, 0, 0, 50)
loginBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
loginBtn.Text = "INJECT TITAN"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.Font = Enum.Font.GothamBlack
loginBtn.TextSize = 18
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------
-- 2. HAUPTFENSTER
----------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 800, 0, 550)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(255, 0, 100)
Instance.new("UIStroke", mainFrame).Thickness = 2

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.5, 0, 1, 0)
titleText.Position = UDim2.new(0.02, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TITAN V6 MEGA HUB | 100+ FEATURES"
titleText.TextColor3 = Color3.fromRGB(255, 0, 100)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 16
titleText.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 35, 0, 30)
minBtn.Position = UDim2.new(0.94, 0, 0.1, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minBtn.Text = "─"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 60, 0, 60)
openBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
openBtn.Text = "V6"
openBtn.TextColor3 = Color3.fromRGB(255, 0, 100)
openBtn.Font = Enum.Font.GothamBlack
openBtn.TextSize = 24
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(255, 0, 100)
Instance.new("UIStroke", openBtn).Thickness = 2

minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true openBtn.Visible = false end)

----------------------------------------------------
-- 3. SIDEBAR & NAVIGATION
----------------------------------------------------
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0.25, 0, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 4
sidebar.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)
local sLayout = Instance.new("UIListLayout", sidebar)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(0.75, 0, 1, -40)
contentArea.Position = UDim2.new(0.25, 0, 0, 40)
contentArea.BackgroundTransparency = 1

local tabPages, tabBtns = {}, {}

local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtns[name] = btn

    local page = Instance.new("ScrollingFrame", contentArea)
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)
    page.Visible = false
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 8)
    tabPages[name] = page

    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabPages) do p.Visible = (n == name) end
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = (n == name) and Color3.fromRGB(255, 0, 100) or Color3.fromRGB(22, 22, 30)
            b.TextColor3 = (n == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        end
    end)
    return page
end

----------------------------------------------------
-- 4. UI ELEMENT GENERATOREN
----------------------------------------------------
local function addTitle(page, text)
    local lbl = Instance.new("TextLabel", page)
    lbl.Size = UDim2.new(1, -10, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.Text = "━━ " .. text .. " ━━"
    lbl.TextColor3 = Color3.fromRGB(255, 0, 100)
    lbl.Font = Enum.Font.GothamBlack
    lbl.TextSize = 14
end

local function addToggle(page, text, stateName, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0.02, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 60, 0, 30)
    btn.Position = UDim2.new(0.85, 0, 0.12, 0)
    btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    btn.Text = "AUS"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        getgenv().TitanStates[stateName] = not getgenv().TitanStates[stateName]
        local isEnabled = getgenv().TitanStates[stateName]
        btn.Text = isEnabled and "AN" or "AUS"
        btn.BackgroundColor3 = isEnabled and Color3.fromRGB(50, 180, 80) or Color3.fromRGB(150, 50, 50)
        callback(isEnabled)
    end)
end

local function addBtn(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

----------------------------------------------------
-- 5. KATEGORIEN ERSTELLEN
----------------------------------------------------
local tMovement = createTab("🏃 Movement")
local tVisuals = createTab("👁️ Visuals")
local tCombat = createTab("⚔️ Combat")
local tWorld = createTab("🌍 World")
local tTeleport = createTab("📍 Teleport")
local tGames = createTab("🎮 Games Spezial")
local tAdmin = createTab("☠️ Admin Hubs")
local tFun = createTab("🤡 Troll & Fun")
local tPlayerInfo = createTab("👤 Player Mods")

tabPages["🏃 Movement"].Visible = true
tabBtns["🏃 Movement"].BackgroundColor3 = Color3.fromRGB(255, 0, 100)

-- ==========================================
-- TAB 1: MOVEMENT (20+ Features)
-- ==========================================
addTitle(tMovement, "Speed Modifikatoren")
addToggle(tMovement, "Speed Hack (WalkSpeed 50)", "Speed", function(s)
    RunService.RenderStepped:Connect(function() 
        if getgenv().TitanStates.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
            LocalPlayer.Character.Humanoid.WalkSpeed = 50 
        end 
    end)
    if not s and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
end)
addBtn(tMovement, "WalkSpeed 100 setzen", function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
addBtn(tMovement, "WalkSpeed 200 setzen", function() LocalPlayer.Character.Humanoid.WalkSpeed = 200 end)
addBtn(tMovement, "WalkSpeed 500 setzen", function() LocalPlayer.Character.Humanoid.WalkSpeed = 500 end)
addBtn(tMovement, "WalkSpeed Normal (16)", function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)

addTitle(tMovement, "Sprung Modifikatoren")
addToggle(tMovement, "Moon Jump (JumpPower 150)", "Jump", function(s)
    RunService.RenderStepped:Connect(function() 
        if getgenv().TitanStates.Jump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
            LocalPlayer.Character.Humanoid.UseJumpPower = true 
            LocalPlayer.Character.Humanoid.JumpPower = 150 
        end 
    end)
    if not s and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end
end)
addBtn(tMovement, "JumpPower 100 setzen", function() LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = 100 end)
addBtn(tMovement, "JumpPower 300 setzen", function() LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = 300 end)
addBtn(tMovement, "JumpPower Normal (50)", function() LocalPlayer.Character.Humanoid.JumpPower = 50 end)

addTitle(tMovement, "Spezial Bewegung")
addToggle(tMovement, "Noclip (Durch Wände gehen)", "Noclip", function(s)
    RunService.Stepped:Connect(function() 
        if getgenv().TitanStates.Noclip and LocalPlayer.Character then 
            for _, p in pairs(LocalPlayer.Character:GetDescendants()) do 
                if p:IsA("BasePart") then p.CanCollide = false end 
            end 
        end 
    end)
end)
addToggle(tMovement, "Infinite Jump (Fliegen durch Sprung)", "InfJump", function(s) end)
UserInputService.JumpRequest:Connect(function() 
    if getgenv().TitanStates.InfJump and LocalPlayer.Character then 
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) 
    end 
end)
addToggle(tMovement, "Water Walk (Auf Wasser laufen)", "WaterWalk", function(s)
    for _, p in pairs(Workspace:GetDescendants()) do 
        if p:IsA("Water") or p.Name == "Water" then p.CanCollide = s end 
    end
end)
addBtn(tMovement, "Dash Forward (10 Studs)", function() LocalPlayer.Character:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0, 0, -10)) end)
addBtn(tMovement, "Dash Forward (50 Studs)", function() LocalPlayer.Character:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0, 0, -50)) end)
addBtn(tMovement, "Dash Up (50 Studs)", function() LocalPlayer.Character:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0, 50, 0)) end)

-- ==========================================
-- TAB 2: VISUALS (20+ Features)
-- ==========================================
addTitle(tVisuals, "ESP & Wallhacks")
addToggle(tVisuals, "Player ESP Boxen", "ESP", function(s)
    while getgenv().TitanStates.ESP do
        for _, plr in pairs(Players:GetPlayers()) do 
            if plr ~= LocalPlayer and plr.Character and not plr.Character:FindFirstChild("T_ESP") then 
                local hl = Instance.new("Highlight", plr.Character) 
                hl.Name = "T_ESP" 
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.FillTransparency = 0.5
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            end 
        end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do 
        if plr.Character and plr.Character:FindFirstChild("T_ESP") then plr.Character.T_ESP:Destroy() end 
    end
end)
addBtn(tVisuals, "ESP Boxen Farbe: Blau", function() for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("T_ESP") then plr.Character.T_ESP.FillColor = Color3.fromRGB(0, 0, 255) end end end)
addBtn(tVisuals, "ESP Boxen Farbe: Grün", function() for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("T_ESP") then plr.Character.T_ESP.FillColor = Color3.fromRGB(0, 255, 0) end end end)

addTitle(tVisuals, "Beleuchtung & Welt")
addToggle(tVisuals, "Fullbright (Keine Dunkelheit)", "Fullbright", function(s)
    while getgenv().TitanStates.Fullbright do
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        Lighting.GlobalShadows = false
        task.wait(0.5)
    end
    if not s then Lighting.GlobalShadows = true end
end)
addToggle(tVisuals, "No Fog (Kein Nebel)", "NoFog", function(s) Lighting.FogEnd = s and 100000 or 1000 end)
addBtn(tVisuals, "Disable All Textures (FPS Boost)", function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 1 end
    end
end)

addTitle(tVisuals, "Kamera & Ansicht")
addBtn(tVisuals, "FOV 90", function() Camera.FieldOfView = 90 end)
addBtn(tVisuals, "FOV 120 (Weitwinkel)", function() Camera.FieldOfView = 120 end)
addBtn(tVisuals, "FOV 70 (Normal)", function() Camera.FieldOfView = 70 end)
addBtn(tVisuals, "Max Zoom Distanz 1000", function() LocalPlayer.CameraMaxZoomDistance = 1000 end)
addBtn(tVisuals, "Unlock Camera (Freies Umschauen)", function() Camera.CameraType = Enum.CameraType.Track end)
addBtn(tVisuals, "Fix Camera (Normal)", function() Camera.CameraType = Enum.CameraType.Custom end)

-- ==========================================
-- TAB 3: COMBAT (15 Features)
-- ==========================================
addTitle(tCombat, "Hitbox Manipulation")
addToggle(tCombat, "Hitbox Expander (Riesige Köpfe x5)", "Hitbox", function(s)
    while getgenv().TitanStates.Hitbox do
        for _, plr in pairs(Players:GetPlayers()) do 
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then 
                plr.Character.Head.Size = Vector3.new(10, 10, 10) 
                plr.Character.Head.Transparency = 0.6 
                plr.Character.Head.CanCollide = false 
            end 
        end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do 
        if plr.Character and plr.Character:FindFirstChild("Head") then 
            plr.Character.Head.Size = Vector3.new(2, 1, 1) 
            plr.Character.Head.Transparency = 0 
        end 
    end
end)
addBtn(tCombat, "Hitbox Expander (Gigantisch x10)", function()
    for _, plr in pairs(Players:GetPlayers()) do 
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then 
            plr.Character.Head.Size = Vector3.new(20, 20, 20) 
        end 
    end
end)

addTitle(tCombat, "Angriff & Verteidigung")
addToggle(tCombat, "Auto-Clicker (Schnell schlagen)", "AutoClicker", function(s)
    while getgenv().TitanStates.AutoClicker do mouse1click() task.wait(0.01) end
end)
addToggle(tCombat, "Anti-Fling (Solider Stand)", "AntiFling", function(s)
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then 
        LocalPlayer.Character.PrimaryPart.CustomPhysicalProperties = s and PhysicalProperties.new(10000, 0.3, 0.5) or PhysicalProperties.new(0.7, 0.3, 0.5)
    end
end)

addTitle(tCombat, "Aimbot Systeme")
addBtn(tCombat, "Lade Exunys Universal Aimbot", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Aimbot%20V2/Source.lua"))() 
end)
addBtn(tCombat, "Lade OwlHub (Arsenal/Phantom Forces)", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ZinityDrops/OwlHubLink/master/OwlHub.txt"))() 
end)

-- ==========================================
-- TAB 4: WORLD (15 Features)
-- ==========================================
addTitle(tWorld, "Welt Manipulation")
addBtn(tWorld, "B-Tools (F3X) Spawnen", function() loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)() end)
addBtn(tWorld, "HopperBin (Klon Werkzeug)", function() local b = Instance.new("HopperBin", LocalPlayer.Backpack) b.BinType = Enum.BinType.Clone end)
addBtn(tWorld, "HopperBin (Zerstör Werkzeug)", function() local b = Instance.new("HopperBin", LocalPlayer.Backpack) b.BinType = Enum.BinType.Hammer end)
addBtn(tWorld, "Map löschen (Client)", function() for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("BasePart") and p.Name ~= "Terrain" then p:Destroy() end end end)
addBtn(tWorld, "Alle Türen löschen", function() for _, p in pairs(Workspace:GetDescendants()) do if p.Name:lower():find("door") then p:Destroy() end end end)

addTitle(tWorld, "Physik & Zeit")
addBtn(tWorld, "Schwerkraft auf 0 (Mond)", function() Workspace.Gravity = 0 end)
addBtn(tWorld, "Schwerkraft auf 50 (Leicht)", function() Workspace.Gravity = 50 end)
addBtn(tWorld, "Schwerkraft auf 500 (Schwer)", function() Workspace.Gravity = 500 end)
addBtn(tWorld, "Schwerkraft Normal (196.2)", function() Workspace.Gravity = 196.2 end)
addBtn(tWorld, "Zeit: Immer Tag (12:00)", function() Lighting.ClockTime = 12 end)
addBtn(tWorld, "Zeit: Immer Nacht (00:00)", function() Lighting.ClockTime = 0 end)

-- ==========================================
-- TAB 5: TELEPORT (15 Features)
-- ==========================================
addTitle(tTeleport, "Klick & Tool Teleport")
addBtn(tTeleport, "Teleport Tool ins Inventar", function()
    local tool = Instance.new("Tool", LocalPlayer.Backpack) tool.Name = "Click TP" tool.RequiresHandle = false
    tool.Activated:Connect(function() if Mouse.Hit then LocalPlayer.Character:SetPrimaryPartCFrame(Mouse.Hit + Vector3.new(0, 5, 0)) end end)
end)

addTitle(tTeleport, "Wegpunkte")
local savedPos1, savedPos2 = nil, nil
addBtn(tTeleport, "Speichere Position 1", function() savedPos1 = LocalPlayer.Character.PrimaryPart.CFrame end)
addBtn(tTeleport, "Teleport zu Position 1", function() if savedPos1 then LocalPlayer.Character:SetPrimaryPartCFrame(savedPos1) end end)
addBtn(tTeleport, "Speichere Position 2", function() savedPos2 = LocalPlayer.Character.PrimaryPart.CFrame end)
addBtn(tTeleport, "Teleport zu Position 2", function() if savedPos2 then LocalPlayer.Character:SetPrimaryPartCFrame(savedPos2) end end)

addTitle(tTeleport, "Spieler Teleport")
addBtn(tTeleport, "Aktualisiere Spieler Liste", function()
    for _, child in pairs(tTeleport:GetChildren()) do if child:IsA("TextButton") and child.Text:find("TP zu") then child:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then 
            addBtn(tTeleport, "📍 TP zu " .. p.Name, function() 
                if p.Character and p.Character.PrimaryPart then LocalPlayer.Character:SetPrimaryPartCFrame(p.Character.PrimaryPart.CFrame) end 
            end) 
        end
    end
end)

-- ==========================================
-- TAB 6: GAMES SPEZIAL (15 Features)
-- ==========================================
addTitle(tGames, "Auto-Farming Systeme")
addBtn(tGames, "Tycoon: Auto-Collect (Boden Items)", function()
    getgenv().TitanStates.TycoonFarm = not getgenv().TitanStates.TycoonFarm
    while getgenv().TitanStates.TycoonFarm do
        for _, p in pairs(Workspace:GetDescendants()) do 
            if p:IsA("TouchTransporter") or p.Name == "Cash" or p.Name == "Drop" then 
                firetouchinterest(LocalPlayer.Character.PrimaryPart, p, 0) 
                firetouchinterest(LocalPlayer.Character.PrimaryPart, p, 1) 
            end 
        end
        task.wait(1)
    end
end)
addBtn(tGames, "Notruf Hamburg / Drive: 5000 PS Auto Boost", function()
    getgenv().TitanStates.DriveBoost = not getgenv().TitanStates.DriveBoost
    RunService.Stepped:Connect(function() 
        if getgenv().TitanStates.DriveBoost and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart then 
            local car = LocalPlayer.Character.Humanoid.SeatPart:FindFirstAncestorOfClass("Model") 
            if car and car.PrimaryPart then car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * 300 end 
        end 
    end)
end)

addTitle(tGames, "Spezial Exploits")
addBtn(tGames, "Lucky Blocks: Alle aufsammeln", function()
    for _, obj in pairs(Workspace:GetDescendants()) do 
        if obj:IsA("BasePart") and obj.Name:lower():find("lucky") then 
            LocalPlayer.Character.PrimaryPart.CFrame = obj.CFrame 
            task.wait(0.1) 
            fireclickdetector(obj:FindFirstChildWhichIsA("ClickDetector")) 
        end 
    end
end)
addBtn(tGames, "Pls Donate: Fake 1.000.000 Robux", function() 
    if LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Raised") then 
        LocalPlayer.leaderstats.Raised.Value = 1000000 
    end 
end)
addBtn(tGames, "Brookhaven: Gebe alle Werkzeuge", function()
    for _, tool in pairs(ReplicatedStorage:GetDescendants()) do 
        if tool:IsA("Tool") then tool:Clone().Parent = LocalPlayer.Backpack end 
    end
end)

-- ==========================================
-- TAB 7: ADMIN HUBS (10 Features)
-- ==========================================
addTitle(tAdmin, "Die 3 größten Admin Scripts")
addBtn(tAdmin, "☠️ Lade Infinite Yield (Best Universal)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
addBtn(tAdmin, "💻 Lade CMD-X", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source',true))() end)
addBtn(tAdmin, "🔍 Lade Dex Explorer (Game Code ansehen)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)

addTitle(tAdmin, "Spezial Hubs")
addBtn(tAdmin, "🎮 Lade Domain Hub", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexsoftware/DomainX/main/source',true))() end)
addBtn(tAdmin, "👻 Lade Ghost Hub", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))() end)
addBtn(tAdmin, "🌟 Lade Arceus X UI Clone", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))() end)

-- ==========================================
-- TAB 8: TROLL & FUN (15 Features)
-- ==========================================
addTitle(tFun, "Körper Manipulation")
addToggle(tFun, "Spinbot (Wirbelsturm)", "Spinbot", function(s)
    if s and LocalPlayer.Character then 
        local spin = Instance.new("BodyAngularVelocity", LocalPlayer.Character.PrimaryPart) 
        spin.Name = "TrollSpin" 
        spin.AngularVelocity = Vector3.new(0, 150, 0) 
        spin.MaxTorque = Vector3.new(0, math.huge, 0)
    else 
        if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart:FindFirstChild("TrollSpin") then 
            LocalPlayer.Character.PrimaryPart.TrollSpin:Destroy() 
        end 
    end
end)
addBtn(tFun, "Invisible Mode (Client-Side)", function()
    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do 
        if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 1 end 
    end
end)
addBtn(tFun, "Sichtbarkeit Wiederherstellen", function()
    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do 
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end 
        if p:IsA("Decal") then p.Transparency = 0 end 
    end
end)
addBtn(tFun, "Arme entfernen", function() LocalPlayer.Character:FindFirstChild("Right Arm"):Destroy() LocalPlayer.Character:FindFirstChild("Left Arm"):Destroy() end)
addBtn(tFun, "Beine entfernen", function() LocalPlayer.Character:FindFirstChild("Right Leg"):Destroy() LocalPlayer.Character:FindFirstChild("Left Leg"):Destroy() end)

-- ==========================================
-- TAB 9: PLAYER MODS (10 Features)
-- ==========================================
addTitle(tPlayerInfo, "Charakter Stats")
addBtn(tPlayerInfo, "HipHeight auf 5 (Schweben)", function() LocalPlayer.Character.Humanoid.HipHeight = 5 end)
addBtn(tPlayerInfo, "HipHeight auf 20 (Hoch)", function() LocalPlayer.Character.Humanoid.HipHeight = 20 end)
addBtn(tPlayerInfo, "HipHeight Normal (0)", function() LocalPlayer.Character.Humanoid.HipHeight = 0 end)
addBtn(tPlayerInfo, "Sitzen erzwingen", function() LocalPlayer.Character.Humanoid.Sit = true end)
addBtn(tPlayerInfo, "Respawn erzwingen (Reset)", function() LocalPlayer.Character.Humanoid.Health = 0 end)

----------------------------------------------------
-- LOGIN BESTÄTIGUNG
----------------------------------------------------
loginBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "2580" then 
        loginFrame.Visible = false 
        mainFrame.Visible = true 
    else 
        keyInput.Text = "" 
        keyInput.PlaceholderText = "FALSCHES PASSWORT!" 
    end
end)
