local Players = game:GetService("Players")

assert(type(firetouchinterest) == "function", "firetouchinterest를 지원하지 않는 환경입니다.")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local trigger = workspace
    :WaitForChild("BoatStages")
    :WaitForChild("NormalStages")
    :WaitForChild("TheEnd")
    :WaitForChild("GoldenChest")
    :WaitForChild("Trigger")

firetouchinterest(humanoidRootPart, trigger, 0)
task.wait(0.1)
firetouchinterest(humanoidRootPart, trigger, 1)
