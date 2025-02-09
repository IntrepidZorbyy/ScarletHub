local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create Fullscreen Loading Frame
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26) -- Black background
loadingFrame.BackgroundTransparency = 1 -- Start fully transparent (for fade-in)
loadingFrame.Parent = screenGui

-- Create Title
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 0.1, 0)
titleText.Position = UDim2.new(0, 0, 0.1, 0)
titleText.Text = "Scarlet Hub"
titleText.TextScaled = true
titleText.Font = Enum.Font.SourceSansBold
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(247, 64, 64)
titleText.Parent = loadingFrame

-- Create Loading Text
local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0.5, 0, 0.1, 0)
loadingText.Position = UDim2.new(0.25, 0, 0.35, 0)
loadingText.Text = "Loading... 0%"
loadingText.TextScaled = true
loadingText.Font = Enum.Font.SourceSansBold
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Parent = loadingFrame

-- Create Progress Bar Background
local progressBarBG = Instance.new("Frame")
progressBarBG.Size = UDim2.new(0.6, 0, 0.05, 0)
progressBarBG.Position = UDim2.new(0.2, 0, 0.5, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark gray background
progressBarBG.Parent = loadingFrame

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.CornerRadius = UDim.new(0, 8)
progressBarCorner.Parent = progressBarBG

-- Create Progress Fill Bar
local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0) -- Start empty
progressFill.BackgroundColor3 = Color3.fromRGB(247, 64, 64) -- Light blue progress color
progressFill.Parent = progressBarBG

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(0, 8)
progressFillCorner.Parent = progressFill

-- Create Motivational Text
local motivationalText = Instance.new("TextLabel")
motivationalText.Size = UDim2.new(0.8, 0, 0.1, 0)
motivationalText.Position = UDim2.new(0.1, 0, 0.7, 0)
motivationalText.Text = ""
motivationalText.TextScaled = true
motivationalText.Font = Enum.Font.SourceSansBold
motivationalText.BackgroundTransparency = 1
motivationalText.TextColor3 = Color3.fromRGB(247, 64, 64)
motivationalText.Parent = loadingFrame

-- List of patience-based motivational messages
local messages = {
    "Patience is the key to success.",
    "Good things come to those who wait.",
    "Stay patient and trust the process.",
    "The best things take time to grow.",
    "Great achievements require patience.",
    "A wise man does not try to hurry history.",
    "Slow progress is better than no progress.",
    "Endurance and patience lead to success."
}

-- Function to shuffle messages
local function shuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

-- Randomly decide loading time (between 10 and 23 seconds)
local totalLoadingTime = math.random(10, 23)

-- Fade-in effect
local fadeInTween = tweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 0})
fadeInTween:Play()
fadeInTween.Completed:Wait()

-- Shuffle messages randomly
shuffleTable(messages)

-- Function to show motivational messages in a random order
local function showMotivation()
    for i = 1, #messages do
        motivationalText.Text = messages[i]
        motivationalText.TextTransparency = 1
        local fadeInMotivation = tweenService:Create(motivationalText, TweenInfo.new(1), {TextTransparency = 0})
        fadeInMotivation:Play()
        task.wait(3) -- Message stays for 3 seconds
        local fadeOutMotivation = tweenService:Create(motivationalText, TweenInfo.new(1), {TextTransparency = 1})
        fadeOutMotivation:Play()
        fadeOutMotivation.Completed:Wait()
    end
end

-- Run motivational text updates in parallel
task.spawn(showMotivation)

-- Animate the Progress Bar and Percentage over the random loading time
local incrementTime = totalLoadingTime / 100 -- Smooth update time
for i = 0, 100, 1 do
    progressFill.Size = UDim2.new(i / 100, 0, 1, 0)
    loadingText.Text = "Loading... " .. i .. "%"
    task.wait(incrementTime)
end

-- Small delay after reaching 100%
task.wait(1)

-- Fade-out effect
local fadeOutTween = tweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
fadeOutTween:Play()
fadeOutTween.Completed:Wait()

-- Remove Loading Screen
screenGui:Destroy()
