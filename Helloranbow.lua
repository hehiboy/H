    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HelloRainbowGUI"
    screenGui.ResetOnSpawn = false

    local attached = false
    local okAttach = pcall(function()
        screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
    end)
    if not okAttach then
        local gethuiFn = gethui or get_hidden_ui
        if gethuiFn then
            screenGui.Parent = gethuiFn()
        else
            screenGui.Parent = game:GetService("CoreGui")
        end
    end

    local label = Instance.new("TextLabel")
    label.Name = "HelloLabel"
    label.Size = UDim2.new(0, 420, 0, 140)
    label.Position = UDim2.new(0.5, -210, 0.4, -70)
    label.BackgroundTransparency = 1
    label.Text = "Hello World"
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.3
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Parent = screenGui

    -- Drag
    local dragging = false
    local dragStart = nil
    local startPos = nil

    local function beginDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = label.Position
    end

    local function updateDrag(inputPos)
        if not dragging then return end
        local delta = inputPos - dragStart
        label.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    local function endDrag()
        dragging = false
    end

    label.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(input)
        end
    end)

    label.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updateDrag(input.Position)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            endDrag()
        end
    end)

    -- Rainbow + blink
    local t0 = tick()
    RunService.RenderStepped:Connect(function()
        local t = tick() - t0
        local hue = (t * 90) % 360
        local r, g, b = hsv_to_rgb(hue)
        label.TextColor3 = Color3.new(r, g, b)

        local blink = 0.5 + 0.5 * math.sin(t * 6.5)
        label.TextTransparency = 1 - blink
        label.TextStrokeTransparency = 0.4 + 0.4 * (1 - blink)
    end)

    return true
end)
return ok and result
