 local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
        local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Shop%20Items/Source.lua"))()
        local UIS = game:GetService("UserInputService")
        local exampleTool = LoadCustomInstance("rbxassetid://12848567274") -- wand model
        
        if game:GetService("Players").LocalPlayer.PlayerGui.MainUI.ItemShop.Visible == true then
            -- Create custom shop item
            CustomShop.CreateItem(exampleTool, {
                Title = "Gun",
                Desc = "Works on entities",
                Image = "https://www.freepnglogos.com/uploads/gun-png/download-handgun-png-image-png-image-pngimg-1.png",
                Price = "gun",
                Stack = 1,
            })
            ----------------------------------------- parenting
        else
            exampleTool.Parent = game.Players.LocalPlayer.Backpack
        end
        local tool = exampleTool
        local function Shoot()
            local bullet = game:GetObjects("rbxassetid://12848374097")[1]
            task.wait()
            bullet.Anchored = false
            bullet.Massless = false
            local Sound = Instance.new("Sound", game.StarterPlayer)
            Sound.Volume = 3.5
            Sound.SoundId = "rbxassetid://5238024665"
            Sound.PlayOnRemove = true
            Sound:Destroy()
            HRP = exampleTool.BulletPart.CFrame * CFrame.Angles(0,math.rad(-90),0)
            local Attachment = Instance.new("Attachment", bullet)
            local LV = Instance.new("LinearVelocity", Attachment) -- creating the linear velocity
            LV.MaxForce = math.huge -- no need to worry about this
            LV.VectorVelocity = (game:GetService("Players").LocalPlayer:GetMouse().Hit.Position - tool.BulletPart.Position).Unit * 100-- HRP.lookVector * 50 -- change 100 with how fast you want the projectile to go
            LV.Attachment0 = Attachment --Required Attachment
            bullet.Parent = game.Workspace
            bullet.CFrame = tool.BulletPart.CFrame * CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
            bullet.Touched:Connect(function(part)
                local Model = part:FindFirstAncestorWhichIsA("Model")
                if Model ~= nil and Model:GetAttribute("IsCustomEntity") == true then
                    Model:Destroy()
                end
            end)
            task.wait(0.3)
            bullet:Destroy()
            end
        ----------------------------------------------- Shooting!
           
        UIS.InputBegan:Connect(function(input)
            if tool.Parent == game.Players.LocalPlayer.Character then
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                getgenv().BulletType = "12848374097"
                Shoot()
               
                end
            end
        end)
