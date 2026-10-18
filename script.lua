local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- GUI Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TriggerHubPro"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 1. SCHWEBENDER MINIMIER-BUTTON (Öffnet das Menü wieder)
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.45, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
openBtn.Text = "⚡"
openBtn.TextSize = 24
openBtn.TextColor3 = Color3.fromRGB(0, 220, 255)
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true -- Schwebeknopf auf dem Handy verschiebbar
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0) -- Perfekter Kreis
openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(0, 180, 255)
openStroke.Thickness = 2
openStroke.Parent = openBtn

-- 2. HAUPTFENSTER
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.25, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Touch-Dragging
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 60)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- TITEL-LEISTE
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

-- Titel Text
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0.5, 0, 1, 0)
titleText.Position = UDim2.new(0.04, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "⚡ Trigger Hub"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Mini-Buttons (Scan & Minimieren)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(0.88, 0, 0.15, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
minimizeBtn.Text = "─"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
minimizeBtn.TextSize = 14
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0, 65, 0, 32)
scanBtn.Position = UDim2.new(0.67, 0, 0.15, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
scanBtn.Text = "Scan"
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.TextSize = 12
scanBtn.Font = Enum.Font.GothamBold
scanBtn.Parent = titleBar

local scanCorner = Instance.new("UICorner")
scanCorner.CornerRadius = UDim.new(0, 8)
scanCorner.Parent = scanBtn

-- SCROLLBEREICH (Für Mobile Touch optimiert)
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.92, 0, 0.85, -15)
scrollFrame.Position = UDim2.new(0.04, 0, 0.13, 10)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)

-- MOCK INTERAKTION (ClickDetector, ProximityPrompt, Touch)
local function triggerTarget(data)
    local target = data.Object
    local kind = data.Type

    if kind == "Click" and target:IsA("ClickDetector") then
        fireclickdetector(target)
    elseif kind == "Prompt" and target:IsA("ProximityPrompt") then
        fireproximityprompt(target)
    elseif kind == "Touch" and target:IsA("BasePart") then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Befeuert TouchInterest für Boden-Buttons/Tycoon-Platten
            firetouchinterest(character.HumanoidRootPart, target, 0)
            task.wait(0.1)
            firetouchinterest(character.HumanoidRootPart, target, 1)
        end
    end
end

-- SCAN ENGINE (Findet wirklich ALLES)
local function startFullScan()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local itemsFound = {}

    for _, obj in pairs(Workspace:GetDescendants()) do
        local triggerData = nil

        if obj:IsA("ClickDetector") then
            local pName = obj.Parent and obj.Parent.Name or "Knopf"
            triggerData = {Name = "🔔 " .. pName, Object = obj, Type = "Click"}
        elseif obj:IsA("ProximityPrompt") then
            local actionName = obj.ObjectText ~= "" and (obj.ObjectText .. " (" .. obj.ActionText .. ")") or (obj.Parent and obj.Parent.Name or "Prompt")
            triggerData = {Name = "🔘 " .. actionName, Object = obj, Type = "Prompt"}
        elseif obj:IsA("TouchTransporter") or (obj:IsA("BasePart") and obj:FindFirstChildWhichIsA("TouchTransporter")) then
            local pName = obj.Name ~= "TouchInterest" and obj.Name or (obj.Parent and obj.Parent.Name or "Pad")
            triggerData = {Name = "👣 " .. pName, Object = obj, Type = "Touch"}
        end

        if triggerData and not itemsFound[triggerData.Name] then
            itemsFound[triggerData.Name] = true

            -- Modern UI Card Container
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, -8, 0, 44)
            card.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
            card.BorderSizePixel = 0
            card.Parent = scrollFrame

            local cardCorner = Instance.new("UICorner")
            cardCorner.CornerRadius = UDim.new(0, 8)
            cardCorner.Parent = card

            local cardStroke = Instance.new("UIStroke")
            cardStroke.Color = Color3.fromRGB(40, 40, 55)
            cardStroke.Thickness = 1
            cardStroke.Parent = card

            -- Name Label
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.62, 0, 1, 0)
            label.Position = UDim2.new(0.04, 0, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = triggerData.Name
            label.TextColor3 = Color3.fromRGB(230, 230, 245)
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextTruncate = Enum.TextTruncate.AtEnd
            label.Parent = card

            -- Action Button (Mobile-Friendly Touch-Fläche)
            local actionBtn = Instance.new("TextButton")
            actionBtn.Size = UDim2.new(0, 85, 0, 30)
            actionBtn.Position = UDim2.new(0.70, 0, 0.16, 0)
            actionBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
            actionBtn.Text = "Auslösen"
            actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            actionBtn.TextSize = 12
            actionBtn.Font = Enum.Font.GothamBold
            actionBtn.Parent = card

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = actionBtn

            actionBtn.MouseButton1Click:Connect(function()
                -- Klick-Animation
                TweenService:Create(actionBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 80, 0, 28)}):Play()
                task.wait(0.1)
                TweenService:Create(actionBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 85, 0, 30)}):Play()
                
                triggerTarget(triggerData)
            end)
        end
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 15)
end

-- MINIMIEREN & ÖFFNEN LOGIK (Mit sanfter Animation)
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openBtn.Visible = false
end)

scanBtn.MouseButton1Click:Connect(function()
    startFullScan()
end)

-- Initialer Scan beim Start
startFullScan()
