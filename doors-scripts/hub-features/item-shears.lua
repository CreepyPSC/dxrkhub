 local Tool = game:GetObjects("rbxassetid://12685165702")[1]
        local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        local Sound = Instance.new("Sound")
        local Idle = Tool.Animations.idle
        local IdleTrack = Humanoid:LoadAnimation(Idle)
        Tool.Parent = game.Players.LocalPlayer.Backpack
        
        Sound.PlaybackSpeed = 1.25
        Sound.SoundId = "rbxassetid://9118823101"
        Sound.Parent = Tool
        
        Tool.Activated:Connect(function()
            local Use = Tool.Animations.use
            local UseTrack = Humanoid:LoadAnimation(Use)
            UseTrack:Play()
            Sound:Play()
            wait(0.25)
            Sound:Play()
            game:GetService("Players").LocalPlayer:GetMouse().Target:FindFirstAncestorOfClass("Model"):Destroy()
        end)
        
        Tool.Equipped:Connect(function()
            IdleTrack:Play()
        end)
        Tool.Unequipped:Connect(function()
           IdleTrack:Stop()
        end)
