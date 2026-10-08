-- Si Cút Hub - Liquid Glass UI
-- UI ONLY - không có chức năng exploit/cheat

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local LOGO_ID = "rbxassetid://132011680945971"

local Config = {
    Theme = "Glass",
    GlassOpacity = 0.28,
    TextColor = Color3.fromRGB(240, 247, 255),
    AnimationSpeed = 0.45,
}

local Colors = {
    White = Color3.fromRGB(240,247,255),
    Blue = Color3.fromRGB(75,175,255),
    Blue2 = Color3.fromRGB(35,115,190),
    Glass = Color3.fromRGB(45,65,85),
    GlassDark = Color3.fromRGB(15,27,42),
    Panel = Color3.fromRGB(7,22,40),
    Dark = Color3.fromRGB(3,12,25),
    Gray = Color3.fromRGB(145,165,185),
    Green = Color3.fromRGB(80,220,150),
}

local function Tween(object, duration, properties, style, direction)
    local info = TweenInfo.new(
        duration or Config.AnimationSpeed,
        style or Enum.EasingStyle.Quint,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

local function Corner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = object
    return corner
end

local function AddStroke(object, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Colors.Blue
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = object
    return stroke
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SiCut_LiquidGlass"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Scale = Instance.new("UIScale")
Scale.Scale = 1
Scale.Parent = ScreenGui

local Camera = workspace.CurrentCamera

local function UpdateScale()
    if not Camera then return end
    Scale.Scale = math.clamp(Camera.ViewportSize.X / 1000, 0.58, 1)
end

UpdateScale()
if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0,900,0,555)
Main.Position = UDim2.new(0.5,-450,0.5,-277)
Main.BackgroundColor3 = Colors.Glass
Main.BackgroundTransparency = Config.GlassOpacity
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Corner(Main,20)

local MainStroke = AddStroke(Main, Colors.Blue, 1.5, 0.08)

local GlassGradient = Instance.new("UIGradient")
GlassGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120,190,255)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(55,85,110)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(25,45,65)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75,125,165)),
})
GlassGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,0.75),
    NumberSequenceKeypoint.new(0.45,0.95),
    NumberSequenceKeypoint.new(1,0.78),
})
GlassGradient.Rotation = 25
GlassGradient.Parent = Main

local Shine = Instance.new("Frame")
Shine.Name = "GlassShine"
Shine.Size = UDim2.new(0,180,1,100)
Shine.Position = UDim2.new(-0.25,0,0,0)
Shine.BackgroundColor3 = Color3.fromRGB(190,225,255)
Shine.BackgroundTransparency = 0.94
Shine.BorderSizePixel = 0
Shine.Rotation = 12
Shine.ZIndex = 2
Shine.Parent = Main
local ShineGradient = Instance.new("UIGradient")
ShineGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,1),
    NumberSequenceKeypoint.new(0.5,0.2),
    NumberSequenceKeypoint.new(1,1),
})
ShineGradient.Parent = Shine
Corner(Shine,30)

task.spawn(function()
    while ScreenGui.Parent do
        Shine.Position = UDim2.new(-0.25,0,0,0)
        local tween = Tween(Shine,3.5,{
            Position = UDim2.new(1.2,0,0,0)
        },Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
        tween.Completed:Wait()
        task.wait(1.2)
    end
end)

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0,225,1,0)
Sidebar.BackgroundColor3 = Colors.GlassDark
Sidebar.BackgroundTransparency = math.min(Config.GlassOpacity+0.08,0.9)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main
Corner(Sidebar,20)
AddStroke(Sidebar,Color3.fromRGB(150,205,255),1,0.72)

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0,62,0,62)
Logo.Position = UDim2.new(0,18,0,18)
Logo.BackgroundTransparency = 1
Logo.Image = LOGO_ID
Logo.ScaleType = Enum.ScaleType.Fit
Logo.ZIndex = 8
Logo.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0,125,0,30)
Title.Position = UDim2.new(0,88,0,20)
Title.BackgroundTransparency = 1
Title.Text = "Si cút"
Title.TextColor3 = Config.TextColor
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 8
Title.Parent = Sidebar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0,120,0,20)
Version.Position = UDim2.new(0,89,0,48)
Version.BackgroundTransparency = 1
Version.Text = "BETA V2"
Version.TextColor3 = Colors.Blue
Version.TextSize = 11
Version.Font = Enum.Font.GothamBold
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.ZIndex = 8
Version.Parent = Sidebar

local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Size = UDim2.new(1,-24,0,46)
SettingsButton.Position = UDim2.new(0,12,0,105)
SettingsButton.BackgroundColor3 = Color3.fromRGB(75,120,155)
SettingsButton.BackgroundTransparency = 0.45
SettingsButton.BorderSizePixel = 0
SettingsButton.Text = ""
SettingsButton.AutoButtonColor = false
SettingsButton.ZIndex = 8
SettingsButton.Parent = Sidebar
Corner(SettingsButton,12)
AddStroke(SettingsButton,Colors.Blue,1,0.45)

local SettingsIcon = Instance.new("TextLabel")
SettingsIcon.Size = UDim2.new(0,42,1,0)
SettingsIcon.Position = UDim2.new(0,8,0,0)
SettingsIcon.BackgroundTransparency = 1
SettingsIcon.Text = "⚙"
SettingsIcon.TextColor3 = Colors.Blue
SettingsIcon.TextSize = 20
SettingsIcon.Font = Enum.Font.GothamBold
SettingsIcon.ZIndex = 9
SettingsIcon.Parent = SettingsButton

local SettingsText = Instance.new("TextLabel")
SettingsText.Size = UDim2.new(1,-55,1,0)
SettingsText.Position = UDim2.new(0,52,0,0)
SettingsText.BackgroundTransparency = 1
SettingsText.Text = "Settings"
SettingsText.TextColor3 = Config.TextColor
SettingsText.TextSize = 14
SettingsText.Font = Enum.Font.GothamMedium
SettingsText.TextXAlignment = Enum.TextXAlignment.Left
SettingsText.ZIndex = 9
SettingsText.Parent = SettingsButton

local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(0,44,0,44)
Avatar.Position = UDim2.new(0,16,1,-63)
Avatar.BackgroundColor3 = Color3.fromRGB(50,70,90)
Avatar.BackgroundTransparency = 0.35
Avatar.BorderSizePixel = 0
Avatar.ZIndex = 8
Avatar.Parent = Sidebar
Corner(Avatar,22)
AddStroke(Avatar,Color3.fromRGB(160,210,255),1,0.55)

pcall(function()
    local image = Players:GetUserThumbnailAsync(
        Player.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size100x100
    )
    Avatar.Image = image
end)

local DisplayName = Instance.new("TextLabel")
DisplayName.Size = UDim2.new(0,145,0,20)
DisplayName.Position = UDim2.new(0,69,1,-63)
DisplayName.BackgroundTransparency = 1
DisplayName.Text = Player.DisplayName
DisplayName.TextColor3 = Config.TextColor
DisplayName.TextSize = 13
DisplayName.Font = Enum.Font.GothamBold
DisplayName.TextXAlignment = Enum.TextXAlignment.Left
DisplayName.ZIndex = 8
DisplayName.Parent = Sidebar

local Username = Instance.new("TextLabel")
Username.Size = UDim2.new(0,145,0,18)
Username.Position = UDim2.new(0,69,1,-43)
Username.BackgroundTransparency = 1
Username.Text = "@"..Player.Name
Username.TextColor3 = Colors.Gray
Username.TextSize = 10
Username.Font = Enum.Font.Gotham
Username.TextXAlignment = Enum.TextXAlignment.Left
Username.ZIndex = 8
Username.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1,-225,1,0)
Content.Position = UDim2.new(0,225,0,0)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1,-130,0,40)
Header.Position = UDim2.new(0,30,0,27)
Header.BackgroundTransparency = 1
Header.Text = "Settings"
Header.TextColor3 = Config.TextColor
Header.TextSize = 28
Header.Font = Enum.Font.GothamBold
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.ZIndex = 8
Header.Parent = Content

local Description = Instance.new("TextLabel")
Description.Size = UDim2.new(1,-60,0,25)
Description.Position = UDim2.new(0,30,0,67)
Description.BackgroundTransparency = 1
Description.Text = "Tùy chỉnh giao diện và hiệu ứng kính lỏng."
Description.TextColor3 = Colors.Gray
Description.TextSize = 13
Description.Font = Enum.Font.Gotham
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.ZIndex = 8
Description.Parent = Content

local ThemeTitle = Instance.new("TextLabel")
ThemeTitle.Size = UDim2.new(1,-60,0,25)
ThemeTitle.Position = UDim2.new(0,30,0,105)
ThemeTitle.BackgroundTransparency = 1
ThemeTitle.Text = "Giao diện"
ThemeTitle.TextColor3 = Config.TextColor
ThemeTitle.TextSize = 17
ThemeTitle.Font = Enum.Font.GothamBold
ThemeTitle.TextXAlignment = Enum.TextXAlignment.Left
ThemeTitle.ZIndex = 8
ThemeTitle.Parent = Content

local DefaultTheme = Instance.new("TextButton")
DefaultTheme.Size = UDim2.new(0,195,0,82)
DefaultTheme.Position = UDim2.new(0,30,0,140)
DefaultTheme.BackgroundColor3 = Colors.Panel
DefaultTheme.BackgroundTransparency = 0.15
DefaultTheme.BorderSizePixel = 0
DefaultTheme.Text = ""
DefaultTheme.AutoButtonColor = false
DefaultTheme.ZIndex = 8
DefaultTheme.Parent = Content
Corner(DefaultTheme,14)
AddStroke(DefaultTheme,Colors.Blue,1.3,0.25)

local DefaultTitle = Instance.new("TextLabel")
DefaultTitle.Size = UDim2.new(1,-20,0,25)
DefaultTitle.Position = UDim2.new(0,12,0,12)
DefaultTitle.BackgroundTransparency = 1
DefaultTitle.Text = "Mặc định"
DefaultTitle.TextColor3 = Config.TextColor
DefaultTitle.TextSize = 14
DefaultTitle.Font = Enum.Font.GothamBold
DefaultTitle.TextXAlignment = Enum.TextXAlignment.Left
DefaultTitle.ZIndex = 9
DefaultTitle.Parent = DefaultTheme

local DefaultDesc = Instance.new("TextLabel")
DefaultDesc.Size = UDim2.new(1,-20,0,25)
DefaultDesc.Position = UDim2.new(0,12,0,40)
DefaultDesc.BackgroundTransparency = 1
DefaultDesc.Text = "Giao diện xanh tối"
DefaultDesc.TextColor3 = Colors.Gray
DefaultDesc.TextSize = 11
DefaultDesc.Font = Enum.Font.Gotham
DefaultDesc.TextXAlignment = Enum.TextXAlignment.Left
DefaultDesc.ZIndex = 9
DefaultDesc.Parent = DefaultTheme

local GlassTheme = Instance.new("TextButton")
GlassTheme.Size = UDim2.new(0,195,0,82)
GlassTheme.Position = UDim2.new(0,240,0,140)
GlassTheme.BackgroundColor3 = Color3.fromRGB(80,135,175)
GlassTheme.BackgroundTransparency = 0.55
GlassTheme.BorderSizePixel = 0
GlassTheme.Text = ""
GlassTheme.AutoButtonColor = false
GlassTheme.ZIndex = 8
GlassTheme.Parent = Content
Corner(GlassTheme,14)
AddStroke(GlassTheme,Color3.fromRGB(150,215,255),1.5,0.15)

local GlassTitle = Instance.new("TextLabel")
GlassTitle.Size = UDim2.new(1,-20,0,25)
GlassTitle.Position = UDim2.new(0,12,0,12)
GlassTitle.BackgroundTransparency = 1
GlassTitle.Text = "Kính lỏng"
GlassTitle.TextColor3 = Config.TextColor
GlassTitle.TextSize = 14
GlassTitle.Font = Enum.Font.GothamBold
GlassTitle.TextXAlignment = Enum.TextXAlignment.Left
GlassTitle.ZIndex = 9
GlassTitle.Parent = GlassTheme

local GlassDesc = Instance.new("TextLabel")
GlassDesc.Size = UDim2.new(1,-20,0,25)
GlassDesc.Position = UDim2.new(0,12,0,40)
GlassDesc.BackgroundTransparency = 1
GlassDesc.Text = "Trong suốt • Liquid Glass"
GlassDesc.TextColor3 = Colors.Gray
GlassDesc.TextSize = 11
GlassDesc.Font = Enum.Font.Gotham
GlassDesc.TextXAlignment = Enum.TextXAlignment.Left
GlassDesc.ZIndex = 9
GlassDesc.Parent = GlassTheme

local OpacityTitle = Instance.new("TextLabel")
OpacityTitle.Size = UDim2.new(1,-60,0,25)
OpacityTitle.Position = UDim2.new(0,30,0,250)
OpacityTitle.BackgroundTransparency = 1
OpacityTitle.Text = "Độ mờ kính"
OpacityTitle.TextColor3 = Config.TextColor
OpacityTitle.TextSize = 17
OpacityTitle.Font = Enum.Font.GothamBold
OpacityTitle.TextXAlignment = Enum.TextXAlignment.Left
OpacityTitle.ZIndex = 8
OpacityTitle.Parent = Content

local OpacityValue = Instance.new("TextLabel")
OpacityValue.Size = UDim2.new(0,60,0,25)
OpacityValue.Position = UDim2.new(1,-90,0,250)
OpacityValue.BackgroundTransparency = 1
OpacityValue.Text = "28%"
OpacityValue.TextColor3 = Colors.Blue
OpacityValue.TextSize = 14
OpacityValue.Font = Enum.Font.GothamBold
OpacityValue.TextXAlignment = Enum.TextXAlignment.Right
OpacityValue.ZIndex = 8
OpacityValue.Parent = Content

local Slider = Instance.new("Frame")
Slider.Size = UDim2.new(1,-60,0,8)
Slider.Position = UDim2.new(0,30,0,292)
Slider.BackgroundColor3 = Color3.fromRGB(35,55,75)
Slider.BackgroundTransparency = 0.2
Slider.BorderSizePixel = 0
Slider.ZIndex = 8
Slider.Parent = Content
Corner(Slider,10)

local initial = Config.GlassOpacity

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(initial,0,1,0)
SliderFill.BackgroundColor3 = Colors.Blue
SliderFill.BorderSizePixel = 0
SliderFill.ZIndex = 9
SliderFill.Parent = Slider
Corner(SliderFill,10)

local SliderKnob = Instance.new("TextButton")
SliderKnob.Size = UDim2.new(0,22,0,22)
SliderKnob.Position = UDim2.new(initial,-11,0.5,-11)
SliderKnob.BackgroundColor3 = Color3.fromRGB(245,250,255)
SliderKnob.BorderSizePixel = 0
SliderKnob.Text = ""
SliderKnob.AutoButtonColor = false
SliderKnob.ZIndex = 10
SliderKnob.Parent = Slider
Corner(SliderKnob,11)
AddStroke(SliderKnob,Colors.Blue,2,0)

local OpacityDescription = Instance.new("TextLabel")
OpacityDescription.Size = UDim2.new(1,-60,0,30)
OpacityDescription.Position = UDim2.new(0,30,0,310)
OpacityDescription.BackgroundTransparency = 1
OpacityDescription.Text = "Kéo thanh để điều chỉnh độ trong suốt của lớp kính."
OpacityDescription.TextColor3 = Colors.Gray
OpacityDescription.TextSize = 11
OpacityDescription.Font = Enum.Font.Gotham
OpacityDescription.TextXAlignment = Enum.TextXAlignment.Left
OpacityDescription.ZIndex = 8
OpacityDescription.Parent = Content

local ColorTitle = Instance.new("TextLabel")
ColorTitle.Size = UDim2.new(1,-60,0,25)
ColorTitle.Position = UDim2.new(0,30,0,355)
ColorTitle.BackgroundTransparency = 1
ColorTitle.Text = "Màu chữ"
ColorTitle.TextColor3 = Config.TextColor
ColorTitle.TextSize = 17
ColorTitle.Font = Enum.Font.GothamBold
ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorTitle.ZIndex = 8
ColorTitle.Parent = Content

local ColorHolder = Instance.new("Frame")
ColorHolder.Size = UDim2.new(1,-60,0,48)
ColorHolder.Position = UDim2.new(0,30,0,390)
ColorHolder.BackgroundTransparency = 1
ColorHolder.ZIndex = 8
ColorHolder.Parent = Content

local ColorLayout = Instance.new("UIListLayout")
ColorLayout.FillDirection = Enum.FillDirection.Horizontal
ColorLayout.Padding = UDim.new(0,12)
ColorLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ColorLayout.Parent = ColorHolder

local TextObjects = {
    Title, SettingsText, DisplayName, Header, ThemeTitle,
    OpacityTitle, ColorTitle, DefaultTitle, GlassTitle
}

local ConfirmTitle
local No

local function CreateColorButton(color,name)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0,50,0,40)
    Button.BackgroundColor3 = color
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.ZIndex = 9
    Button.Parent = ColorHolder
    Corner(Button,12)
    AddStroke(Button,Color3.fromRGB(255,255,255),1,0.65)

    Button.MouseButton1Click:Connect(function()
        Config.TextColor = color
        for _,object in ipairs(TextObjects) do
            if object and object.Parent then
                object.TextColor3 = color
            end
        end
        if ConfirmTitle then ConfirmTitle.TextColor3 = color end
        if No then No.TextColor3 = color end
    end)
end

CreateColorButton(Color3.fromRGB(240,247,255),"White")
CreateColorButton(Color3.fromRGB(80,175,255),"Blue")
CreateColorButton(Color3.fromRGB(85,225,155),"Green")
CreateColorButton(Color3.fromRGB(190,120,255),"Purple")
CreateColorButton(Color3.fromRGB(255,215,90),"Yellow")

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,-60,0,25)
Status.Position = UDim2.new(0,30,1,-42)
Status.BackgroundTransparency = 1
Status.Text = "●  Giao diện hiện tại: Kính lỏng"
Status.TextColor3 = Colors.Green
Status.TextSize = 12
Status.Font = Enum.Font.GothamMedium
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.ZIndex = 8
Status.Parent = Content

local function ApplyDefault()
    Config.Theme = "Default"
    Tween(Main,0.5,{BackgroundColor3=Colors.Panel,BackgroundTransparency=0})
    Tween(Sidebar,0.5,{BackgroundColor3=Colors.Dark,BackgroundTransparency=0})
    Tween(DefaultTheme,0.3,{BackgroundTransparency=0.05})
    Tween(GlassTheme,0.3,{BackgroundTransparency=0.45})
    MainStroke.Transparency = 0.15
    Status.Text = "●  Giao diện hiện tại: Mặc định"
end

local function ApplyGlass()
    Config.Theme = "Glass"
    Tween(Main,0.5,{BackgroundColor3=Colors.Glass,BackgroundTransparency=Config.GlassOpacity})
    Tween(Sidebar,0.5,{BackgroundColor3=Colors.GlassDark,BackgroundTransparency=math.min(Config.GlassOpacity+0.08,0.9)})
    Tween(DefaultTheme,0.3,{BackgroundTransparency=0.45})
    Tween(GlassTheme,0.3,{BackgroundTransparency=0.15})
    MainStroke.Transparency = 0.05
    Status.Text = "●  Giao diện hiện tại: Kính lỏng"
end

DefaultTheme.MouseButton1Click:Connect(ApplyDefault)
GlassTheme.MouseButton1Click:Connect(ApplyGlass)

local SliderDragging = false

local function SetOpacity(percent)
    percent = math.clamp(percent,0,90)
    local value = percent/100
    Config.GlassOpacity = value
    OpacityValue.Text = math.floor(percent).."%"

    Tween(SliderFill,0.12,{Size=UDim2.new(value,0,1,0)})
    Tween(SliderKnob,0.12,{Position=UDim2.new(value,-11,0.5,-11)})

    if Config.Theme == "Glass" then
        Tween(Main,0.18,{BackgroundTransparency=value})
        Tween(Sidebar,0.18,{BackgroundTransparency=math.min(value+0.08,0.9)})
    end
end

local function UpdateSlider(input)
    local x = input.Position.X
    local start = Slider.AbsolutePosition.X
    local width = Slider.AbsoluteSize.X
    local percent = ((x-start)/width)*90
    SetOpacity(percent)
end

Slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        SliderDragging = true
        UpdateSlider(input)
    end
end)

SliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        SliderDragging = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not SliderDragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        UpdateSlider(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        SliderDragging = false
    end
end)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,36,0,30)
Minimize.Position = UDim2.new(1,-82,0,10)
Minimize.BackgroundColor3 = Color3.fromRGB(50,75,100)
Minimize.BackgroundTransparency = 0.3
Minimize.BorderSizePixel = 0
Minimize.Text = "−"
Minimize.TextColor3 = Config.TextColor
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.ZIndex = 20
Minimize.Parent = Main
Corner(Minimize,9)

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,36,0,30)
Close.Position = UDim2.new(1,-42,0,10)
Close.BackgroundColor3 = Color3.fromRGB(90,45,65)
Close.BackgroundTransparency = 0.25
Close.BorderSizePixel = 0
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255,225,235)
Close.TextSize = 20
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.ZIndex = 20
Close.Parent = Main
Corner(Close,9)

local MiniLogo = Instance.new("ImageButton")
MiniLogo.Name = "MiniLogo"
MiniLogo.Size = UDim2.new(0,60,0,60)
MiniLogo.Position = UDim2.new(0,15,0.5,-30)
MiniLogo.BackgroundColor3 = Color3.fromRGB(8,22,38)
MiniLogo.BackgroundTransparency = 0.15
MiniLogo.BorderSizePixel = 0
MiniLogo.Image = LOGO_ID
MiniLogo.ScaleType = Enum.ScaleType.Fit
MiniLogo.AutoButtonColor = false
MiniLogo.Visible = false
MiniLogo.ZIndex = 30
MiniLogo.Parent = ScreenGui
Corner(MiniLogo,30)
AddStroke(MiniLogo,Colors.Blue,2,0)

local Overlay = Instance.new("Frame")
Overlay.Name = "ConfirmOverlay"
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Visible = false
Overlay.ZIndex = 100
Overlay.Parent = ScreenGui

local Confirm = Instance.new("Frame")
Confirm.Size = UDim2.new(0,390,0,205)
Confirm.Position = UDim2.new(0.5,-195,0.5,-102)
Confirm.BackgroundColor3 = Colors.Glass
Confirm.BackgroundTransparency = 0.18
Confirm.BorderSizePixel = 0
Confirm.ZIndex = 101
Confirm.Parent = Overlay
Corner(Confirm,18)
AddStroke(Confirm,Colors.Blue,1.5,0.1)

local ConfirmLogo = Instance.new("ImageLabel")
ConfirmLogo.Size = UDim2.new(0,52,0,52)
ConfirmLogo.Position = UDim2.new(0,20,0,20)
ConfirmLogo.BackgroundTransparency = 1
ConfirmLogo.Image = LOGO_ID
ConfirmLogo.ZIndex = 103
ConfirmLogo.Parent = Confirm

ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Size = UDim2.new(1,-90,0,32)
ConfirmTitle.Position = UDim2.new(0,84,0,20)
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Text = "Đóng Si cút?"
ConfirmTitle.TextColor3 = Config.TextColor
ConfirmTitle.TextSize = 21
ConfirmTitle.Font = Enum.Font.GothamBold
ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfirmTitle.ZIndex = 103
ConfirmTitle.Parent = Confirm

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Size = UDim2.new(1,-40,0,35)
ConfirmText.Position = UDim2.new(0,20,0,83)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Bạn có chắc muốn đóng menu không?"
ConfirmText.TextColor3 = Colors.Gray
ConfirmText.TextSize = 13
ConfirmText.Font = Enum.Font.Gotham
ConfirmText.ZIndex = 103
ConfirmText.Parent = Confirm

No = Instance.new("TextButton")
No.Size = UDim2.new(0,130,0,40)
No.Position = UDim2.new(0,45,1,-58)
No.BackgroundColor3 = Color3.fromRGB(35,60,82)
No.BackgroundTransparency = 0.2
No.BorderSizePixel = 0
No.Text = "Không"
No.TextColor3 = Config.TextColor
No.TextSize = 13
No.Font = Enum.Font.GothamBold
No.AutoButtonColor = false
No.ZIndex = 103
No.Parent = Confirm
Corner(No,10)

local Yes = Instance.new("TextButton")
Yes.Size = UDim2.new(0,130,0,40)
Yes.Position = UDim2.new(1,-175,1,-58)
Yes.BackgroundColor3 = Colors.Blue2
Yes.BorderSizePixel = 0
Yes.Text = "Có"
Yes.TextColor3 = Color3.fromRGB(255,255,255)
Yes.TextSize = 13
Yes.Font = Enum.Font.GothamBold
Yes.AutoButtonColor = false
Yes.ZIndex = 103
Yes.Parent = Confirm
Corner(Yes,10)

local NormalSize = UDim2.new(0,900,0,555)
local NormalPosition = UDim2.new(0.5,-450,0.5,-277)

local function OpenMenu()
    Main.Visible = true
    Main.Size = UDim2.new(0,720,0,440)
    Main.Position = UDim2.new(0.5,-360,0.5,-220)
    Main.Rotation = -1
    Tween(Main,0.55,{
        Size=NormalSize,
        Position=NormalPosition,
        Rotation=0
    },Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
end

local function MinimizeMenu()
    local tween = Tween(Main,0.42,{
        Size=UDim2.new(0,720,0,440),
        Position=UDim2.new(0.5,-360,0.5,-220),
        Rotation=1
    },Enum.EasingStyle.Quint,Enum.EasingDirection.In)

    tween.Completed:Connect(function()
        Main.Visible = false
        Main.Rotation = 0
        MiniLogo.Visible = true
        MiniLogo.Size = UDim2.new(0,5,0,5)
        Tween(MiniLogo,0.5,{
            Size=UDim2.new(0,60,0,60)
        },Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    end)
end

local function ShowConfirm()
    Overlay.Visible = true
    Overlay.BackgroundTransparency = 1
    Tween(Overlay,0.25,{BackgroundTransparency=0.35})

    Confirm.Size = UDim2.new(0,320,0,165)
    Confirm.Position = UDim2.new(0.5,-160,0.5,-82)

    Tween(Confirm,0.38,{
        Size=UDim2.new(0,390,0,205),
        Position=UDim2.new(0.5,-195,0.5,-102)
    },Enum.EasingStyle.Back,Enum.EasingDirection.Out)
end

Minimize.MouseButton1Click:Connect(MinimizeMenu)

MiniLogo.MouseButton1Click:Connect(function()
    MiniLogo.Visible = false
    OpenMenu()
end)

Close.MouseButton1Click:Connect(ShowConfirm)

No.MouseButton1Click:Connect(function()
    Tween(Overlay,0.2,{BackgroundTransparency=1})
    Tween(Confirm,0.2,{Size=UDim2.new(0,320,0,165)})
    task.wait(0.2)
    Overlay.Visible = false
end)

Yes.MouseButton1Click:Connect(function()
    Tween(Overlay,0.25,{BackgroundTransparency=1})
    Tween(Confirm,0.25,{Size=UDim2.new(0,320,0,165)})
    task.wait(0.25)
    ScreenGui:Destroy()
end)

SettingsButton.MouseEnter:Connect(function()
    Tween(SettingsButton,0.18,{BackgroundTransparency=0.2})
end)

SettingsButton.MouseLeave:Connect(function()
    Tween(SettingsButton,0.18,{BackgroundTransparency=0.45})
end)

Minimize.MouseEnter:Connect(function()
    Tween(Minimize,0.18,{BackgroundTransparency=0})
end)

Minimize.MouseLeave:Connect(function()
    Tween(Minimize,0.18,{BackgroundTransparency=0.3})
end)

Close.MouseEnter:Connect(function()
    Tween(Close,0.18,{
        BackgroundColor3=Color3.fromRGB(135,55,80),
        BackgroundTransparency=0
    })
end)

Close.MouseLeave:Connect(function()
    Tween(Close,0.18,{
        BackgroundColor3=Color3.fromRGB(90,45,65),
        BackgroundTransparency=0.25
    })
end)

local Dragging = false
local DragStart
local StartPosition

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not Dragging then return end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local Delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

SetOpacity(Config.GlassOpacity * 100)
ApplyGlass()

print("✓ Si Cút Liquid Glass GUI loaded successfully")
