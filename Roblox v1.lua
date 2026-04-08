-- [[ WorkSphereX V22 - DELTA STABLE ]] --
local _0x1 = game:GetService("Players").LocalPlayer
local _0x2 = game:GetService("CoreGui")
local _0x3 = game:GetService("RunService")
local _0x4 = game:GetService("ReplicatedStorage")

local _0xStats = {60, 16, 100, 200}
local _0xConfig = {S = false, G = false, H = false, R = false, Active = true}

if _0x2:FindFirstChild("WSX_V22") then _0x2.WSX_V22:Destroy() end

local _0xUI = Instance.new("ScreenGui", _0x2)
_0xUI.Name = "WSX_V22"

local _0xM = Instance.new("Frame", _0xUI)
_0xM.Size = UDim2.new(0, 210, 0, 265)
_0xM.Position = UDim2.new(0.5, -105, 0.4, -132)
_0xM.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_0xM.BorderSizePixel = 2
_0xM.BorderColor3 = Color3.fromRGB(212, 175, 55)
_0xM.Active = true
_0xM.Draggable = true

local _0xH = Instance.new("TextLabel", _0xM)
_0xH.Size = UDim2.new(0, 145, 0, 45)
_0xH.Position = UDim2.new(0, 10, 0, 0)
_0xH.Text = "WorkSphereX"
_0xH.TextColor3 = Color3.fromRGB(212, 175, 55)
_0xH.BackgroundTransparency = 1
_0xH.Font = Enum.Font.SourceSansBold
_0xH.TextSize = 25
_0xH.TextXAlignment = Enum.TextXAlignment.Left

local _0xL = Instance.new("ImageButton", _0xUI)
_0xL.Size = UDim2.new(0, 65, 0, 65)
_0xL.Position = UDim2.new(0, 20, 0.5, -32)
_0xL.Image = "rbxassetid://105772375329038"
_0xL.Visible = false
_0xL.BackgroundTransparency = 0.1
_0xL.Active = true
_0xL.Draggable = true
Instance.new("UICorner", _0xL).CornerRadius = UDim.new(1, 0)

local function _0xBtn(t, y, k)
    local b = Instance.new("TextButton", _0xM)
    b.Size = UDim2.new(0.9, 0, 0, 42)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.Text = t .. ": OFF"
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 19
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        _0xConfig[k] = not _0xConfig[k]
        b.Text = t .. (_0xConfig[k] and ": ON" or ": OFF")
        b.BackgroundColor3 = _0xConfig[k] and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(40, 40, 40)
    end)
end

_0xBtn("SPEED (60)", 55, "S")
_0xBtn("GOD MODE", 105, "G")
_0xBtn("NO HUNGER", 155, "H")
_0xBtn("INSTANT REVIVE", 205, "R")

local _0xC = Instance.new("TextButton", _0xM)
_0xC.Size = UDim2.new(0, 28, 0, 28)
_0xC.Position = UDim2.new(0.84, 0, 0, 8)
_0xC.Text = "X"
_0xC.BackgroundColor3 = Color3.new(0.7, 0, 0)
Instance.new("UICorner", _0xC)

local _0xMini = Instance.new("TextButton", _0xM)
_0xMini.Size = UDim2.new(0, 28, 0, 28)
_0xMini.Position = UDim2.new(0.67, 0, 0, 8)
_0xMini.Text = "-"
_0xMini.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Instance.new("UICorner", _0xMini)

_0xMini.MouseButton1Click:Connect(function() _0xM.Visible = false _0xL.Visible = true end)
_0xL.MouseButton1Click:Connect(function() _0xM.Visible = true _0xL.Visible = false end)
_0xC.MouseButton1Click:Connect(function() _0xConfig.Active = false _0xUI:Destroy() end)

_0x3.Heartbeat:Connect(function()
    if not _0xConfig.Active then return end
    pcall(function()
        local char = _0x1.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = _0xConfig.S and _0xStats[1] or _0xStats[2]
            if _0xConfig.G then hum.Health = _0xStats[3] end
            if _0xConfig.H then
                _0x1:SetAttribute("Hunger", _0xStats[3])
                for _, v in pairs(_0x1:GetDescendants()) do
                    if (v:IsA("NumberValue") or v:IsA("IntValue")) and v.Name:lower():find("hunger") then v.Value = _0xStats[4] end
                end
            end
            if _0xConfig.R and hum.Health <= 0 then
                local rem = _0x4:FindFirstChild("Revive") or _0x4:FindFirstChild("RemoteEvent")
                if rem then rem:FireServer("Bandage", _0x1) end
            end
        end
    end)
end)

