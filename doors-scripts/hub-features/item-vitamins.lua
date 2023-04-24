local tool = game:GetObjects("rbxassetid://12827538877")[1]
        tool.Parent = game.Players.LocalPlayer.Backpack
        
        local anim = Instance.new("Animation")
        anim.Name = "idle"
        anim.AnimationId = "rbxassetid://10479585177"
        local idle = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        
        local anim = Instance.new("Animation")
        anim.Name = "open"
        anim.AnimationId = "rbxassetid://10482563149"
        local use = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        
        tool.Equipped:Connect(function()
            idle:Play()
        end)
        
        tool.Unequipped:Connect(function()
            idle:Stop()
        end)
        
        local using = false
        tool.Activated:Connect(function()
            if using == false then
                using = true
                use:Play()
                tool.Handle.sound_open:Play()
                task.wait(0.5)
                using = false
                tool:Destroy()
                use:Stop()
                local OldSpeedBoost = game.Players.LocalPlayer.Character.Humanoid:GetAttribute("SpeedBoost")
                game.Players.LocalPlayer.Character.Humanoid:SetAttribute("SpeedBoost", getgenv().CustomVitamins.SpeedBoost + OldSpeedBoost)
                task.wait(getgenv().CustomVitamins.EffectDuration)
                game.Players.LocalPlayer.Character.Humanoid:SetAttribute("SpeedBoost", OldSpeedBoost)
            end
        end)
