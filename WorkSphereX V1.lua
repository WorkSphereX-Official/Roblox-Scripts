-- [[ WorkSphereX GAMING - V22 ]] --
local player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- OFFICIAL ASSET ID
local WSX_LOGO_ID = "rbxassetid://105772375329038"

-- Cleanup
if CoreGui:FindFirstChild("WSX_V22") then CoreGui.WSX_V22:Destroy() end

local WSX_Settings = {
    Running = true,
    SpeedEnabled = false,
    GodEnabled = false,
    HungerEnabled = false,
    InstantRevive = false
}

-- [[ UI SYSTEM ]] --
local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "WSX_V22"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 210, 0, 265) 
main.Position = UDim2.new(0.5, -105, 0.4, -132)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(212, 175, 55)
main.Active, main.Draggable = true, true

local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(0, 145, 0, 45)
header.Position = UDim2.new(0, 10, 0, 0)
header.Text = "WorkSphereX"
header.TextColor3 = Color3.fromRGB(212, 175, 55)
header.BackgroundTransparency = 1
header.TextXAlignment = Enum.TextXAlignment.Left
header.Font = Enum.Font.SourceSansBold
header.TextSize = 25 

-- Minimize Button
local logo = Instance.new("ImageButton", sg)
logo.Size = UDim2.new(0, 65, 0, 65)
logo.Position = UDim2.new(0, 20, 0.5, -32)
logo.Image = WSX_LOGO_ID
logo.Visible = false
logo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
logo.BackgroundTransparency = 0.1
logo.Active, logo.Draggable = true, true
Instance.new("UICorner", logo).CornerRadius = UDim.new(1, 0)

-- [[ COMPONENT BUILDER ]] --
local function addBtn(txt, y, key)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(0.9, 0, 0, 42)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.Text = txt .. ": OFF"
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 19
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        WSX_Settings[key] = not WSX_Settings[key]
        b.Text = txt .. (WSX_Settings[key] and ": ON" or ": OFF")
        b.BackgroundColor3 = WSX_Settings[key] and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(40, 40, 40)
    end)
end

addBtn("SPEED (60)", 55, "SpeedEnabled")
addBtn("GOD MODE", 105, "GodEnabled")
addBtn("NO HUNGER", 155, "HungerEnabled")
addBtn("INSTANT REVIVE", 205, "InstantRevive")

-- Controls
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(0.84, 0, 0, 8)
close.Text = "X"
close.BackgroundColor3 = Color3.new(0.7, 0, 0)
close.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", close)

local mini = Instance.new("TextButton", main)
mini.Size = UDim2.new(0, 28, 0, 28)
mini.Position = UDim2.new(0.67, 0, 0, 8)
mini.Text = "-"
mini.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mini.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", mini)

mini.MouseButton1Click:Connect(function() main.Visible = false logo.Visible = true end)
logo.MouseButton1Click:Connect(function() main.Visible = true logo.Visible = false end)
close.MouseButton1Click:Connect(function() 
    WSX_Settings.Running = false
    sg:Destroy()
end)

-- [[ THE HUNGER OVERDRIVE ENGINE ]] --
RunService.Heartbeat:Connect(function()
    if not WSX_Settings.Running then return end
    pcall(function()
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hum then
            hum.WalkSpeed = WSX_Settings.SpeedEnabled and 60 or 16
            if WSX_Settings.GodEnabled then hum.Health = 100 end
            
            -- [[ HUNGER OVERDRIVE ]] --
            if WSX_Settings.HungerEnabled then
                -- Force Attributes to 100 (Common for UI)
                player:SetAttribute("Hunger", 100)
                player:SetAttribute("Food", 100)
                player:SetAttribute("Stomach", 100)
                
                -- Force All Descendant Values to 200 (To ensure full bars)
                for _, v in pairs(player:GetDescendants()) do
                    if (v:IsA("NumberValue") or v:IsA("IntValue")) then
                        local n = v.Name:lower()
                        if n:find("hunger") or n:find("food") or n:find("stomach") or n:find("eat") then
                            v.Value = 200 -- Set higher to force visual "Full" state
                        end
                    end
                end
            end

            -- Instant Revive
            if WSX_Settings.InstantRevive and hum.Health <= 0 then
                local rem = game:GetService("ReplicatedStorage"):FindFirstChild("Revive") or game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
                if rem then 
                    rem:FireServer("Bandage")
                    rem:FireServer(player)
                end
            end
        end
    end)
end)

print("WorkSphereX V22 - 100% Hunger Bar Fix")
