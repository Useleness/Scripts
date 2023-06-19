if not game:IsLoaded() then game.Loaded:Wait() end
-----------------------------------------------------
local msg = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/messages.lua"))()
local UserInputService=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local trainpos = nil
local ClickTP = false
local AR = false
local P = game.Players
local LP = P.LocalPlayer
local mouse = LP:GetMouse()
local FarmFS = false
local FarmJFMS = false
local ELB = {}
local MR = false
local AutoEquip = {}
AutoEquip.State = false
AutoEquip.Tool = "None"
AutoEquip.LB = 0
-------------------------------
msg.Notify("Binds (Toggle)", "F1 - Train JF+MS  |  F2 - Train FS\nF3 - Auto Respawn", 4)
-------------------------------
local vu=game:GetService("VirtualUser")
LP.Idled:connect(function() vu:CaptureController()vu:ClickButton2(Vector2.new()) end)
---------------------------------------------
local Events = {}
Events.Respawn = {"Respawn"}
Events.FS = {"Add_FS_Request"}
Events.MS = {"Add_MS_Request"}
Events.JF = {"Add_JF_Request"}
Events.MR = {"Add_Meditation_Request"}
Events.Aura = {"ConcealRevealAura"}
RunService.Stepped:Connect(function()
    if FarmJFMS then game.ReplicatedStorage.RemoteEvent:FireServer(Events.MS); game.ReplicatedStorage.RemoteEvent:FireServer(Events.JF) end
    if FarmFS then game.ReplicatedStorage.RemoteEvent:FireServer(Events.FS) end
    if AR then if LP.Character:FindFirstChild("Humanoid") ~= nil and LP.Character.Humanoid.Health == 0 then game.ReplicatedStorage.RemoteEvent:FireServer(Events.Respawn) end 
    if MR then game.ReplicatedStorage.RemoteEvent:FireServer(Events.MR) end
        LP.PlayerGui.IntroGui.Enabled = false; game:GetService("Lighting").Blur.Enabled = false; LP.PlayerGui.ScreenGui.Enabled = true
        if trainpos ~= nil and LP.Character:FindFirstChild("HumanoidRootPart") ~= nil then LP.Character.HumanoidRootPart.CFrame = trainpos end
    
    end
    if AutoEquip.State then
        if AutoEquip.Tool ~= "None" then
            if LP.Backpack:FindFirstChild(AutoEquip.Tool) ~= nil then
                LP.Backpack:FindFirstChild(AutoEquip.Tool).Parent = LP.Character
            end
        end
        if AutoEquip.LB ~= 0 then
            Events.ELB = {"EquipWeight_Request", AutoEquip.LB}
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(Events.ELB)
        end
    end
end)
UserInputService.InputBegan:Connect(function(a, b)
    if a.KeyCode == Enum.KeyCode.F1 then FarmJFMS = not FarmJFMS
        if FarmJFMS then msg.Notify("FarmJFMS", "Enabled")
        else msg.Notify("FarmJFMS", "Disabled") end end
    if a.KeyCode == Enum.KeyCode.F2 then FarmFS = not FarmFS 
        if FarmFS then msg.Notify("FarmFS", "Enabled")
        else msg.Notify("FarmFS", "Disabled") end end
    if a.KeyCode == Enum.KeyCode.F3 then AR = not AR 
        if AR and LP.Character:FindFirstChild("HumanoidRootPart") ~= nil then msg.Notify("AutoRespawn", "Enabled"); trainpos = LP.Character.HumanoidRootPart.CFrame
        else msg.Notify("AutoRespawn", "Disabled") trainpos = nil end end
    if a.KeyCode==Enum.KeyCode.F6 then loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/rejoin.lua"))() end
    if a.KeyCode==Enum.KeyCode.F4 then AutoEquip.State = not AutoEquip.State
        if AutoEquip.State then msg.Notify("AutoEquip", "Enabled")
        else msg.Notify("AutoEquip", "Disabled") end end
    if a.KeyCode == Enum.KeyCode.F5 then
            if AutoEquip.State and AutoEquip.Tool == "Meditate" then AutoEquip.Tool = "None"; msg.Notify("AutoEquip", "Tool: Disabled")
            elseif AutoEquip.State and AutoEquip.Tool == "None" then AutoEquip.Tool = "Meditate"; msg.Notify("AutoEquip", "Tool: Meditation"); LP.Character.Humanoid:UnequipTools()
            if LP.Backpack:FindFirstChild("Meditate") ~= nil then
                LP.Backpack:FindFirstChild("Meditate").Parent = LP.Character
                msg.Chat("Successfully equiped!", "Green")
            else msg.Chat("There is some problem...", "Red") end
        end
    end
end)
UserInputService.InputBegan:connect(function(a,b)
    if a.KeyCode==Enum.KeyCode.P then
        if AutoEquip.LB < 25 then AutoEquip.LB = AutoEquip.LB + 1; msg.Notify("AutoEquip", "LB: "..tostring(AutoEquip.LB)) end
    elseif a.KeyCode==Enum.KeyCode.O then
        if AutoEquip.LB > 0 then AutoEquip.LB = AutoEquip.LB - 1; msg.Notify("AutoEquip", "LB: "..tostring(AutoEquip.LB)) elseif AutoEquip.LB == 0 then msg.Notify("AutoEquip", "LB: None") end
    end
end)
----------------------------------------
UserInputService.InputBegan:connect(function(a,b)
    if a.KeyCode==Enum.KeyCode.G then ClickTP = not ClickTP
        if ClickTP then msg.Notify("ClickTP", "Enabled")
        else msg.Notify("ClickTP", "Disabled") end
    elseif a.KeyCode==Enum.KeyCode.PageUp then
        if ClickTP then LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.CFrame.Position.x, LP.Character.HumanoidRootPart.CFrame.Position.y+200,LP.Character.HumanoidRootPart.CFrame.Position.z) end
    elseif a.KeyCode==Enum.KeyCode.PageDown then
        if ClickTP then LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.CFrame.Position.x, LP.Character.HumanoidRootPart.CFrame.Position.y-200,LP.Character.HumanoidRootPart.CFrame.Position.z) end
    end
end)
mouse.Button1Down:Connect(function() if mouse.Target and ClickTP then LP.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z) end end)
----------------------------------------
