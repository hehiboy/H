-- fps.lua (hiện FPS)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0,120,0,30)
TextLabel.Position = UDim2.new(0,10,0,10) -- góc trái trên
TextLabel.BackgroundTransparency = 0.3
TextLabel.BackgroundColor3 = Color3.new(0,0,0)
TextLabel.TextColor3 = Color3.new(0,1,0)
TextLabel.Font = Enum.Font.Code
TextLabel.TextSize = 18
TextLabel.Text = "FPS: ..."
TextLabel.Parent = ScreenGui

local frames, fps, lastTime = 0, 0, tick()
RunService.RenderStepped:Connect(function()
    frames += 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = now
        TextLabel.Text = "FPS: "..fps
    end
end)
