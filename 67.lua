--[[
    Z7F Script - ULTIMATE MEGA HYBRID EDITION
    Combined Version with All Features from Multiple Scripts
    Developer: Z7F ON TOP
    Version: 6.0.0 ULTIMATE HYBRID
]]

-- Load Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local LocalPlayer = player
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.ResetOnSpawn = false

-- Wait a moment
task.wait(0.5)

-- ============================================
-- 🚨 BAN CHECK SYSTEM
-- ============================================
local BannedUsers = {
    ["TM_704"] = true,
    ["704_TM"] = true,
    ["704_TMMA1"] = true,
    ["nan_dihanix"] = true,
    ["Si07Ac"] = true,
    ["33yahya"] = true,
    ["m_avig"] = true,
    ["7_rgh1"] = true,
    ["Jdvdhvsbx"] = true,
}

if BannedUsers[player.Name] then
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local bg = Instance.new("ImageLabel", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundTransparency = 1
    bg.Image = "rbxassetid://8991722426"

    local txt = Instance.new("TextLabel", bg)
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 32
    txt.TextColor3 = Color3.fromRGB(255,0,0)
    txt.TextWrapped = true
    txt.Text = "عذراً ، لايمكنك تشغيل السكربت لانك من قائمة المحظورين\n\nرسالة من المطور :\n( بنعالي يازبال محروم من سكربتي واحلم انك تشغله ياكلب بنعالي يلا ختفو )"

    while true do task.wait(1e9) end
    return
end

-- ============================================
-- 🎬 INTRO SCREEN
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 1

local img = Instance.new("ImageLabel", bg)
img.Size = UDim2.new(1,0,1,0)
img.Position = UDim2.new(0,0,0,0)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://16264019547"
img.ImageTransparency = 1

local label = Instance.new("TextLabel", bg)
label.Size = UDim2.new(0.8,0,0.2,0)
label.Position = UDim2.new(0.1,0,0.4,0)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 48
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Text = "Z7F ON TOP"
label.TextTransparency = 1
label.TextStrokeTransparency = 0.7
label.TextScaled = true

local gradient = Instance.new("UIGradient", label)
gradient.Rotation = 0
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,200,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
})
gradient.Offset = Vector2.new(-1,0)
local tweenGlow = TweenService:Create(
    gradient,
    TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
    {Offset = Vector2.new(1,0)}
)
tweenGlow:Play()

local sound = Instance.new("Sound", bg)
sound.SoundId = "rbxassetid://14145620056"
sound.Volume = 1
sound:Play()

local fadeInTween = TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 0})
local imgTween = TweenService:Create(img, TweenInfo.new(1.5), {ImageTransparency = 0})
local labelTween = TweenService:Create(label, TweenInfo.new(1.5), {TextTransparency = 0})

fadeInTween:Play()
imgTween:Play()
labelTween:Play()

task.spawn(function()
    task.wait(5)
    local fadeOutTween = TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 1})
    local imgOutTween = TweenService:Create(img, TweenInfo.new(1.5), {ImageTransparency = 1})
    local labelOutTween = TweenService:Create(label, TweenInfo.new(1.5), {TextTransparency = 1})

    fadeOutTween:Play()
    imgOutTween:Play()
    labelOutTween:Play()

    task.wait(1.5)
    screenGui:Destroy()
end)

-- ============================================
-- 🛡️ ANTI-MOVEMENT SYSTEM
-- ============================================
local Fixing = false
local Connections = {}

local function DisconnectAll()
    for _, c in pairs(Connections) do
        if c.Connected then
            c:Disconnect()
        end
    end
    table.clear(Connections)
end

local function fixMovement()
    if Fixing then return end
    Fixing = true

    DisconnectAll()

    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then Fixing = false return end

    hum.AutoRotate = true
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

    local function antiForcedSit()
        if hum and hum.Parent then
            if hum:GetState() ~= Enum.HumanoidStateType.Jumping
            and hum:GetState() ~= Enum.HumanoidStateType.Freefall
            and hum:GetState() ~= Enum.HumanoidStateType.Swimming then
                hum.Sit = true
            end
        end
    end

    Connections["HB"] = RunService.Heartbeat:Connect(antiForcedSit)
    Connections["Sit"] = hum:GetPropertyChangedSignal("Sit"):Connect(antiForcedSit)

    task.spawn(function()
        while hum and hum.Parent do
            antiForcedSit()
            task.wait(0.05)
        end
    end)

    Fixing = false
end

player.CharacterAdded:Connect(function()
    task.wait(0.3)
    fixMovement()
end)

if player.Character then
    task.wait(0.3)
    fixMovement()
end

-- ============================================
-- 📜 PROTECTED USERS SYSTEM
-- ============================================
local ProtectedUsers = {
    ["1il5f"] = true,
    ["1il5i"] = true,
    ["sj3zx"] = true,
    ["awr_9351156"] = true,
    ["eyad51533"] = true,
    ["ababahbada"] = true,
    ["JP_EB15"] = true,
    ["noor105320"] = true,
}

local function IsProtectedUserInServer(name)
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr.Name:lower() == name:lower() then
            return true
        end
    end
    return false
end

local function ShowProtectedMessage(username)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.ResetOnSpawn = false

    local baseWidth = 200
    local extraWidth = math.clamp(#username*8,0,200)
    local frameWidth = baseWidth + extraWidth

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, frameWidth,0,70)
    frame.Position = UDim2.new(1, frameWidth,1,-120)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local icon = Instance.new("ImageLabel", frame)
    icon.Size = UDim2.new(0,55,0,55)
    icon.Position = UDim2.new(0,8,0.5,-27)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://13722469288"

    local txt = Instance.new("TextLabel", frame)
    txt.Size = UDim2.new(1, -70,1,0)
    txt.Position = UDim2.new(0, 68,0,0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 18
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    txt.TextWrapped = true
    txt.Text = "الاعب ("..username..") محمي من مطور السكربت"

    local gradient = Instance.new("UIGradient", txt)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180,180,180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180,180,180))
    })
    gradient.Offset = Vector2.new(-1,0)

    local tweenGlow = TweenService:Create(
        gradient,
        TweenInfo.new(1.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
        {Offset = Vector2.new(1,0)}
    )
    tweenGlow:Play()

    TweenService:Create(
        frame,
        TweenInfo.new(0.35, Enum.EasingStyle.Quad),
        {Position = UDim2.new(1,-frameWidth,1,-120)}
    ):Play()

    task.spawn(function()
        task.wait(7)
        local out = TweenService:Create(
            frame,
            TweenInfo.new(0.35, Enum.EasingStyle.Quad),
            {Position = UDim2.new(1, frameWidth,1,-120)}
        )
        out:Play()
        out.Completed:Connect(function()
            gui:Destroy()
        end)
    end)
end

local function ShouldBlockInput(input)
    if input == "" then return false end
    input = input:lower()
    
    if #input < 2 then return false end
    
    local blocked = false
    
    for username,_ in pairs(ProtectedUsers) do
        if IsProtectedUserInServer(username) then
            local plr = Players:FindFirstChild(username)
            local unameLower = username:lower()
            
            if unameLower:find(input) then
                ShowProtectedMessage(username)
                blocked = true
            end
            
            if plr and plr.DisplayName:lower():find(input) then
                ShowProtectedMessage(username)
                blocked = true
            end
        end
    end
    
    return blocked
end

_G.IsProtected = function(target)
    if not target then return false end
    target = target:lower()
    
    if #target < 2 then return false end
    
    local blocked = false
    
    for uname,_ in pairs(ProtectedUsers) do
        if IsProtectedUserInServer(uname) then
            if uname:lower():find(target) then
                ShowProtectedMessage(uname)
                blocked = true
            end
            
            local pl = Players:FindFirstChild(uname)
            if pl and pl.DisplayName:lower():find(target) then
                ShowProtectedMessage(uname)
                blocked = true
            end
        end
    end
    
    return blocked
end

_G.ProtectToolClick = function(target)
    return _G.IsProtected(target)
end

-- Remove old GUI
if CoreGui:FindFirstChild("Z7F_UI") then
    CoreGui:FindFirstChild("Z7F_UI"):Destroy()
end

-- ============================================
-- 🎮 MAIN GUI CREATION (HYBRID VERSION)
-- ============================================
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 340, 0, 240)
Frame.Position = UDim2.new(0.5, -170, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
Frame.BackgroundTransparency = 0.4
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0,15)
FrameCorner.Parent = Frame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Thickness = 2
FrameStroke.Color = Color3.fromRGB(0,0,0)
FrameStroke.Parent = Frame

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Parent = Frame
Shadow.AnchorPoint = Vector2.new(0.5,0.5)
Shadow.Position = UDim2.new(0.5,0,0.5,0)
Shadow.Size = UDim2.new(1,40,1,40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency = 0.5

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,10)
Title.BackgroundTransparency = 1
Title.Text = "Z7F HYBRID"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Parent = Frame

-- Title Glow
local glowGradientTitle = Instance.new("UIGradient")
glowGradientTitle.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180,180,180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
}
glowGradientTitle.Rotation = 45
glowGradientTitle.Parent = Title
glowGradientTitle.Offset = Vector2.new(-1,0)

local glowTweenTitle = TweenService:Create(glowGradientTitle, TweenInfo.new(1.2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,true),{Offset = Vector2.new(1,0)})
glowTweenTitle:Play()

-- Page Toggle Button
local PageToggle = Instance.new("TextButton")
PageToggle.Size = UDim2.new(0, 80, 0, 25)
PageToggle.Position = UDim2.new(1, -85, 0, 10)
PageToggle.Text = "حقوق"
PageToggle.Font = Enum.Font.GothamBold
PageToggle.TextSize = 14
PageToggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
PageToggle.TextColor3 = Color3.fromRGB(255,255,255)
PageToggle.Parent = Frame

local PageToggleCorner = Instance.new("UICorner")
PageToggleCorner.CornerRadius = UDim.new(0,8)
PageToggleCorner.Parent = PageToggle

-- Main Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1,0,1,-50)
ScrollFrame.Position = UDim2.new(0,0,0,50)
ScrollFrame.CanvasSize = UDim2.new(0,0,0,820)
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Active = true
ScrollFrame.Selectable = true
ScrollFrame.Visible = true
ScrollFrame.Parent = Frame

-- Rights Scroll Frame
local RightsScrollFrame = Instance.new("ScrollingFrame")
RightsScrollFrame.Size = UDim2.new(1,0,1,-50)
RightsScrollFrame.Position = UDim2.new(0,0,0,50)
RightsScrollFrame.CanvasSize = UDim2.new(0,0,0,500)
RightsScrollFrame.ScrollBarThickness = 8
RightsScrollFrame.BackgroundTransparency = 1
RightsScrollFrame.Active = true
RightsScrollFrame.Selectable = true
RightsScrollFrame.Visible = false
RightsScrollFrame.Parent = Frame

-- Player Image
local MidImage = Instance.new("ImageLabel")
MidImage.Size = UDim2.new(0,80,0,80)
MidImage.Position = UDim2.new(0.5,-40,0,0)
MidImage.BackgroundTransparency = 1
MidImage.Image = "rbxassetid://7992557358"
MidImage.Parent = ScrollFrame

local MidCorner = Instance.new("UICorner")
MidCorner.CornerRadius = UDim.new(1,0)
MidCorner.Parent = MidImage

-- Text Container
local TextContainer = Instance.new("Frame")
TextContainer.Size = UDim2.new(1,0,0,80)
TextContainer.Position = UDim2.new(0,0,0,80)
TextContainer.BackgroundTransparency = 1
TextContainer.Parent = ScrollFrame

-- User Label
local UserLabel = Instance.new("TextLabel")
UserLabel.Size = UDim2.new(1,0,0.3,0)
UserLabel.Position = UDim2.new(0,0,0,0)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = "User"
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 22
UserLabel.TextColor3 = Color3.fromRGB(255,255,255)
UserLabel.TextXAlignment = Enum.TextXAlignment.Center
UserLabel.Parent = TextContainer

-- Nick Label
local NickLabel = Instance.new("TextLabel")
NickLabel.Size = UDim2.new(1,0,0.3,0)
NickLabel.Position = UDim2.new(0,0,0.3,0)
NickLabel.BackgroundTransparency = 1
NickLabel.Text = "NickName"
NickLabel.Font = Enum.Font.Gotham
NickLabel.TextSize = 18
NickLabel.TextColor3 = Color3.fromRGB(180,180,180)
NickLabel.TextXAlignment = Enum.TextXAlignment.Center
NickLabel.Parent = TextContainer

-- Text Box
local NickTextBox = Instance.new("TextBox")
NickTextBox.Size = UDim2.new(0.8,0,0.4,0)
NickTextBox.Position = UDim2.new(0.1,0,0.6,0)
NickTextBox.Text = ""
NickTextBox.PlaceholderText = "لقب/يوزر"
NickTextBox.ClearTextOnFocus = true
NickTextBox.Font = Enum.Font.Gotham
NickTextBox.TextSize = 18
NickTextBox.TextColor3 = Color3.fromRGB(255,255,255)
NickTextBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
NickTextBox.BorderColor3 = Color3.fromRGB(100,100,100)
NickTextBox.TextXAlignment = Enum.TextXAlignment.Center
NickTextBox.TextYAlignment = Enum.TextYAlignment.Center
NickTextBox.Parent = TextContainer

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0,8)
TextBoxCorner.Parent = NickTextBox

-- Create Rights Page
local function createRightsPage()
    local RightsTitle = Instance.new("TextLabel")
    RightsTitle.Size = UDim2.new(1,0,0,40)
    RightsTitle.Position = UDim2.new(0,0,0,0)
    RightsTitle.BackgroundTransparency = 1
    RightsTitle.Text = "حقوق المطور"
    RightsTitle.Font = Enum.Font.GothamBold
    RightsTitle.TextSize = 24
    RightsTitle.TextColor3 = Color3.fromRGB(255,255,255)
    RightsTitle.TextXAlignment = Enum.TextXAlignment.Center
    RightsTitle.Parent = RightsScrollFrame

    local DeveloperInfo = Instance.new("TextLabel")
    DeveloperInfo.Size = UDim2.new(0.9,0,0,100)
    DeveloperInfo.Position = UDim2.new(0.05,0,0,50)
    DeveloperInfo.BackgroundTransparency = 1
    DeveloperInfo.Text = "المطور: Z7F\n\nشكراً لاستخدامك السكريبت\nجميع الحقوق محفوظة © 2024"
    DeveloperInfo.Font = Enum.Font.Gotham
    DeveloperInfo.TextSize = 16
    DeveloperInfo.TextColor3 = Color3.fromRGB(200,200,200)
    DeveloperInfo.TextXAlignment = Enum.TextXAlignment.Center
    DeveloperInfo.TextYAlignment = Enum.TextYAlignment.Center
    DeveloperInfo.TextWrapped = true
    DeveloperInfo.Parent = RightsScrollFrame

    local VersionInfo = Instance.new("TextLabel")
    VersionInfo.Size = UDim2.new(0.9,0,0,30)
    VersionInfo.Position = UDim2.new(0.05,0,0,170)
    VersionInfo.BackgroundTransparency = 1
    VersionInfo.Text = "الإصدار: 6.0.0 ULTIMATE HYBRID"
    VersionInfo.Font = Enum.Font.GothamBold
    VersionInfo.TextSize = 18
    VersionInfo.TextColor3 = Color3.fromRGB(100,200,255)
    VersionInfo.TextXAlignment = Enum.TextXAlignment.Center
    VersionInfo.Parent = RightsScrollFrame

    local FeaturesLabel = Instance.new("TextLabel")
    FeaturesLabel.Size = UDim2.new(0.9,0,0,30)
    FeaturesLabel.Position = UDim2.new(0.05,0,0,220)
    FeaturesLabel.BackgroundTransparency = 1
    FeaturesLabel.Text = "جميع الميزات المتاحة:"
    FeaturesLabel.Font = Enum.Font.GothamBold
    FeaturesLabel.TextSize = 18
    FeaturesLabel.TextColor3 = Color3.fromRGB(255,255,255)
    FeaturesLabel.TextXAlignment = Enum.TextXAlignment.Center
    FeaturesLabel.Parent = RightsScrollFrame

    local features = {
        "✨ نظام استهداف اللاعبين",
        "🎯 نظام المشاهدة",
        "⚡ نظام الانتقال السريع",
        "🔧 نظام البانق الخلفي والوجهي",
        "💺 نظام الجلوس فوق الرأس",
        "🎒 نظام الحقيبة الظهر",
        "💦 نظام المص والاغتصاب",
        "🔄 أداة الاختيار بالماوس",
        "🔒 نظام الكلبشة والتجميد",
        "👑 أنظمة النسخ المتعددة",
        "🚀 نظام السقوط السريع",
        "🛡️ مضادات الحماية المختلفة",
        "🎮 مضاد AFK التلقائي",
        "🔐 مضاد النسخ والقتل",
        "👥 نظام الحماية للاعبين"
    }

    for i, feature in ipairs(features) do
        local FeatureLabel = Instance.new("TextLabel")
        FeatureLabel.Size = UDim2.new(0.8,0,0,25)
        FeatureLabel.Position = UDim2.new(0.1,0,0,260 + (i-1)*30)
        FeatureLabel.BackgroundTransparency = 1
        FeatureLabel.Text = "• " .. feature
        FeatureLabel.Font = Enum.Font.Gotham
        FeatureLabel.TextSize = 14
        FeatureLabel.TextColor3 = Color3.fromRGB(180,180,180)
        FeatureLabel.TextXAlignment = Enum.TextXAlignment.Left
        FeatureLabel.Parent = RightsScrollFrame
    end
end

createRightsPage()

-- Top Image
local TopImage = Instance.new("ImageLabel")
TopImage.Size = UDim2.new(0,80,0,80)
TopImage.BackgroundTransparency = 1
TopImage.ZIndex = 4
TopImage.Image = "rbxassetid://11835491319"
TopImage.Parent = ScreenGui

local TopImageCorner = Instance.new("UICorner")
TopImageCorner.CornerRadius = UDim.new(1,0)
TopImageCorner.Parent = TopImage

local topImageOffset = Vector2.new(120,-60)
local function updateTopImagePosition()
    TopImage.Position = UDim2.new(0.5, topImageOffset.X + (Frame.Position.X.Offset + Frame.Size.X.Offset/2 - 170),
                                0.5, topImageOffset.Y + (Frame.Position.Y.Offset + Frame.Size.Y.Offset/2 - 120))
end
updateTopImagePosition()

-- Button Creation Function
local function createButton(name, text, positionX, positionY, parent)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0.42,0,0,36)
    button.Position = UDim2.new(positionX,0,positionY,0)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BackgroundColor3 = Color3.fromRGB(25,25,25)
    button.BackgroundTransparency = 0.5
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0,10)
    buttonCorner.Parent = button
    
    return button
end

-- ======================== جميع الأزرار ========================

-- الصف الأول
local SelectToolButton = createButton("SelectToolButton", "أداة الاختيار", 0.05, 170, ScrollFrame)
local WatchButton = createButton("WatchButton", "مـشـاهـده", 0.52, 170, ScrollFrame)

-- الصف الثاني
local TeleportButton = createButton("TeleportButton", "انـتـقـال", 0.05, 220, ScrollFrame)
local BangButton = createButton("BangButton", "بـانـق خـلـفـي", 0.52, 220, ScrollFrame)

-- الصف الثالث
local FaceBangButton = createButton("FaceBangButton", "بـانـق وجـه", 0.05, 270, ScrollFrame)
local HeadSitButton = createButton("HeadSitButton", "جـلـوس فـوق راسـه", 0.52, 270, ScrollFrame)

-- الصف الرابع
local BackpackButton = createButton("BackpackButton", "حـقـيـبـة ظـهـر", 0.05, 320, ScrollFrame)
local SuckButton = createButton("SuckButton", "مـص قـضـيـبـه", 0.52, 320, ScrollFrame)

-- الصف الخامس
local BenxButton = createButton("BenxButton", "يـغـتـصـبـك", 0.05, 370, ScrollFrame)
local HandcuffButton = createButton("HandcuffButton", "امـسـاك بـكـلـبـش", 0.52, 370, ScrollFrame)

-- الصف السادس
local FreezeButton = createButton("FreezeButton", "تـجـميـد بـكـلـبـش", 0.05, 420, ScrollFrame)
local AntiBangButton = createButton("AntiBangButton", "سقوط سريع", 0.52, 420, ScrollFrame)

-- الصف السابع (أنظمة النسخ)
local CopyStrongButton = createButton("CopyStrongButton", "نـسـخ قـوي", 0.05, 470, ScrollFrame)
local CopyFunnyButton = createButton("CopyFunnyButton", "نـسخ طقطقه", 0.52, 470, ScrollFrame)

-- الصف الثامن
local CopyStrong2Button = createButton("CopyStrong2Button", "نـسـخ جـيـد", 0.05, 520, ScrollFrame)
local CopyBeautifulButton = createButton("CopyBeautifulButton", "نـسـخ حـلـو", 0.52, 520, ScrollFrame)

-- الصف التاسع
local CopyExtendButton = createButton("CopyExtendButton", "نـسـخ تـطـويـل", 0.05, 570, ScrollFrame)
local CopyFatButton = createButton("CopyFatButton", "نـسـخ تـسـمـيـن", 0.52, 570, ScrollFrame)

-- الصف العاشر
local CopyThinButton = createButton("CopyThinButton", "نـسـخ تـنـحـيـف", 0.05, 620, ScrollFrame)
local CopyAntiHackButton = createButton("CopyAntiHackButton", "نـسـخ رهـيـب", 0.52, 620, ScrollFrame)

-- الصف الحادي عشر
local DoubleReButton = createButton("DoubleReButton", "دبـل ري", 0.05, 670, ScrollFrame)
local DoubleAuraButton = createButton("DoubleAuraButton", "دبل اورا", 0.52, 670, ScrollFrame)

-- الصف الثاني عشر (أنظمة الحماية)
local AntiAFKButton = createButton("AntiAFKButton", "مضاد AFK: ❌", 0.05, 720, ScrollFrame)
local AntiCopyButton = createButton("AntiCopyButton", "مضاد النسخ: ❌", 0.52, 720, ScrollFrame)

-- الصف الثالث عشر
local AntiKillButton = createButton("AntiKillButton", "مضاد القتل: ❌", 0.05, 770, ScrollFrame)

ScrollFrame.CanvasSize = UDim2.new(0,0,0,820)

-- Toggle Window Button
local ToggleWindowButton = Instance.new("ImageButton")
ToggleWindowButton.Size = UDim2.new(0,50,0,50)
ToggleWindowButton.Position = UDim2.new(1,-60,0.5,-25)
ToggleWindowButton.AnchorPoint = Vector2.new(0,0)
ToggleWindowButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
ToggleWindowButton.BackgroundTransparency = 0.6
ToggleWindowButton.BorderSizePixel = 2
ToggleWindowButton.BorderColor3 = Color3.fromRGB(0,0,0)
ToggleWindowButton.Image = "rbxassetid://11835491319"
ToggleWindowButton.Parent = ScreenGui

local ToggleWindowCorner = Instance.new("UICorner")
ToggleWindowCorner.CornerRadius = UDim.new(1,0)
ToggleWindowCorner.Parent = ToggleWindowButton

-- Notification System
local Notifications = {}

local function updateNotificationsPositions()
    for i, notif in ipairs(Notifications) do
        local targetPos = UDim2.new(1,-260,1,-80 - (i-1)*80)
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = targetPos}):Play()
    end
end

local function createNotification(titleText, mainText, playerImageId, duration)
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(0,300,0,70)
    Notification.Position = UDim2.new(1,10,1,-80)
    Notification.BackgroundColor3 = Color3.fromRGB(10,10,10)
    Notification.BackgroundTransparency = 0.4
    Notification.BorderSizePixel = 0
    Notification.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,15)
    Corner.Parent = Notification

    local PlayerImage = Instance.new("ImageLabel")
    PlayerImage.Size = UDim2.new(0,50,0,50)
    PlayerImage.Position = UDim2.new(0,10,0.5,-25)
    PlayerImage.BackgroundTransparency = 1
    PlayerImage.Image = playerImageId
    PlayerImage.Parent = Notification
    
    local ImgCorner = Instance.new("UICorner")
    ImgCorner.CornerRadius = UDim.new(1,0)
    ImgCorner.Parent = PlayerImage

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1,-70,0,25)
    TitleLabel.Position = UDim2.new(0,60,0,0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Notification

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1,-50,1,-25)
    TextLabel.Position = UDim2.new(0,65,0,15)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = mainText
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 18
    TextLabel.TextColor3 = Color3.fromRGB(200,200,200)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Notification

    table.insert(Notifications,1,Notification)
    updateNotificationsPositions()

    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1,-260,1,-80)}):Play()

    task.spawn(function()
        task.wait(duration)
        TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Position = UDim2.new(1,10,1,-80), BackgroundTransparency = 1}):Play()
        task.wait(0.5)
        Notification:Destroy()
        for i, v in ipairs(Notifications) do
            if v == Notification then
                table.remove(Notifications,i)
                break
            end
        end
        updateNotificationsPositions()
    end)
end

-- Helper Functions
local targetPlayer = nil
local watching = nil
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

-- متغيرات النسخ
local copyStrongActive = false
local copyFunnyActive = false
local copyStrong2Active = false
local copyBeautifulActive = false
local copyExtendActive = false
local copyFatActive = false
local copyThinActive = false
local copyAntiHackActive = false
local doubleReActive = false
local doubleAuraActive = false

local function createGlow(button)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,200,200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
    })
    gradient.Offset = Vector2.new(-1,0)
    gradient.Parent = button
    
    local tween = TweenService:Create(gradient, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1,0)})
    tween:Play()
    return gradient, tween
end

local function flashGlow(button, duration)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,200,200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
    })
    gradient.Offset = Vector2.new(-1,0)
    gradient.Parent = button
    
    local tween = TweenService:Create(gradient, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Offset = Vector2.new(1,0)})
    tween:Play()
    tween.Completed:Connect(function()
        gradient:Destroy()
    end)
end

local function GetRoot(plr)
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
end

-- Target Player System
local function setTargetFromText()
    local search = NickTextBox.Text:lower()
    if #search < 2 then 
        targetPlayer = nil 
        UserLabel.Text = "User"
        NickLabel.Text = "NickName"
        MidImage.Image = "rbxassetid://7992557358"
        return 
    end
    
    if ShouldBlockInput(search) then
        NickTextBox.Text = ""
        return
    end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), search, 1, true) or string.find(plr.DisplayName:lower(), search, 1, true) then
            targetPlayer = plr
            UserLabel.Text = plr.Name
            NickLabel.Text = plr.DisplayName
            
            local success, result = pcall(function()
                return Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            end)
            
            if success then
                MidImage.Image = result
            end
            break
        end
    end
end

NickTextBox:GetPropertyChangedSignal("Text"):Connect(setTargetFromText)

-- Page Toggle System
local isRightsPage = false
PageToggle.MouseButton1Click:Connect(function()
    isRightsPage = not isRightsPage
    if isRightsPage then
        PageToggle.Text = "الرئيسية"
        ScrollFrame.Visible = false
        RightsScrollFrame.Visible = true
    else
        PageToggle.Text = "حقوق"
        ScrollFrame.Visible = true
        RightsScrollFrame.Visible = false
    end
end)

-- ======================== الأنظمة الأساسية ========================

-- Watch System
local function applyWatching(plr)
    if not plr or not plr.Character then return end
    local humanoid = plr.Character:FindFirstChild("Humanoid")
    if humanoid then
        workspace.CurrentCamera.CameraSubject = humanoid
    end

    plr.CharacterAdded:Connect(function(char)
        if watchingEnabled then
            repeat task.wait() until char:FindFirstChild("Humanoid")
            workspace.CurrentCamera.CameraSubject = char:FindFirstChild("Humanoid")
        end
    end)
end

WatchButton.MouseButton1Click:Connect(function()
    local plr = Players:FindFirstChild(UserLabel.Text)
    if not plr then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end

    if watchingEnabled then
        watchingEnabled = false
        watching = nil
        WatchButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if WatchButton:FindFirstChildOfClass("UIGradient") then
            WatchButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid")
        end
        createNotification("Z7F", "تم إيقاف المشاهدة", "rbxassetid://7992557358", 3)
        return
    end

    watchingEnabled = true
    watching = plr
    WatchButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
    createGlow(WatchButton)
    applyWatching(plr)
    createNotification("Z7F", "تم تشغيل المشاهدة لـ "..plr.Name, "rbxassetid://7992557358", 3)
end)

-- Teleport System
TeleportButton.MouseButton1Click:Connect(function()
    local plr = Players:FindFirstChild(UserLabel.Text)
    if not plr or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    local targetPos = plr.Character.HumanoidRootPart.Position

    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0,3,0))
    end

    flashGlow(TeleportButton,1)
    createNotification("Z7F", "تم الانتقال إلى "..plr.Name, "rbxassetid://7992557358", 3)
end)

-- Bang System
local bangHeartbeat = nil
local bangAnimationId = "10714068222"

local function playBangAnimation()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://"..bangAnimationId
    local animTrack = humanoid:LoadAnimation(animation)
    animTrack.Looped = true
    animTrack:Play()
    animTrack:AdjustSpeed(1000)
end

local function startBang()
    if not targetPlayer or not targetPlayer.Character then return end
    playBangAnimation()
    if bangHeartbeat then bangHeartbeat:Disconnect() end
    
    bangHeartbeat = RunService.Heartbeat:Connect(function()
        if targetPlayer.Character and player.Character then
            local targetTorso = targetPlayer.Character:FindFirstChild("UpperTorso") or targetPlayer.Character:FindFirstChild("Torso")
            local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if targetTorso and playerHRP then
                playerHRP.CFrame = targetTorso.CFrame * CFrame.new(0, 0, 0.70)
            end
        end
    end)
end

local function stopBang()
    if bangHeartbeat then bangHeartbeat:Disconnect() bangHeartbeat = nil end
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do track:Stop() end
    end
end

BangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    bangActive = not bangActive
    if bangActive then
        BangButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(BangButton)
        startBang()
        createNotification("Z7F", "تم تشغيل البانق الخلفي على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        BangButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if BangButton:FindFirstChildOfClass("UIGradient") then
            BangButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        stopBang()
        createNotification("Z7F", "تم إيقاف البانق الخلفي", "rbxassetid://7992557358", 3)
    end
end)

-- Face Bang System
local suckAnimTrack = nil
local currentDistance = 1.5
local movingIn = true
local movementSpeed = 0.5
local minDistance = 0.5
local maxDistance = 2.5

local function updateFaceBang()
    while faceBangActive do
        local localChar = player.Character
        if not localChar then task.wait() continue end
        
        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid and faceBangActive then
            humanoid.Sit = true
            if not suckAnimTrack then
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://2506281703"
                suckAnimTrack = humanoid:LoadAnimation(animation)
                suckAnimTrack:Play()
                suckAnimTrack:AdjustSpeed(1.5)
            end
        end

        if targetPlayer and targetPlayer.Character then
            local humanoidRootPart = localChar:FindFirstChild("HumanoidRootPart")
            local targetHead = targetPlayer.Character:FindFirstChild("Head")
            if humanoidRootPart and targetHead then
                if movingIn then
                    currentDistance = currentDistance - movementSpeed
                    if currentDistance <= minDistance then movingIn = false end
                else
                    currentDistance = currentDistance + movementSpeed
                    if currentDistance >= maxDistance then movingIn = true end
                end
                local faceDirection = targetHead.CFrame.LookVector
                local targetPosition = targetHead.Position + (faceDirection * currentDistance)
                targetPosition = Vector3.new(targetPosition.X, targetHead.Position.Y, targetPosition.Z)
                humanoidRootPart.CFrame = CFrame.new(targetPosition, targetHead.Position)
                humanoidRootPart.Velocity = Vector3.new(0,2,0)
            end
        end

        task.wait()
    end

    local localChar = player.Character
    if localChar then
        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Sit = false end
    end
    if suckAnimTrack then suckAnimTrack:Stop() suckAnimTrack = nil end
end

FaceBangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    faceBangActive = not faceBangActive
    if faceBangActive then
        FaceBangButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(FaceBangButton)
        task.spawn(updateFaceBang)
        createNotification("Z7F", "تم تشغيل البانق الوجهي على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        FaceBangButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if FaceBangButton:FindFirstChildOfClass("UIGradient") then
            FaceBangButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        faceBangActive = false
        createNotification("Z7F", "تم إيقاف البانق الوجهي", "rbxassetid://7992557358", 3)
    end
end)

-- Head Sit System
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
    if headSitHeartbeat then headSitHeartbeat:Disconnect() headSitHeartbeat = nil end
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
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    headSitActive = not headSitActive
    if headSitActive then
        HeadSitButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(HeadSitButton)
        startHeadSit()
        createNotification("Z7F", "تم تشغيل الجلوس فوق رأس "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        HeadSitButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if HeadSitButton:FindFirstChildOfClass("UIGradient") then
            HeadSitButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        stopHeadSit()
        createNotification("Z7F", "تم إيقاف الجلوس فوق الرأس", "rbxassetid://7992557358", 3)
    end
end)

-- Backpack System
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
    if backpackHeartbeat then backpackHeartbeat:Disconnect() backpackHeartbeat = nil end
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
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    backpackActive = not backpackActive
    if backpackActive then
        BackpackButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(BackpackButton)
        startBackpack()
        createNotification("Z7F", "تم تشغيل الحقيبة الظهر على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        BackpackButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if BackpackButton:FindFirstChildOfClass("UIGradient") then
            BackpackButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        stopBackpack()
        createNotification("Z7F", "تم إيقاف الحقيبة الظهر", "rbxassetid://7992557358", 3)
    end
end)

-- Suck System
local suckAnimTrack2 = nil
local currentDistance2 = 1.5
local movingIn2 = true
local verticalOffset2 = 2

local function updateSuck()
    while suckActive do
        local localChar = player.Character
        if not localChar then task.wait() continue end

        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = true
            if not suckAnimTrack2 then
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://2506281703"
                suckAnimTrack2 = humanoid:LoadAnimation(animation)
                suckAnimTrack2:Play()
                suckAnimTrack2:AdjustSpeed(1.5)
            end
        end

        if targetPlayer and targetPlayer.Character then
            local humanoidRootPart = localChar:FindFirstChild("HumanoidRootPart")
            local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart and targetHRP then
                if movingIn2 then
                    currentDistance2 = currentDistance2 - movementSpeed
                    if currentDistance2 <= minDistance then movingIn2 = false end
                else
                    currentDistance2 = currentDistance2 + movementSpeed
                    if currentDistance2 >= maxDistance then movingIn2 = true end
                end

                local targetPosition = targetHRP.Position - Vector3.new(0, verticalOffset2, 0) + (targetHRP.CFrame.LookVector * currentDistance2)
                humanoidRootPart.CFrame = CFrame.new(targetPosition, targetHRP.Position - Vector3.new(0, verticalOffset2, 0))
                humanoidRootPart.Velocity = Vector3.new(0,2,0)
            end
        end

        task.wait()
    end

    local localChar = player.Character
    if localChar then
        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Sit = false end
    end
    if suckAnimTrack2 then
        suckAnimTrack2:Stop()
        suckAnimTrack2 = nil
    end
end

SuckButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    suckActive = not suckActive
    if suckActive then
        SuckButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(SuckButton)
        task.spawn(updateSuck)
        createNotification("Z7F", "تم تشغيل المص على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        SuckButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if SuckButton:FindFirstChildOfClass("UIGradient") then
            SuckButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        suckActive = false
        createNotification("Z7F", "تم إيقاف المص", "rbxassetid://7992557358", 3)
    end
end)

-- Benx System
local function startBenx()
    if not targetPlayer or not targetPlayer.Character then return end

    benxActive = true

    task.spawn(function()
        local LocalPlayer = Players.LocalPlayer

        repeat
            task.wait()
            pcall(function()
                local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")

                if hrp and hum and targetPlayer.Character and targetPlayer.Character:FindFirstChild("LowerTorso") then
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                    task.wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.8) * CFrame.Angles(-1.5, math.rad(0), 0)
                    task.wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                    task.wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.8) * CFrame.Angles(-1.5, math.rad(0), 0)
                    task.wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                    task.wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.8) * CFrame.Angles(-1.5, math.rad(0), 0)
                    task.wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                end
            end)
        until not benxActive

        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end)
end

local function stopBenx()
    benxActive = false
end

BenxButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end

    benxActive = not benxActive
    if benxActive then
        BenxButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        createGlow(BenxButton)
        startBenx()
        createNotification("Z7F", "تم تشغيل الاغتصاب على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        BenxButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        if BenxButton:FindFirstChildOfClass("UIGradient") then
            BenxButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        stopBenx()
        createNotification("Z7F", "تم إيقاف الاغتصاب", "rbxassetid://7992557358", 3)
    end
end)

-- ======================== الأنظمة الجديدة ========================

-- Handcuff System
HandcuffButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end

    flashGlow(HandcuffButton, 1)

    local char = player.Character
    if not char then return end

    local toolNames = {
        "كلبشه","كلبشة","كلبش عيد الرعب","كلبشة الملاك",
        "كلبش","كلبشة سبونج بوب","كلبشة ذهبيه","كلبشه ذهبيبه",
        "كلبشة ملاك"
    }

    local function isWantedTool(tool)
        local name = tool.Name:lower()
        for _, n in ipairs(toolNames) do
            if string.find(name, n) then return true end
        end
        if string.find(name, "handcuff") or string.find(name, "cuff") then return true end
        return false
    end

    local tool
    for _, item in ipairs(player.Backpack:GetChildren()) do
        if isWantedTool(item) then tool = item break end
    end
    if not tool then
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Tool") and isWantedTool(item) then
                tool = item break
            end
        end
    end
    if not tool then return end

    tool.Parent = char

    local remoteName = "كلبشه"
    local remoteFolder = char:FindFirstChild(remoteName)
    if remoteFolder and remoteFolder:FindFirstChild("RemoteEvent") then
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            remoteFolder.RemoteEvent:FireServer(targetHRP)
        end
    end
    createNotification("Z7F", "تم استخدام الكلبشة على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
end)

-- Freeze System
FreezeButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end

    flashGlow(FreezeButton, 1)

    local char = player.Character
    if not char then return end

    local toolNames = {
        "كلبشه","كلبشة","كلبش عيد الرعب","كلبشة الملاك",
        "كلبش","كلبشة سبونج بوب","كلبشة ذهبيه","كلبشه ذهبيبه",
        "كلبشة ملاك"
    }

    local function isWantedTool(tool)
        local name = tool.Name:lower()
        for _, n in ipairs(toolNames) do
            if string.find(name, n) then return true end
        end
        if string.find(name, "handcuff") or string.find(name, "cuff") then return true end
        return false
    end

    local tool
    for _, item in ipairs(player.Backpack:GetChildren()) do
        if isWantedTool(item) then tool = item break end
    end
    if not tool then
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Tool") and isWantedTool(item) then
                tool = item break
            end
        end
    end
    if not tool then return end

    tool.Parent = char

    local remoteName = "كلبشه"
    local remoteFolder = char:FindFirstChild(remoteName)
    if remoteFolder and remoteFolder:FindFirstChild("RemoteEvent") then
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            remoteFolder.RemoteEvent:FireServer(targetHRP)
        end
    end

    task.wait(0.5)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(".char")
    end)

    task.wait(0.3)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(".unchar")
    end)
    
    createNotification("Z7F", "تم تجميد "..targetPlayer.Name, "rbxassetid://7992557358", 3)
end)

-- Anti Bang (Fast Fall)
AntiBangButton.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        createNotification("Z7F", "جاري السقوط السريع...", "rbxassetid://7992557358", 2)
        local lastCFrame = hrp.CFrame
        hrp.CFrame = CFrame.new(0, -500, 0)
        task.wait(0.7)
        hrp.CFrame = lastCFrame
        createNotification("Z7F", "تمت عملية السقوط", "rbxassetid://7992557358", 3)
    end
end)

-- ======================== أنظمة النسخ ========================

-- Copy Strong System
local function startCopyStrong()
    if not targetPlayer then return end
    
    while copyStrongActive and targetPlayer do
        local plrName = targetPlayer.Name
        local prefix = #plrName >= 3 and string.sub(plrName,1,3) or plrName
        
        local args = {
            ". .neon "..prefix..
            " .paint "..prefix..
            " pk .size "..prefix..
            " 3 .height "..prefix..
            " 0.1 .aura "..prefix..
            " .title "..prefix..
            " تم النسخ بواسطة Z7F"
        }

        pcall(function()
            local hdadmin = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdminHDClient")
            if hdadmin then
                local signals = hdadmin:FindFirstChild("Signals")
                if signals then
                    local request = signals:FindFirstChild("RequestCommandSilent")
                    if request then
                        request:InvokeServer(unpack(args))
                    end
                end
            end
        end)
        task.wait(7)
    end
end

CopyStrongButton.MouseButton1Click:Connect(function()
    if not targetPlayer then 
        createNotification("Z7F", "لم يتم تحديد لاعب", "rbxassetid://7992557358", 3)
        return 
    end
    
    copyStrongActive = not copyStrongActive
    
    if copyStrongActive then
        CopyStrongButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyStrongButton)
        task.spawn(startCopyStrong)
        createNotification("Z7F", "تم تشغيل النسخ القوي على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyStrongButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyStrongButton:FindFirstChildOfClass("UIGradient") then
            CopyStrongButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyStrongActive = false
        createNotification("Z7F", "تم إيقاف النسخ القوي", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Funny System
local function startCopyFunny()
    if not targetPlayer then return end

    while copyFunnyActive and targetPlayer do
        local plrName = targetPlayer.Name
        local prefix = #plrName >= 5 and string.sub(plrName,1,3) or plrName
        local args = {
            ".dog "..prefix.." .jp "..prefix.." 0 .titlepk "..prefix.." \218\175\217\132\216\168 \217\133\216\183\217\139\217\138\216\185\217\139"
        }
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
        end)
        task.wait(7)
    end
end

CopyFunnyButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyFunnyActive = not copyFunnyActive
    if copyFunnyActive then
        CopyFunnyButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyFunnyButton)
        task.spawn(startCopyFunny)
        createNotification("Z7F", "تم تشغيل نسخ طقطقه على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyFunnyButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyFunnyButton:FindFirstChildOfClass("UIGradient") then
            CopyFunnyButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyFunnyActive = false
        createNotification("Z7F", "تم إيقاف نسخ طقطقه", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Strong 2 System
local function startCopyStrong2()
    if not targetPlayer then return end

    while copyStrong2Active and targetPlayer do
        local plrName = targetPlayer.Name
        local prefix = #plrName >= 5 and string.sub(plrName,1,3) or plrName
        local args = {
            ".size "..prefix.." 3 .fat "..prefix.." .box "..prefix.." .sit "..prefix.." .neon "..prefix.." .paint "..prefix.." pk .shine "..prefix.." .titlepk "..prefix.." \217\133\217\139\217\137\216\175\217\139\216\185\217\137\217\136\217\139\216\179\217\145"
        }
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
        end)
        task.wait(7)
    end
end

CopyStrong2Button.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyStrong2Active = not copyStrong2Active
    if copyStrong2Active then
        CopyStrong2Button.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyStrong2Button)
        task.spawn(startCopyStrong2)
        createNotification("Z7F", "تم تشغيل نسخ جيد على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyStrong2Button.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyStrong2Button:FindFirstChildOfClass("UIGradient") then
            CopyStrong2Button:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyStrong2Active = false
        createNotification("Z7F", "تم إيقاف نسخ جيد", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Beautiful System
local function startCopyBeautiful()
    if not targetPlayer then return end

    while copyBeautifulActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,3)) or name

        local args = {
            ". .size "..prefix.." 3 .height "..prefix.." 0.1 .neon "..prefix.." .paint "..prefix.." pk .sit "..prefix..
            " .jp "..prefix.." 0 .aura "..prefix.." .fat "..prefix.." .titlepk "..prefix.." Z7F \217\129\216\173\217\139\217\137\217\132\217\139\217\138\217\139\217\139\217\139"
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(7)
    end
end

CopyBeautifulButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    copyBeautifulActive = not copyBeautifulActive

    if copyBeautifulActive then
        CopyBeautifulButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyBeautifulButton)
        task.spawn(startCopyBeautiful)
        createNotification("Z7F", "تم تشغيل نسخ حلو على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyBeautifulButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyBeautifulButton:FindFirstChildOfClass("UIGradient") then
            CopyBeautifulButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyBeautifulActive = false
        createNotification("Z7F", "تم إيقاف نسخ حلو", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Extend System
local function startCopyExtend()
    if not targetPlayer then return end

    while copyExtendActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name

        local args = {
            ". .char "..prefix.." .neon "..prefix.." .size "..prefix.." 3 .sit "..prefix.." .jp "..prefix.." 0 .height "..prefix.." 3 .fast "..prefix
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(7)
    end
end

CopyExtendButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    copyExtendActive = not copyExtendActive

    if copyExtendActive then
        CopyExtendButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyExtendButton)
        task.spawn(startCopyExtend)
        createNotification("Z7F", "تم تشغيل نسخ تطويل على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyExtendButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyExtendButton:FindFirstChildOfClass("UIGradient") then
            CopyExtendButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyExtendActive = false
        createNotification("Z7F", "تم إيقاف نسخ تطويل", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Fat System
local function startCopyFat()
    if not targetPlayer then return end

    while copyFatActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name

        local args = {
            ". .char "..prefix.." ardaomeroglucooj .neon "..prefix.." .paint "..prefix.." pk .sit "..prefix.." .jp "..prefix.." 0 .fat "..prefix.." .thin "..prefix
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(7)
    end
end

CopyFatButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    copyFatActive = not copyFatActive

    if copyFatActive then
        CopyFatButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyFatButton)
        task.spawn(startCopyFat)
        createNotification("Z7F", "تم تشغيل نسخ تسمين على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyFatButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyFatButton:FindFirstChildOfClass("UIGradient") then
            CopyFatButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyFatActive = false
        createNotification("Z7F", "تم إيقاف نسخ تسمين", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Thin System
local function startCopyThin()
    if not targetPlayer then return end

    while copyThinActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name

        local args = {
            ".neon "..prefix.." .fast "..prefix.." .size "..prefix.." 2 .paint "..prefix.." pk .sit "..prefix.." .thin "..prefix.." .shine "..prefix
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(7)
    end
end

CopyThinButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    copyThinActive = not copyThinActive

    if copyThinActive then
        CopyThinButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyThinButton)
        task.spawn(startCopyThin)
        createNotification("Z7F", "تم تشغيل نسخ تنحيف على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyThinButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyThinButton:FindFirstChildOfClass("UIGradient") then
            CopyThinButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyThinActive = false
        createNotification("Z7F", "تم إيقاف نسخ تنحيف", "rbxassetid://7992557358", 3)
    end
end)

-- Copy Anti Hack System
local function startCopyAntiHack()
    if not targetPlayer then return end

    while copyAntiHackActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,3)) or name

        local args = {
            ".size "..prefix.." 3 .height "..prefix.." 1 .fat "..prefix.." .thin "..prefix.." .sit "..prefix.." .neon "..prefix.." .paint "..prefix.." pk"
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(7)
    end
end

CopyAntiHackButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    copyAntiHackActive = not copyAntiHackActive

    if copyAntiHackActive then
        CopyAntiHackButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyAntiHackButton)
        task.spawn(startCopyAntiHack)
        createNotification("Z7F", "تم تشغيل نسخ رهيب على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        CopyAntiHackButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyAntiHackButton:FindFirstChildOfClass("UIGradient") then
            CopyAntiHackButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        copyAntiHackActive = false
        createNotification("Z7F", "تم إيقاف نسخ رهيب", "rbxassetid://7992557358", 3)
    end
end)

-- Double Re System
local function startDoubleRe()
    if not targetPlayer then return end

    while doubleReActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name

        local args = {
            ".re "..prefix.." .re "..prefix
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(3)
    end
end

DoubleReButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    doubleReActive = not doubleReActive

    if doubleReActive then
        DoubleReButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(DoubleReButton)
        task.spawn(startDoubleRe)
        createNotification("Z7F", "تم تشغيل دبل ري على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        DoubleReButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if DoubleReButton:FindFirstChildOfClass("UIGradient") then
            DoubleReButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        doubleReActive = false
        createNotification("Z7F", "تم إيقاف دبل ري", "rbxassetid://7992557358", 3)
    end
end)

-- Double Aura System
local function startDoubleAura()
    if not targetPlayer then return end

    while doubleAuraActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 3 and string.sub(name,1,3)) or name

        local args = {
            ".aura "..prefix.." .aura "..prefix
        }

        pcall(function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("HDAdminHDClient")
                :WaitForChild("Signals")
                :WaitForChild("RequestCommandSilent")
                :InvokeServer(unpack(args))
        end)

        task.wait(3)
    end
end

DoubleAuraButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end

    doubleAuraActive = not doubleAuraActive

    if doubleAuraActive then
        DoubleAuraButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(DoubleAuraButton)
        task.spawn(startDoubleAura)
        createNotification("Z7F", "تم تشغيل دبل اورا على "..targetPlayer.Name, "rbxassetid://7992557358", 3)
    else
        DoubleAuraButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if DoubleAuraButton:FindFirstChildOfClass("UIGradient") then
            DoubleAuraButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        doubleAuraActive = false
        createNotification("Z7F", "تم إيقاف دبل اورا", "rbxassetid://7992557358", 3)
    end
end)

-- ======================== نظام مضاد AFK ========================
local antiAFKConnection = nil
AntiAFKButton.MouseButton1Click:Connect(function()
    antiAFKActive = not antiAFKActive
    
    if antiAFKActive then
        AntiAFKButton.Text = "مضاد AFK: ✅"
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(AntiAFKButton)
        
        antiAFKConnection = RunService.Heartbeat:Connect(function()
            VirtualInputManager:SendKeyEvent(true, "W", false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, "W", false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(true, "S", false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, "S", false, game)
        end)
        
        createNotification("Z7F", "تم تشغيل مضاد AFK", "rbxassetid://7992557358", 3)
    else
        AntiAFKButton.Text = "مضاد AFK: ❌"
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if AntiAFKButton:FindFirstChildOfClass("UIGradient") then
            AntiAFKButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
        
        createNotification("Z7F", "تم إيقاف مضاد AFK", "rbxassetid://7992557358", 3)
    end
end)

-- ======================== نظام مضاد النسخ ========================
local antiCopyConnection = nil
AntiCopyButton.MouseButton1Click:Connect(function()
    antiCopyActive = not antiCopyActive
    
    if antiCopyActive then
        AntiCopyButton.Text = "مضاد النسخ: ✅"
        AntiCopyButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(AntiCopyButton)
        
        -- تشفير متغيرات حساسة
        local secureData = {
            ["TargetPlayer"] = "",
            ["ScriptName"] = "Z7F_Script_" .. math.random(1, 999999),
            ["Creator"] = "Z7F",
            ["Version"] = "6.0.0",
            ["Timestamp"] = os.time()
        }
        
        -- حماية ضد النسخ
        antiCopyConnection = RunService.Heartbeat:Connect(function()
            -- التحقق من سلامة المتغيرات
            if targetPlayer and not targetPlayer.Parent then
                targetPlayer = nil
            end
            
            -- حماية ضد التعديل الخارجي
            if getgenv().AntiCopy ~= true then
                getgenv().AntiCopy = true
            end
        end)
        
        -- إضافة طبقة حماية إضافية
        local function protectScript()
            local gui = ScreenGui
            gui.Name = secureData.ScriptName
            
            -- جعل النوافذ غير قابلة للنسخ
            for _, obj in pairs(gui:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
                    obj.ResetOnSpawn = false
                    obj.Archivable = false
                end
            end
        end
        
        protectScript()
        
        createNotification("Z7F", "تم تشغيل مضاد النسخ المتقدم", "rbxassetid://7992557358", 3)
    else
        AntiCopyButton.Text = "مضاد النسخ: ❌"
        AntiCopyButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if AntiCopyButton:FindFirstChildOfClass("UIGradient") then
            AntiCopyButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        
        if antiCopyConnection then
            antiCopyConnection:Disconnect()
            antiCopyConnection = nil
        end
        
        createNotification("Z7F", "تم إيقاف مضاد النسخ", "rbxassetid://7992557358", 3)
    end
end)

-- ======================== نظام مضاد القتل ========================
AntiKillButton.MouseButton1Click:Connect(function()
    antiKillActive = not antiKillActive
    
    if antiKillActive then
        AntiKillButton.Text = "مضاد القتل: ✅"
        AntiKillButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(AntiKillButton)
        
        -- حماية الشخصية من القتل
        local function protectCharacter(character)
            task.wait(1)
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.BreakJointsOnDeath = false
            
            -- إضافة حماية إضافية
            local forceField = Instance.new("ForceField")
            forceField.Parent = character
            forceField.Visible = false
            
            humanoid.Died:Connect(function()
                task.wait(3)
                if character and character.Parent then
                    character:BreakJoints()
                end
            end)
        end
        
        player.CharacterAdded:Connect(protectCharacter)
        
        -- حماية الحالية
        if player.Character then
            protectCharacter(player.Character)
        end
        
        createNotification("Z7F", "تم تشغيل مضاد القتل", "rbxassetid://7992557358", 3)
    else
        AntiKillButton.Text = "مضاد القتل: ❌"
        AntiKillButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if AntiKillButton:FindFirstChildOfClass("UIGradient") then
            AntiKillButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        
        createNotification("Z7F", "تم إيقاف مضاد القتل", "rbxassetid://7992557358", 3)
    end
end)

-- ======================== Select Tool System ========================

local function NotifyTool(message)
    createNotification("Z7F Tool", message, "rbxassetid://7992557358", 3)
end

local function createSelectTool()
    local backpack = player:WaitForChild("Backpack")
    
    local oldTool = backpack:FindFirstChild("SELECT")
    if oldTool then
        oldTool:Destroy()
    end
    
    local selectTool = Instance.new("Tool")
    selectTool.Name = "SELECT"
    selectTool.Parent = backpack
    selectTool.CanBeDropped = false
    selectTool.ToolTip = "اختر لاعب"
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Parent = selectTool
    handle.Size = Vector3.new(0.7, 0.7, 0.7)
    handle.BrickColor = BrickColor.new("Bright blue")
    handle.Material = Enum.Material.Neon
    
    local mesh = Instance.new("SpecialMesh")
    mesh.Parent = handle
    mesh.MeshType = Enum.MeshType.Sphere
    
    local pointLight = Instance.new("PointLight")
    pointLight.Parent = handle
    pointLight.Color = Color3.fromRGB(0, 100, 255)
    pointLight.Brightness = 2
    pointLight.Range = 10
    
    selectTool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local target = mouse.Target
        
        if not target then 
            NotifyTool("لم تضغط على شيء!")
            return 
        end
        
        local character = target.Parent
        local selectedPlayer = Players:GetPlayerFromCharacter(character)
        
        if not selectedPlayer then
            local model = character
            while model do
                selectedPlayer = Players:GetPlayerFromCharacter(model)
                if selectedPlayer then break end
                model = model.Parent
            end
        end
        
        if selectedPlayer and selectedPlayer ~= player then
            if _G.ProtectToolClick(selectedPlayer.Name) then
                NotifyTool("❌ هذا اللاعب محمي!")
                return
            end
            
            targetPlayer = selectedPlayer
            UserLabel.Text = selectedPlayer.Name
            NickLabel.Text = selectedPlayer.DisplayName
            
            local success, result = pcall(function()
                return Players:GetUserThumbnailAsync(selectedPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            end)
            
            if success then
                MidImage.Image = result
            end
            NotifyTool("✅ تم اختيار: " .. selectedPlayer.Name)
        else
            NotifyTool("❌ هذا ليس لاعب!")
        end
    end)
    
    return selectTool
end

SelectToolButton.MouseButton1Click:Connect(function()
    selectToolActive = not selectToolActive
    if selectToolActive then
        SelectToolButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(SelectToolButton)
        createSelectTool()
        NotifyTool("✅ تم إنشاء أداة الاختيار")
    else
        SelectToolButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if SelectToolButton:FindFirstChildOfClass("UIGradient") then
            SelectToolButton:FindFirstChildOfClass("UIGradient"):Destroy()
        end
        local backpack = player:WaitForChild("Backpack")
        local oldTool = backpack:FindFirstChild("SELECT")
        if oldTool then oldTool:Destroy() end
        NotifyTool("❌ تم إزالة أداة الاختيار")
    end
end)

-- ======================== Window Controls ========================

local dragging = false
local dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	Frame.Position = newPos
	updateTopImagePosition()
end

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		update(input)
	end
end)

local windowButtonDragging = false
local windowButtonDragStart, windowButtonStartPos
ToggleWindowButton.MouseButton1Down:Connect(function(input)
    windowButtonDragging = true
    windowButtonDragStart = input.Position
    windowButtonStartPos = ToggleWindowButton.Position
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then windowButtonDragging = false end
    end)
end)

UserInputService.InputChanged:Connect(function(input)
    if windowButtonDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - windowButtonDragStart
        ToggleWindowButton.Position = UDim2.new(windowButtonStartPos.X.Scale, windowButtonStartPos.X.Offset + delta.X, windowButtonStartPos.Y.Scale, windowButtonStartPos.Y.Offset + delta.Y)
    end
end)

ToggleWindowButton.MouseButton1Click:Connect(function()
    local newState = not Frame.Visible
    Frame.Visible = newState
    TopImage.Visible = newState
end)

-- ======================== Entrance Animation ========================

Frame.Position = UDim2.new(0.5,-170,1.2,0)
TweenService:Create(Frame, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
{Position=UDim2.new(0.5,-170,0.5,-120)}):Play()

-- ======================== Welcome Message ========================

task.wait(1)
createNotification("Z7F", "تم تحميل السكريبت بنجاح!", "rbxassetid://7992557358", 5)
createNotification("Z7F", "Z7F HYBRID - النسخة المتطورة", "rbxassetid://7992557358", 5)

-- ======================== Cleanup System ========================

local function cleanup()
    -- Stop all systems
    stopBang()
    stopHeadSit()
    stopBackpack()
    stopBenx()
    
    -- Stop copy systems
    copyStrongActive = false
    copyFunnyActive = false
    copyStrong2Active = false
    copyBeautifulActive = false
    copyExtendActive = false
    copyFatActive = false
    copyThinActive = false
    copyAntiHackActive = false
    doubleReActive = false
    doubleAuraActive = false
    
    -- Stop anti-AFK
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
        antiAFKConnection = nil
    end
    
    -- Stop anti-copy
    if antiCopyConnection then
        antiCopyConnection:Disconnect()
        antiCopyConnection = nil
    end
    
    -- Stop watching
    watchingEnabled = false
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid")
    end
    
    -- Clear target
    targetPlayer = nil
    
    -- Clear Benx global
    getgenv().Benx = false
    
    createNotification("Z7F", "تم تنظيف السكربت", "rbxassetid://7992557358", 2)
end

-- Cleanup when the main GUI is removed
game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Z7F_UI" then
        cleanup()
    end
end)

-- Cleanup when the game closes
game:BindToClose(function()
    cleanup()
end)

-- ======================== Auto Messages ========================

task.spawn(function()
    task.wait(2)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer("Z7F HYBRID ON TOP")
    end)
end)

task.spawn(function()
    task.wait(15)
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer("Z7F~THE~BEST~HYBRID~SCRIPT")
    end)
end)

task.spawn(function()
    task.wait(180)
    local function sendThirdMessage()
        local args = {
            "#ScRiPt ! Z7F ! HYBRID#"
        }
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
        end)
    end

    sendThirdMessage()
    while true do
        task.wait(600)
        sendThirdMessage()
    end
end)

task.spawn(function()
    task.wait(900)
    local function sendFourthMessage()
        local args = {
            "<iUse-Script-Z7F-HYBRID>by Z7F"
        }
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
        end)
    end

    sendFourthMessage()

    task.wait(480)
    while true do
        task.wait(1200)
        sendFourthMessage()
    end
end)

print("[Z7F HYBRID Script] Loaded Successfully!")
warn("Z7F HYBRID Script by Z7F ON TOP - Ultimate Hybrid Edition")

-- Add safety delay at the end
task.wait(1)
createNotification("Z7F", "جاهز للاستخدام!", "rbxassetid://7992557358", 3)

-- Character Events
player.CharacterAdded:Connect(function()
    task.wait(0.1)
    if bangActive then startBang() end
    if headSitActive then startHeadSit() end
    if backpackActive then startBackpack() end
    fixMovement()
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if targetPlayer and leavingPlayer == targetPlayer then
        bangActive = false
        faceBangActive = false
        headSitActive = false
        backpackActive = false
        suckActive = false
        benxActive = false
        copyStrongActive = false
        copyFunnyActive = false
        copyStrong2Active = false
        copyBeautifulActive = false
        copyExtendActive = false
        copyFatActive = false
        copyThinActive = false
        copyAntiHackActive = false
        doubleReActive = false
        doubleAuraActive = false
        
        local buttons = {
            BangButton, FaceBangButton, HeadSitButton, BackpackButton, SuckButton, BenxButton,
            CopyStrongButton, CopyFunnyButton, CopyStrong2Button, CopyBeautifulButton,
            CopyExtendButton, CopyFatButton, CopyThinButton, CopyAntiHackButton,
            DoubleReButton, DoubleAuraButton, HandcuffButton, FreezeButton, SelectToolButton
        }
        
        for _, btn in pairs(buttons) do
            if btn then
                btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
                if btn:FindFirstChildOfClass("UIGradient") then
                    btn:FindFirstChildOfClass("UIGradient"):Destroy()
                end
            end
        end
        
        stopBang()
        stopHeadSit()
        stopBackpack()
        stopBenx()
        
        targetPlayer = nil
        UserLabel.Text = "User"
        NickLabel.Text = "NickName"
        MidImage.Image = "rbxassetid://7992557358"
        createNotification("Z7F", "خرج اللاعب المستهدف", "rbxassetid://7992557358", 3)
    end
end)