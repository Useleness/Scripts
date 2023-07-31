_G.Test1 = true -- True or False.
local metoolbp = game.Players.LocalPlayer.Backpack:FindFirstChild("Meditate")
local metoolcr = game.Players.LocalPlayer.Character:FindFirstChild("Meditate")
local rl11 = game.Players.LocalPlayer.DataValues.Realm.Value
local rl12 = game.Players.LocalPlayer.DataValues.RealmRank.Value
while _G.Test1 do task.wait()
	local QI = game.Players.LocalPlayer.DataValues.QI.Value
	task.wait(0.5)
	if game.Players.LocalPlayer.DataValues.QI.Value == QI then
		if metoolbp ~= nil then metoolbp.Parent = game.Players.LocalPlayer.Character; task.wait() end
		metoolcr:Activate()
	end
end
--game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.dimasikprofi4.Character.HumanoidRootPart.CFrame - Teleport on player
