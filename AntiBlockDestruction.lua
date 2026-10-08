local player = game:GetService("Players").LocalPlayer
local env = getgenv()

local token = {}
env.MyBlockProtection = token

task.spawn(function()
    while env.MyBlockProtection == token do
        pcall(function()
            local blocks = workspace:FindFirstChild("Blocks")
            local mine = blocks and blocks:FindFirstChild(player.Name)

            if not mine then
                return
            end

            for _, part in ipairs(
                mine:QueryDescendants("BasePart[CanTouch = true]")
            ) do
                pcall(function()
                    part.CanTouch = false
                end)
            end
        end)

        task.wait(0.1)
    end
end)
