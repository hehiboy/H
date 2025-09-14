-- 🔥 Giảm Lag + FullBright + Hiển Thị FPS + Ping
-- Dùng cho KRNL Mobile/PC

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")

-- 🟢 Giảm lag
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") or v:IsA("PostEffect") then
        v:Destroy()
    end
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 1e6
Lighting.Brightness = 2

local fb = Instance.new("ColorCorrectionEffect")
fb.Name = "SuperFullBright"
fb.Parent = Lighting
fb.Brightness = 0.2
fb.Contrast = 0.15
fb.Saturation = 0.1

for _, v in pairs(game:GetDescendants()) do
    if v:IsA("ParticleEmitter") 
    or v:IsA("Trail") 
    or v:IsA("Fire") 
    or v:IsA("Smoke") then
        v.Enabled = false
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1
    end
end

-- 🟢 Tạo GUI hiển thị FPS & Ping
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0,200,0,50)
TextLabel.Position = UDim2.new(0,10,0,10) -- góc trái trên
TextLabel.BackgroundTransparency = 0.5
TextLabel.BackgroundColor3 = Color3.new(0,0,0)
TextLabel.TextColor3 = Color3.new(0,1,0)
TextLabel.TextStrokeTransparency = 0
TextLabel.Font = Enum.Font.Code
TextLabel.TextSize = 18
TextLabel.Parent = ScreenGui

-- 🟢 Update FPS + Ping
local fps = 0
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = now
    end

    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    TextLabel.Text = "⚡ FPS: "..fps.." | 📶 Ping: "..ping
end)    while EquipLoop do
        if tool.Parent ~= character then
            tool.Parent = LocalPlayer.Backpack
        end
        humanoid:EquipTool(tool)

        -- Giảm lag: 0.1s/lần
        if OptimizeMode then
            task.wait(0.1)
        else
            if LoopMode == "safe" then
                task.wait(0.1)
            elseif LoopMode == "turbo" then
                task.wait()
            end
        end
    end
end

--== Run AutoEquip ==--
local function runAutoEquip()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

    local tool = character:FindFirstChildWhichIsA("Tool")
    if not tool then
        warn("⚠️ Equip 1 tool trước khi bật Auto Equip")
        EquipLoop = false
        return
    end

    task.spawn(function()
        toggleToolLoop(tool)
    end)
end

--== Hotkey Toggle ==--
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Hotkey then
        EquipLoop = not EquipLoop
        if EquipLoop then
            print("✅ Auto Equip BẬT (0.1s)")
            runAutoEquip()
        else
            print("⛔ Auto Equip TẮT")
        end
    end
end)

print("⚡ Script đã load | Nhấn phím [L] để bật/tắt Auto Equip | FullBright luôn bật")
