--[[ WorkSphereX LIGHT-PROTECTED SOURCE - V87 ]]--
local _0x1 = game:GetService("Players").LocalPlayer
local _0x2 = game:GetService("CoreGui")
local _0x3 = game:GetService("RunService")
local _0xData = {S = false, H = false, R = false, A = true}

-- CLEANUP
pcall(function() if _0x2:FindFirstChild("WSX_V22") then _0x2.WSX_V22:Destroy() end end)
local _0xUI = Instance.new("ScreenGui", _0x2); _0xUI.Name = "WSX_V22"

-- MINIMIZE LOGO
local _0xLogo = Instance.new("ImageButton", _0xUI); _0xLogo.Size = UDim2.new(0, 50, 0, 50)
_0xLogo.Position = UDim2.new(0, 10, 0.5, -25); _0xLogo.Image = "rbxassetid://105772375329038"; _0xLogo.Visible = false
_0xLogo.BackgroundTransparency = 0.3; Instance.new("UICorner", _0xLogo).CornerRadius = UDim.new(1, 0)

-- MAIN MENU
local _0xMain = Instance.new("Frame", _0xUI); _0xMain.Size = UDim2.new(0, 225, 0, 230)
_0xMain.Position = UDim2.new(0.5, -112, 0.4, -115); _0xMain.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_0xMain.BorderSizePixel = 2; _0xMain.BorderColor3 = Color3.fromRGB(255, 215, 0); _0xMain.Active = true; _0xMain.Draggable = true
Instance.new("UICorner", _0xMain)

local _0xTitle = Instance.new("TextLabel", _0xMain); _0xTitle.Size = UDim2.new(0, 120, 0, 45)
_0xTitle.Position = UDim2.new(0, 10, 0, 0); _0xTitle.Text = "WorkSphereX"; _0xTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
_0xTitle.BackgroundTransparency = 1; _0xTitle.Font = 3; _0xTitle.TextSize = 20; _0xTitle.TextXAlignment = 0

-- UI CONTROLS
local _0xX = Instance.new("TextButton", _0xMain); _0xX.Size = UDim2.new(0, 32, 0, 32); _0xX.Position = UDim2.new(0.83, 0, 0, 7)
_0xX.Text = "X"; _0xX.BackgroundColor3 = Color3.fromRGB(200, 0, 0); _0xX.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", _0xX); _0xX.MouseButton1Click:Connect(function() _0xData.A = false; _0xUI:Destroy() end)

local _0xM = Instance.new("TextButton", _0xMain); _0xM.Size = UDim2.new(0, 32, 0, 32); _0xM.Position = UDim2.new(0.65, 0, 0, 7)
_0xM.Text = "-"; _0xM.BackgroundColor3 = Color3.fromRGB(60, 60, 60); _0xM.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", _0xM); _0xM.MouseButton1Click:Connect(function() _0xMain.Visible = false; _0xLogo.Visible = true end)
_0xLogo.MouseButton1Click:Connect(function() _0xMain.Visible = true; _0xLogo.Visible = false end)

-- BUTTON ENGINE
local function _0xCreateToggle(txt, y, key)
    local _0xBtn = Instance.new("TextButton", _0xMain); _0xBtn.Size = UDim2.new(0.9, 0, 0, 42)
    _0xBtn.Position = UDim2.new(0.05, 0, 0, y); _0xBtn.Text = txt .. ": OFF"
    _0xBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35); _0xBtn.TextColor3 = Color3.new(1, 1, 1)
    _0xBtn.Font = 3; _0xBtn.TextSize = 17; Instance.new("UICorner", _0xBtn)
    _0xBtn.MouseButton1Click:Connect(function()
        _0xData[key] = not _0xData[key]
        _0xBtn.Text = txt .. (_0xData[key] and ": ON" or ": OFF")
        _0xBtn.BackgroundColor3 = _0xData[key] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
end

_0xCreateToggle("SPEED (60)", 55, "S")
_0xCreateToggle("NO HUNGER", 105, "H")
_0xCreateToggle("AUTO REVIVE", 155, "R")

-- LOGIC LOOP
_0x3.Heartbeat:Connect(function()
    if not _0xData.A then return end
    pcall(function()
        local _0xChar = _0x1.Character
        local _0xHum = _0xChar and _0xChar:FindFirstChildOfClass("Humanoid")
        if _0xHum then
            _0xHum.WalkSpeed = _0xData.S and 60 or 16
            if _0xData.H then _0x1:SetAttribute("Hunger", 100) end
            if _0xData.R and _0xHum.Health <= 0 then 
                _0xHum:ChangeState(11) -- Forced Resumption State
                _0xHum.Health = 100 
            end
        end
    end)
end)
      
