-- ==========================================
-- ||         CONFIGURATION                ||
-- ==========================================
local ValidKeys = {
    "OwnerTe",
    "KM-3432-5644-9775-3455",
    "K25TGFSDFEFWEFWEF2", 
    -- You can add as many keys as you want here!
}

local GetKeyLink = "https://work.ink/2FOQ/2d2495f1-69a3-470a-a318-140715bc21ed"
local DiscordLink = "https://discord.gg/DdjVT2aMwx"
local LoadScript = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/API-AyGent/KalminScript/refs/heads/main/Kalmin.lua"))()'

-- ==========================================
-- ||         SERVICES & SETUP             ||
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- Clean up previous instance if it exists
if CoreGui:FindFirstChild("KalminPremiumUI") then
    CoreGui.KalminPremiumUI:Destroy()
end

local function Notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

local function copyToClipboard(text, notifyText)
    if setclipboard then
        setclipboard(text)
        Notify("Success", notifyText .. " copied to clipboard!")
    else
        Notify("Error", "Your executor does not support setclipboard.")
    end
end

-- ==========================================
-- ||         UI CONSTRUCTION              ||
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KalminPremiumUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 40, 40)
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

-- Top Bar 
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, 0, 0, 40)

local Icon = Instance.new("ImageLabel")
Icon.Name = "Icon"
Icon.Parent = TopBar
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0, 10, 0, 5)
Icon.Size = UDim2.new(0, 30, 0, 30)
Icon.Image = "rbxassetid://126925031200401"

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 50, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Kalmin KeySystem"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- TextBox
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyInput.Position = UDim2.new(0, 20, 0, 50)
KeyInput.Size = UDim2.new(1, -40, 0, 45)
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 18
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false

-- Padding for Textbox
local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 15)
UIPadding.Parent = KeyInput

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(50, 50, 50)
InputStroke.Thickness = 1
InputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
InputStroke.Parent = KeyInput

-- Buttons Helper Function
local function CreateButton(name, text, pos, size, strokeColor, parent)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Parent = parent
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.Position = pos
    Btn.Size = size
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = text
    Btn.TextColor3 = strokeColor
    Btn.TextSize = 18
    Btn.AutoButtonColor = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = strokeColor
    Stroke.Thickness = 1.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Btn
    
    -- Hover Animations
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
    end)
    
    return Btn
end

local AuthBtn = CreateButton("AuthBtn", "Authorize Key", UDim2.new(0, 20, 0, 115), UDim2.new(0.5, -25, 0, 45), Color3.fromRGB(0, 255, 0), MainFrame)
local GetKeyBtn = CreateButton("GetKeyBtn", "Get Key", UDim2.new(0.5, 5, 0, 115), UDim2.new(0.5, -25, 0, 45), Color3.fromRGB(0, 255, 255), MainFrame)
local DiscordBtn = CreateButton("DiscordBtn", "Join Discord", UDim2.new(0, 20, 0, 180), UDim2.new(1, -40, 0, 45), Color3.fromRGB(0, 85, 255), MainFrame)

-- ==========================================
-- ||         BUTTON LOGIC                 ||
-- ==========================================

GetKeyBtn.MouseButton1Click:Connect(function()
    copyToClipboard(GetKeyLink, "Get Key Link")
end)

DiscordBtn.MouseButton1Click:Connect(function()
    copyToClipboard(DiscordLink, "Discord Link")
end)

local isAuthorizing = false
AuthBtn.MouseButton1Click:Connect(function()
    if isAuthorizing then return end
    
    local inputKey = KeyInput.Text
    
    if inputKey == "" then
        Notify("Error", "Please input a key first!")
        return
    end
    
    isAuthorizing = true
    AuthBtn.Text = "Authorizing"
    
    -- Blinking effect for 3 seconds
    local blinkTween1 = TweenService:Create(AuthBtn, TweenInfo.new(0.4), {TextTransparency = 0.8})
    local blinkTween2 = TweenService:Create(AuthBtn, TweenInfo.new(0.4), {TextTransparency = 0})
    
    local startTime = tick()
    task.spawn(function()
        while tick() - startTime < 3 do
            blinkTween1:Play()
            blinkTween1.Completed:Wait()
            blinkTween2:Play()
            blinkTween2.Completed:Wait()
        end
    end)
    
    task.wait(3) -- Wait exactly 3 seconds
    
    -- Reset Transparency just in case
    AuthBtn.TextTransparency = 0
    
    -- Check if key is valid
    local keyCorrect = false
    for _, v in ipairs(ValidKeys) do
        if inputKey == v then
            keyCorrect = true
            break
        end
    end
    
    if keyCorrect then
        Notify("Success", "Correct Key!")
        AuthBtn.Text = "Correct Key!"
        AuthBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
        
        task.wait(0.5) -- Fade delay
        
        -- Fade Out Main UI slightly
        TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        for _, obj in pairs(MainFrame:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
                TweenService:Create(obj, TweenInfo.new(0.5), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
            elseif obj:IsA("UIStroke") then
                TweenService:Create(obj, TweenInfo.new(0.5), {Transparency = 1}):Play()
            elseif obj:IsA("ImageLabel") then
                TweenService:Create(obj, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
            end
        end
        
        task.wait(0.5)
        Notify("Loading", "Loading Script... (Please wait)")
        
        task.wait(1.5) -- Give user time to read the notification before loading script
        ScreenGui:Destroy()
        
        -- Execute the script you requested
        local loadFunc = loadstring(LoadScript)
        if loadFunc then loadFunc() else Notify("Error", "Failed to load script URL.") end
    else
        Notify("Error", "Wrong Key!")
        AuthBtn.Text = "Authorize Key"
        isAuthorizing = false
    end
end)
