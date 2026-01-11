-- ███████╗███████╗███████╗
-- ██╔════╝██╔════╝██╔════╝
-- ███████╗█████╗  █████╗  
-- ╚════██║██╔══╝  ██╔══╝  
-- ███████║██║     ██║     
-- ╚══════╝╚═╝     ╚═╝     
-- Z7F Script Ultimate v7.0
-- © 2024 All Rights Reserved

-- ===========================================
-- SERVICES
-- ===========================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local LocalPlayer = player
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- ===========================================
-- GUI CREATION
-- ===========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "Z7F_Ultimate_" .. math.random(1000, 9999)

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 280)
Frame.Position = UDim2.new(0.5, -175, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Frame.BackgroundTransparency = 0.3
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Frame Design
local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0,12)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Thickness = 1.5
FrameStroke.Color = Color3.fromRGB(40,40,40)

-- Shadow Effect
local Shadow = Instance.new("ImageLabel")
Shadow.Parent = Frame
Shadow.AnchorPoint = Vector2.new(0.5,0.5)
Shadow.Position = UDim2.new(0.5,0,0.5,0)
Shadow.Size = UDim2.new(1,50,1,50)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency = 0.6
Shadow.ZIndex = 0

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,35)
Title.Position = UDim2.new(0,0,0,5)
Title.BackgroundTransparency = 1
Title.Text = "Z7F ULTIMATE"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)

-- Title Glow Effect
local glowGradientTitle = Instance.new("UIGradient", Title)
glowGradientTitle.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180,180,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
}
glowGradientTitle.Rotation = 45
local glowTweenTitle = TweenService:Create(glowGradientTitle, TweenInfo.new(1.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,true),{Offset = Vector2.new(1,0)})
glowGradientTitle.Offset = Vector2.new(-1,0)
glowTweenTitle:Play()

-- Page Toggle Button
local PageToggle = Instance.new("TextButton", Frame)
PageToggle.Size = UDim2.new(0, 85, 0, 28)
PageToggle.Position = UDim2.new(1, -90, 0, 10)
PageToggle.Text = "⚙️ Settings"
PageToggle.Font = Enum.Font.GothamBold
PageToggle.TextSize = 14
PageToggle.BackgroundColor3 = Color3.fromRGB(35,35,35)
PageToggle.TextColor3 = Color3.fromRGB(255,255,255)
local PageToggleCorner = Instance.new("UICorner", PageToggle)
PageToggleCorner.CornerRadius = UDim.new(0,8)
local PageToggleStroke = Instance.new("UIStroke", PageToggle)
PageToggleStroke.Thickness = 1
PageToggleStroke.Color = Color3.fromRGB(70,70,70)

-- ScrollFrame for Main Page
local ScrollFrame = Instance.new("ScrollingFrame", Frame)
ScrollFrame.Size = UDim2.new(1,0,1,-45)
ScrollFrame.Position = UDim2.new(0,0,0,45)
ScrollFrame.CanvasSize = UDim2.new(0,0,0,620)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Active = true
ScrollFrame.Visible = true

-- ScrollFrame for Settings Page
local SettingsScrollFrame = Instance.new("ScrollingFrame", Frame)
SettingsScrollFrame.Size = UDim2.new(1,0,1,-45)
SettingsScrollFrame.Position = UDim2.new(0,0,0,45)
SettingsScrollFrame.CanvasSize = UDim2.new(0,0,0,400)
SettingsScrollFrame.ScrollBarThickness = 6
SettingsScrollFrame.BackgroundTransparency = 1
SettingsScrollFrame.Active = true
SettingsScrollFrame.Visible = false

-- ===========================================
-- PLAYER SELECTION SECTION
-- ===========================================
local PlayerSelector = Instance.new("Frame", ScrollFrame)
PlayerSelector.Size = UDim2.new(0.9,0,0,160)
PlayerSelector.Position = UDim2.new(0.05,0,0,0)
PlayerSelector.BackgroundTransparency = 1

-- Player Image
local MidImage = Instance.new("ImageLabel", PlayerSelector)
MidImage.Size = UDim2.new(0,70,0,70)
MidImage.Position = UDim2.new(0.5,-35,0,0)
MidImage.BackgroundTransparency = 1
MidImage.Image = "rbxassetid://7992557358"
local MidCorner = Instance.new("UICorner", MidImage)
MidCorner.CornerRadius = UDim.new(1,0)
local MidStroke = Instance.new("UIStroke", MidImage)
MidStroke.Thickness = 2
MidStroke.Color = Color3.fromRGB(100,100,100)

-- Player Info
local PlayerInfo = Instance.new("Frame", PlayerSelector)
PlayerInfo.Size = UDim2.new(1,0,0,75)
PlayerInfo.Position = UDim2.new(0,0,0,75)
PlayerInfo.BackgroundTransparency = 1

local UserLabel = Instance.new("TextLabel", PlayerInfo)
UserLabel.Size = UDim2.new(1,0,0.4,0)
UserLabel.Position = UDim2.new(0,0,0,0)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = "User"
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 20
UserLabel.TextColor3 = Color3.fromRGB(255,255,255)
UserLabel.TextXAlignment = Enum.TextXAlignment.Center

local NickLabel = Instance.new("TextLabel", PlayerInfo)
NickLabel.Size = UDim2.new(1,0,0.3,0)
NickLabel.Position = UDim2.new(0,0,0.4,0)
NickLabel.BackgroundTransparency = 1
NickLabel.Text = "NickName"
NickLabel.Font = Enum.Font.Gotham
NickLabel.TextSize = 16
NickLabel.TextColor3 = Color3.fromRGB(180,180,180)
NickLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Search Box
local NickTextBox = Instance.new("TextBox", PlayerInfo)
NickTextBox.Size = UDim2.new(0.8,0,0.4,0)
NickTextBox.Position = UDim2.new(0.1,0,0.7,0)
NickTextBox.Text = ""
NickTextBox.PlaceholderText = "Enter player name..."
NickTextBox.PlaceholderColor3 = Color3.fromRGB(150,150,150)
NickTextBox.Font = Enum.Font.Gotham
NickTextBox.TextSize = 16
NickTextBox.TextColor3 = Color3.fromRGB(255,255,255)
NickTextBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
NickTextBox.BorderSizePixel = 0
Instance.new("UICorner", NickTextBox).CornerRadius = UDim.new(0,8)

-- ===========================================
-- STYLED BUTTONS CREATION
-- ===========================================
local function createStyledButton(name, position, isWide)
    local width = isWide and 0.9 or 0.42
    local btn = Instance.new("TextButton", ScrollFrame)
    btn.Size = UDim2.new(width,0,0,34)
    btn.Position = position
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.BackgroundTransparency = 0.5
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,8)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(60,60,60)
    
    return btn
end

-- Button positions
local buttonSpacing = 40
local startY = 170

-- Create all buttons
local SelectToolButton = createStyledButton("Selection Tool: ❌", UDim2.new(0.05,0,0,startY), true)
local AntiBangButton = createStyledButton("Quick Fall", UDim2.new(0.52,0,0,startY), false)
local TeleportButton = createStyledButton("Teleport", UDim2.new(0.05,0,0,startY + buttonSpacing), false)
local WatchButton = createStyledButton("Spectate", UDim2.new(0.52,0,0,startY + buttonSpacing), false)
local BangButton = createStyledButton("Back Bang", UDim2.new(0.05,0,0,startY + buttonSpacing*2), false)
local FaceBangButton = createStyledButton("Face Bang", UDim2.new(0.52,0,0,startY + buttonSpacing*2), false)
local HeadSitButton = createStyledButton("Head Sit", UDim2.new(0.05,0,0,startY + buttonSpacing*3), false)
local BackpackButton = createStyledButton("Backpack", UDim2.new(0.52,0,0,startY + buttonSpacing*3), false)
local SuckButton = createStyledButton("Suck", UDim2.new(0.05,0,0,startY + buttonSpacing*4), false)
local BenxButton = createStyledButton("Rape", UDim2.new(0.52,0,0,startY + buttonSpacing*4), false)
local AntiAFKButton = createStyledButton("Anti-AFK: ❌", UDim2.new(0.05,0,0,startY + buttonSpacing*5), false)
local AntiCopyButton = createStyledButton("Anti-Copy: ❌", UDim2.new(0.52,0,0,startY + buttonSpacing*5), false)
local AntiKillButton = createStyledButton("Anti-Kill: ❌", UDim2.new(0.05,0,0,startY + buttonSpacing*6), true)

-- ===========================================
-- SETTINGS PAGE
-- ===========================================
local function createSettingsPage()
    local SettingsTitle = Instance.new("TextLabel", SettingsScrollFrame)
    SettingsTitle.Size = UDim2.new(1,0,0,35)
    SettingsTitle.Position = UDim2.new(0,0,0,0)
    SettingsTitle.BackgroundTransparency = 1
    SettingsTitle.Text = "⚙️ Settings"
    SettingsTitle.Font = Enum.Font.GothamBold
    SettingsTitle.TextSize = 22
    SettingsTitle.TextColor3 = Color3.fromRGB(255,255,255)
    SettingsTitle.TextXAlignment = Enum.TextXAlignment.Center

    -- Developer Info
    local DeveloperInfo = Instance.new("TextLabel", SettingsScrollFrame)
    DeveloperInfo.Size = UDim2.new(0.9,0,0,80)
    DeveloperInfo.Position = UDim2.new(0.05,0,0,45)
    DeveloperInfo.BackgroundTransparency = 1
    DeveloperInfo.Text = "🛠️ Developer: Z7F\n\n✨ Thanks for using the script\n© All Rights Reserved 2024"
    DeveloperInfo.Font = Enum.Font.Gotham
    DeveloperInfo.TextSize = 16
    DeveloperInfo.TextColor3 = Color3.fromRGB(200,200,200)
    DeveloperInfo.TextXAlignment = Enum.TextXAlignment.Center
    DeveloperInfo.TextYAlignment = Enum.TextYAlignment.Center
    DeveloperInfo.TextWrapped = true

    -- Version Info
    local VersionInfo = Instance.new("TextLabel", SettingsScrollFrame)
    VersionInfo.Size = UDim2.new(0.9,0,0,30)
    VersionInfo.Position = UDim2.new(0.05,0,0,140)
    VersionInfo.BackgroundTransparency = 1
    VersionInfo.Text = "📦 Version: 7.0.0"
    VersionInfo.Font = Enum.Font.GothamBold
    VersionInfo.TextSize = 18
    VersionInfo.TextColor3 = Color3.fromRGB(100,200,255)
    VersionInfo.TextXAlignment = Enum.TextXAlignment.Center

    -- Features List
    local FeaturesLabel = Instance.new("TextLabel", SettingsScrollFrame)
    FeaturesLabel.Size = UDim2.new(0.9,0,0,30)
    FeaturesLabel.Position = UDim2.new(0.05,0,0,180)
    FeaturesLabel.BackgroundTransparency = 1
    FeaturesLabel.Text = "🎮 Available Features:"
    FeaturesLabel.Font = Enum.Font.GothamBold
    FeaturesLabel.TextSize = 18
    FeaturesLabel.TextColor3 = Color3.fromRGB(255,255,255)
    FeaturesLabel.TextXAlignment = Enum.TextXAlignment.Center

    local features = {
        "🎯 Advanced Player Targeting System",
        "👁️ Smart Spectate System",
        "⚡ Instant Teleport System",
        "👥 Back Bang System",
        "😁 Face Bang System",
        "🧑‍🦽 Head Sit System",
        "🎒 Backpack System",
        "💦 Suck System",
        "🔥 Rape System",
        "🖱️ Mouse Selection Tool",
        "🚀 Quick Fall System",
        "🛡️ Anti-AFK Protection",
        "🔒 Anti-Copy Protection",
        "⚔️ Anti-Kill Protection"
    }

    for i, feature in ipairs(features) do
        local FeatureLabel = Instance.new("TextLabel", SettingsScrollFrame)
        FeatureLabel.Size = UDim2.new(0.8,0,0,25)
        FeatureLabel.Position = UDim2.new(0.1,0,0,220 + (i-1)*28)
        FeatureLabel.BackgroundTransparency = 1
        FeatureLabel.Text = "• " .. feature
        FeatureLabel.Font = Enum.Font.Gotham
        FeatureLabel.TextSize = 14
        FeatureLabel.TextColor3 = Color3.fromRGB(180,180,180)
        FeatureLabel.TextXAlignment = Enum.TextXAlignment.Left
    end
end
createSettingsPage()

-- ===========================================
-- TOP IMAGE
-- ===========================================
local TopImage = Instance.new("ImageLabel", ScreenGui)
TopImage.Size = UDim2.new(0,75,0,75)
TopImage.BackgroundTransparency = 1
TopImage.ZIndex = 4
TopImage.Image = "rbxassetid://11835491319"
Instance.new("UICorner", TopImage).CornerRadius = UDim.new(1,0)

local topImageOffset = Vector2.new(130,-70)
local function updateTopImagePosition()
    TopImage.Position = UDim2.new(
        0.5, topImageOffset.X + (Frame.Position.X.Offset + Frame.Size.X.Offset/2 - 175),
        0.5, topImageOffset.Y + (Frame.Position.Y.Offset + Frame.Size.Y.Offset/2 - 140)
    )
end
updateTopImagePosition()

-- ===========================================
-- NOTIFICATION SYSTEM
-- ===========================================
local Notifications = {}
local function createNotification(titleText, mainText, playerImageId, duration)
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(0,270,0,70)
    Notification.Position = UDim2.new(1,10,1,-85)
    Notification.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Notification.BackgroundTransparency = 0.4
    Notification.BorderSizePixel = 0
    Notification.Parent = ScreenGui

    local Corner = Instance.new("UICorner", Notification)
    Corner.CornerRadius = UDim.new(0,12)

    local Stroke = Instance.new("UIStroke", Notification)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(50,50,50)

    local PlayerImage = Instance.new("ImageLabel", Notification)
    PlayerImage.Size = UDim2.new(0,50,0,50)
    PlayerImage.Position = UDim2.new(0,10,0.5,-25)
    PlayerImage.BackgroundTransparency = 1
    PlayerImage.Image = playerImageId
    Instance.new("UICorner", PlayerImage).CornerRadius = UDim.new(1,0)

    local TitleLabel = Instance.new("TextLabel", Notification)
    TitleLabel.Size = UDim2.new(1,-70,0,25)
    TitleLabel.Position = UDim2.new(0,70,0,5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TextLabel = Instance.new("TextLabel", Notification)
    TextLabel.Size = UDim2.new(1,-70,1,-30)
    TextLabel.Position = UDim2.new(0,70,0,25)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = mainText
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 12
    TextLabel.TextColor3 = Color3.fromRGB(200,200,200)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = true

    table.insert(Notifications,1,Notification)
    
    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1,-280,1,-85)}):Play()

    task.delay(duration, function()
        TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = UDim2.new(1,10,1,-85), BackgroundTransparency = 1}):Play()
        task.wait(0.5)
        Notification:Destroy()
    end)
end

-- ===========================================
-- PAGE TOGGLE SYSTEM
-- ===========================================
local isSettingsPage = false
PageToggle.MouseButton1Click:Connect(function()
    isSettingsPage = not isSettingsPage
    if isSettingsPage then
        PageToggle.Text = "Main"
        PageToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
        ScrollFrame.Visible = false
        SettingsScrollFrame.Visible = true
    else
        PageToggle.Text = "⚙️ Settings"
        PageToggle.BackgroundColor3 = Color3.fromRGB(35,35,35)
        ScrollFrame.Visible = true
        SettingsScrollFrame.Visible = false
    end
end)

-- ===========================================
-- SYSTEM VARIABLES
-- ===========================================
local targetPlayer = nil
local watchingEnabled = false
local bangActive = false
local faceBangActive = false
local headSitActive = false
local backpackActive = false
local suckActive = false
local benxActive = false
local selectToolActive = false
local antiAFKActive = false
local antiCopyActive = false
local antiKillActive = false

-- Anti-Copy Protection
getgenv().AntiCopy = true
getgenv().AntiKill = true

-- ===========================================
-- HELPER FUNCTIONS
-- ===========================================
local function createGlow(button)
    local gradient = Instance.new("UIGradient", button)
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180,180,180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
    })
    gradient.Offset = Vector2.new(-1,0)
    local tween = TweenService:Create(gradient, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1,0)})
    tween:Play()
    return gradient, tween
end

local function removeGlow(button)
    local gradient = button:FindFirstChildOfClass("UIGradient")
    if gradient then gradient:Destroy() end
end

local function updateButtonState(button, active, textOn, textOff)
    if active then
        button.BackgroundColor3 = Color3.fromRGB(255,255,255)
        button.TextColor3 = Color3.fromRGB(0,0,0)
        button.Text = textOn
        createGlow(button)
    else
        button.BackgroundColor3 = Color3.fromRGB(30,30,30)
        button.TextColor3 = Color3.fromRGB(255,255,255)
        button.Text = textOff
        removeGlow(button)
    end
end

local function GetRoot(plr)
    if plr and plr.Character then
        return plr.Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- ===========================================
-- PLAYER TARGETING SYSTEM
-- ===========================================
NickTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    local search = NickTextBox.Text:lower()
    if #search < 2 then
        UserLabel.Text = "User"
        NickLabel.Text = "NickName"
        MidImage.Image = "rbxassetid://7992557358"
        targetPlayer = nil
        return
    end

    for _, plr in pairs(Players:GetPlayers()) do
        local name = plr.Name:lower()
        local nick = plr.DisplayName:lower()
        if string.find(name, search, 1, true) or string.find(nick, search, 1, true) then
            targetPlayer = plr
            UserLabel.Text = plr.Name
            NickLabel.Text = plr.DisplayName
            MidImage.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            createNotification("Z7F", "Targeted: "..plr.Name, MidImage.Image, 3)
            break
        end
    end
end)

-- ===========================================
-- SPECTATE SYSTEM
-- ===========================================
WatchButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "No player selected!", "rbxassetid://7992557358", 3)
        return 
    end

    if watchingEnabled then
        watchingEnabled = false
        updateButtonState(WatchButton, false, "", "Spectate")
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid")
        end
        createNotification("Z7F", "Spectate stopped", "rbxassetid://7992557358", 3)
        return
    end

    watchingEnabled = true
    updateButtonState(WatchButton, true, "Spectating ✅", "")
    
    if targetPlayer.Character then
        local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
    
    createNotification("Z7F", "Spectating: "..targetPlayer.Name, MidImage.Image, 3)
end)

-- ===========================================
-- TELEPORT SYSTEM
-- ===========================================
TeleportButton.MouseButton1Click:Connect(function()
    if not targetPlayer or not targetPlayer.Character or not GetRoot(targetPlayer) then 
        createNotification("Z7F", "Cannot teleport!", "rbxassetid://7992557358", 3)
        return 
    end
    
    local targetPos = GetRoot(targetPlayer).Position
    local playerRoot = GetRoot(player)
    
    if playerRoot then
        playerRoot.CFrame = CFrame.new(targetPos + Vector3.new(0,3,0))
        createNotification("Z7F", "Teleported to "..targetPlayer.Name, MidImage.Image, 3)
    end
end)

-- ===========================================
-- BACK BANG SYSTEM
-- ===========================================
local bangHeartbeat = nil
local function startBang()
    if not targetPlayer or not targetPlayer.Character then return end
    
    if bangHeartbeat then bangHeartbeat:Disconnect() end
    
    bangHeartbeat = RunService.Heartbeat:Connect(function()
        if targetPlayer.Character and player.Character then
            local targetTorso = targetPlayer.Character:FindFirstChild("UpperTorso") or targetPlayer.Character:FindFirstChild("Torso")
            local playerHRP = GetRoot(player)
            if targetTorso and playerHRP then
                playerHRP.CFrame = targetTorso.CFrame * CFrame.new(0, 0, 0.70)
            end
        end
    end)
end

local function stopBang()
    if bangHeartbeat then 
        bangHeartbeat:Disconnect() 
        bangHeartbeat = nil 
    end
end

BangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "No player selected!", "rbxassetid://7992557358", 3)
        return 
    end
    
    bangActive = not bangActive
    updateButtonState(BangButton, bangActive, "Back Bang ✅", "Back Bang")
    
    if bangActive then
        startBang()
        createNotification("Z7F", "Back Bang enabled", MidImage.Image, 3)
    else
        stopBang()
        createNotification("Z7F", "Back Bang disabled", "rbxassetid://7992557358", 3)
    end
end)

-- ===========================================
-- FACE BANG SYSTEM
-- ===========================================
local faceBangHeartbeat = nil
local function startFaceBang()
    if not targetPlayer or not targetPlayer.Character then return end
    if faceBangHeartbeat then faceBangHeartbeat:Disconnect() end
    
    faceBangHeartbeat = RunService.Heartbeat:Connect(function()
        if targetPlayer.Character and player.Character then
            local targetHead = targetPlayer.Character:FindFirstChild("Head")
            local playerHRP = GetRoot(player)
            if targetHead and playerHRP then
                playerHRP.CFrame = targetHead.CFrame * CFrame.new(0, 0, 1.5)
            end
        end
    end)
end

local function stopFaceBang()
    if faceBangHeartbeat then 
        faceBangHeartbeat:Disconnect() 
        faceBangHeartbeat = nil 
    end
end

FaceBangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "No player selected!", "rbxassetid://7992557358", 3)
        return 
    end
    
    faceBangActive = not faceBangActive
    updateButtonState(FaceBangButton, faceBangActive, "Face Bang ✅", "Face Bang")
    
    if faceBangActive then
        startFaceBang()
        createNotification("Z7F", "Face Bang enabled", MidImage.Image, 3)
    else
        stopFaceBang()
        createNotification("Z7F", "Face Bang disabled", "rbxassetid://7992557358", 3)
    end
end)

-- ===========================================
-- HEAD SIT SYSTEM
-- ===========================================
local headSitHeartbeat = nil
local function startHeadSit()
    if not targetPlayer or not targetPlayer.Character then return end
    if headSitHeartbeat then headSitHeartbeat:Disconnect() end
    
    headSitHeartbeat = RunService.Heartbeat:Connect(function()
        pcall(function()
            local plrRoot = GetRoot(player)
            if not plrRoot then return end
            local targetHead = targetPlayer.Character:FindFirstChild("Head")
            if not targetHead then return end

            if not plrRoot:FindFirstChild("BreakVelocity") then
                local TempV = Instance.new("BodyVelocity")
                TempV.Velocity = Vector3.new(0,0,0)
                TempV.MaxForce = Vector3.new(1e5,1e5,1e5)
                TempV.Name = "BreakVelocity"
                TempV.Parent = plrRoot
            end

            player.Character.Humanoid.Sit = true
            plrRoot.CFrame = targetHead.CFrame * CFrame.new(0,2,0)
            plrRoot.Velocity = Vector3.new(0,0,0)
        end)
    end)
end

local function stopHeadSit()
    if headSitHeartbeat then 
        headSitHeartbeat:Disconnect() 
        headSitHeartbeat = nil 
    end
    local plrRoot = GetRoot(player)
    if plrRoot and plrRoot:FindFirstChild("BreakVelocity") then
        plrRoot.BreakVelocity:Destroy()
    end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Sit = false
    end
end

HeadSitButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "No player selected!", "rbxassetid://7992557358", 3)
        return 
    end
    
    headSitActive = not headSitActive
    updateButtonState(HeadSitButton, headSitActive, "Head Sit ✅", "Head Sit")
    
    if headSitActive then
        startHeadSit()
        createNotification("Z7F", "Head Sit enabled", MidImage.Image, 3)
    else
        stopHeadSit()
        createNotification("Z7F", "Head Sit disabled", "rbxassetid://7992557358", 3)
    end
end)

-- ===========================================
-- BACKPACK SYSTEM
-- ===========================================
local backpackHeartbeat = nil
local function startBackpack()
    if not targetPlayer or not targetPlayer.Character then return end
    if backpackHeartbeat then backpackHeartbeat:Disconnect() end

    backpackHeartbeat = RunService.Heartbeat:Connect(function()
        pcall(function()
            local root = GetRoot(player)
            if not root then return end
            local target = targetPlayer.Character
            if not target then return end

            if not root:FindFirstChild("BreakVelocity") then
                local TempV = Instance.new("BodyVelocity")
                TempV.Velocity = Vector3.new(0,0,0)
                TempV.MaxForce = Vector3.new(1e5,1e5,1e5)
                TempV.Name = "BreakVelocity"
                TempV.Parent = root
            end

            local targetTorso = target:FindFirstChild("Torso") or target:FindFirstChild("UpperTorso")
            if targetTorso then
                player.Character.Humanoid.Sit = true
                root.CFrame = targetTorso.CFrame * CFrame.new(0,0.5,1.2) * CFrame.Angles(0, math.rad(180), 0)
                root.Velocity = Vector3.new(0,0,0)
            end
        end)
    end)
end

local function stopBackpack()
    if backpackHeartbeat then 
        backpackHeartbeat:Disconnect() 
        backpackHeartbeat = nil 
    end
    local root = GetRoot(player)
    if root and root:FindFirstChild("BreakVelocity") then
        root.BreakVelocity:Destroy()
    end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Sit = false
    end
end

BackpackButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "No player selected!", "rbxassetid://7992557358", 3)
        return 
    end
    
    backpackActive = not backpackActive
    updateButtonState(BackpackButton, backpackActive, "Backpack ✅", "Backpack")
    
    if backpackActive then
        startBackpack()
        createNotification("Z7F", "Backpack enabled", MidImage.Image, 3)
    else
        stopBackpack()
        createNotification("Z7F", "Backpack disabled", "rbxassetid://7992557358", 3)
    end
end)

-- ===========================================
-- QUICK FALL SYSTEM
-- ===========================================
AntiBangButton.MouseButton1Click:Connect(function()
    local hrp = GetRoot(player)
    if hrp then
        createNotification("Z7F", "Quick fall activated...", "rbxassetid://7992557358", 2)
        workspace.FallenPartsDestroyHeight = -1000
        local lastCFrame = hrp.CFrame
        hrp.CFrame = CFrame.new(0, -500, 0)
        task.wait(0.7)
        hrp.CFrame = lastCFrame
        workspace.FallenPartsDestroyHeight = -500
        createNotification("Z7F", "Quick fall completed", "rbxassetid://7992557358", 3)
    end
end)

-- ===========================================
-- ANTI-AFK SYSTEM
-- ===========================================
local antiAFKConnection = nil
AntiAFKButton.MouseButton1Click:Connect(function()
    antiAFKActive = not antiAFKActive
    
    if antiAFKActive then
        updateButtonState(AntiAFKButton, true, "Anti-AFK: ✅", "")
        
        antiAFKConnection = RunService.Heartbeat:Connect(function()
            VirtualInputManager:SendKeyEvent(true, "W", false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, "W", false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(true, "S", false,