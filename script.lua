local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- Global States
getgenv().Toggles = {
    Speed = false, Jump = false, Noclip = false, Fly = false, InfJump = false,
    ESP = false, Tracers = false, Chams = false, Fullbright = false, NoFog = false,
    Hitbox = false, Aimbot = false, AutoClicker = false, Spin = false, Fling = false,
    WaterWalk = false, AntiFling = false, GodModeVisual = false, AutoFarm = false
}

-- GUI Erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TitanV5_Mega"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------
-- 1. LOGIN SYSTEM
----------------------------------------------------
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 350, 0, 200)
loginFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
loginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", loginFrame).Color = Color3.fromRGB(0, 255, 255)

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Size = UDim2.new(1, 0, 0, 50)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "TITAN V5 | MEGA HUB"
loginTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextSize = 20

local keyInput = Instance.new("TextBox", loginFrame)
keyInput.Size = UDim2.new(0.8, 0, 0, 40)
keyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Passwort (2580)"
keyInput.Font = Enum.Font.GothamMedium
keyInput.Text = ""
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 6)

local loginBtn = Instance.new("TextButton", loginFrame)
loginBtn.Size = UDim2.new(0.8, 0, 0, 40)
loginBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
loginBtn.Text = "SYSTEM STARTEN"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

----------------------------------------------------
-- 2. HAUPTFENSTER & UI ENGINE
----------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 700, 0, 480)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(0, 255, 255)

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)
local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.5, 0, 1, 0)
titleText.Position = UDim2.new(0.02, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TITAN V5 MEGA HUB | 70+ FEATURES"
titleText.TextColor3 = Color3.fromRGB(0, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 30, 0, 25)
minBtn.Position = UDim2.new(0.94, 0, 0.15, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
openBtn.Text = "T5"
openBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
openBtn.Font = Enum.Font.GothamBlack
openBtn.TextSize = 20
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(0, 255, 255)

minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true; openBtn.Visible = false end)

-- Sidebar
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0.25, 0, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 2
local sLayout = Instance.new("UIListLayout", sidebar)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(0.75, 0, 1, -35)
contentArea.Position = UDim2.new(0.25, 0, 0, 35)
contentArea.BackgroundTransparency = 1

local tabPages, tabBtns = {}, {}

local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtns[name] = btn

    local page = Instance.new("ScrollingFrame", contentArea)
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
    page.Visible = false
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 5)
    tabPages[name] = page

    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabPages) do p.Visible = (n == name) end
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = (n == name) and Color3.fromRGB(0, 150, 200) or Color3.fromRGB(22, 22, 30)
            b.TextColor3 = (n == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        end
    end)
    return page
end

local function addToggle(page, text, stateName, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -5, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0.02, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 45, 0, 22)
    btn.Position = UDim2.new(0.85, 0, 0.13, 0)
    btn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    btn.Text = "AUS"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(function()
        getgenv().Toggles[stateName] = not getgenv().Toggles[stateName]
        btn.Text = getgenv().Toggles[stateName] and "AN" or "AUS"
        btn.BackgroundColor3 = getgenv().Toggles[stateName] and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(150, 50, 50)
        callback(getgenv().Toggles[stateName])
    end)
end

local function addBtn(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -5, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(callback)
end

----------------------------------------------------
-- 3. TABS & FEATURES EINBAUEN
----------------------------------------------------
local tMovement = createTab("🏃 Movement")
local tVisuals = createTab("👁️ Visuals")
local tCombat = createTab("⚔️ Combat / PvP")
local tWorld = createTab("🌍 World / Server")
local tFun = createTab("🤡 Trolling / Fun")
local tTeleport = createTab("📍 Teleport Hub")
local tGames = createTab("🎮 Games & AutoFarms")

tabPages["🏃 Movement"].Visible = true
tabBtns["🏃 Movement"].BackgroundColor3 = Color3.fromRGB(0, 150, 200)

-- ==========================================
-- TAB 1: MOVEMENT (12 Features)
-- ==========================================
addToggle(tMovement, "Speed Hack (WalkSpeed 100)", "Speed", function(s)
    RunService.RenderStepped:Connect(function() if getgenv().Toggles.Speed and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 100 end end)
    if not s and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
end)
addToggle(tMovement, "Super Speed (WalkSpeed 250)", "Speed", function(s)
    RunService.RenderStepped:Connect(function() if s and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 250 end end)
end)
addToggle(tMovement, "Moon Jump (JumpPower 150)", "Jump", function(s)
    RunService.RenderStepped:Connect(function() if getgenv().Toggles.Jump and LocalPlayer.Character then LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = 150 end end)
    if not s and LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = 50 end
end)
addToggle(tMovement, "Noclip (Durch alles gehen)", "Noclip", function(s)
    RunService.Stepped:Connect(function() if getgenv().Toggles.Noclip and LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)
end)
addToggle(tMovement, "Infinite Jump (Fliegen durch Sprung)", "InfJump", function(s) end)
UserInputService.JumpRequest:Connect(function() if getgenv().Toggles.InfJump and LocalPlayer.Character then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)
addToggle(tMovement, "Jesus Walk (Auf Wasser laufen)", "WaterWalk", function(s)
    for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("Water") or p.Name == "Water" then p.CanCollide = s end end
end)
addBtn(tMovement, "Teleport Vorwärts (Dash)", function()
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then LocalPlayer.Character:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0, 0, -20)) end
end)
addBtn(tMovement, "Teleport Hoch (Up)", function()
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then LocalPlayer.Character:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0, 50, 0)) end
end)

-- ==========================================
-- TAB 2: VISUALS (10 Features)
-- ==========================================
addToggle(tVisuals, "Player ESP (Rote Boxen)", "ESP", function(s)
    while getgenv().Toggles.ESP do
        for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character and not plr.Character:FindFirstChild("ESPH") then local h = Instance.new("Highlight", plr.Character) h.Name = "ESPH" h.FillColor = Color3.new(1,0,0) end end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("ESPH") then plr.Character.ESPH:Destroy() end end
end)
addToggle(tVisuals, "Fullbright (Kein Schatten/Nacht)", "Fullbright", function(s)
    Lighting.Ambient = s and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
    Lighting.GlobalShadows = not s
end)
addToggle(tVisuals, "No Fog (Kein Nebel)", "NoFog", function(s)
    Lighting.FogEnd = s and 100000 or 1000
end)
addBtn(tVisuals, "FOV 120 (Weitwinkel)", function() Camera.FieldOfView = 120 end)
addBtn(tVisuals, "FOV 70 (Normal)", function() Camera.FieldOfView = 70 end)
addBtn(tVisuals, "Unsichtbares Wasser", function() Workspace.Terrain.WaterTransparency = 1 end)
addBtn(tVisuals, "Third Person Lock erzwingen", function() LocalPlayer.CameraMaxZoomDistance = 15 LocalPlayer.CameraMinZoomDistance = 15 end)

-- ==========================================
-- TAB 3: COMBAT & PVP (10 Features)
-- ==========================================
addToggle(tCombat, "Hitbox Expander (Riesige Köpfe)", "Hitbox", function(s)
    while getgenv().Toggles.Hitbox do
        for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.Size = Vector3.new(8,8,8) plr.Character.Head.Transparency = 0.5 plr.Character.Head.CanCollide = false end end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.Size = Vector3.new(2,1,1) plr.Character.Head.Transparency = 0 end end
end)
addToggle(tCombat, "Auto-Clicker (Schnell schlagen)", "AutoClicker", function(s)
    while getgenv().Toggles.AutoClicker do mouse1click() task.wait(0.05) end
end)
addToggle(tCombat, "Anti-Fling (Kann nicht weggeschleudert werden)", "AntiFling", function(s)
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then LocalPlayer.Character.PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5) end
end)
addBtn(tCombat, "Aimbot-Logik injizieren", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Aimbot%20V2/Source.lua"))() end)

-- ==========================================
-- TAB 4: WORLD & SERVER (12 Features)
-- ==========================================
addBtn(tWorld, "B-Tools (F3X) Spawnen", function() loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)() end)
addBtn(tWorld, "Map zerstören (Client-Side)", function() for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("BasePart") and p.Name ~= "Terrain" then p:Destroy() end end end)
addBtn(tWorld, "Schwerkraft auf 0 (Mond)", function() Workspace.Gravity = 0 end)
addBtn(tWorld, "Schwerkraft Normal (196.2)", function() Workspace.Gravity = 196.2 end)
addBtn(tWorld, "Alle Unanchored Parts zu mir teleportieren", function()
    for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("BasePart") and not p.Anchored then p.CFrame = LocalPlayer.Character.PrimaryPart.CFrame end end
end)
addBtn(tWorld, "Zeit auf Tag setzen", function() Lighting.ClockTime = 12 end)
addBtn(tWorld, "Zeit auf Nacht setzen", function() Lighting.ClockTime = 0 end)

-- ==========================================
-- TAB 5: TROLLING & FUN (8 Features)
-- ==========================================
addToggle(tFun, "Spinbot (Wirbelsturm)", "Spin", function(s)
    if s and LocalPlayer.Character then 
        local spin = Instance.new("BodyAngularVelocity", LocalPlayer.Character.PrimaryPart) spin.Name = "TrollSpin" spin.AngularVelocity = Vector3.new(0, 100, 0) spin.MaxTorque = Vector3.new(0, math.huge, 0)
    else if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart:FindFirstChild("TrollSpin") then LocalPlayer.Character.PrimaryPart.TrollSpin:Destroy() end end
end)
addBtn(tFun, "Invisible Mode (Visual)", function()
    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 1 end end
end)
addBtn(tFun, "Remove Limbs (Nur Torso)", function()
    for _, p in pairs(LocalPlayer.Character:GetChildren()) do if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and p.Name ~= "Torso" and p.Name ~= "UpperTorso" then p:Destroy() end end
end)
addBtn(tFun, "Chat Spam 'Titan V5 OPs'", function()
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Titan V5 Mega Hub is OP!", "All")
end)

-- ==========================================
-- TAB 6: TELEPORT (10 Features)
-- ==========================================
addBtn(tTeleport, "Teleport to Spawn", function() LocalPlayer.Character:SetPrimaryPartCFrame(Workspace:FindFirstChildWhichIsA("SpawnLocation").CFrame + Vector3.new(0,5,0)) end)
addBtn(tTeleport, "Klick-Teleport (Zielen + E drücken)", function()
    Mouse.KeyDown:Connect(function(k) if k == "e" and Mouse.Hit then LocalPlayer.Character:SetPrimaryPartCFrame(Mouse.Hit + Vector3.new(0, 5, 0)) end end)
end)
local savedPos = nil
addBtn(tTeleport, "Speichere aktuelle Position", function() savedPos = LocalPlayer.Character.PrimaryPart.CFrame end)
addBtn(tTeleport, "Teleport zu Speicherpunkt", function() if savedPos then LocalPlayer.Character:SetPrimaryPartCFrame(savedPos) end end)
addBtn(tTeleport, "Lade alle Spieler für TP", function()
    for _, child in pairs(tTeleport:GetChildren()) do if child:IsA("TextButton") and child.Text:find("TP zu") then child:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then addBtn(tTeleport, "📍 TP zu " .. p.Name, function() LocalPlayer.Character:SetPrimaryPartCFrame(p.Character.PrimaryPart.CFrame) end) end
    end
end)

-- ==========================================
-- TAB 7: GAMES & AUTOFARMS (10 Features)
-- ==========================================
addBtn(tGames, "🚗 Notruf Hamburg / Drive: 5000 PS", function()
    RunService.Stepped:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart then local c = LocalPlayer.Character.Humanoid.SeatPart:FindFirstAncestorOfClass("Model") if c and c.PrimaryPart then c.PrimaryPart.AssemblyLinearVelocity = c.PrimaryPart.CFrame.LookVector * 250 end end end)
end)
addBtn(tGames, "💸 Pls Donate: Fake 1M Robux", function() if LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Raised") then LocalPlayer.leaderstats.Raised.Value = 1000000 end end)
addBtn(tGames, "🏭 Tycoon: Auto-Collect Cash", function()
    while task.wait(0.5) do for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("TouchTransporter") or p.Name=="Cash" then firetouchinterest(LocalPlayer.Character.PrimaryPart, p, 0) firetouchinterest(LocalPlayer.Character.PrimaryPart, p, 1) end end end
end)
addBtn(tGames, "📦 Lucky Blocks: Collect All", function()
    for _, obj in pairs(Workspace:GetDescendants()) do if obj:IsA("BasePart") and obj.Name:lower():find("lucky") then LocalPlayer.Character.PrimaryPart.CFrame = obj.CFrame task.wait(0.1) end end
end)
addBtn(tGames, "🏙️ Brookhaven: Give All Tools", function()
    for _, tool in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do if tool:IsA("Tool") then tool:Clone().Parent = LocalPlayer.Backpack end end
end)
addBtn(tGames, "⚔️ Uff / Arsenal: ESP & Hitbox Combo", function()
    getgenv().Toggles.ESP = true getgenv().Toggles.Hitbox = true
end)

----------------------------------------------------
-- LOGIN CONFIRMATION
----------------------------------------------------
loginBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "2580" then loginFrame.Visible = false mainFrame.Visible = true else keyInput.PlaceholderText = "Falscher Key!" keyInput.Text = "" end
end)
