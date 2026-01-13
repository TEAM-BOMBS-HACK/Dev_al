-- ===========================================
-- Z7F SCRIPT V9.0.0 FINAL - BASIC VERSION
-- DEVELOPER: Z7F & Alaoui
-- ULTIMATE COMPACT VERSION
-- ===========================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService('VirtualUser')
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- ===========================================
-- 🔒 قائمة المحميين
-- ===========================================

local ProtectedUsers = {
    ["1il5f"] = true,
    ["1il5i"] = true,
    ["eyad51533"] = true,
    ["sj3zx"] = true,
    ["awr_9351156"] = true,
    ["ababahbada"] = true,
    ["Tx_3a"] = true,
    ["volex37"] = true,
    ["nanMrNoHackk"] = true,
    ["name"] = true,
    ["JP_EB15"] = true,
    ["noor105320"] = true
}

-- ===========================================
-- 🚫 قائمة المحظورين
-- ===========================================

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
    ["dc_vt11"] = true,
    ["7_rgh23"] = true,
    ["FM7_5"] = true
}

-- ===========================================
-- 📋 جدول الإشعارات
-- ===========================================

local Notifications = {}
local function updateNotificationsPositions()
    for i, notif in ipairs(Notifications) do
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(1, -260, 1, -80 - (i-1) * 80)}):Play()
    end
end

-- ===========================================
-- 🔔 دالة إنشاء إشعار
-- ===========================================

local function createNotification(titleText, mainText, playerImageId, duration)
    local baseWidth = 300
    local textWidth = #mainText * 6
    local notifWidth = math.max(baseWidth, textWidth + 40)

    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(0, notifWidth, 0, 70)
    Notification.Position = UDim2.new(1, 10, 1, -80)
    Notification.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Notification.BackgroundTransparency = 0.4
    Notification.BorderSizePixel = 0
    Notification.Parent = CoreGui
    Instance.new("UICorner", Notification).CornerRadius = UDim.new(0, 15)

    local PlayerImage = Instance.new("ImageLabel", Notification)
    PlayerImage.Size = UDim2.new(0, 50, 0, 50)
    PlayerImage.Position = UDim2.new(0, 10, 0.5, -25)
    PlayerImage.BackgroundTransparency = 1
    PlayerImage.Image = playerImageId
    Instance.new("UICorner", PlayerImage).CornerRadius = UDim.new(1, 0)

    local TitleLabel = Instance.new("TextLabel", Notification)
    TitleLabel.Size = UDim2.new(1, -70, 0, 25)
    TitleLabel.Position = UDim2.new(0, 60, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TextLabel = Instance.new("TextLabel", Notification)
    TextLabel.Size = UDim2.new(1, -50, 1, -25)
    TextLabel.Position = UDim2.new(0, 65, 0, 15)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = mainText
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 18
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    table.insert(Notifications, 1, Notification)
    updateNotificationsPositions()

    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -(notifWidth - 40), 1, -80)}):Play()

    delay(duration, function()
        Notification:Destroy()
        for i, v in ipairs(Notifications) do
            if v == Notification then
                table.remove(Notifications, i)
                break
            end
        end
        updateNotificationsPositions()
    end)
end

-- ===========================================
-- 🔒 فحص المحظورين
-- ===========================================

if BannedUsers[LocalPlayer.Name] then
    local gui = Instance.new("ScreenGui")
    gui.Parent = CoreGui
    gui.ResetOnSpawn = false

    local bg = Instance.new("ImageLabel", gui)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundTransparency = 1
    bg.Image = "rbxassetid://8991722426"

    local txt = Instance.new("TextLabel", bg)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 32
    txt.TextColor3 = Color3.fromRGB(255, 0, 0)
    txt.TextWrapped = true
    txt.Text = "عذراً ، لايمكنك تشغيل السكربت لانك من قائمة المحظورين\n\nرسالة من المطور :\n( بنعالي يازبال محروم من سكربتي واحلم انك تشغله ياكلب بنعالي يلا ختفو )"

    while true do
        task.wait(1e9)
    end
    return
end

-- ===========================================
-- 🔧 نظام منع الموت والتجميد
-- ===========================================

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
    if Fixing then
        return
    end
    Fixing = true

    DisconnectAll()

    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        Fixing = false
        return
    end

    hum.AutoRotate = true
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

    local function antiForcedSit()
        if hum and hum.Parent then
            if hum:GetState() ~= Enum.HumanoidStateType.Jumping and hum:GetState() ~= Enum.HumanoidStateType.Freefall and hum:GetState() ~= Enum.HumanoidStateType.Swimming then
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

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.3)
    fixMovement()
end)

if LocalPlayer.Character then
    task.wait(0.3)
    fixMovement()
end

-- ===========================================
-- 🎬 شاشة البداية
-- ===========================================

task.spawn(function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui

    local bg = Instance.new("Frame", screenGui)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 1

    local img = Instance.new("ImageLabel", bg)
    img.Size = UDim2.new(1, 0, 1, 0)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://16264019547"
    img.ImageTransparency = 1

    local label = Instance.new("TextLabel", bg)
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 48
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = "Z7F ON TOP"
    label.TextTransparency = 1
    label.TextStrokeTransparency = 0.7
    label.TextScaled = true

    local gradient = Instance.new("UIGradient", label)
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    gradient.Offset = Vector2.new(-1, 0)

    local tweenGlow = TweenService:Create(
        gradient,
        TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
        {Offset = Vector2.new(1, 0)}
    )
    tweenGlow:Play()

    local fadeInTween = TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 0})
    local imgTween = TweenService:Create(img, TweenInfo.new(1.5), {ImageTransparency = 0})
    local labelTween = TweenService:Create(label, TweenInfo.new(1.5), {TextTransparency = 0})

    fadeInTween:Play()
    imgTween:Play()
    labelTween:Play()

    task.delay(5, function()
        local fadeOutTween = TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 1})
        local imgOutTween = TweenService:Create(img, TweenInfo.new(1.5), {ImageTransparency = 1})
        local labelOutTween = TweenService:Create(label, TweenInfo.new(1.5), {TextTransparency = 1})

        fadeOutTween:Play()
        imgOutTween:Play()
        labelOutTween:Play()

        task.delay(1.5, function()
            screenGui:Destroy()
        end)
    end)
end)

-- ===========================================
-- 📢 رسائل الترحيب
-- ===========================================

task.spawn(function()
    task.wait(3)
    local args = {"Z7F ON TOP"}
    pcall(function()
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
    end)
end)

task.delay(15, function()
    local args = {"Z7F~THE~BEST~SCRIPT"}
    pcall(function()
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
    end)
end)

-- ===========================================
-- 🎮 الواجهة الرئيسية (مدمجة وعريضة)
-- ===========================================

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "Z7F_GUI_" .. math.random(1, 999999)

-- الإطار الرئيسي (عريض)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 500, 0, 380) -- عريض وضخم
Frame.Position = UDim2.new(0.5, -250, 0.5, -190)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BackgroundTransparency = 0.2 -- أقل شفافية
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 10)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Thickness = 2
FrameStroke.Color = Color3.fromRGB(50, 50, 50)

-- العنوان الرئيسي
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Z7F ULTIMATE"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

local glowGradientTitle = Instance.new("UIGradient", Title)
glowGradientTitle.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 180, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
glowGradientTitle.Rotation = 45
local glowTweenTitle = TweenService:Create(
    glowGradientTitle,
    TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
    {Offset = Vector2.new(1, 0)}
)
glowGradientTitle.Offset = Vector2.new(-1, 0)
glowTweenTitle:Play()

-- أزرار التنقل (محاذاة جديدة)
local RightsButton = Instance.new("TextButton", Frame)
RightsButton.Size = UDim2.new(0, 90, 0, 30)
RightsButton.Position = UDim2.new(1, -95, 0, 10)
RightsButton.Text = "حـقـوق"
RightsButton.Font = Enum.Font.GothamBold
RightsButton.TextSize = 14
RightsButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
RightsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RightsButton.AutoButtonColor = false
Instance.new("UICorner", RightsButton).CornerRadius = UDim.new(0, 8)

local OtherPageButton = Instance.new("TextButton", Frame)
OtherPageButton.Size = UDim2.new(0, 90, 0, 30)
OtherPageButton.Position = UDim2.new(0.5, -45, 0, 10)
OtherPageButton.Text = "مـيـزات"
OtherPageButton.Font = Enum.Font.GothamBold
OtherPageButton.TextSize = 14
OtherPageButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
OtherPageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OtherPageButton.AutoButtonColor = false
Instance.new("UICorner", OtherPageButton).CornerRadius = UDim.new(0, 8)

local MainPageButton = Instance.new("TextButton", Frame)
MainPageButton.Size = UDim2.new(0, 90, 0, 30)
MainPageButton.Position = UDim2.new(0, 5, 0, 10)
MainPageButton.Text = "اسـتـهـداف"
MainPageButton.Font = Enum.Font.GothamBold
MainPageButton.TextSize = 14
MainPageButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainPageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainPageButton.AutoButtonColor = false
Instance.new("UICorner", MainPageButton).CornerRadius = UDim.new(0, 8)

-- إطارات الصفحات
local MainScrollFrame = Instance.new("ScrollingFrame", Frame)
MainScrollFrame.Size = UDim2.new(1, -10, 1, -55)
MainScrollFrame.Position = UDim2.new(0, 5, 0, 45)
MainScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
MainScrollFrame.ScrollBarThickness = 8
MainScrollFrame.BackgroundTransparency = 1
MainScrollFrame.Active = true
MainScrollFrame.Selectable = true
MainScrollFrame.Visible = true

local OtherScrollFrame = Instance.new("ScrollingFrame", Frame)
OtherScrollFrame.Size = UDim2.new(1, -10, 1, -55)
OtherScrollFrame.Position = UDim2.new(0, 5, 0, 45)
OtherScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
OtherScrollFrame.ScrollBarThickness = 8
OtherScrollFrame.BackgroundTransparency = 1
OtherScrollFrame.Active = true
OtherScrollFrame.Selectable = true
OtherScrollFrame.Visible = false

local RightsScrollFrame = Instance.new("ScrollingFrame", Frame)
RightsScrollFrame.Size = UDim2.new(1, -10, 1, -55)
RightsScrollFrame.Position = UDim2.new(0, 5, 0, 45)
RightsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
RightsScrollFrame.ScrollBarThickness = 8
RightsScrollFrame.BackgroundTransparency = 1
RightsScrollFrame.Active = true
RightsScrollFrame.Selectable = true
RightsScrollFrame.Visible = false

-- ===========================================
-- 🎯 صفحة الاستهداف
-- ===========================================

local PlayerSelector = Instance.new("Frame", MainScrollFrame)
PlayerSelector.Size = UDim2.new(0.96, 0, 0, 140)
PlayerSelector.Position = UDim2.new(0.02, 0, 0, 0)
PlayerSelector.BackgroundTransparency = 1

local MidImage = Instance.new("ImageLabel", PlayerSelector)
MidImage.Size = UDim2.new(0, 60, 0, 60)
MidImage.Position = UDim2.new(0.5, -30, 0, 0)
MidImage.BackgroundTransparency = 1
MidImage.Image = "rbxassetid://7992557358"
Instance.new("UICorner", MidImage).CornerRadius = UDim.new(1, 0)

local PlayerInfo = Instance.new("Frame", PlayerSelector)
PlayerInfo.Size = UDim2.new(1, 0, 0, 70)
PlayerInfo.Position = UDim2.new(0, 0, 0, 65)
PlayerInfo.BackgroundTransparency = 1

local UserLabel = Instance.new("TextLabel", PlayerInfo)
UserLabel.Size = UDim2.new(1, 0, 0.4, 0)
UserLabel.Position = UDim2.new(0, 0, 0, 0)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = "User"
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 18
UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UserLabel.TextXAlignment = Enum.TextXAlignment.Center

local NickLabel = Instance.new("TextLabel", PlayerInfo)
NickLabel.Size = UDim2.new(1, 0, 0.3, 0)
NickLabel.Position = UDim2.new(0, 0, 0.4, 0)
NickLabel.BackgroundTransparency = 1
NickLabel.Text = "NickName"
NickLabel.Font = Enum.Font.Gotham
NickLabel.TextSize = 14
NickLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
NickLabel.TextXAlignment = Enum.TextXAlignment.Center

local NickTextBox = Instance.new("TextBox", PlayerInfo)
NickTextBox.Size = UDim2.new(0.8, 0, 0.5, 0)
NickTextBox.Position = UDim2.new(0.1, 0, 0.7, 0)
NickTextBox.Text = ""
NickTextBox.PlaceholderText = "اكتب اسم اللاعب..."
NickTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
NickTextBox.ClearTextOnFocus = true
NickTextBox.Font = Enum.Font.Gotham
NickTextBox.TextSize = 14
NickTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NickTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NickTextBox.BorderSizePixel = 0
NickTextBox.TextXAlignment = Enum.TextXAlignment.Center
NickTextBox.TextYAlignment = Enum.TextYAlignment.Center
Instance.new("UICorner", NickTextBox).CornerRadius = UDim.new(0, 8)

-- ===========================================
-- 🎮 دالة إنشاء أزرار عامة
-- ===========================================

local function createButton(name, position, width, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(width, 0, 0, 32)
    btn.Position = position
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BackgroundTransparency = 0.4
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

-- ===========================================
-- 🎭 نظام التوهج
-- ===========================================

local function createGlow(button)
    local gradient = Instance.new("UIGradient", button)
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    gradient.Offset = Vector2.new(-1, 0)
    local tween = TweenService:Create(gradient, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1, 0)})
    tween:Play()
    return gradient, tween
end

local function removeGlow(button)
    local gradient = button:FindFirstChildOfClass("UIGradient")
    if gradient then
        gradient:Destroy()
    end
end

local function flashGlow(button, duration)
    local gradient = Instance.new("UIGradient", button)
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    gradient.Offset = Vector2.new(-1, 0)
    local tween = TweenService:Create(gradient, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        gradient:Destroy()
    end)
end

local function updateButtonState(button, active, textOn, textOff)
    if active then
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        button.TextColor3 = Color3.fromRGB(0, 0, 0)
        button.Text = textOn
        createGlow(button)
    else
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = textOff
        removeGlow(button)
    end
end

-- ===========================================
-- 🎯 نظام استهداف اللاعب
-- ===========================================

local targetPlayer = nil
local watchingEnabled = false
local bangActive = false
local faceBangActive = false
local headSitActive = false
local backpackActive = false
local suckActive = false
local benxActive = false

local function GetRoot(plr)
    if plr and plr.Character then
        return plr.Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function setTargetFromText()
    local search = NickTextBox.Text:lower()
    if #search < 2 then
        targetPlayer = nil
        UserLabel.Text = "User"
        NickLabel.Text = "NickName"
        MidImage.Image = "rbxassetid://7992557358"
        return
    end

    for _, plr in pairs(Players:GetPlayers()) do
        local name = plr.Name:lower()
        local nick = plr.DisplayName:lower()
        if string.find(name, search, 1, true) or string.find(nick, search, 1, true) then
            if ProtectedUsers[plr.Name] then
                return
            end
            
            targetPlayer = plr
            UserLabel.Text = plr.Name
            NickLabel.Text = plr.DisplayName
            MidImage.Image = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            
            local thumb = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            createNotification("Z7F SYSTEM","تم استهداف اللاعب "..plr.DisplayName,thumb,5)
            break
        end
    end
end

NickTextBox:GetPropertyChangedSignal("Text"):Connect(setTargetFromText)

-- ===========================================
-- 🎮 أزرار صفحة الاستهداف
-- ===========================================

local startY = 150
local buttonWidth = 0.48
local buttonSpacing = 38

-- الصف الأول
local WatchButton = createButton("مـشـاهـده", UDim2.new(0.02, 0, 0, startY), buttonWidth, MainScrollFrame)
local TeleportButton = createButton("انـتـقـال", UDim2.new(0.51, 0, 0, startY), buttonWidth, MainScrollFrame)

-- الصف الثاني
local BangButton = createButton("بـانـق خـلـفـي", UDim2.new(0.02, 0, 0, startY + buttonSpacing), buttonWidth, MainScrollFrame)
local FaceBangButton = createButton("بـانـق وجـه", UDim2.new(0.51, 0, 0, startY + buttonSpacing), buttonWidth, MainScrollFrame)

-- الصف الثالث
local HeadSitButton = createButton("جـلـوس فـوق راسـه", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 2), buttonWidth, MainScrollFrame)
local BackpackButton = createButton("حـقـيـبـة ظـهـر", UDim2.new(0.51, 0, 0, startY + buttonSpacing * 2), buttonWidth, MainScrollFrame)

-- الصف الرابع
local SuckButton = createButton("مـص قـضـيـبـه", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 3), buttonWidth, MainScrollFrame)
local BenxButton = createButton("يـغـتـصـبـك", UDim2.new(0.51, 0, 0, startY + buttonSpacing * 3), buttonWidth, MainScrollFrame)

-- الصف الخامس
local CopyStrongButton = createButton("نـسـخ قـوي", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 4), buttonWidth, MainScrollFrame)
local CopyFunnyButton = createButton("نـسخ طقطقه", UDim2.new(0.51, 0, 0, startY + buttonSpacing * 4), buttonWidth, MainScrollFrame)

-- الصف السادس
local CopyBeautifulButton = createButton("نـسـخ حـلـو", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 5), buttonWidth, MainScrollFrame)
local CopyExtendButton = createButton("نـسـخ تـطـويـل", UDim2.new(0.51, 0, 0, startY + buttonSpacing * 5), buttonWidth, MainScrollFrame)

-- الصف السابع
local CopyFatButton = createButton("نـسـخ تـسـمـيـن", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 6), buttonWidth, MainScrollFrame)
local CopyThinButton = createButton("نـسـخ تـنـحـيـف", UDim2.new(0.51, 0, 0, startY + buttonSpacing * 6), buttonWidth, MainScrollFrame)

-- الصف الثامن
local CopyAntiHackButton = createButton("نـسـخ رهـيـب", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 7), buttonWidth, MainScrollFrame)
local DoubleReButton = createButton("دبـل ري", UDim2.new(0.51, 0, 0, startY + buttonSpacing * 7), buttonWidth, MainScrollFrame)

-- الصف التاسع
local DoubleAuraButton = createButton("دبل اورا", UDim2.new(0.02, 0, 0, startY + buttonSpacing * 8), buttonWidth, MainScrollFrame)

-- ===========================================
-- 🎮 نظام المشاهدة
-- ===========================================

WatchButton.MouseButton1Click:Connect(function()
    local plr = Players:FindFirstChild(UserLabel.Text)
    if not plr then return end
    if ProtectedUsers[plr.Name] then return end

    if watchingEnabled then
        watchingEnabled = false
        updateButtonState(WatchButton, false, "", "مـشـاهـده")
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
        end
        return
    end

    watchingEnabled = true
    updateButtonState(WatchButton, true, "مـشـاهـده ✅", "")
    if plr.Character then
        local humanoid = plr.Character:FindFirstChild("Humanoid")
        if humanoid then
            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
    plr.CharacterAdded:Connect(function(char)
        if watchingEnabled then
            repeat task.wait() until char:FindFirstChild("Humanoid")
            workspace.CurrentCamera.CameraSubject = char:FindFirstChild("Humanoid")
        end
    end)
end)

-- ===========================================
-- ⚡ نظام الانتقال
-- ===========================================

TeleportButton.MouseButton1Click:Connect(function()
    local plr = Players:FindFirstChild(UserLabel.Text)
    if not plr or not GetRoot(plr) then return end
    if ProtectedUsers[plr.Name] then return end

    local targetPos = GetRoot(plr).Position
    local playerRoot = GetRoot(LocalPlayer)
    if playerRoot then
        playerRoot.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
    end
    flashGlow(TeleportButton, 1)
end)

-- ===========================================
-- 👥 نظام البانق الخلفي
-- ===========================================

local bangHeartbeat = nil

local function startBang()
    if not targetPlayer or not targetPlayer.Character then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    if bangHeartbeat then bangHeartbeat:Disconnect() end
    bangHeartbeat = RunService.Heartbeat:Connect(function()
        if targetPlayer.Character and LocalPlayer.Character then
            local targetTorso = targetPlayer.Character:FindFirstChild("UpperTorso") or targetPlayer.Character:FindFirstChild("Torso")
            local playerHRP = GetRoot(LocalPlayer)
            if targetTorso and playerHRP then
                playerHRP.CFrame = targetTorso.CFrame * CFrame.new(0, 0, 0.70)
            end
        end
    end)
end

local function stopBang()
    if bangHeartbeat then bangHeartbeat:Disconnect() bangHeartbeat = nil end
end

BangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    bangActive = not bangActive
    updateButtonState(BangButton, bangActive, "بـانـق خـلـفـي ✅", "بـانـق خـلـفـي")
    if bangActive then startBang() else stopBang() end
end)

-- ===========================================
-- 😁 نظام البانق الوجهي
-- ===========================================

local faceBangHeartbeat = nil
local currentDistance = 1.5
local movingIn = true
local movementSpeed = 0.5

local function updateFaceBang()
    while faceBangActive do
        if targetPlayer and targetPlayer.Character then
            if ProtectedUsers[targetPlayer.Name] then
                faceBangActive = false
                break
            end
            
            local humanoidRootPart = GetRoot(LocalPlayer)
            local targetHead = targetPlayer.Character:FindFirstChild("Head")
            if humanoidRootPart and targetHead then
                if movingIn then currentDistance = currentDistance - movementSpeed
                else currentDistance = currentDistance + movementSpeed end
                if currentDistance <= 0.5 then movingIn = false end
                if currentDistance >= 2.5 then movingIn = true end
                
                local faceDirection = targetHead.CFrame.LookVector
                local targetPosition = targetHead.Position + (faceDirection * currentDistance)
                targetPosition = Vector3.new(targetPosition.X, targetHead.Position.Y, targetPosition.Z)
                humanoidRootPart.CFrame = CFrame.new(targetPosition, targetHead.Position)
            end
        end
        RunService.Heartbeat:Wait()
    end
end

FaceBangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    faceBangActive = not faceBangActive
    updateButtonState(FaceBangButton, faceBangActive, "بـانـق وجـه ✅", "بـانـق وجـه")
    if faceBangActive then task.spawn(updateFaceBang) else faceBangActive = false end
end)

-- ===========================================
-- 🧑‍🦽 نظام الجلوس فوق الرأس
-- ===========================================

local headSitHeartbeat = nil

local function startHeadSit()
    if not targetPlayer or not targetPlayer.Character then return end
    if ProtectedUsers[targetPlayer.Name] then return end
    
    if headSitHeartbeat then headSitHeartbeat:Disconnect() end
    
    headSitHeartbeat = RunService.Heartbeat:Connect(function()
        pcall(function()
            local plrRoot = GetRoot(LocalPlayer)
            if not plrRoot then return end
            
            local targetHead = targetPlayer.Character:FindFirstChild("Head")
            if not targetHead then return end
            
            LocalPlayer.Character.Humanoid.Sit = true
            plrRoot.CFrame = targetHead.CFrame * CFrame.new(0, 2, 0)
            plrRoot.Velocity = Vector3.new(0, 0, 0)
        end)
    end)
end

local function stopHeadSit()
    if headSitHeartbeat then
        headSitHeartbeat:Disconnect()
        headSitHeartbeat = nil
    end
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Sit = false
    end
end

HeadSitButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    headSitActive = not headSitActive
    updateButtonState(HeadSitButton, headSitActive, "جـلـوس فـوق راسـه ✅", "جـلـوس فـوق راسـه")
    if headSitActive then startHeadSit() else stopHeadSit() end
end)

-- ===========================================
-- 🎒 نظام الحقيبة الظهر
-- ===========================================

local backpackHeartbeat = nil

local function startBackpack()
    if not targetPlayer or not targetPlayer.Character then return end
    if ProtectedUsers[targetPlayer.Name] then return end
    
    if backpackHeartbeat then backpackHeartbeat:Disconnect() end
    
    backpackHeartbeat = RunService.Heartbeat:Connect(function()
        pcall(function()
            local root = GetRoot(LocalPlayer)
            if not root then return end
            
            local target = targetPlayer.Character
            if not target then return end
            
            local targetTorso = target:FindFirstChild("Torso") or target:FindFirstChild("UpperTorso")
            if targetTorso then
                LocalPlayer.Character.Humanoid.Sit = true
                root.CFrame = targetTorso.CFrame * CFrame.new(0, 0.5, 1.2) * CFrame.Angles(0, math.rad(180), 0)
                root.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end)
end

local function stopBackpack()
    if backpackHeartbeat then
        backpackHeartbeat:Disconnect()
        backpackHeartbeat = nil
    end
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Sit = false
    end
end

BackpackButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    backpackActive = not backpackActive
    updateButtonState(BackpackButton, backpackActive, "حـقـيـبـة ظـهـر ✅", "حـقـيـبـة ظـهـر")
    if backpackActive then startBackpack() else stopBackpack() end
end)

-- ===========================================
-- 💦 نظام المص
-- ===========================================

local suckHeartbeat = nil
local currentDistance2 = 1.5
local movingIn2 = true

local function updateSuck()
    while suckActive do
        if targetPlayer and targetPlayer.Character then
            if ProtectedUsers[targetPlayer.Name] then
                suckActive = false
                break
            end
            
            local humanoidRootPart = GetRoot(LocalPlayer)
            local targetHRP = GetRoot(targetPlayer)
            
            if humanoidRootPart and targetHRP then
                if movingIn2 then currentDistance2 = currentDistance2 - movementSpeed
                else currentDistance2 = currentDistance2 + movementSpeed end
                if currentDistance2 <= 0.5 then movingIn2 = false end
                if currentDistance2 >= 2.5 then movingIn2 = true end
                
                local targetPosition = targetHRP.Position - Vector3.new(0, 2, 0) + (targetHRP.CFrame.LookVector * currentDistance2)
                humanoidRootPart.CFrame = CFrame.new(targetPosition, targetHRP.Position - Vector3.new(0, 2, 0))
                humanoidRootPart.Velocity = Vector3.new(0, 2, 0)
            end
        end
        RunService.Heartbeat:Wait()
    end
end

SuckButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    suckActive = not suckActive
    updateButtonState(SuckButton, suckActive, "مـص قـضـيـبـه ✅", "مـص قـضـيـبـه")
    if suckActive then task.spawn(updateSuck) else suckActive = false end
end)

-- ===========================================
-- 🔥 نظام الاغتصاب
-- ===========================================

local benxHeartbeat = nil

local function updateBenx()
    while benxActive do
        if targetPlayer and targetPlayer.Character then
            if ProtectedUsers[targetPlayer.Name] then
                benxActive = false
                break
            end
            
            local char = LocalPlayer.Character
            local hrp = GetRoot(LocalPlayer)
            
            if char and hrp and targetPlayer.Character:FindFirstChild("LowerTorso") then
                local patterns = {
                    {offset = Vector3.new(0, 0, -1.3), angle = -1.5},
                    {offset = Vector3.new(0, 0, -1.8), angle = -1.5},
                    {offset = Vector3.new(0, 0, -2.3), angle = -1.5},
                    {offset = Vector3.new(0, 0, -2.8), angle = -1.5},
                    {offset = Vector3.new(0, 0, -2.3), angle = -1.5},
                    {offset = Vector3.new(0, 0, -1.8), angle = -1.5}
                }
                
                for _, pattern in ipairs(patterns) do
                    if not benxActive then break end
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(pattern.offset) * CFrame.Angles(pattern.angle, math.rad(0), 0)
                    char.Humanoid.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    task.wait(0.1)
                end
            end
        end
        task.wait()
    end
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Sit = false
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

BenxButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    benxActive = not benxActive
    updateButtonState(BenxButton, benxActive, "يـغـتـصـبـك ✅", "يـغـتـصـبـك")
    if benxActive then task.spawn(updateBenx) else benxActive = false end
end)

-- ===========================================
-- 📝 أنظمة النسخ الكاملة
-- ===========================================

local copyStrongActive = false
local copyFunnyActive = false
local copyBeautifulActive = false
local copyExtendActive = false
local copyFatActive = false
local copyThinActive = false
local copyAntiHackActive = false
local doubleReActive = false
local doubleAuraActive = false

local function getPlayerPrefix()
    if not targetPlayer then return "" end
    local name = targetPlayer.Name
    if #name >= 3 then return string.sub(name, 1, 3) else return name end
end

-- نسخ قوي
CopyStrongButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyStrongActive = not copyStrongActive
    updateButtonState(CopyStrongButton, copyStrongActive, "نـسـخ قـوي ✅", "نـسـخ قـوي")
    if copyStrongActive then
        local prefix = getPlayerPrefix()
        local args = {
            ". .neon " .. prefix .. " .paint " .. prefix .. " pk .size " .. prefix .. " 3 .height " .. prefix .. " 0.1 .aura " .. prefix .. " .title " .. prefix .. " \217\133\216\175\217\139\216\185\217\137\217\136\216\179\217\139"
        }
        task.spawn(function()
            while copyStrongActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- نسخ طقطقه
CopyFunnyButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyFunnyActive = not copyFunnyActive
    updateButtonState(CopyFunnyButton, copyFunnyActive, "نـسخ طقطقه ✅", "نـسخ طقطقه")
    if copyFunnyActive then
        local prefix = getPlayerPrefix()
        local args = {".dog " .. prefix .. " .jp " .. prefix .. " 0 .titlepk " .. prefix .. " \218\175\217\132\216\168 \217\133\216\183\217\139\217\138\216\185\217\139"}
        task.spawn(function()
            while copyFunnyActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- نسخ حلو
CopyBeautifulButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyBeautifulActive = not copyBeautifulActive
    updateButtonState(CopyBeautifulButton, copyBeautifulActive, "نـسـخ حـلـو ✅", "نـسـخ حـلـو")
    if copyBeautifulActive then
        local prefix = getPlayerPrefix()
        local args = {
            ". .size " .. prefix .. " 3 .height " .. prefix .. " 0.1 .neon " .. prefix .. " .paint " .. prefix .. " pk .sit " .. prefix .. " .jp " .. prefix .. " 0 .aura " .. prefix .. " .fat " .. prefix .. " .titlepk " .. prefix .. " Z7F \217\129\216\173\217\139\217\137\217\132\217\139\217\138\217\139\217\139\217\139\217\139"
        }
        task.spawn(function()
            while copyBeautifulActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- نسخ تطويل
CopyExtendButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyExtendActive = not copyExtendActive
    updateButtonState(CopyExtendButton, copyExtendActive, "نـسـخ تـطـويـل ✅", "نـسـخ تـطـويـل")
    if copyExtendActive then
        local prefix = getPlayerPrefix()
        local args = {". .char " .. prefix .. " .neon " .. prefix .. " .size " .. prefix .. " 3 .sit " .. prefix .. " .jp " .. prefix .. " 0 .height " .. prefix .. " 3 .fast " .. prefix}
        task.spawn(function()
            while copyExtendActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- نسخ تسمين
CopyFatButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyFatActive = not copyFatActive
    updateButtonState(CopyFatButton, copyFatActive, "نـسـخ تـسـمـيـن ✅", "نـسـخ تـسـمـيـن")
    if copyFatActive then
        local prefix = getPlayerPrefix()
        local args = {". .char " .. prefix .. " ardaomeroglucooj .neon " .. prefix .. " .paint " .. prefix .. " pk .sit " .. prefix .. " .jp " .. prefix .. " 0 .fat " .. prefix .. " .thin " .. prefix}
        task.spawn(function()
            while copyFatActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- نسخ تنحيف
CopyThinButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyThinActive = not copyThinActive
    updateButtonState(CopyThinButton, copyThinActive, "نـسـخ تـنـحـيـف ✅", "نـسـخ تـنـحـيـف")
    if copyThinActive then
        local prefix = getPlayerPrefix()
        local args = {".neon " .. prefix .. " .fast " .. prefix .. " .size " .. prefix .. " 2 .paint " .. prefix .. " pk .sit " .. prefix .. " .thin " .. prefix .. " .shine " .. prefix}
        task.spawn(function()
            while copyThinActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- نسخ رهيب
CopyAntiHackButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    copyAntiHackActive = not copyAntiHackActive
    updateButtonState(CopyAntiHackButton, copyAntiHackActive, "نـسـخ رهـيـب ✅", "نـسـخ رهـيـب")
    if copyAntiHackActive then
        local prefix = getPlayerPrefix()
        local args = {".size " .. prefix .. " 3 .height " .. prefix .. " 1 .fat " .. prefix .. " .thin " .. prefix .. " .sit " .. prefix .. " .neon " .. prefix .. " .paint " .. prefix .. " pk"}
        task.spawn(function()
            while copyAntiHackActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(7)
            end
        end)
    end
end)

-- دبل ري
DoubleReButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    doubleReActive = not doubleReActive
    updateButtonState(DoubleReButton, doubleReActive, "دبـل ري ✅", "دبـل ري")
    if doubleReActive then
        local prefix = getPlayerPrefix()
        local args = {".re " .. prefix .. " .re " .. prefix}
        task.spawn(function()
            while doubleReActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(3)
            end
        end)
    end
end)

-- دبل اورا
DoubleAuraButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    if ProtectedUsers[targetPlayer.Name] then return end

    doubleAuraActive = not doubleAuraActive
    updateButtonState(DoubleAuraButton, doubleAuraActive, "دبل اورا ✅", "دبل اورا")
    if doubleAuraActive then
        local prefix = getPlayerPrefix()
        local args = {".aura " .. prefix .. " .aura " .. prefix}
        task.spawn(function()
            while doubleAuraActive do
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(3)
            end
        end)
    end
end)

-- ===========================================
-- 🎨 صفحة الميزات
-- ===========================================

local otherStartY = 20

-- سبام الرسائل
local SpamTextBox = Instance.new("TextBox", OtherScrollFrame)
SpamTextBox.Size = UDim2.new(0.96, 0, 0, 35)
SpamTextBox.Position = UDim2.new(0.02, 0, 0, otherStartY)
SpamTextBox.Text = "اكـتـب هـنـا"
SpamTextBox.ClearTextOnFocus = true
SpamTextBox.Font = Enum.Font.Gotham
SpamTextBox.TextSize = 14
SpamTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpamTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpamTextBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
SpamTextBox.TextXAlignment = Enum.TextXAlignment.Center
SpamTextBox.TextYAlignment = Enum.TextYAlignment.Center
Instance.new("UICorner", SpamTextBox).CornerRadius = UDim.new(0, 6)

local SpamButton = createButton("سـبـام رسـايـل", UDim2.new(0.02, 0, 0, otherStartY + 45), 0.96, OtherScrollFrame)

-- الصف الأول
local AntiKlbButton = createButton("مـضـاد كـلـبـش", UDim2.new(0.02, 0, 0, otherStartY + 85), 0.48, OtherScrollFrame)
local AntiBanqButton = createButton("مـضـاد بـانـق", UDim2.new(0.51, 0, 0, otherStartY + 85), 0.48, OtherScrollFrame)

-- الصف الثاني
local AntiCopyButton = createButton("مـضـاد نـسـخ", UDim2.new(0.02, 0, 0, otherStartY + 125), 0.48, OtherScrollFrame)
local AntiCopyMButton = createButton("مـضـاد نـسـخ (M)", UDim2.new(0.51, 0, 0, otherStartY + 125), 0.48, OtherScrollFrame)

-- الصف الثالث
local RandomSizeButton = createButton("حـجـم عـشـوائـي", UDim2.new(0.02, 0, 0, otherStartY + 165), 0.48, OtherScrollFrame)
local RandomSkinButton = createButton("سـكـن عـشـوائـي", UDim2.new(0.51, 0, 0, otherStartY + 165), 0.48, OtherScrollFrame)

-- الصف الرابع
local AntiAfkButton = createButton("مـضـاد افـك", UDim2.new(0.02, 0, 0, otherStartY + 205), 0.48, OtherScrollFrame)
local CmdNearButton = createButton("اوامـر لـلـقـريـبـيـن", UDim2.new(0.51, 0, 0, otherStartY + 205), 0.48, OtherScrollFrame)

-- الصف الخامس
local PrepButton = createButton("تـجـهـيـز صـمـلـه", UDim2.new(0.02, 0, 0, otherStartY + 245), 0.48, OtherScrollFrame)
local AutoPrepButton = createButton("تـجـهـيـز تـلـقـائـي", UDim2.new(0.51, 0, 0, otherStartY + 245), 0.48, OtherScrollFrame)

-- الصف السادس
local FlyButton = createButton("طـيـران", UDim2.new(0.02, 0, 0, otherStartY + 285), 0.48, OtherScrollFrame)
local NoclipButton = createButton("نـوكـلـيـب", UDim2.new(0.51, 0, 0, otherStartY + 285), 0.48, OtherScrollFrame)

-- الصف السابع
local TeleportToolButton = createButton("اداة تنقل", UDim2.new(0.02, 0, 0, otherStartY + 325), 0.48, OtherScrollFrame)
local SpinButton = createButton("دوران", UDim2.new(0.51, 0, 0, otherStartY + 325), 0.48, OtherScrollFrame)

-- الصف الثامن
local JumpTextBox = Instance.new("TextBox", OtherScrollFrame)
JumpTextBox.Size = UDim2.new(0.48, 0, 0, 32)
JumpTextBox.Position = UDim2.new(0.02, 0, 0, otherStartY + 365)
JumpTextBox.Text = "قوة القفز"
JumpTextBox.Font = Enum.Font.Gotham
JumpTextBox.TextSize = 13
JumpTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
JumpTextBox.BorderColor3 = Color3.fromRGB(150, 150, 150)
Instance.new("UICorner", JumpTextBox).CornerRadius = UDim.new(0, 6)
JumpTextBox.ClearTextOnFocus = true

local SpeedTextBox = Instance.new("TextBox", OtherScrollFrame)
SpeedTextBox.Size = UDim2.new(0.48, 0, 0, 32)
SpeedTextBox.Position = UDim2.new(0.51, 0, 0, otherStartY + 365)
SpeedTextBox.Text = "عدد السرعة"
SpeedTextBox.Font = Enum.Font.Gotham
SpeedTextBox.TextSize = 13
SpeedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedTextBox.BorderColor3 = Color3.fromRGB(150, 150, 150)
Instance.new("UICorner", SpeedTextBox).CornerRadius = UDim.new(0, 6)
SpeedTextBox.ClearTextOnFocus = true

-- الصف التاسع
local JumpButton = createButton("قـفـز لـلاعـب", UDim2.new(0.02, 0, 0, otherStartY + 405), 0.48, OtherScrollFrame)
local SpeedButton = createButton("سـرعـه لـلاعـب", UDim2.new(0.51, 0, 0, otherStartY + 405), 0.48, OtherScrollFrame)

-- الصف العاشر
local RejoinButton = createButton("اعـادة دخـول لـسـيـرفـر", UDim2.new(0.02, 0, 0, otherStartY + 445), 0.48, OtherScrollFrame)
local ChangeServerButton = createButton("تـغـيـر الـسـيـرفـر", UDim2.new(0.51, 0, 0, otherStartY + 445), 0.48, OtherScrollFrame)

-- ===========================================
-- 🔧 أنظمة الميزات
-- ===========================================

-- سبام الرسائل
local spamActive = false
local spamLoop = nil

SpamButton.MouseButton1Click:Connect(function()
    spamActive = not spamActive
    
    if spamActive then
        updateButtonState(SpamButton, true, "سـبـام رسـايـل ✅", "سـبـام رسـايـل")
        
        spamLoop = task.spawn(function()
            while spamActive do
                local text = SpamTextBox.Text
                if #text >= 1 then
                    local args = { text }
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args))
                    end)
                end
                task.wait(0.3)
            end
        end)
    else
        updateButtonState(SpamButton, false, "", "سـبـام رسـايـل")
        spamActive = false
        if spamLoop then spamLoop = nil end
    end
end)

-- مضاد كلبش
local antibotActive = false
local antibotLoop = nil

AntiKlbButton.MouseButton1Click:Connect(function()
    antibotActive = not antibotActive
    updateButtonState(AntiKlbButton, antibotActive, "مـضـاد كـلـبـش ✅", "مـضـاد كـلـبـش")
    
    if antibotActive then
        antibotLoop = task.spawn(function()
            local lp = Players.LocalPlayer
            local function fixMovement()
                local char = lp.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum then return end
                hum.AutoRotate = true
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                while hum.Parent and antibotActive do
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                    hum.Sit = true
                    task.wait(0.1)
                end
            end
            lp.CharacterAdded:Connect(function()
                task.wait(0.5)
                fixMovement()
            end)
            if lp.Character then
                task.wait(0.5)
                fixMovement()
            end
        end)
    else
        antibotActive = false
        if antibotLoop then antibotLoop = nil end
    end
end)

-- مضاد بانق
local antibanActive = false
local antibanLoop = nil

AntiBanqButton.MouseButton1Click:Connect(function()
    antibanActive = not antibanActive
    updateButtonState(AntiBanqButton, antibanActive, "مـضـاد بـانـق ✅", "مـضـاد بـانـق")
    
    if antibanActive then
        antibanLoop = task.spawn(function()
            while antibanActive do
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local lastCFrame = hrp.CFrame
                    workspace.FallenPartsDestroyHeight = -1000
                    hrp.CFrame = CFrame.new(Vector3.new(0,-500,0))
                    task.wait(0.7)
                    hrp.CFrame = lastCFrame
                    workspace.FallenPartsDestroyHeight = -500
                end
                task.wait(1)
            end
        end)
    else
        antibanActive = false
        if antibanLoop then antibanLoop = nil end
    end
end)

-- مضاد نسخ
local antiCopyActive = false
local antiCopyLoop = nil

AntiCopyButton.MouseButton1Click:Connect(function()
    antiCopyActive = not antiCopyActive
    updateButtonState(AntiCopyButton, antiCopyActive, "مـضـاد نـسـخ ✅", "مـضـاد نـسـخ")
    
    if antiCopyActive then
        antiCopyLoop = task.spawn(function()
            while antiCopyActive do
                pcall(function()
                    local args1 = {"0.9"}
                    game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer(unpack(args1))
                    local args2 = {" \226\128\152", Color3.new(0, 0, 0), "n"}
                    game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Title"):FireServer(unpack(args2))
                end)
                task.wait(1)
            end
        end)
    else
        antiCopyActive = false
        if antiCopyLoop then antiCopyLoop = nil end
    end
end)

-- مضاد نسخ (M)
local antiCopyMActive = false
local antiCopyMLoop = nil

AntiCopyMButton.MouseButton1Click:Connect(function()
    antiCopyMActive = not antiCopyMActive
    updateButtonState(AntiCopyMButton, antiCopyMActive, "مـضـاد نـسـخ (M) ✅", "مـضـاد نـسـخ (M)")
    
    if antiCopyMActive then
        antiCopyMLoop = task.spawn(function()
            while antiCopyMActive do
                local args = {
                    ".unneon me .unsize me .unaura me .unbox me .untitle me .unpaint .unheight me"
                }
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args))
                end)
                task.wait(5)
            end
        end)
    else
        antiCopyMActive = false
        if antiCopyMLoop then antiCopyMLoop = nil end
    end
end)

-- حجم عشوائي
local randomSizeActive = false
local randomSizeLoop = nil

RandomSizeButton.MouseButton1Click:Connect(function()
    randomSizeActive = not randomSizeActive
    updateButtonState(RandomSizeButton, randomSizeActive, "حـجـم عـشـوائـي ✅", "حـجـم عـشـوائـي")
    
    if randomSizeActive then
        randomSizeLoop = task.spawn(function()
            while randomSizeActive do
                local sizes = {"1", "1.3", "1.7", "1.8", "0.9"}
                for _, s in pairs(sizes) do
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer(s)
                    end)
                    task.wait(0.5)
                end
            end
        end)
    else
        randomSizeActive = false
        if randomSizeLoop then randomSizeLoop = nil end
    end
end)

-- سكن عشوائي
local randomSkinActive = false
local randomSkinLoop = nil

RandomSkinButton.MouseButton1Click:Connect(function()
    randomSkinActive = not randomSkinActive
    updateButtonState(RandomSkinButton, randomSkinActive, "سـكـن عـشـوائـي ✅", "سـكـن عـشـوائـي")
    
    if randomSkinActive then
        randomSkinLoop = task.spawn(function()
            while randomSkinActive do
                local skins = {
                    {2291954878, "n"},
                    {7201145808, "n"},
                    {1306261556, "n"},
                    {5134648287, "n"},
                    {2578699902, "n"},
                    {4294786270, "n"}
                }
                for _, skin in pairs(skins) do
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Char"):FireServer(skin[1], skin[2])
                    end)
                    task.wait(0.5)
                end
            end
        end)
    else
        randomSkinActive = false
        if randomSkinLoop then randomSkinLoop = nil end
    end
end)

-- مضاد افك
local antiAfkActive = false
local antiAfkLoop = nil

AntiAfkButton.MouseButton1Click:Connect(function()
    antiAfkActive = not antiAfkActive
    updateButtonState(AntiAfkButton, antiAfkActive, "مـضـاد افـك ✅", "مـضـاد افـك")
    
    if antiAfkActive then
        antiAfkLoop = game:GetService('Players').LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    else
        if antiAfkLoop then
            antiAfkLoop:Disconnect()
            antiAfkLoop = nil
        end
    end
end)

-- أوامر للقريبين
CmdNearButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Z7F-KING/Z7F/refs/heads/main/5-Cmd"))()
    flashGlow(CmdNearButton, 2)
end)

-- تجهيز صمله
PrepButton.MouseButton1Click:Connect(function()
    local function runPrep()
        local args1 = {".char me ardaomeroglucooj"}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args1))
        wait(0.5)

        local args2 = {"2"}
        game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer(unpack(args2))
        wait(1)

        local args3 = {"3"}
        game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer(unpack(args3))
        wait(0.5)

        local args4 = {".titlebk me 9MLH | \216\181\217\133\217\132\216\169"}
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args4))
        wait(1)
    end
    pcall(runPrep)
    flashGlow(PrepButton, 2)
end)

-- تجهيز تلقائي
local autoPrepActive = false
local autoPrepLoop = nil

AutoPrepButton.MouseButton1Click:Connect(function()
    autoPrepActive = not autoPrepActive
    updateButtonState(AutoPrepButton, autoPrepActive, "تـجـهـيـز تـلـقـائـي ✅", "تـجـهـيـز تـلـقـائـي")
    
    if autoPrepActive then
        autoPrepLoop = task.spawn(function()
            while autoPrepActive do
                local function runAutoPrep()
                    local args1 = {".char me ardaomeroglucooj"}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args1))
                    wait(0.5)

                    local args2 = {"2"}
                    game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer(unpack(args2))
                    wait(1)

                    local args3 = {"3"}
                    game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer(unpack(args3))
                    wait(0.5)

                    local args4 = {".titlebk me 9MLH | \216\181\217\133\217\132\216\169"}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer(unpack(args4))
                    wait(1)
                end
                pcall(runAutoPrep)
                task.wait(6)
            end
        end)
    else
        autoPrepActive = false
        if autoPrepLoop then autoPrepLoop = nil end
    end
end)

-- ===========================================
-- 🚀 أنظمة الحركة
-- ===========================================

-- طيران
local flying = false
local lv, ao
local Speed = 150

local function setupFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    hum.PlatformStand = true
    lv = Instance.new("LinearVelocity")
    lv.MaxForce = math.huge
    lv.Attachment0 = hrp:FindFirstChild("RootRigAttachment")
    lv.Parent = hrp
    ao = Instance.new("AlignOrientation")
    ao.Mode = Enum.OrientationAlignmentMode.OneAttachment
    ao.MaxTorque = math.huge
    ao.Attachment0 = hrp:FindFirstChild("RootRigAttachment")
    ao.Parent = hrp
end

local function stopFly()
    if lv then lv:Destroy() end
    if ao then ao:Destroy() end
    lv, ao = nil, nil
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

RunService.RenderStepped:Connect(function()
    if flying and lv and ao then
        local cam = Workspace.CurrentCamera
        local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
        local mv = controlModule:GetMoveVector()
        ao.CFrame = cam.CFrame
        lv.VectorVelocity = cam.CFrame:VectorToWorldSpace(Vector3.new(mv.X, 0, mv.Z)) * Speed
    end
end)

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    updateButtonState(FlyButton, flying, "طـيـران ✅", "طـيـران")
    if flying then setupFly() else stopFly() end
end)

-- نوكليب
local noclipActive = false
local noclipConnection = nil

local function enableNoclip()
    noclipConnection = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function disableNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
end

NoclipButton.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    updateButtonState(NoclipButton, noclipActive, "نـوكـلـيـب ✅", "نـوكـلـيـب")
    if noclipActive then enableNoclip() else disableNoclip() end
end)

-- أداة تنقل
local tpToolGiven = false
local tpTool = nil
local tpActive = false

local function giveTeleportTool()
    if tpToolGiven then return end
    tpToolGiven = true
    tpTool = Instance.new("Tool")
    tpTool.RequiresHandle = false
    tpTool.CanBeDropped = false
    tpTool.Name = "Z7F | اداة تنقل"
    tpTool.Parent = LocalPlayer.Backpack
    tpTool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        local pos = mouse.Hit.p
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        end)
    end)
end

TeleportToolButton.MouseButton1Click:Connect(function()
    tpActive = not tpActive
    updateButtonState(TeleportToolButton, tpActive, "اداة تنقل ✅", "اداة تنقل")
    if tpActive then giveTeleportTool() else
        if tpTool and tpTool.Parent then
            tpTool:Destroy()
            tpToolGiven = false
            tpTool = nil
        end
    end
end)

-- دوران
local spinActive = false
local spinThread = nil

local function startSpin()
    while spinActive do
        task.wait()
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(55), 0)
        end)
    end
end

SpinButton.MouseButton1Click:Connect(function()
    spinActive = not spinActive
    updateButtonState(SpinButton, spinActive, "دوران ✅", "دوران")
    if spinActive then
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if spinActive then spinThread = task.spawn(startSpin) end
        end)
        spinThread = task.spawn(startSpin)
    else
        spinActive = false
        spinThread = nil
    end
end)

-- ===========================================
-- 📊 أنظمة الإحصائيات
-- ===========================================

JumpButton.MouseButton1Click:Connect(function()
    local jumpVal = tonumber(JumpTextBox.Text)
    if not jumpVal then
        JumpTextBox.Text = "قوة القفز"
        jumpVal = 50
    end
    
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = math.clamp(jumpVal, 1, 5000)
        end
    end
    flashGlow(JumpButton, 1.5)
end)

SpeedButton.MouseButton1Click:Connect(function()
    local speedVal = tonumber(SpeedTextBox.Text)
    if not speedVal then
        SpeedTextBox.Text = "عدد السرعة"
        speedVal = 16
    end
    
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = math.clamp(speedVal, 1, 5000)
        end
    end
    flashGlow(SpeedButton, 1.5)
end)

-- ===========================================
-- 🔄 أنظمة السيرفرات
-- ===========================================

RejoinButton.MouseButton1Click:Connect(function()
    local placeId = game.PlaceId
    local jobId = game.JobId
    TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
    flashGlow(RejoinButton, 1)
end)

ChangeServerButton.MouseButton1Click:Connect(function()
    local placeId = game.PlaceId
    local servers = HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100")).data
    for _, server in ipairs(servers) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
            break
        end
    end
    flashGlow(ChangeServerButton, 1)
end)

-- ===========================================
-- 📄 صفحة الحقوق + زر خاص
-- ===========================================

local function createRightsPage()
    -- العنوان
    local RightsTitle = Instance.new("TextLabel", RightsScrollFrame)
    RightsTitle.Size = UDim2.new(1, 0, 0, 35)
    RightsTitle.Position = UDim2.new(0, 0, 0, 0)
    RightsTitle.BackgroundTransparency = 1
    RightsTitle.Text = "حقـوق الـمـطـور"
    RightsTitle.Font = Enum.Font.GothamBold
    RightsTitle.TextSize = 22
    RightsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    RightsTitle.TextXAlignment = Enum.TextXAlignment.Center

    -- معلومات المطور
    local DeveloperInfo = Instance.new("TextLabel", RightsScrollFrame)
    DeveloperInfo.Size = UDim2.new(0.96, 0, 0, 80)
    DeveloperInfo.Position = UDim2.new(0.02, 0, 0, 45)
    DeveloperInfo.BackgroundTransparency = 1
    DeveloperInfo.Text = "Z7F SCRIPT V9.0.0 FINAL\n✨ شكراً لاستخدامك السكريبت\n© جميع الحقوق محفوظة 2026"
    DeveloperInfo.Font = Enum.Font.Gotham
    DeveloperInfo.TextSize = 16
    DeveloperInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    DeveloperInfo.TextXAlignment = Enum.TextXAlignment.Center
    DeveloperInfo.TextYAlignment = Enum.TextYAlignment.Center
    DeveloperInfo.TextWrapped = true

    -- المطورين
    local FeaturesLabel = Instance.new("TextLabel", RightsScrollFrame)
    FeaturesLabel.Size = UDim2.new(0.96, 0, 0, 30)
    FeaturesLabel.Position = UDim2.new(0.02, 0, 0, 140)
    FeaturesLabel.BackgroundTransparency = 1
    FeaturesLabel.Text = "المطـورين"
    FeaturesLabel.Font = Enum.Font.GothamBold
    FeaturesLabel.TextSize = 18
    FeaturesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FeaturesLabel.TextXAlignment = Enum.TextXAlignment.Center

    local features = {"المطور Z7F", "المطور علاوي", "المساعد لاوي"}

    for i, feature in ipairs(features) do
        local FeatureLabel = Instance.new("TextLabel", RightsScrollFrame)
        FeatureLabel.Size = UDim2.new(0.96, 0, 0, 25)
        FeatureLabel.Position = UDim2.new(0.02, 0, 0, 180 + (i - 1) * 28)
        FeatureLabel.BackgroundTransparency = 1
        FeatureLabel.Text = "• " .. feature
        FeatureLabel.Font = Enum.Font.Gotham
        FeatureLabel.TextSize = 14
        FeatureLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        FeatureLabel.TextXAlignment = Enum.TextXAlignment.Center
    end

    -- زر سري خاص داخل صفحة الحقوق
    local SecretButton = Instance.new("TextButton", RightsScrollFrame)
    SecretButton.Size = UDim2.new(0.8, 0, 0, 40)
    SecretButton.Position = UDim2.new(0.1, 0, 0, 300)
    SecretButton.Text = "🏆 زر سري - اضغط"
    SecretButton.Font = Enum.Font.GothamBold
    SecretButton.TextSize = 18
    SecretButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SecretButton.BackgroundTransparency = 0.4
    SecretButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SecretButton.AutoButtonColor = false
    Instance.new("UICorner", SecretButton).CornerRadius = UDim.new(0, 8)

    SecretButton.MouseButton1Click:Connect(function()
        -- تنفيذ أوامر سريعة
        local function runSecretCommands()
            -- 1. تغيير الحجم
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Size"):FireServer("3")
            end)
            
            -- 2. تغيير السكن
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Char"):FireServer(2291954878, "n")
            end)
            
            -- 3. إرسال رسالة
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SendMessage"):FireServer("Z7F SECRET ACTIVATED!")
            end)
            
            -- 4. تفعيل تأثيرات
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("PrivateCommands"):WaitForChild("Neon"):FireServer("me")
            end)
            
            -- 5. إظهار إشعار
            local thumb = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            createNotification("Z7F SECRET", "تم تفعيل الأوامر السرية!", thumb, 10)
        end
        
        runSecretCommands()
        flashGlow(SecretButton, 2)
        
        -- تأثير توهج مكثف
        local gradient = Instance.new("UIGradient", SecretButton)
        gradient.Rotation = 0
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
        gradient.Offset = Vector2.new(-1, 0)
        local tween = TweenService:Create(gradient, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1, 0)})
        tween:Play()
        
        task.delay(3, function()
            tween:Cancel()
            gradient:Destroy()
        end)
    end)
end
createRightsPage()

-- ===========================================
-- 🔄 نظام تبديل الصفحات
-- ===========================================

local function switchToPage(pageName)
    MainScrollFrame.Visible = false
    OtherScrollFrame.Visible = false
    RightsScrollFrame.Visible = false
    
    MainPageButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    OtherPageButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    RightsButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    MainPageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OtherPageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    RightsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    if pageName == "main" then
        MainScrollFrame.Visible = true
        MainPageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainPageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    elseif pageName == "other" then
        OtherScrollFrame.Visible = true
        OtherPageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OtherPageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    elseif pageName == "rights" then
        RightsScrollFrame.Visible = true
        RightsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        RightsButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    end
end

MainPageButton.MouseButton1Click:Connect(function()
    switchToPage("main")
end)

OtherPageButton.MouseButton1Click:Connect(function()
    switchToPage("other")
end)

RightsButton.MouseButton1Click:Connect(function()
    switchToPage("rights")
end)

-- ===========================================
-- 🎪 نظام السحب والتحريك
-- ===========================================

local dragging = false
local dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    Frame.Position = newPos
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        update(input)
    end
end)

-- زر إخفاء/إظهار النافذة
local ToggleWindowButton = Instance.new("ImageButton", ScreenGui)
ToggleWindowButton.Size = UDim2.new(0, 40, 0, 40)
ToggleWindowButton.Position = UDim2.new(1, -45, 0.5, -20)
ToggleWindowButton.AnchorPoint = Vector2.new(0, 0.5)
ToggleWindowButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleWindowButton.BackgroundTransparency = 0.6
ToggleWindowButton.BorderSizePixel = 2
ToggleWindowButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToggleWindowButton.Image = "rbxassetid://11835491319"
ToggleWindowButton.AutoButtonColor = false
Instance.new("UICorner", ToggleWindowButton).CornerRadius = UDim.new(1, 0)

ToggleWindowButton.MouseButton1Click:Connect(function()
    local newState = not Frame.Visible
    Frame.Visible = newState
end)

-- ===========================================
-- 🚀 تأثير دخول النافذة
-- ===========================================

Frame.Position = UDim2.new(0.5, -250, 1.2, 0)
TweenService:Create(Frame, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -250, 0.5, -190)}):Play()

-- ===========================================
-- 📢 إشعار الديسكورد
-- ===========================================

local discordLink = "https://discord.gg/k3YUvAfnMw"
setclipboard(discordLink)
local thumb = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
createNotification("Z7F SYSTEM", "تم نسخ الدسكورد للحافظة!", thumb, 18)

-- ===========================================
-- 📢 نظام الرسائل التلقائية
-- ===========================================

task.spawn(function()
    while true do
        task.wait(300)
        ReplicatedStorage.Events.SendMessage:FireServer("Z7F ON TOP")
    end
end)

task.spawn(function()
    while true do
        task.wait(1020)
        ReplicatedStorage.Events.SendMessage:FireServer(">UsE Z7F ScRiPt<")
    end
end)

-- ===========================================
-- 🔄 أنظمة إعادة التنشيط
-- ===========================================

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if bangActive then startBang() end
    if faceBangActive then task.spawn(updateFaceBang) end
    if headSitActive then startHeadSit() end
    if backpackActive then startBackpack() end
    if suckActive then task.spawn(updateSuck) end
    if benxActive then task.spawn(updateBenx) end
    if spinActive then spinThread = task.spawn(startSpin) end
    if flying then setupFly() end
    if noclipActive then enableNoclip() end
end)

-- ===========================================
-- 🚫 نظام مراقبة خروج اللاعب
-- ===========================================

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if targetPlayer and leavingPlayer == targetPlayer then
        bangActive = false
        faceBangActive = false
        headSitActive = false
        backpackActive = false
        suckActive = false
        benxActive = false
        
        updateButtonState(BangButton, false, "", "بـانـق خـلـفـي")
        updateButtonState(FaceBangButton, false, "", "بـانـق وجـه")
        updateButtonState(HeadSitButton, false, "", "جـلـوس فـوق راسـه")
        updateButtonState(BackpackButton, false, "", "حـقـيـبـة ظـهـر")
        updateButtonState(SuckButton, false, "", "مـص قـضـيـبـه")
        updateButtonState(BenxButton, false, "", "يـغـتـصـبـك")
        
        stopBang()
        stopHeadSit()
        stopBackpack()
        
        targetPlayer = nil
        UserLabel.Text = "User"
        NickLabel.Text = "NickName"
        MidImage.Image = "rbxassetid://7992557358"
    end
end)

-- ===========================================
-- 🧹 دالة التنظيف
-- ===========================================

local function cleanup()
    stopBang()
    stopHeadSit()
    stopBackpack()
    stopFly()
    disableNoclip()
    
    if bangHeartbeat then bangHeartbeat:Disconnect() end
    if headSitHeartbeat then headSitHeartbeat:Disconnect() end
    if backpackHeartbeat then backpackHeartbeat:Disconnect() end
    if spamLoop then spamLoop = nil end
    if antibanLoop then antibanLoop = nil end
    if antiCopyLoop then antiCopyLoop = nil end
    if antiCopyMLoop then antiCopyMLoop = nil end
    if randomSizeLoop then randomSizeLoop = nil end
    if randomSkinLoop then randomSkinLoop = nil end
    if antiAfkLoop then antiAfkLoop:Disconnect() end
    
    targetPlayer = nil
end

game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child == ScreenGui then
        cleanup()
    end
end)

game:BindToClose(function()
    cleanup()
end)

-- ===========================================
-- ✅ إشعار البدء
-- ===========================================

task.wait(1.5)
print("=====================================")
print("Z7F Script Loaded Successfully!")
print("Version: 9.0.0 FINAL")
print("Size: ULTRA COMPACT")
print("Developer: Z7F & Alaoui")
print("=====================================")
createNotification("Z7F SYSTEM", "تم تحميل السكربت بنجاح!", thumb, 5)