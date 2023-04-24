local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
        local debrisService = game:GetService("Debris")
        local UserInputService = game:GetService("UserInputService")
        local runservice = game:GetService("RunService")
        
        local SCARH = game:GetObjects("rbxassetid://13125400869")[1] or LoadCustomInstance("rbxassetid://13125400869")
        SCARH.Parent = game.Players.LocalPlayer.Backpack
        
        local shot = Instance.new("Sound", SCARH)
        shot.SoundId = "rbxassetid://2025903231"
        shot.Volume = 1.5
        shot.PlaybackSpeed = 1.5
        
        local bullet = game:GetObjects("rbxassetid://13115337607")[1]
        bullet.Anchored = true
        bullet.Massless = true
        
        local bulletAttachment = Instance.new("Attachment", bullet)
        bulletAttachment.Name = "BulletAttachment"
        bullet.Parent = workspace
        
        
        local bolt = SCARH.Bolt
        local boltWeld = bolt.ManualWeld
        
        local tweenService = game:GetService("TweenService")
        
        local scopeObject
        local camera = workspace.CurrentCamera
        for _,deivid in ipairs(SCARH:GetDescendants()) do
            if deivid.Name == "Reticle" then
                    scopeObject = deivid -- im so pro -divid
                    break
                end
            end
        
        
        local isTweening = false
        
        local function tween()
            if isTweening then
                return
            end
            isTweening = true
        
            local startPos = bolt.ManualWeld.C0
            local tween1 = tweenService:Create(bolt.ManualWeld, TweenInfo.new(0.02, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                C0 = bolt.ManualWeld.C0 * CFrame.new(0, 0, -0.40)
            })
            tween1:Play()
            tween1.Completed:Wait()
        
            local tween2 = tweenService:Create(bolt.ManualWeld, TweenInfo.new(0.02, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                C0 = startPos
            })
            tween2:Play()
            tween2.Completed:Wait()
            
            isTweening = false
        end
        
        local function shootBullet()
            local mouse = game.Players.LocalPlayer:GetMouse()
            local targetPos = mouse.Hit.p
            local bulletPos = SCARH.Flash.Position
        
            local shootDirection = (mouse.Hit.p - SCARH.Handle.Position * CFrame.new(mat.random(1,3),math.random(1,3),math.random(1,3))).Unit
            local bulletClone = bullet:Clone()
            bulletClone.CFrame = CFrame.new(bulletPos, targetPos)
            bulletClone.Parent = workspace
        
            local bulletVelocity = shootDirection * 10000
            bulletClone.Anchored = false
            bulletClone.Massless = false
            bulletClone.CanCollide = true
            bulletClone.CanTouch = true
            bulletClone.Transparency = 0
        
            local bulletForce = Instance.new("BodyForce", bulletClone)
            bulletForce.Force = bulletVelocity * bulletClone:GetMass()
            bulletClone.Touched:Connect(function(part)
                local Model = part:FindFirstAncestorWhichIsA("Model")
                if Model ~= nil and Model:GetAttribute("IsCustomEntity") == true then
                    Model:Destroy()
                end
            end)
            debrisService:AddItem(bulletClone, 5)
        
            bulletClone.Touched:Connect(function(part)
                local Model = part:FindFirstAncestorWhichIsA("Model")
                if Model ~= nil and Model:GetAttribute("IsCustomEntity") == true then
                    Model:Destroy()
                end
            end)
        end
        
        
        SCARH.Activated:Connect(function()
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do 
                task.wait(0.09)
                spawn(function()
                    shot:Play()
                    tween()
                    shootBullet()
                    SCARH.Flash.Light.Enabled = true
                    SCARH.Flash.lite.Enabled = true
                    task.wait(0.1)
                    SCARH.Flash.lite.Enabled = false
                    SCARH.Flash.Light.Enabled = false
                end)
            end
        
        end)
        
        local isPressedRight = false
        UserInputService.InputBegan:Connect(function (input, _gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                isPressedRight = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function (input, _gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                isPressedRight = false
            end
        end)
        
        local rsconnection
        local didTween = false
        
        rsconnection = runservice.RenderStepped:Connect(function()
            if SCARH ~= nil then
                if isPressedRight then
                    print(didTween)
                    if didTween == false then
                        didTween = true
                        local tween = tweenService:Create(camera,TweenInfo.new(0.5),{
                            ["CFrame"] = scopeObject.CFrame * CFrame.new(0,0,-0.6)
                        }):Play()
                        wait(0.5)
                    else
                        camera.CFrame = scopeObject.CFrame
                    end
                end
                if not isPressedRight then
                    if didTween == true then
                        local tween = tweenService:Create(camera,TweenInfo.new(0.5),{
                            ["CFrame"] = Game.Players.LocalPlayer.Character.Head.CFrame
                        }):Play()
                        wait(0.5)
                        didTween = false
                    end
                end
            else
                rsconnection:Disconnect()
                return
            end
        end)
        
        UserInputService.InputBegan:Connect(function(input)
            
            -- no ballers? :c
            if SCARH.Parent == game.Players.LocalPlayer.Character then
                if input.KeyCode == Enum.KeyCode.Q then
                    print("l")
                    local MagClone = SCARH.Mag:Clone()
                    MagClone.Parent = workspace
                    MagClone.CFrame = SCARH.Mag.CFrame
                    MagClone.ManualWeld:Destroy()
                    Magclone.CanCollide = true
                    task.wait(10)
                    MagClone:Destroy()
                end
            end
        end)
