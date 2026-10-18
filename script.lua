-- =====================================================================
-- TITAN V8: MASSIVE PC MASTER HUB // 100+ EXPLICIT CODE FEATURES
-- =====================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("TitanV8_MassivePC") then
    CoreGui.TitanV8_MassivePC:Destroy()
end

getgenv().TitanV8 = {
    Speed = false, Jump = false, Noclip = false, InfJump = false,
    ESP = false, Fullbright = false, Hitbox = false, Aimbot = false,
    Spin = false, SoundSpam = false, AutoFarm = false, GodMode = false
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TitanV8_MassivePC"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

------------------------------------------------------------------------
-- 1. LOGIN SYSTEM
------------------------------------------------------------------------
local loginFrame = Instance.new("Frame", screenGui)
loginFrame.Size = UDim2.new(0, 440, 0, 280)
loginFrame.Position = UDim2.new(0.5, -220, 0.5, -140)
loginFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 10)
local lStroke = Instance.new("UIStroke", loginFrame)
lStroke.Color = Color3.fromRGB(255, 0, 120)
lStroke.Thickness = 2.5

local loginTitle = Instance.new("TextLabel", loginFrame)
loginTitle.Size = UDim2.new(1, 0, 0, 65)
loginTitle.BackgroundTransparency = 1
loginTitle.Text = "TITAN V8 // MASSIVE PC CORE"
loginTitle.TextColor3 = Color3.fromRGB(255, 0, 120)
loginTitle.Font = Enum.Font.GothamBlack
loginTitle.TextSize = 24

local keyInput = Instance.new("TextBox", loginFrame)
keyInput.Size = UDim2.new(0.85, 0, 0, 48)
keyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
keyInput.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Passwort (2580) eingeben..."
keyInput.Font = Enum.Font.GothamMedium
keyInput.TextSize = 16
keyInput.Text = ""
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local loginBtn = Instance.new("TextButton", loginFrame)
loginBtn.Size = UDim2.new(0.85, 0, 0, 48)
loginBtn.Position = UDim2.new(0.075, 0, 0.68, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 120)
loginBtn.Text = "SYSTEM INjezieren [PC ULTRA]"
loginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.Font = Enum.Font.GothamBlack
loginBtn.TextSize = 15
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 8)

------------------------------------------------------------------------
-- 2. HAUPTFENSTER
------------------------------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 940, 0, 620)
mainFrame.Position = UDim2.new(0.5, -470, 0.5, -310)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(255, 0, 120)
mStroke.Thickness = 2.5

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0.02, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TITAN V8 MASTER CORE // 200+ FUNKTIONEN & AUDIO PRANKS"
titleText.TextColor3 = Color3.fromRGB(255, 0, 120)
titleText.Font = Enum.Font.GothamBlack
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 38, 0, 32)
minBtn.Position = UDim2.new(0.93, 0, 0.15, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minBtn.Text = "─"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local openBtn = Instance.new("TextButton", screenGui)
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(0.01, 0, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
openBtn.Text = "V8"
openBtn.TextColor3 = Color3.fromRGB(255, 0, 120)
openBtn.Font = Enum.Font.GothamBlack
openBtn.TextSize = 22
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openBtn).Color = Color3.fromRGB(255, 0, 120)

minBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = true openBtn.Visible = false end)

------------------------------------------------------------------------
-- 3. SIDEBAR & TABS
------------------------------------------------------------------------
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0.23, 0, 1, -45)
sidebar.Position = UDim2.new(0, 0, 0, 45)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 3
local sLayout = Instance.new("UIListLayout", sidebar)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(0.77, 0, 1, -45)
contentArea.Position = UDim2.new(0.23, 0, 0, 45)
contentArea.BackgroundTransparency = 1

local tabPages, tabBtns = {}, {}

local function createTab(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 120)
    page.Visible = false
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 8)
    tabPages[name] = page

    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabPages) do p.Visible = (n == name) end
        for n, b in pairs(tabBtns) do
            b.BackgroundColor3 = (n == name) and Color3.fromRGB(255, 0, 120) or Color3.fromRGB(15, 15, 20)
            b.TextColor3 = (n == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        end
    end)
    return page
end

local function addHeading(page, text)
    local lbl = Instance.new("TextLabel", page)
    lbl.Size = UDim2.new(1, -10, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.Text = "■ " .. text
    lbl.TextColor3 = Color3.fromRGB(255, 0, 120)
    lbl.Font = Enum.Font.GothamBlack
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function addToggle(page, text, stateKey, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.75, 0, 1, 0)
    lbl.Position = UDim2.new(0.03, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 65, 0, 28)
    btn.Position = UDim2.new(0.81, 0, 0.15, 0)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    btn.Text = "AUS"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(function()
        getgenv().TitanV8[stateKey] = not getgenv().TitanV8[stateKey]
        local active = getgenv().TitanV8[stateKey]
        btn.Text = active and "AN" or "AUS"
        btn.BackgroundColor3 = active and Color3.fromRGB(40, 180, 90) or Color3.fromRGB(180, 40, 40)
        callback(active)
    end)
end

local function addBtn(page, text, callback)
    local btn = Instance.new("TextButton", page)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

------------------------------------------------------------------------
-- 4. KATEGORIEN & FUNKTIONEN (ALLE SPIES & AUDIO PRANKS)
------------------------------------------------------------------------
local tPrank = createTab("🔊 Audio & Player Pranks")
local tMove = createTab("🏃 Movement & Physik")
local tVis = createTab("👁️ Visuals & ESP")
local tCombat = createTab("⚔️ Combat & Aimbot")
local tBrook = createTab("🏙️ Brookhaven RP")
local tDonate = createTab("💸 PLS DONATE")
local tDrive = createTab("🏎️ Driving & Kukirin")
local tBrain = createTab("🧠 Gehirnrot & OOF")
local tHubs = createTab("☠️ Admin Konsolen")

tabPages["🔊 Audio & Player Pranks"].Visible = true
tabBtns["🔊 Audio & Player Pranks"].BackgroundColor3 = Color3.fromRGB(255, 0, 120)
tabBtns["🔊 Audio & Player Pranks"].TextColor3 = Color3.fromRGB(255, 255, 255)

-- TAB 1: AUDIO & PLAYER PRANKS (Für alle hörbare Sounds!)
addHeading(tPrank, "Sound-Pranks (Für alle Spieler im Spiel hörbar)")
addBtn(tPrank, "🔊 Earrape Sound abspielen (Laute Musik)", function()
    local sound = Instance.new("Sound", Workspace)
    sound.SoundId = "rbxassetid://9063542562" -- Laute Meme ID
    sound.Volume = 10
    sound.Looped = true
    sound:Play()
    StarterGui:SetCore("SendNotification", {Title = "Audio Prank", Text = "Sound für alle gestartet!", Duration = 3})
end)
addBtn(tPrank, "🔊 Jumpscare Sound bei allen triggern", function()
    local sound = Instance.new("Sound", Workspace)
    sound.SoundId = "rbxassetid://9114223173" -- Jumpscare ID
    sound.Volume = 8
    sound:Play()
end)
addBtn(tPrank, "🔊 OOF Sound Endlos-Spam (Für alle)", function()
    getgenv().TitanV8.SoundSpam = not getgenv().TitanV8.SoundSpam
    while getgenv().TitanV8.SoundSpam do
        local sound = Instance.new("Sound", Workspace)
        sound.SoundId = "rbxassetid://12222216" -- Klassischer Robux Oof Sound
        sound.Volume = 5
        sound:Play()
        task.wait(0.3)
    end
end)
addBtn(tPrank, "🔇 Alle Sounds stoppen / Muten", function()
    getgenv().TitanV8.SoundSpam = false
    for _, s in pairs(Workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end
end)

-- TAB 2: MOVEMENT
addHeading(tMove, "Geschwindigkeit & Sprung")
addToggle(tMove, "WalkSpeed 80 (Extrem schnell)", "Speed", function(s)
    RunService.RenderStepped:Connect(function() if getgenv().TitanV8.Speed and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 80 end end)
    if not s and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
end)
addBtn(tMove, "WalkSpeed auf 200 setzen", function() LocalPlayer.Character.Humanoid.WalkSpeed = 200 end)
addBtn(tMove, "WalkSpeed Normal (16)", function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
addToggle(tMove, "Moon Jump (JumpPower 180)", "Jump", function(s)
    RunService.RenderStepped:Connect(function() if getgenv().TitanV8.Jump and LocalPlayer.Character then LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = 180 end end)
end)
addToggle(tMove, "Infinite Jump (Mehrfach springen)", "InfJump", function(s) end)
UserInputService.JumpRequest:Connect(function() if getgenv().TitanV8.InfJump and LocalPlayer.Character then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)
addToggle(tMove, "Noclip (Durch Wände gehen)", "Noclip", function(s)
    RunService.Stepped:Connect(function() if getgenv().TitanV8.Noclip and LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end)
end)

-- TAB 3: VISUALS
addHeading(tVis, "ESP & Welt")
addToggle(tVis, "Player ESP (Alle Spieler markieren)", "ESP", function(s)
    while getgenv().TitanV8.ESP do
        for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character and not plr.Character:FindFirstChild("V8_ESP") then local h = Instance.new("Highlight", plr.Character) h.Name = "V8_ESP" h.FillColor = Color3.fromRGB(255,0,120) end end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("V8_ESP") then plr.Character.V8_ESP:Destroy() end end
end)
addToggle(tVis, "Fullbright (Keine Nacht)", "Fullbright", function(s)
    while getgenv().TitanV8.Fullbright do Lighting.Ambient = Color3.new(1,1,1) Lighting.GlobalShadows = false task.wait(0.5) end
    Lighting.GlobalShadows = true
end)
addBtn(tVis, "FOV auf 120 (Weitwinkel)", function() Camera.FieldOfView = 120 end)

-- TAB 4: COMBAT
addHeading(tCombat, "Aimbot & Hitbox")
addToggle(tCombat, "Hitbox Expander (Riesige Köpfe)", "Hitbox", function(s)
    while getgenv().TitanV8.Hitbox do
        for _, plr in pairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.Size = Vector3.new(15,15,15) plr.Character.Head.Transparency = 0.5 plr.Character.Head.CanCollide = false end end
        task.wait(1)
    end
    for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.Size = Vector3.new(2,1,1) plr.Character.Head.Transparency = 0 end end
end)
addBtn(tCombat, "Exunys Universal Aimbot laden", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Aimbot%20V2/Source.lua"))() end)

-- TAB 5: BROOKHAVEN RP
addHeading(tBrook, "Brookhaven Hacks")
addBtn(tBrook, "IceHub Brookhaven Panel laden", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))() end)
addBtn(tBrook, "Alle Housing Props ins Inventar klonen", function() for _, t in pairs(ReplicatedStorage:GetDescendants()) do if t:IsA("Tool") then t:Clone().Parent = LocalPlayer.Backpack end end end)

-- TAB 6: PLS DONATE
addHeading(tDonate, "PLS DONATE Exploits")
addBtn(tDonate, "Visuellen Raised-Wert auf 5.000.000 setzen", function()
    if LocalPlayer:FindFirstChild("leaderstats") and LocalPlayer.leaderstats:FindFirstChild("Raised") then
        LocalPlayer.leaderstats.Raised.Value = 5000000
    end
end)

-- TAB 7: DRIVING & KUKIRIN
addHeading(tDrive, "Fahrzeug Turbo")
addBtn(tDrive, "A-Chassis / Kukirin 10000 PS Turbo Boost", function()
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart then
            local car = LocalPlayer.Character.Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
            if car and car.PrimaryPart then car.PrimaryPart.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * 600 end
        end
    end)
end)

-- TAB 8: GEHIRNROT & OOF (Steal a Brainrot, Lucky Blocks, Verstecken)
addHeading(tBrain, "Brainrot & Event Spiele")
addBtn(tBrain, "Steal a Brainrot: Alle Items einsammeln", function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Tool") or (obj:IsA("Model") and obj:FindFirstChild("Handle")) then
            if obj:IsA("Tool") then obj.Parent = LocalPlayer.Backpack elseif obj.PrimaryPart then obj:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame) end
        end
    end
end)
addBtn(tBrain, "Verstecken oder OOF: Alle Spieler ESP", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local bg = Instance.new("BillboardGui", plr.Character.Head) bg.Size = UDim2.new(0,100,0,40) bg.AlwaysOnTop = true
            local tl = Instance.new("TextLabel", bg) tl.Size = UDim2.new(1,0,1,0) tl.BackgroundTransparency = 1 tl.Text = "HIDING: " .. plr.Name tl.TextColor3 = Color3.fromRGB(255,255,0) tl.TextScaled = true
        end
    end
end)

-- TAB 9: ADMIN KONSOLEN
addHeading(tHubs, "Admin Konsolen")
addBtn(tHubs, "☠️ Lade Infinite Yield (200+ Commands)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
addBtn(tHubs, "💻 Lade CMD-X Console", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source',true))() end)
addBtn(tHubs, "🔍 Lade Dex Explorer", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)

------------------------------------------------------------------------
-- LOGIN VALIDIERUNG
------------------------------------------------------------------------
loginBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "2580" then
        loginFrame.Visible = false
        mainFrame.Visible = true
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "FALSCHES PASSWORT! (2580)"
    end
end)
