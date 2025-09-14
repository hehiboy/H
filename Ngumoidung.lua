--== Auto Equip Giảm Lag + FullBright + Hotkey ==--
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Cấu hình
local OptimizeMode = true      -- bật giảm lag
local LoopMode = "safe"        -- safe = an toàn, tránh drop FPS
local Hotkey = Enum.KeyCode.L  -- phím bật/tắt Auto Equip

-- Trạng thái
local EquipLoop = false

--== FullBright Auto ==--
local function enableFullBright()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 1e6
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end
enableFullBright()

--== Auto Equip ==--
local function toggleToolLoop(tool)
    local character = LocalPlayer.Character
    if not character or not tool then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    while EquipLoop do
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
