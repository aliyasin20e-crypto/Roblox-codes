-- =====================================================================
-- TITAN V7: PC ULTIMATE MASTER HUB (100+ Funktionen & Spiel-Spezifisch)
-- =====================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- Schutz vor mehrfacher Ausführung
if CoreGui:FindFirstChild("TitanV7_PC") then
    CoreGui.TitanV7_PC:Destroy()
end

getgenv().TitanPC = {
    Speed = false, Jump = false, Noclip = false, InfJump = false, 
    ESP = false, Fullbright = false, Hitbox = false, Aimbot = false, 
    AutoFarm = false, GodModeVisual = false, Spin = false, AntiFling = false
}

-- Haupt GUI Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TitanV7_PC"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

------------------------------------------------------------------------
-- 1. LOGIN SYSTEM (PC DESIGN)
------------------------------------------------------------------------
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 420, 0, 260)
loginFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
loginFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 8)
local lStroke = Instance.new("UIStroke", loginFrame)
lStroke.Color = Color3.fromRGB(0, 255, 150)
lStroke.Thickness = 2

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Size = UDim2.new(1, 0, 0, 60)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "TITAN V7 // PC MASTER HUB"
loginTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextSize = 22

local keyInput = Instance.new("TextBox", loginFrame)
keyInput.Size = UDim2.new(0.85, 0, 0, 45)
keyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Passwort eingeben (2580)..."
keyInput.Font = Enum.Font.GothamMedium
keyInput.TextSize = 15
keyInput.Text = ""
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 6)

local loginBtn = Instance.new("TextButton", loginFrame)
loginBtn.Size = UDim2.new(0.85, 0, 0, 45)
loginBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 120)
loginBtn.Text = "SYSTEM ENTSPERREN [PC PERFORMANCE]"
loginBtn.TextColor3 = Color3.fromRGB(12, 12, 16)
loginBtn.Font = Enum.Font.GothamBlack
loginBtn.TextSize = 14
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 6)

------------------------------------------------------------------------
-- 2. HAUPTFENSTER (GIGANTISCHES PC DASHBOARD)
------------------------------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 900, 0, 600)
mainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(0, 255, 150)
mStroke.Thickness = 2

-- Titelleiste
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0.02, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TITAN V7 PRO // ULTRA PERFORMANCE MODE // 100+ HACKS"
titleText.TextColor3 = Color3.fromRGB(0, 255, 150)
titleText.Font = Enum.Font.GothamBlack
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left

-- Minimieren / Schließen
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 35, 0, 30)
minBtn.Position = UDim2.new(0.93, 0, 0.12, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minBtn.Text = "─"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.01, 0, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
openBtn.Text = "V7"
openBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
openBtn.Font = Enum.Font.GothamBlack
openBtn.TextSize = 20
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(0, 255, 150)

minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true openBtn.Visible = false end)

------------------------------------------------------------------------
-- 3. NAVIGATION & TABS
------------------------------------------------------------------------
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0.22, 0, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 3
local sLayout = Instance.new("UIListLayout", sidebar)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(0.78, 0, 1, -40)
contentArea.Position = UDim2.new(0.22, 0, 0, 40)
contentArea.BackgroundTransparency = 1

local tabPages, tabBtns = {}, {}

local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtns[name] = btn

    local page = Instance.new("ScrollingFrame", contentArea)
    page.Size = UDim2.new(1, -15, 1, -15)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
    page.Visible = false
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 8)
    tabPages[name] = page

    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabPages) do p.Visible = (n == name) end
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = (n == name) and Color3.fromRGB(0, 200, 120) or Color3.fromRGB(18, 18, 24)
            b.TextColor3 = (n == name) and Color3.fromRGB(12, 12, 16) or Color3.fromRGB(180, 180, 180)
        end
    end)
    return page
end

local function addHeading(page, text)
    local lbl = Instance.new("TextLabel", page)
    lbl.Size = UDim2.new(1, -10, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.Text = "► " .. text
    lbl.TextColor3 = Color3.fromRGB(0, 255, 150)
    lbl.Font = Enum.Font.GothamBlack
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function addToggle(page, text, stateKey, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -10, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.75, 0, 1, 0)
    lbl.Position = UDim2.new(0.03, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 60, 0, 26)
    btn.Position = UDim2.new(0.82, 0, 0.16, 0)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    btn.Text = "AUS"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(function()
        getgenv().TitanPC[stateKey] = not getgenv().TitanPC[stateKey]
        local active = getgenv().TitanPC[stateKey]
        btn.Text = active and "AN" or "AUS"
        btn.BackgroundColor3 = active and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        callback(active)
    end)
end

local function addBtn(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

------------------------------------------------------------------------
-- 4. KATEGORIEN & ALLE FUNKTIONEN
------------------------------------------------------------------------
local tMove = createTab("🏃 Movement & Physik")
local tVis = createTab("👁️ Visuals & ESP")
local tCombat = createTab("⚔️ Combat & Aimbot")
local tWorld = createTab("🌍 Welt & Admin Tools")
local tBrook = createTab("🏙️ Brookhaven RP")
local tDonate = createTab("💸 PLS DONATE")
local tDrive = createTab("🏎️ Driving & Kukirin")
local tBrain = createTab("🧠 Gehirnrot / Oof / Fun")
local tHubs = createTab("☠️ Infinite Yield & Dex")

tabPages["🏃 Movement & Physik"].Visible = true
tabBtns["🏃 Movement & Physik"].BackgroundColor3 = Color3.fromRGB(0, 200, 120)
tabBtns["🏃 Movement & Physik"].TextColor3 = Color3.fromRGB(12, 12, 16)

-- TAB 1: MOVEMENT
addHeading(tMove, "Geschwindigkeit & Sprung")
addToggle(tMove, "WalkSpeed 75 (Schnell)", "Speed", function(s)
    RunService.RenderStepped:Connect(function() if getgenv().TitanPC.Speed and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 75 end end)
    if not s and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
end)
addBtn(tMove, "WalkSpeed auf 150 setzen", function() LocalPlayer.Character.Humanoid.WalkSpeed = 150 end)
addBtn(tMove, "WalkSpeed auf Normal (16)", function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
addToggle(tMove, "Moon Jump (JumpPower 150)", "Jump", function(s)
    RunService.RenderStepped:Connect(function() if getgenv().TitanPC.Jump and LocalPlayer.Character then LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = 150 end end)
end)
addToggle(tMove, "Infinite Jump (Fliegen)", "InfJump", function(s) end)
UserInputService.JumpRequest:Connect(function() if getgenv().TitanPC.InfJump and LocalPlayer.Character then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)

addHeading(tMove, "Erweiterte Physik")
addToggle(tMove, "Noclip (Durch Wände laufen)", "Noclip", function(s)
    RunService.Stepped:Connect(function() if getgenv().TitanPC.Noclip and LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)
end)
addBtn(tMove, "Gravity auf 0 (Schwerelosigkeit)", function() Workspace.Gravity = 0 end)
addBtn(tMove, "Gravity Normal (196.2)", function() Workspace.Gravity = 196.2 end)
addBtn(tMove, "Teleport Vorwärts (50 Studs)", function() LocalPlayer.Character:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(0,0,-50)) end)

-- TAB 2: VISUALS
addHeading(tVis, "ESP & Darstellung")
addToggle(tVis, "Player ESP (Gegner Highlight)", "ESP", function(s)
    while getgenv().TitanPC.ESP do
        for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character and not plr.Character:FindFirstChild("H_ESP") then local h = Instance.new("Highlight", plr.Character) h.Name = "H_ESP" h.FillColor = Color3.fromRGB(0,255,150) end end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("H_ESP") then plr.Character.H_ESP:Destroy() end end
end)
addToggle(tVis, "Fullbright (Keine Nacht / Schatten)", "Fullbright", function(s)
    while getgenv().TitanPC.Fullbright do Lighting.Ambient = Color3.new(1,1,1) Lighting.GlobalShadows = false task.wait(0.5) end
    Lighting.GlobalShadows = true
end)
addBtn(tVis, "FOV auf 120 einstellen", function() Camera.FieldOfView = 120 end)
addBtn(tVis, "FOV auf Normal (70)", function() Camera.FieldOfView = 70 end)

-- TAB 3: COMBAT
addHeading(tCombat, "Hitbox & Aimbot")
addToggle(tCombat, "Hitbox Expander (Köpfe x6)", "Hitbox", function(s)
    while getgenv().TitanPC.Hitbox do
        for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.Size = Vector3.new(12,12,12) plr.Character.Head.Transparency = 0.5 plr.Character.Head.CanCollide = false end end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.Size = Vector3.new(2,1,1) plr.Character.Head.Transparency = 0 end end
end)
addBtn(tCombat, "Universal Aimbot (Exunys V2) laden", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Aimbot%20V2/Source.lua"))() end)
addBtn(tCombat, "Arsenal / FPS Silent Aim laden", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ZinityDrops/OwlHubLink/master/OwlHub.txt"))() end)

-- TAB 4: WORLD & ADMIN
addHeading(tWorld, "Welt & Gebäude")
addBtn(tWorld, "F3X B-Tools laden (Welt bauen/löschen)", function() loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)() end)
addBtn(tWorld, "Client-Side Map löschen", function() for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("BasePart") and p.Name ~= "Terrain" then p:Destroy() end end end)
addBtn(tWorld, "Alle Türen öffnen/entfernen", function() for _, p in pairs(Workspace:GetDescendants()) do if p.Name:lower():find("door") then p:Destroy() end end end)

-- TAB 5: BROOKHAVEN RP (Bild oben links im Bild)
addHeading(tBrook, "Brookhaven Funktionen")
addBtn(tBrook, "IceHub Brookhaven Panel laden", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))() end)
addBtn(tBrook, "Alle Housing Props & Items ins Inventar", function() for _, t in pairs(ReplicatedStorage:GetDescendants()) do if t:IsA("Tool") then t:Clone().Parent = LocalPlayer.Backpack end end end)
addBtn(tBrook, "Teleport zu allen Häusern auf der Map", function()
    for _, obj in pairs(Workspace:GetDescendants()) do if obj.Name:lower():find("house") and obj:IsA("Model") and obj.PrimaryPart then LocalPlayer.Character:SetPrimaryPartCFrame(obj.PrimaryPart.CFrame) task.wait(1) end end
end)

-- TAB 6: PLS DONATE (Bild oben 2. von links)
addHeading(tDonate, "PLS DONATE Exploits")
addBtn(tDonate, "Visuellen Raised-Wert auf 1.000.000 setzen", function()
    if LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Raised") then
        LocalPlayer.leaderstats.Raised.Value = 1000000
        StarterGui:SetCore("SendNotification", {Title = "PLS DONATE", Text = "Visueller Betrag geändert!", Duration = 4})
    end
end)
addBtn(tDonate, "Auto-Claim / Booth Interactor", function()
    for _, p in pairs(Workspace:GetDescendants()) do if p:IsA("ProximityPrompt") and p.ActionText:lower():find("claim") then fireproximityprompt(p) end end
end)

-- TAB 7: DRIVING EMPIRE & KUKIRIN (Bild Mitte links)
addHeading(tDrive, "Fahrzeug & Scooter Turbo")
addBtn(tDrive, "A-Chassis / Drive Kukirin 5000 PS Boost", function()
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart then
            local car = LocalPlayer.Character.Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
            if car and car.PrimaryPart then car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * 400 end
        end
    end)
    StarterGui:SetCore("SendNotification", {Title = "Vehicle Boost", Text = "Aktiv! Steig in ein Fahrzeug.", Duration = 3})
end)
addBtn(tDrive, "Alle Autos/Scooter auf der Map zu dir holen", function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj:FindFirstChildWhichIsA("VehicleSeat") or obj.Name:lower():find("scooter") or obj.Name:lower():find("kukirin")) then
            if obj.PrimaryPart then obj:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame + Vector3.new(0,3,10)) end
        end
    end
end)

-- TAB 8: GEHIRNROT / LUCKY BLOCKS / OOF (Bild oben rechts & unten)
addHeading(tBrain, "Brainrot & Event Spiele")
addBtn(tBrain, "Steal a Brainrot: Alle freien Items einsammeln", function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Tool") or (obj:IsA("Model") and obj:FindFirstChild("Handle")) then
            if obj:IsA("Tool") then obj.Parent = LocalPlayer.Backpack elseif obj.PrimaryPart then obj:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame) end
        end
    end
end)
addBtn(tBrain, "Lucky Blocks: Alle Blöcke herbeiteleportieren", function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("lucky") then
            LocalPlayer.Character.PrimaryPart.CFrame = obj.CFrame
            task.wait(0.1)
        end
    end
end)
addBtn(tBrain, "Verstecken oder OOF: Alle Spieler ESP anzeigen", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local bg = Instance.new("BillboardGui", plr.Character.Head) bg.Size = UDim2.new(0,100,0,40) bg.AlwaysOnTop = true
            local tl = Instance.new("TextLabel", bg) tl.Size = UDim2.new(1,0,1,0) tl.BackgroundTransparency = 1 tl.Text = "VERSTECKT: " .. plr.Name tl.TextColor3 = Color3.fromRGB(255,255,0) tl.TextScaled = true
        end
    end
end)

-- TAB 9: ADMIN HUBS
addHeading(tHubs, "Mächtige Admin Konsolen")
addBtn(tHubs, "☠️ Lade Infinite Yield (200+ Commands)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
addBtn(tHubs, "💻 Lade CMD-X Console", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source',true))() end)
addBtn(tHubs, "🔍 Lade Dex Explorer (Studio Code Viewer)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)

------------------------------------------------------------------------
-- LOGIN VALIDIERUNG
------------------------------------------------------------------------
loginBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "2580" then
        loginFrame.Visible = false
        mainFrame.Visible = true
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "FALSCHER CODE! (2580)"
    end
end)
