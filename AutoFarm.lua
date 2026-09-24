if game.PlaceId ~= 537413528 then
    return
end

assert(type(getgenv) == "function", "getgenv를 지원하지 않는 환경입니다.")
assert(type(firetouchinterest) == "function", "firetouchinterest를 지원하지 않는 환경입니다.")

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local FcMaster = true
local Silent = true
local Value = true
local TriggerChest = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger

getgenv().AF = Value

local function touchGoldenChest(humanoidRootPart)
    firetouchinterest(humanoidRootPart, TriggerChest, 0)

    task.delay(0.1, function()
        if humanoidRootPart.Parent and TriggerChest.Parent then
            firetouchinterest(humanoidRootPart, TriggerChest, 1)
        end
    end)
end

local function startAutoFarm()
    if Value == false then
        return
    end

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
        or character:WaitForChild("Humanoid")

    local newPart = Instance.new("Part")
    newPart.Size = Vector3.new(5, 1, 5)
    newPart.Transparency = 1
    newPart.CanCollide = true
    newPart.Anchored = true
    newPart.Parent = workspace

    local decal = Instance.new("Decal")
    decal.Texture = "rbxassetid://139953968294114"
    decal.Face = Enum.NormalId.Top
    decal.Parent = newPart

    local function TPAF(iteration)
        if not Silent then
            if Value == false or getgenv().AF == false then
                return
            end

            if iteration == 5 then
                task.delay(0.8, function()
                    workspace.ClaimRiverResultsGold:FireServer()
                end)

                humanoidRootPart.CFrame = CFrame.new(
                    -51,
                    65,
                    984 + (iteration - 1) * 770
                )
                touchGoldenChest(humanoidRootPart)
            elseif iteration == 1 then
                humanoidRootPart.CFrame = CFrame.new(
                    160.16104125976562,
                    29.595888137817383,
                    973.813720703125
                )
            else
                humanoidRootPart.CFrame = CFrame.new(
                    -51,
                    65,
                    984 + (iteration - 1) * 770
                )
            end

            newPart.Position =
                humanoidRootPart.Position - Vector3.new(0, 2, 0)

            if iteration == 1 then
                wait(2.3)
            else
                repeat
                    task.wait()
                until #tostring(
                    Players.LocalPlayer.OtherData
                        :FindFirstChild("Stage" .. (iteration - 1)).Value
                ) > 2
            end

            if iteration ~= 4 then
                workspace.ClaimRiverResultsGold:FireServer()
            end

            if iteration == 10 then
                if Lighting.OutdoorAmbient == Color3.fromRGB(200, 200, 200)
                    or Lighting.OutdoorAmbient
                        == Color3.fromRGB(255, 255, 255)
                then
                    wait(0.1)

                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z > 7529.08984 then
                        game.Players.LocalPlayer.Character:BreakJoints()
                    end
                end
            end
        else
            if Value == false or getgenv().AF == false then
                return
            end

            if iteration == 1 then
                humanoidRootPart.CFrame = CFrame.new(
                    160.16104125976562,
                    29.595888137817383,
                    973.813720703125
                )
            elseif iteration == 5 then
                task.delay(0.8, function()
                    workspace.ClaimRiverResultsGold:FireServer()
                end)

                humanoidRootPart.CFrame = CFrame.new(
                    70.02417755126953,
                    138.9026336669922,
                    1371.6341552734375 + (iteration - 2) * 770
                )
                touchGoldenChest(humanoidRootPart)
            else
                humanoidRootPart.CFrame = CFrame.new(
                    70.02417755126953,
                    138.9026336669922,
                    1371.6341552734375 + (iteration - 2) * 770
                )
            end

            newPart.Position =
                humanoidRootPart.Position - Vector3.new(0, 2, 0)

            if iteration == 1 then
                wait(2.3)
            else
                repeat
                    task.wait()
                until #tostring(
                    Players.LocalPlayer.OtherData
                        :FindFirstChild("Stage" .. (iteration - 1)).Value
                ) > 2
            end

            if iteration ~= 4 then
                workspace.ClaimRiverResultsGold:FireServer()
            end

            if iteration == 10 then
                if Lighting.OutdoorAmbient == Color3.fromRGB(200, 200, 200)
                    or Lighting.OutdoorAmbient
                        == Color3.fromRGB(255, 255, 255)
                then
                    wait(0.1)

                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z > 7529.08984 then
                        game.Players.LocalPlayer.Character:BreakJoints()
                    end
                end
            end
        end
    end

    for i = 1, 10 do
        if not Value then
            break
        end

        TPAF(i)
    end

    newPart:Destroy()
end

local function onCharacterRespawned()
    if getgenv().AF == true then
        if FcMaster == false then
            return
        end

        local character = player.Character or player.CharacterAdded:Wait()
        character:WaitForChild("HumanoidRootPart")
        startAutoFarm()
    end
end

if getgenv().__ASU_AUTOFARM_CONNECTION then
    getgenv().__ASU_AUTOFARM_CONNECTION:Disconnect()
end

if Value then
    game.Players.LocalPlayer.Character:BreakJoints()
    wait(1)

    getgenv().__ASU_AUTOFARM_CONNECTION =
        game.Players.LocalPlayer.CharacterAdded:Connect(
            onCharacterRespawned
        )
end
