--// Hữudz Lag Fix + Rainbow FPS
--// Delta / Roblox

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

--========================
-- LOADING
--========================
local gui = Instance.new("ScreenGui")
gui.Name = "HuuDZ_LagFix"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local loading = Instance.new("TextLabel")
loading.Size = UDim2.new(0, 220, 0, 45)
loading.Position = UDim2.new(0.5, -110, 0.08, 0)
loading.BackgroundTransparency = 1
loading.Text = "loat hữudz"
loading.TextScaled = true
loading.Font = Enum.Font.GothamBold
loading.TextColor3 = Color3.new(1,1,1)
loading.Parent = gui

task.wait(1)

--========================
-- LAG FIX
--========================

-- Giảm chất lượng rendering
pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

-- Tắt các hiệu ứng Lighting nặng
for _, v in ipairs(Lighting:GetChildren()) do
    if v:IsA("BloomEffect")
    or v:IsA("BlurEffect")
    or v:IsA("ColorCorrectionEffect")
    or v:IsA("SunRaysEffect")
    or v:IsA("DepthOfFieldEffect") then
        v.Enabled = false
    end
end

-- Giảm các hiệu ứng particle/trail
for _, obj in ipairs(workspace:GetDescendants()) do
    pcall(function()
        if obj:IsA("ParticleEmitter")
        or obj:IsA("Trail")
        or obj:IsA("Beam") then
            obj.Enabled = false
        elseif obj:IsA("Smoke")
        or obj:IsA("Fire")
        or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end)
end

--========================
-- FPS DISPLAY
--========================

local fps = Instance.new("TextLabel")
fps.Size = UDim2.new(0, 150, 0, 40)
fps.Position = UDim2.new(0, 15, 0, 15)
fps.BackgroundTransparency = 0.25
fps.BackgroundColor3 = Color3.fromRGB(20,20,20)
fps.Text = "FPS: 0"
fps.TextScaled = true
fps.Font = Enum.Font.GothamBold
fps.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = fps

--========================
-- 7 MÀU LIÊN TỤC
--========================

local colors = {
    Color3.fromRGB(255,0,0),       -- Đỏ
    Color3.fromRGB(255,127,0),     -- Cam
    Color3.fromRGB(255,255,0),     -- Vàng
    Color3.fromRGB(0,255,0),       -- Xanh lá
    Color3.fromRGB(0,170,255),     -- Xanh dương
    Color3.fromRGB(75,0,255),      -- Xanh tím
    Color3.fromRGB(255,0,255)      -- Tím
}

local colorIndex = 1

task.spawn(function()
    while gui.Parent do
        fps.TextColor3 = colors[colorIndex]
        colorIndex = colorIndex + 1

        if colorIndex > #colors then
            colorIndex = 1
        end

        task.wait(0.12)
    end
end)

--========================
-- TÍNH FPS
--========================

local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames += 1

    local now = tick()if now - lastTime >= 1 then
        fps.Text = "FPS: " .. frames
        frames = 0
        lastTime = now
    end
end)

--========================
-- XÓA LOADING
--========================

task.wait(1)
loading:Destroy()

print("Hữudz Lag Fix đã bật!")
