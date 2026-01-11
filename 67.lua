-- ███████╗███████╗███████╗ ULTIMATE MEGA MERGED SCRIPT v10.0
-- ██╔════╝██╔════╝██╔════╝ Z7F ON TOP - ALL SYSTEMS INTEGRATED
-- ███████╗█████╗  █████╗  © 2024 Z7F - ALL RIGHTS RESERVED
-- ╚════██║██╔══╝  ██╔══╝  ANTI-COPY, ANTI-KILL, ANTI-AFK
-- ███████║██║     ██║     FULL PROTECTION SYSTEMS
-- ╚══════╝╚═╝     ╚═╝     PRODUCTION READY

-- ============================================
-- 🚨 BAN CHECK SYSTEM
-- ============================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local BannedUsers = {["TM_704"]=true,["704_TM"]=true,["704_TMMA1"]=true,["nan_dihanix"]=true,["Si07Ac"]=true,["33yahya"]=true,["m_avig"]=true,["7_rgh1"]=true,["Jdvdhvsbx"]=true}

if BannedUsers[player.Name] then
    local gui = Instance.new("ScreenGui", game.CoreGui)
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
    txt.Text = "عذراً ، لايمكنك تشغيل السكربت لانك من قائمة المحظورين\n\nرسالة من المطور :\n( بنعالي يازبال محروم من سكربتي واحلم انك تشغله ياكلب بنعالي يلا ختفو )"
    while true do wait(1e9) end
    return
end

-- ============================================
-- 🎬 INTRO SCREEN
-- ============================================
local TweenService = game:GetService("TweenService")
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.ResetOnSpawn = false
local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 1
local img = Instance.new("ImageLabel", bg)
img.Size = UDim2.new(1,0,1,0)
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

local sound = Instance.new("Sound", bg)
sound.SoundId = "rbxassetid://14145620056"
sound:Play()
TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(img, TweenInfo.new(1.5), {ImageTransparency = 0}):Play()
TweenService:Create(label, TweenInfo.new(1.5), {TextTransparency = 0}):Play()

spawn(function()
    wait(5)
    TweenService:Create(bg, TweenInfo.new(1.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(img, TweenInfo.new(1.5), {ImageTransparency = 1}):Play()
    TweenService:Create(label, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
    wait(1.5)
    screenGui:Destroy()
end)

-- ============================================
-- 🛡️ ANTI-MOVEMENT SYSTEM
-- ============================================
local Fixing = false
local Connections = {}
local function DisconnectAll()
    for _, c in pairs(Connections) do if c.Connected then c:Disconnect() end end
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
        if hum and hum.Parent and hum:GetState() ~= Enum.HumanoidStateType.Jumping and hum:GetState() ~= Enum.HumanoidStateType.Freefall and hum:GetState() ~= Enum.HumanoidStateType.Swimming then
            hum.Sit = true
        end
    end
    
    local RunService = game:GetService("RunService")
    Connections["HB"] = RunService.Heartbeat:Connect(antiForcedSit)
    Connections["Sit"] = hum:GetPropertyChangedSignal("Sit"):Connect(antiForcedSit)
    spawn(function() while hum and hum.Parent do antiForcedSit() wait(0.05) end end)
    Fixing = false
end

player.CharacterAdded:Connect(function() wait(0.3) fixMovement() end)
if player.Character then wait(0.3) fixMovement() end

-- ============================================
-- 📜 PROTECTED USERS SYSTEM
-- ============================================
local ProtectedUsers = {["1il5f"]=true,["1il5i"]=true,["sj3zx"]=true,["awr_9351156"]=true,["eyad51533"]=true,["ababahbada"]=true,["JP_EB15"]=true,["noor105320"]=true}
local function IsProtectedUserInServer(name)
    for _,plr in ipairs(Players:GetPlayers()) do if plr.Name:lower() == name:lower() then return true end end
    return false
end

local function ShowProtectedMessage(username)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.ResetOnSpawn = false
    local frameWidth = 200 + math.clamp(#username*8,0,200)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, frameWidth,0,70)
    frame.Position = UDim2.new(1, frameWidth,1,-120)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BackgroundTransparency = 0.4
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)
    
    local icon = Instance.new("ImageLabel", frame)
    icon.Size = UDim2.new(0,55,0,55)
    icon.Position = UDim2.new(0,8,0.5,-27)
    icon.Image = "rbxassetid://13722469288"
    
    local txt = Instance.new("TextLabel", frame)
    txt.Size = UDim2.new(1, -70,1,0)
    txt.Position = UDim2.new(0, 68,0,0)
    txt.Text = "الاعب ("..username..") محمي من مطور السكربت"
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 18
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    
    TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1,-frameWidth,1,-120)}):Play()
    spawn(function() wait(7) TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, frameWidth,1,-120)}):Play() wait(0.5) gui:Destroy() end)
end

_G.IsProtected = function(target)
    if not target then return false end
    target = target:lower()
    if #target < 2 then return false end
    for uname,_ in pairs(ProtectedUsers) do
        if IsProtectedUserInServer(uname) then
            if uname:lower():find(target) then ShowProtectedMessage(uname) return true end
            local pl = Players:FindFirstChild(uname)
            if pl and pl.DisplayName:lower():find(target) then ShowProtectedMessage(uname) return true end
        end
    end
    return false
end

_G.ProtectToolClick = function(target) return _G.IsProtected(target) end

-- ============================================
-- 🎮 MAIN GUI CREATION
-- ============================================
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Z7F_UI"
ScreenGui.ResetOnSpawn = false

-- Create Main Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 340, 0, 240)
Frame.Position = UDim2.new(0.5, -170, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
Frame.BackgroundTransparency = 0.4
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,15)
Instance.new("UIStroke", Frame).Thickness = 2

-- Shadow
local Shadow = Instance.new("ImageLabel", Frame)
Shadow.AnchorPoint = Vector2.new(0.5,0.5)
Shadow.Position = UDim2.new(0.5,0,0.5,0)
Shadow.Size = UDim2.new(1,40,1,40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency = 0.5

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,10)
Title.BackgroundTransparency = 1
Title.Text = "Z7F"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.TextColor3 = Color3.fromRGB(255,255,255)

-- Title Glow
local glowGradientTitle = Instance.new("UIGradient", Title)
glowGradientTitle.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180,180,180)),ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))}
glowGradientTitle.Rotation = 45
glowGradientTitle.Offset = Vector2.new(-1,0)
TweenService:Create(glowGradientTitle, TweenInfo.new(1.2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1,true),{Offset = Vector2.new(1,0)}):Play()

-- Page Toggle Button
local PageToggle = Instance.new("TextButton", Frame)
PageToggle.Size = UDim2.new(0, 80, 0, 25)
PageToggle.Position = UDim2.new(1, -85, 0, 10)
PageToggle.Text = "حقوق"
PageToggle.Font = Enum.Font.GothamBold
PageToggle.TextSize = 14
PageToggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
PageToggle.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", PageToggle).CornerRadius = UDim.new(0,8)

-- Main Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame", Frame)
ScrollFrame.Size = UDim2.new(1,0,1,-50)
ScrollFrame.Position = UDim2.new(0,0,0,50)
ScrollFrame.CanvasSize = UDim2.new(0,0,0,820)
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Active = true

-- Rights Scroll Frame
local RightsScrollFrame = Instance.new("ScrollingFrame", Frame)
RightsScrollFrame.Size = UDim2.new(1,0,1,-50)
RightsScrollFrame.Position = UDim2.new(0,0,0,50)
RightsScrollFrame.CanvasSize = UDim2.new(0,0,0,500)
RightsScrollFrame.ScrollBarThickness = 8
RightsScrollFrame.BackgroundTransparency = 1
RightsScrollFrame.Active = true
RightsScrollFrame.Visible = false

-- Player Image
local MidImage = Instance.new("ImageLabel", ScrollFrame)
MidImage.Size = UDim2.new(0,80,0,80)
MidImage.Position = UDim2.new(0.5,-40,0,0)
MidImage.BackgroundTransparency = 1
MidImage.Image = "rbxassetid://7992557358"
Instance.new("UICorner", MidImage).CornerRadius = UDim.new(1,0)

-- Text Container
local TextContainer = Instance.new("Frame", ScrollFrame)
TextContainer.Size = UDim2.new(1,0,0,80)
TextContainer.Position = UDim2.new(0,0,0,80)
TextContainer.BackgroundTransparency = 1

-- User Label
local UserLabel = Instance.new("TextLabel", TextContainer)
UserLabel.Size = UDim2.new(1,0,0.3,0)
UserLabel.Text = "User"
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 22
UserLabel.TextColor3 = Color3.fromRGB(255,255,255)
UserLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Nick Label
local NickLabel = Instance.new("TextLabel", TextContainer)
NickLabel.Size = UDim2.new(1,0,0.3,0)
NickLabel.Position = UDim2.new(0,0,0.3,0)
NickLabel.Text = "NickName"
NickLabel.Font = Enum.Font.Gotham
NickLabel.TextSize = 18
NickLabel.TextColor3 = Color3.fromRGB(180,180,180)
NickLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Text Box
local NickTextBox = Instance.new("TextBox", TextContainer)
NickTextBox.Size = UDim2.new(0.8,0,0.4,0)
NickTextBox.Position = UDim2.new(0.1,0,0.6,0)
NickTextBox.Text = ""
NickTextBox.PlaceholderText = "لقب/يوزر"
NickTextBox.Font = Enum.Font.Gotham
NickTextBox.TextSize = 18
NickTextBox.TextColor3 = Color3.fromRGB(255,255,255)
NickTextBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
NickTextBox.BorderColor3 = Color3.fromRGB(100,100,100)
NickTextBox.TextXAlignment = Enum.TextXAlignment.Center
NickTextBox.TextYAlignment = Enum.TextYAlignment.Center
Instance.new("UICorner", NickTextBox).CornerRadius = UDim.new(0,8)

-- ======================== جميع الأزرار ========================
local function createButton(name, text, positionX, positionY, parent)
    local button = Instance.new("TextButton", parent)
    button.Name = name
    button.Size = UDim2.new(0.42,0,0,36)
    button.Position = UDim2.new(positionX,0,positionY,0)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.BackgroundColor3 = Color3.fromRGB(25,25,25)
    button.BackgroundTransparency = 0.5
    button.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)
    return button
end

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

-- Top Image
local TopImage = Instance.new("ImageLabel", ScreenGui)
TopImage.Size = UDim2.new(0,80,0,80)
TopImage.BackgroundTransparency = 1
TopImage.ZIndex = 4
TopImage.Image = "rbxassetid://11835491319"
Instance.new("UICorner", TopImage).CornerRadius = UDim.new(1,0)

local topImageOffset = Vector2.new(120,-60)
local function updateTopImagePosition()
    TopImage.Position = UDim2.new(0.5, topImageOffset.X + (Frame.Position.X.Offset + Frame.Size.X.Offset/2 - 170),
                                0.5, topImageOffset.Y + (Frame.Position.Y.Offset + Frame.Size.Y.Offset/2 - 120))
end
updateTopImagePosition()

-- Toggle Window Button
local ToggleWindowButton = Instance.new("ImageButton", ScreenGui)
ToggleWindowButton.Size = UDim2.new(0,50,0,50)
ToggleWindowButton.Position = UDim2.new(1,-60,0.5,-25)
ToggleWindowButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
ToggleWindowButton.BackgroundTransparency = 0.6
ToggleWindowButton.BorderSizePixel = 2
ToggleWindowButton.BorderColor3 = Color3.fromRGB(0,0,0)
ToggleWindowButton.Image = "rbxassetid://11835491319"
Instance.new("UICorner", ToggleWindowButton).CornerRadius = UDim.new(1,0)

-- ======================== أنظمة النسخ المتقدمة ========================
local copyStrongActive, copyFunnyActive, copyStrong2Active, copyBeautifulActive = false, false, false, false
local copyExtendActive, copyFatActive, copyThinActive, copyAntiHackActive = false, false, false, false
local doubleReActive, doubleAuraActive = false, false

local function createGlow(button)
    local gradient = Instance.new("UIGradient", button)
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,200,200)),ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))})
    gradient.Offset = Vector2.new(-1,0)
    local tween = TweenService:Create(gradient, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1,0)})
    tween:Play()
    return gradient, tween
end

-- ======================== نظام TARGET PLAYER ========================
local targetPlayer = nil
local watching = nil
local watchingEnabled = false
local bangActive, faceBangActive, headSitActive, backpackActive, suckActive, benxActive = false, false, false, false, false, false
local selectToolActive, antiAFKActive, antiCopyActive, antiKillActive = false, false, false, false

local function GetRoot(plr)
    return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
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
    
    if _G.IsProtected(search) then
        NickTextBox.Text = ""
        return
    end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if string.find(plr.Name:lower(), search, 1, true) or string.find(plr.DisplayName:lower(), search, 1, true) then
            targetPlayer = plr
            UserLabel.Text = plr.Name
            NickLabel.Text = plr.DisplayName
            local success, result = pcall(function() return Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) end)
            if success then MidImage.Image = result end
            break
        end
    end
end

NickTextBox:GetPropertyChangedSignal("Text"):Connect(setTargetFromText)

-- ======================== WATCH SYSTEM ========================
local function applyWatching(plr)
    if not plr or not plr.Character then return end
    local humanoid = plr.Character:FindFirstChild("Humanoid")
    if humanoid then workspace.CurrentCamera.CameraSubject = humanoid end
    plr.CharacterAdded:Connect(function(char)
        if watchingEnabled then repeat wait() until char:FindFirstChild("Humanoid") workspace.CurrentCamera.CameraSubject = char:FindFirstChild("Humanoid") end
    end)
end

WatchButton.MouseButton1Click:Connect(function()
    local plr = Players:FindFirstChild(UserLabel.Text)
    if not plr then return end
    watchingEnabled = not watchingEnabled
    if watchingEnabled then
        WatchButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(WatchButton)
        applyWatching(plr)
    else
        WatchButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if WatchButton:FindFirstChildOfClass("UIGradient") then WatchButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        if player.Character and player.Character:FindFirstChild("Humanoid") then workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid") end
    end
end)

-- ======================== TELEPORT SYSTEM ========================
TeleportButton.MouseButton1Click:Connect(function()
    local plr = Players:FindFirstChild(UserLabel.Text)
    if not plr or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
    local targetPos = plr.Character.HumanoidRootPart.Position
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0,3,0)) end
end)

-- ======================== BANG SYSTEM ========================
local bangHeartbeat = nil
local bangAnimationId = "10714068222"
local function playBangAnimation()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do track:Stop() end
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
    bangHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
        if targetPlayer.Character and player.Character then
            local targetTorso = targetPlayer.Character:FindFirstChild("UpperTorso") or targetPlayer.Character:FindFirstChild("Torso")
            local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if targetTorso and playerHRP then playerHRP.CFrame = targetTorso.CFrame * CFrame.new(0, 0, 0.70) end
        end
    end)
end

local function stopBang()
    if bangHeartbeat then bangHeartbeat:Disconnect() bangHeartbeat = nil end
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do track:Stop() end end
end

BangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    bangActive = not bangActive
    if bangActive then
        BangButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(BangButton)
        startBang()
    else
        BangButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if BangButton:FindFirstChildOfClass("UIGradient") then BangButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        stopBang()
    end
end)

-- ======================== FACE BANG SYSTEM ========================
local suckAnimTrack = nil
local currentDistance = 1.5
local movingIn = true
local movementSpeed = 0.5
local minDistance = 0.5
local maxDistance = 2.5

local function updateFaceBang()
    while faceBangActive do
        local localChar = player.Character
        if not localChar then wait() continue end
        
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
        wait()
    end

    local localChar = player.Character
    if localChar then
        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Sit = false end
    end
    if suckAnimTrack then suckAnimTrack:Stop() suckAnimTrack = nil end
end

FaceBangButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    faceBangActive = not faceBangActive
    if faceBangActive then
        FaceBangButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(FaceBangButton)
        spawn(updateFaceBang)
    else
        FaceBangButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if FaceBangButton:FindFirstChildOfClass("UIGradient") then FaceBangButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        faceBangActive = false
    end
end)

-- ======================== HEAD SIT SYSTEM ========================
local headSitHeartbeat = nil

local function startHeadSit()
    if not targetPlayer or not targetPlayer.Character then return end
    if headSitHeartbeat then headSitHeartbeat:Disconnect() end
    
    headSitHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
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
    if plrRoot and plrRoot:FindFirstChild("BreakVelocity") then plrRoot.BreakVelocity:Destroy() end
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.Sit = false end
end

HeadSitButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    headSitActive = not headSitActive
    if headSitActive then
        HeadSitButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(HeadSitButton)
        startHeadSit()
    else
        HeadSitButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if HeadSitButton:FindFirstChildOfClass("UIGradient") then HeadSitButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        stopHeadSit()
    end
end)

-- ======================== BACKPACK SYSTEM ========================
local backpackHeartbeat = nil

local function startBackpack()
    if not targetPlayer or not targetPlayer.Character then return end
    if backpackHeartbeat then backpackHeartbeat:Disconnect() end

    backpackHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
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
    if root and root:FindFirstChild("BreakVelocity") then root.BreakVelocity:Destroy() end
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.Sit = false end
end

BackpackButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    backpackActive = not backpackActive
    if backpackActive then
        BackpackButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(BackpackButton)
        startBackpack()
    else
        BackpackButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if BackpackButton:FindFirstChildOfClass("UIGradient") then BackpackButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        stopBackpack()
    end
end)

-- ======================== SUCK SYSTEM ========================
local suckAnimTrack2 = nil
local currentDistance2 = 1.5
local movingIn2 = true
local verticalOffset2 = 2

local function updateSuck()
    while suckActive do
        local localChar = player.Character
        if not localChar then wait() continue end

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
        wait()
    end

    local localChar = player.Character
    if localChar then
        local humanoid = localChar:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Sit = false end
    end
    if suckAnimTrack2 then suckAnimTrack2:Stop() suckAnimTrack2 = nil end
end

SuckButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    suckActive = not suckActive
    if suckActive then
        SuckButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(SuckButton)
        spawn(updateSuck)
    else
        SuckButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if SuckButton:FindFirstChildOfClass("UIGradient") then SuckButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        suckActive = false
    end
end)

-- ======================== BENX SYSTEM ========================
getgenv().Benx = false

local function startBenx()
    if not targetPlayer or not targetPlayer.Character then return end
    benxActive = true
    getgenv().Benx = true

    spawn(function()
        repeat
            wait()
            pcall(function()
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")

                if hrp and hum and targetPlayer.Character and targetPlayer.Character:FindFirstChild("LowerTorso") then
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                    wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.8) * CFrame.Angles(-1.5, math.rad(0), 0)
                    wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                    wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.8) * CFrame.Angles(-1.5, math.rad(0), 0)
                    wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                    wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.8) * CFrame.Angles(-1.5, math.rad(0), 0)
                    wait()
                    hum.Sit = true
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    
                    hrp.CFrame = targetPlayer.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.3) * CFrame.Angles(-1.5, math.rad(0), 0)
                end
            end)
        until not benxActive or not getgenv().Benx

        pcall(function()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").Sit = false
                player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end)
end

local function stopBenx()
    benxActive = false
    getgenv().Benx = false
end

BenxButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    benxActive = not benxActive
    if benxActive then
        BenxButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        createGlow(BenxButton)
        startBenx()
    else
        BenxButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        if BenxButton:FindFirstChildOfClass("UIGradient") then BenxButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        stopBenx()
    end
end)

-- ======================== SELECT TOOL SYSTEM ========================
local function createSelectTool()
    local backpack = player:WaitForChild("Backpack")
    local oldTool = backpack:FindFirstChild("SELECT")
    if oldTool then oldTool:Destroy() end
    
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
        if not target then return end
        
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
            if _G.ProtectToolClick(selectedPlayer.Name) then return end
            targetPlayer = selectedPlayer
            UserLabel.Text = selectedPlayer.Name
            NickLabel.Text = selectedPlayer.DisplayName
            local success, result = pcall(function() return Players:GetUserThumbnailAsync(selectedPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) end)
            if success then MidImage.Image = result end
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
    else
        SelectToolButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if SelectToolButton:FindFirstChildOfClass("UIGradient") then SelectToolButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        local backpack = player:WaitForChild("Backpack")
        local oldTool = backpack:FindFirstChild("SELECT")
        if oldTool then oldTool:Destroy() end
    end
end)

-- ======================== HANDCUFF SYSTEM ========================
HandcuffButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    local char = player.Character
    if not char then return end

    local toolNames = {"كلبشه","كلبشة","كلبش عيد الرعب","كلبشة الملاك","كلبش","كلبشة سبونج بوب","كلبشة ذهبيه","كلبشه ذهبيبه","كلبشة ملاك"}
    local function isWantedTool(tool)
        local name = tool.Name:lower()
        for _, n in ipairs(toolNames) do if string.find(name, n) then return true end end
        if string.find(name, "handcuff") or string.find(name, "cuff") then return true end
        return false
    end

    local tool
    for _, item in ipairs(player.Backpack:GetChildren()) do if isWantedTool(item) then tool = item break end end
    if not tool then for _, item in ipairs(char:GetChildren()) do if item:IsA("Tool") and isWantedTool(item) then tool = item break end end end
    if not tool then return end

    tool.Parent = char
    local remoteName = "كلبشه"
    local remoteFolder = char:FindFirstChild(remoteName)
    if remoteFolder and remoteFolder:FindFirstChild("RemoteEvent") then
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then remoteFolder.RemoteEvent:FireServer(targetHRP) end
    end
end)

-- ======================== FREEZE SYSTEM ========================
FreezeButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    local char = player.Character
    if not char then return end

    local toolNames = {"كلبشه","كلبشة","كلبش عيد الرعب","كلبشة الملاك","كلبش","كلبشة سبونج بوب","كلبشة ذهبيه","كلبشه ذهبيبه","كلبشة ملاك"}
    local function isWantedTool(tool)
        local name = tool.Name:lower()
        for _, n in ipairs(toolNames) do if string.find(name, n) then return true end end
        if string.find(name, "handcuff") or string.find(name, "cuff") then return true end
        return false
    end

    local tool
    for _, item in ipairs(player.Backpack:GetChildren()) do if isWantedTool(item) then tool = item break end end
    if not tool then for _, item in ipairs(char:GetChildren()) do if item:IsA("Tool") and isWantedTool(item) then tool = item break end end end
    if not tool then return end

    tool.Parent = char
    local remoteName = "كلبشه"
    local remoteFolder = char:FindFirstChild(remoteName)
    if remoteFolder and remoteFolder:FindFirstChild("RemoteEvent") then
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then remoteFolder.RemoteEvent:FireServer(targetHRP) end
    end

    wait(0.5)
    pcall(function() game:GetService("ReplicatedStorage").Events.SendMessage:FireServer(".char") end)
    wait(0.3)
    pcall(function() game:GetService("ReplicatedStorage").Events.SendMessage:FireServer(".unchar") end)
end)

-- ======================== ANTI-BANG (FAST FALL) ========================
AntiBangButton.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local lastCFrame = hrp.CFrame
        hrp.CFrame = CFrame.new(0, -500, 0)
        wait(0.7)
        hrp.CFrame = lastCFrame
    end
end)

-- ======================== COPY SYSTEMS ========================
-- Copy Strong System
local function startCopyStrong()
    if not targetPlayer then return end
    while copyStrongActive and targetPlayer do
        local plrName = targetPlayer.Name
        local prefix = #plrName >= 3 and string.sub(plrName,1,3) or plrName
        local args = {". .neon "..prefix.." .paint "..prefix.." pk .size "..prefix.." 3 .height "..prefix.." 0.1 .aura "..prefix.." .title "..prefix.." تم النسخ بواسطة Z7F"}
        pcall(function()
            local hdadmin = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdminHDClient")
            if hdadmin then
                local signals = hdadmin:FindFirstChild("Signals")
                if signals then
                    local request = signals:FindFirstChild("RequestCommandSilent")
                    if request then request:InvokeServer(unpack(args)) end
                end
            end
        end)
        wait(7)
    end
end

CopyStrongButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyStrongActive = not copyStrongActive
    if copyStrongActive then
        CopyStrongButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyStrongButton)
        spawn(startCopyStrong)
    else
        CopyStrongButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyStrongButton:FindFirstChildOfClass("UIGradient") then CopyStrongButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyStrongActive = false
    end
end)

-- Copy Funny System
local function startCopyFunny()
    if not targetPlayer then return end
    while copyFunnyActive and targetPlayer do
        local plrName = targetPlayer.Name
        local prefix = #plrName >= 5 and string.sub(plrName,1,3) or plrName
        local args = {".dog "..prefix.." .jp "..prefix.." 0 .titlepk "..prefix.." \218\175\217\132\216\168 \217\133\216\183\217\139\217\138\216\185\217\139"}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyFunnyButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyFunnyActive = not copyFunnyActive
    if copyFunnyActive then
        CopyFunnyButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyFunnyButton)
        spawn(startCopyFunny)
    else
        CopyFunnyButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyFunnyButton:FindFirstChildOfClass("UIGradient") then CopyFunnyButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyFunnyActive = false
    end
end)

-- Copy Strong 2 System
local function startCopyStrong2()
    if not targetPlayer then return end
    while copyStrong2Active and targetPlayer do
        local plrName = targetPlayer.Name
        local prefix = #plrName >= 5 and string.sub(plrName,1,3) or plrName
        local args = {".size "..prefix.." 3 .fat "..prefix.." .box "..prefix.." .sit "..prefix.." .neon "..prefix.." .paint "..prefix.." pk .shine "..prefix.." .titlepk "..prefix.." \217\133\217\139\217\137\216\175\217\139\216\185\217\137\217\136\217\139\216\179\217\145"}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyStrong2Button.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyStrong2Active = not copyStrong2Active
    if copyStrong2Active then
        CopyStrong2Button.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyStrong2Button)
        spawn(startCopyStrong2)
    else
        CopyStrong2Button.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyStrong2Button:FindFirstChildOfClass("UIGradient") then CopyStrong2Button:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyStrong2Active = false
    end
end)

-- Copy Beautiful System
local function startCopyBeautiful()
    if not targetPlayer then return end
    while copyBeautifulActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,3)) or name
        local args = {". .size "..prefix.." 3 .height "..prefix.." 0.1 .neon "..prefix.." .paint "..prefix.." pk .sit "..prefix.." .jp "..prefix.." 0 .aura "..prefix.." .fat "..prefix.." .titlepk "..prefix.." Z7F \217\129\216\173\217\139\217\137\217\132\217\139\217\138\217\139\217\139\217\139"}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyBeautifulButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyBeautifulActive = not copyBeautifulActive
    if copyBeautifulActive then
        CopyBeautifulButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyBeautifulButton)
        spawn(startCopyBeautiful)
    else
        CopyBeautifulButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyBeautifulButton:FindFirstChildOfClass("UIGradient") then CopyBeautifulButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyBeautifulActive = false
    end
end)

-- Copy Extend System
local function startCopyExtend()
    if not targetPlayer then return end
    while copyExtendActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name
        local args = {". .char "..prefix.." .neon "..prefix.." .size "..prefix.." 3 .sit "..prefix.." .jp "..prefix.." 0 .height "..prefix.." 3 .fast "..prefix}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyExtendButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyExtendActive = not copyExtendActive
    if copyExtendActive then
        CopyExtendButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyExtendButton)
        spawn(startCopyExtend)
    else
        CopyExtendButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyExtendButton:FindFirstChildOfClass("UIGradient") then CopyExtendButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyExtendActive = false
    end
end)

-- Copy Fat System
local function startCopyFat()
    if not targetPlayer then return end
    while copyFatActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name
        local args = {". .char "..prefix.." ardaomeroglucooj .neon "..prefix.." .paint "..prefix.." pk .sit "..prefix.." .jp "..prefix.." 0 .fat "..prefix.." .thin "..prefix}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyFatButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyFatActive = not copyFatActive
    if copyFatActive then
        CopyFatButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyFatButton)
        spawn(startCopyFat)
    else
        CopyFatButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyFatButton:FindFirstChildOfClass("UIGradient") then CopyFatButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyFatActive = false
    end
end)

-- Copy Thin System
local function startCopyThin()
    if not targetPlayer then return end
    while copyThinActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name
        local args = {".neon "..prefix.." .fast "..prefix.." .size "..prefix.." 2 .paint "..prefix.." pk .sit "..prefix.." .thin "..prefix.." .shine "..prefix}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyThinButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyThinActive = not copyThinActive
    if copyThinActive then
        CopyThinButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyThinButton)
        spawn(startCopyThin)
    else
        CopyThinButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyThinButton:FindFirstChildOfClass("UIGradient") then CopyThinButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyThinActive = false
    end
end)

-- Copy Anti Hack System
local function startCopyAntiHack()
    if not targetPlayer then return end
    while copyAntiHackActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,3)) or name
        local args = {".size "..prefix.." 3 .height "..prefix.." 1 .fat "..prefix.." .thin "..prefix.." .sit "..prefix.." .neon "..prefix.." .paint "..prefix.." pk"}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(7)
    end
end

CopyAntiHackButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    copyAntiHackActive = not copyAntiHackActive
    if copyAntiHackActive then
        CopyAntiHackButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(CopyAntiHackButton)
        spawn(startCopyAntiHack)
    else
        CopyAntiHackButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if CopyAntiHackButton:FindFirstChildOfClass("UIGradient") then CopyAntiHackButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        copyAntiHackActive = false
    end
end)

-- Double Re System
local function startDoubleRe()
    if not targetPlayer then return end
    while doubleReActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 5 and string.sub(name,1,4)) or name
        local args = {".re "..prefix.." .re "..prefix}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(3)
    end
end

DoubleReButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    doubleReActive = not doubleReActive
    if doubleReActive then
        DoubleReButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(DoubleReButton)
        spawn(startDoubleRe)
    else
        DoubleReButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if DoubleReButton:FindFirstChildOfClass("UIGradient") then DoubleReButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        doubleReActive = false
    end
end)

-- Double Aura System
local function startDoubleAura()
    if not targetPlayer then return end
    while doubleAuraActive and targetPlayer do
        local name = targetPlayer.Name
        local prefix = (#name >= 3 and string.sub(name,1,3)) or name
        local args = {".aura "..prefix.." .aura "..prefix}
        pcall(function() game:GetService("ReplicatedStorage"):WaitForChild("HDAdminHDClient"):WaitForChild("Signals"):WaitForChild("RequestCommandSilent"):InvokeServer(unpack(args)) end)
        wait(3)
    end
end

DoubleAuraButton.MouseButton1Click:Connect(function()
    if not targetPlayer then return end
    doubleAuraActive = not doubleAuraActive
    if doubleAuraActive then
        DoubleAuraButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(DoubleAuraButton)
        spawn(startDoubleAura)
    else
        DoubleAuraButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if DoubleAuraButton:FindFirstChildOfClass("UIGradient") then DoubleAuraButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        doubleAuraActive = false
    end
end)

-- ======================== ANTI-AFK SYSTEM ========================
local antiAFKConnection = nil
AntiAFKButton.MouseButton1Click:Connect(function()
    antiAFKActive = not antiAFKActive
    if antiAFKActive then
        AntiAFKButton.Text = "مضاد AFK: ✅"
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(AntiAFKButton)
        antiAFKConnection = game:GetService("RunService").Heartbeat:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "S", false, game)
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "S", false, game)
        end)
    else
        AntiAFKButton.Text = "مضاد AFK: ❌"
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if AntiAFKButton:FindFirstChildOfClass("UIGradient") then AntiAFKButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        if antiAFKConnection then antiAFKConnection:Disconnect() antiAFKConnection = nil end
    end
end)

-- ======================== ANTI-COPY SYSTEM ========================
AntiCopyButton.MouseButton1Click:Connect(function()
    antiCopyActive = not antiCopyActive
    if antiCopyActive then
        AntiCopyButton.Text = "مضاد النسخ: ✅"
        AntiCopyButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(AntiCopyButton)
        local antiCopyMeta = {}
        antiCopyMeta.__newindex = function(t, k, v)
            if tostring(k):lower():find("script") or tostring(v):lower():find("z7f") then return end
            rawset(t, k, v)
        end
        setmetatable(_G, antiCopyMeta)
    else
        AntiCopyButton.Text = "مضاد النسخ: ❌"
        AntiCopyButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if AntiCopyButton:FindFirstChildOfClass("UIGradient") then AntiCopyButton:FindFirstChildOfClass("UIGradient"):Destroy() end
        setmetatable(_G, nil)
    end
end)

-- ======================== ANTI-KILL SYSTEM ========================
AntiKillButton.MouseButton1Click:Connect(function()
    antiKillActive = not antiKillActive
    if antiKillActive then
        AntiKillButton.Text = "مضاد القتل: ✅"
        AntiKillButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
        createGlow(AntiKillButton)
        player.CharacterAdded:Connect(function(character)
            wait(1)
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.BreakJointsOnDeath = false
            humanoid.Died:Connect(function()
                wait(3)
                if character and character.Parent then character:BreakJoints() end
            end)
        end)
        if player.Character then
            local humanoid = player.Character:WaitForChild("Humanoid")
            humanoid.BreakJointsOnDeath = false
            humanoid.Died:Connect(function()
                wait(3)
                if player.Character and player.Character.Parent then player.Character:BreakJoints() end
            end)
        end
    else
        AntiKillButton.Text = "مضاد القتل: ❌"
        AntiKillButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
        if AntiKillButton:FindFirstChildOfClass("UIGradient") then AntiKillButton:FindFirstChildOfClass("UIGradient"):Destroy() end
    end
end)

-- ======================== PAGE TOGGLE SYSTEM ========================
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

-- ======================== WINDOW CONTROLS ========================
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

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
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

game:GetService("UserInputService").InputChanged:Connect(function(input)
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

-- ======================== ENTRANCE ANIMATION ========================
Frame.Position = UDim2.new(0.5,-170,1.2,0)
TweenService:Create(Frame, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-170,0.5,-120)}):Play()

-- ======================== CHARACTER EVENTS ========================
player.CharacterAdded:Connect(function()
    wait(0.1)
    if bangActive then startBang() end
    if faceBangActive then spawn(updateFaceBang) end
    if headSitActive then startHeadSit() end
    if backpackActive then startBackpack() end
    if suckActive then spawn(updateSuck) end
    if benxActive then startBenx() end
    fixMovement()
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if targetPlayer and leavingPlayer == targetPlayer then
        bangActive, faceBangActive, headSitActive, backpackActive = false, false, false, false
        suckActive, benxActive = false, false
        copyStrongActive, copyFunnyActive, copyStrong2Active, copyBeautifulActive = false, false, false, false
        copyExtendActive, copyFatActive, copyThinActive, copyAntiHackActive = false, false, false, false
        doubleReActive, doubleAuraActive = false, false
        
        local buttons = {BangButton, FaceBangButton, HeadSitButton, BackpackButton, SuckButton, BenxButton, CopyStrongButton, CopyFunnyButton, CopyStrong2Button, CopyBeautifulButton, CopyExtendButton, CopyFatButton, CopyThinButton, CopyAntiHackButton, DoubleReButton, DoubleAuraButton, HandcuffButton, FreezeButton, SelectToolButton}
        for _, btn in pairs(buttons) do
            if btn then
                btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
                if btn:FindFirstChildOfClass("UIGradient") then btn:FindFirstChildOfClass("UIGradient"):Destroy() end
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
    end
end)

-- ======================== AUTO MESSAGES ========================
spawn(function()
    wait(2)
    pcall(function() game:GetService("ReplicatedStorage").Events.SendMessage:FireServer("Z7F ON TOP") end)
    wait(15)
    pcall(function() game:GetService("ReplicatedStorage").Events.SendMessage:FireServer("Z7F~THE~BEST~SCRIPT") end)
    wait(180)
    local function sendThirdMessage()
        pcall(function() game:GetService("ReplicatedStorage").Events.SendMessage:FireServer("#ScRiPt ! Z7F ! ToP1#") end)
    end
    sendThirdMessage()
    while true do wait(600) sendThirdMessage() end
end)

print("[Z7F Script] Loaded Successfully! Version 10.0 ULTIMATE")
warn("Z7F Script by Z7F ON TOP - All Systems Integrated")

-- ======================== RIGHTS PAGE CONTENT ========================
local function createRightsPage()
    local RightsTitle = Instance.new("TextLabel", RightsScrollFrame)
    RightsTitle.Size = UDim2.new(1,0,0,40)
    RightsTitle.Text = "حقوق المطور"
    RightsTitle.Font = Enum.Font.GothamBold
    RightsTitle.TextSize = 24
    RightsTitle.TextColor3 = Color3.fromRGB(255,255,255)
    RightsTitle.TextXAlignment = Enum.TextXAlignment.Center

    local DeveloperInfo = Instance.new("TextLabel", RightsScrollFrame)
    DeveloperInfo.Size = UDim2.new(0.9,0,0,100)
    DeveloperInfo.Position = UDim2.new(0.05,0,0,50)
    DeveloperInfo.Text = "المطور: Z7F\n\nشكراً لاستخدامك السكريبت\nجميع الحقوق محفوظة © 2024"
    DeveloperInfo.Font = Enum.Font.Gotham
    DeveloperInfo.TextSize = 16
    DeveloperInfo.TextColor3 = Color3.fromRGB(200,200,200)
    DeveloperInfo.TextXAlignment = Enum.TextXAlignment.Center
    DeveloperInfo.TextYAlignment = Enum.TextYAlignment.Center
    DeveloperInfo.TextWrapped = true

    local VersionInfo = Instance.new("TextLabel", RightsScrollFrame)
    VersionInfo.Size = UDim2.new(0.9,0,0,30)
    VersionInfo.Position = UDim2.new(0.05,0,0,170)
    VersionInfo.Text = "الإصدار: 10.0 ULTIMATE"
    VersionInfo.Font = Enum.Font.GothamBold
    VersionInfo.TextSize = 18
    VersionInfo.TextColor3 = Color3.fromRGB(100,200,255)
    VersionInfo.TextXAlignment = Enum.TextXAlignment.Center

    local FeaturesLabel = Instance.new("TextLabel", RightsScrollFrame)
    FeaturesLabel.Size = UDim2.new(0.9,0,0,30)
    FeaturesLabel.Position = UDim2.new(0.05,0,0,220)
    FeaturesLabel.Text = "جميع الميزات المتاحة:"
    FeaturesLabel.Font = Enum.Font.GothamBold
    FeaturesLabel.TextSize = 18
    FeaturesLabel.TextColor3 = Color3.fromRGB(255,255,255)
    FeaturesLabel.TextXAlignment = Enum.TextXAlignment.Center

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
        local FeatureLabel = Instance.new("TextLabel", RightsScrollFrame)
        FeatureLabel.Size = UDim2.new(0.8,0,0,25)
        FeatureLabel.Position = UDim2.new(0.1,0,0,260 + (i-1)*30)
        FeatureLabel.Text = "• " .. feature
        FeatureLabel.Font = Enum.Font.Gotham
        FeatureLabel.TextSize = 14
        FeatureLabel.TextColor3 = Color3.fromRGB(180,180,180)
        FeatureLabel.TextXAlignment = Enum.TextXAlignment.Left
    end
end

createRightsPage()

-- ======================== FINAL INITIALIZATION ========================
wait(1)
print("=====================================")
print("Z7F Script Ready for Use!")
print("Total Features: 15+ Systems")
print("Protection: Anti-Copy, Anti-Kill, Anti-AFK")
print("=====================================")