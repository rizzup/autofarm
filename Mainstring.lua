repeat task.wait() until game:IsLoaded() and game:GetService("ReplicatedStorage"):FindFirstChild("Library") and game.Players.LocalPlayer
getgenv().webhook = ""
local mult = "100x"
local lib = require(game:GetService("ReplicatedStorage").Library)
lib:Load()
local CurrentWorld = lib.WorldCmds.Get()
local world
local chestToMine
local oldJob = game.JobId
local isCoinEffect = false
local loadingworld
local foundKawaii
local chestId
local RealChest
local http_request = http_request or request or HttpPost or syn.request
local chest = "Kawaii Temple Chest"
getgenv().cooldown = 0.09
local InvokeHook = hookfunction(debug.getupvalue(lib.Network.Invoke, 1), function(...) return true end)
local FireHook = hookfunction(debug.getupvalue(lib.Network.Fire, 1), function(...) return true end)
local Fire, Invoke = lib.Network.Fire, lib.Network.Invoke
local bypass = Instance.new("Sound", Workspace)
local audiohook = hookfunction(lib.Audio.Play,function()
    return bypass
end)

local function idToStr(id)
if id == "rbxassetid://12816083942" then
    RealChest = "Kawaii Temple Chest"
elseif id == "rbxassetid://12886237293" then
RealChest = "Dojo Chest"
end
return RealChest
end

function webhook(color,webhook,chestId,mult)
    local data = {
       ["content"] = "@everyone",
       ["username"] = "Chest Finder",
       ["embeds"] = {
           {
               ["title"] = "A " .. mult .. " " .. idToStr(chestId) .." has been found",
               ["description"] = "Join script: ```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance("..tostring(game.PlaceId)..","..'"'..tostring(game.JobId)..'"'..", game.Players.LocalPlayer)```",
               ["type"] = "rich",
               ["color"] = color
           }
       },
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)
    
    local headers = {
       ["content-type"] = "application/json"
    }
    
    local a = {Url = webhook, Body = newdata, Method = "POST", Headers = headers}
  
    http_request(a)
    end


local function serverHop()
    repeat
        local data = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&excludeFullGames=true&limit=100"))
        local bestserver
        for i,v in pairs(data.data) do
          if (tonumber(v.playing) < 12) and (tonumber(v.playing) > 0) then
            bestserver = v.id
          end
        end
        
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, bestserver, game.Players.LocalPlayer)
        task.wait(1)
 until oldJob ~= game.JobId
end
local c = require(game:GetService("ReplicatedStorage")["__DIRECTORY"].Coins["Grab All Coins"])
local function getCoinWorld(chest)
    for i,v in pairs(c) do
        if i == chest then
            for i,v in pairs(v) do
                if i == "world" then
                    world = v
                end
            end
        end
    end
    return world
end

local function IsEquipped(UID)
    if lib.Save.Get().PetsEquipped[UID] or lib.Save.Get().PetsEquipped[UID] then
        return true
    end
end

local function getEquipped()
    local pets = {}
    for i,v in pairs(lib.Save.Get().Pets) do
        if IsEquipped(v.uid) then
            table.insert(pets,v.uid)
        end
    end
    return pets
end

local function dothething()
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
        if v:FindFirstChild("Coin") and v.Coin.MeshId == "rbxassetid://12816083942" then
            foundKawaii = true
            if v.Coin:FindFirstChild("SpecialBonusParticleCoins") then
                chestId = "rbxassetid://12816083942"
                isCoinEffect = true
               chestToMine = v
                end
        end
    end
repeat task.wait()     
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
    if v:FindFirstChild("Coin") and v.Coin.MeshId == "rbxassetid://12816083942" then
        foundKawaii = true
        if v.Coin:FindFirstChild("SpecialBonusParticleCoins") then
            chestId = "rbxassetid://12816083942" -- kawaii
            isCoinEffect = true
           chestToMine = v
            end
    end
end
until foundKawaii == true
    
    if not isCoinEffect then
        for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
            if v:FindFirstChild("Coin") and v.Coin.MeshId == "rbxassetid://12886237293" then
                if v.Coin:FindFirstChild("SpecialBonusParticleCoins") then
                chestId = "rbxassetid://12886237293" -- dojo
                isCoinEffect = true
               chestToMine = v
                end
            end
        end
    end
    if not isCoinEffect then
        serverHop()
    end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chestToMine.POS.CFrame * CFrame.new(0,30,0)
        task.wait(0.3)
        local pets = getEquipped()
    repeat task.wait() Invoke("Join Coin", chestToMine.Name, pets) until chestToMine.POS:FindFirstChild("HUD")
    task.wait(0.3)
        if chestToMine.POS.HUD:FindFirstChild("SpecialBonusTextCoins") and not string.find(chestToMine.POS.HUD.SpecialBonusTextCoins.Text,mult) then
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
                if v:FindFirstChild("Coin") and v.Coin.MeshId == "rbxassetid://12886237293" then
                    if v.Coin:FindFirstChild("SpecialBonusParticleCoins") then
                        chestId = "rbxassetid://12886237293"
                    isCoinEffect = true
                   chestToMine = v
                    end
                end
            end
        
            if not isCoinEffect then
                serverHop()
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chestToMine.POS.CFrame * CFrame.new(0,30,0)
            task.wait(0.3)
            local pets = getEquipped()
            repeat task.wait() Invoke("Join Coin", chestToMine.Name, pets) until chestToMine.POS:FindFirstChild("HUD")
            if not string.find(chestToMine.POS.HUD.SpecialBonusTextCoins.Text,mult) then
                print(chestToMine.POS.HUD.SpecialBonusTextCoins.Text)
                serverHop()
            end
        end
        
        webhook(0x9370DB,getgenv().webhook,chestId,mult)
        task.spawn(function()
            while true do
                if chestToMine ~= nil then
            task.wait(getgenv().cooldown)
            local pets = getEquipped()
            Invoke("Join Coin", chestToMine.Name, pets)
            for i = 1,#pets do
            local pet = pets[i]
            Fire("Farm Coin", chestToMine.Name, pet)
            end
            end
            end
            end)
end


if getCoinWorld(chest) ~= CurrentWorld then
   lib.WorldCmds.Load(getCoinWorld())
   loadingworld = true
end
if loadingworld then
repeat task.wait() until getCoinWorld() == lib.WorldCmds.Get()
task.wait(2)
dothething()
else
    dothething()
end
