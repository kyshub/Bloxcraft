local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local data = player:WaitForChild("Data")

local MAX_LEVEL = 11500

-- ===== INITIALIZE GAME SETTINGS =====
local args = {
	"AutoSkillX",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"EnableAutoRejoin",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"MuteSFX",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"MuteMusic",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"DisableVFX",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AntiAFKHeartbeat"):FireServer()

local args = {
	"DisableCutscene",
	false
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"DisableOtherVFX",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"DisableScreenShake",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"RemoveTexture",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

local args = {
	"RemoveShadows",
	true
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))

-- ===== BLUR BACKGROUND =====
local blur = Instance.new("DepthOfFieldEffect", Lighting)
blur.FocusDistance = 0
blur.InFocusRadius = 50
blur.NearIntensity = 0.4
blur.FarIntensity = 0.4

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

-- ===== SHADOW =====
local shadow = Instance.new("ImageLabel", gui)
shadow.Size = UDim2.new(0, 420, 0, 240)
shadow.Position = UDim2.new(0.5, -210, 0.5, -120)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 1
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)

-- ===== MAIN =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 220)
main.Position = UDim2.new(0.5, -200, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(245,245,250)

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 20)

-- ===== GRADIENT =====
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220,230,255))
}

-- animate gradient
RunService.RenderStepped:Connect(function()
    gradient.Rotation += 0.2
end)

-- ===== TITLE =====
local title = Instance.new("TextLabel", main)
title.Text = "PLAYER PROGRESS"
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamMedium
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(120,120,120)

-- ===== LEFT SIDE =====
local left = Instance.new("Frame", main)
left.Size = UDim2.new(0.5,0,1,-30)
left.Position = UDim2.new(0,0,0,30)
left.BackgroundTransparency = 1

local function createText(y, text)
    local t = Instance.new("TextLabel", left)
    t.Position = UDim2.new(0,20,0,y)
    t.Size = UDim2.new(1,-20,0,25)
    t.BackgroundTransparency = 1
    t.Font = Enum.Font.GothamBold
    t.TextSize = 16
    t.TextColor3 = Color3.fromRGB(30,30,30)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Text = text
    return t
end

local moneyText = createText(10, "💰 0")
local gemsText = createText(40, "💎 0")
local levelText = createText(70, "⭐ Level 0")
local timeText = createText(100, "⏱ 00:00:00")

-- ===== CIRCLE =====
-- ===== PROGRESS BAR (NEW STYLE) =====
local barBg = Instance.new("Frame", main)
barBg.Size = UDim2.new(0, 140, 0, 12)
barBg.Position = UDim2.new(1, -160, 0.5, -6)
barBg.BackgroundColor3 = Color3.fromRGB(220,220,220)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1,0)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(100,140,255)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1,0)

-- gradient cho đẹp
local fillGradient = Instance.new("UIGradient", barFill)
fillGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120,160,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80,120,255))
}

-- text %
local percentText = Instance.new("TextLabel", main)
percentText.Position = UDim2.new(1, -160, 0.5, 10)
percentText.Size = UDim2.new(0, 140, 0, 20)
percentText.BackgroundTransparency = 1
percentText.Font = Enum.Font.GothamBold
percentText.TextSize = 14
percentText.TextColor3 = Color3.fromRGB(80,80,80)
percentText.Text = "0%"

-- ===== TIME SYSTEM =====
local startTime = tick()

RunService.RenderStepped:Connect(function()
    local t = math.floor(tick() - startTime)
    local h = math.floor(t/3600)
    local m = math.floor((t%3600)/60)
    local s = t%60

    timeText.Text = string.format("Time: %02d:%02d:%02d", h,m,s)
end)

-- ===== SMOOTH =====
local current = 0

local function animate(target)
    local start = current
    local startTime = tick()

    local conn
    conn = RunService.RenderStepped:Connect(function()
        local t = math.clamp((tick()-startTime)/0.4,0,1)
        local val = start + (target-start)*t

        percentText.Text = math.floor(val).."%"
        barFill.Size = UDim2.new(val/100,0,1,0)

        if t >= 1 then
            current = target
            conn:Disconnect()
        end
    end)
end

local function formatNumber(n)
    if n >= 1e6 then
        return string.format("%.1fM", n/1e6)
    elseif n >= 1e3 then
        return string.format("%.1fK", n/1e3)
    else
        return tostring(n)
    end
end

-- ===== UPDATE =====
local function update()
    local level = data.Level.Value
    local percent = math.clamp(level/MAX_LEVEL*100,0,100)

    animate(percent)

    moneyText.Text = "Money: "..formatNumber(data.Money.Value)
    gemsText.Text = "Gems: "..formatNumber(data.Gems.Value)
    levelText.Text =  "Level: "..level
end

update()

-- ===== LEVEL CHECK =====
local level0Triggered = false
local level100Triggered = false
local level500Triggered = false
local level750Triggered = false
local level1500Triggered = false
local level3000Triggered = false
local level5000Triggered = false
local level8000Triggered = false
local level9000Triggered = false
local levelRedeemCodesTriggered = false

-- ===== HELPER FUNCTION: LOAD SCRIPT WITH RETRY =====
local function loadScriptWithRetry(url)
    local maxRetries = 2
    for attempt = 1, maxRetries do
        local success, result = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if success then
            return true
        else
            if attempt < maxRetries then
                task.wait(2)
            end
        end
    end
    return false
end

local function checkPlayerLevel()
    local currentLevel = data.Level.Value
    
    -- REDEEM CODES AT LEVEL 3500 (FIRST TIME)
    if currentLevel >= 3500 and not levelRedeemCodesTriggered then
        levelRedeemCodesTriggered = true
        
        task.spawn(function()
            -- ===== REDEEM ALL CODES =====
            local codes = {
                "TYFOR170KCCUWOW","INSANE180KCCU","OMG190KCCU","THEBIG200KCCUTYSM","EIDMUBARAK","HOGFRAGBUGSORRY","OP160KCCUWOW","TYFOR130KCCU","TYFOR140KCCUILY","THEINSANE150KCCU","ALTERUPDATE","BIGGESTUPDATENEXT","SMALLDELAYVERYSORRY","45KFOLLOWSTYY","HUGEUPDATEW","3SPECS","INSANE110KCCUFR","BEST120KCCU","THEBIG100KOMG","TY90KCCUWWWWW","95KCCUSOCLOSE","85KCCUABSURD","TY80KCCUWOWWW","75KCCUWOAH","SORRYFORRESTARTS","SORRYFOR1HDELAY","30KFOLLOWTY","30MVISITS","SORRYSUDDENRESTART","BADISSUESSORRY","BOSSRUSH","VERYBIGUPDATESOON","SINOFPRIDE","15KFOLLOWTY","ROGUEALLIES","RUSHKEYCODE","INSANE60KCCU","65KCCUWOWW","55KCCUWOWW","40KCCUWILD","35KCCUWOW","30KCCU","25KCCU","12.5KFOLLOWTY","10KFOLLOWTY","7.5KFOLLOWTY","ROGUE","UPD5","TYFOR20KCCU","TYFOR15KCCU","TYFOR10KCCU","UPD4.5","GILGAGOAT","5KFOLLOWAGAINTY","HUGEUPDATESOONFR","SORRYFORMOREISSUES","25KLIKES","5KFOLLOWS","VALENTINEEVENT","UPD4","BIGUPDATEFR","5MVISITS","CONQHAKIQUESTFIXEDHOPEFULLY","SORRYFORMORERESTART","SORRYFORTHEBUG","UPD3.5","MOREBLEACH","BETTERCODEHERE","HUGEUPDATES","BIGJJK","UPDATE3","NEWCODE","LOWERSPAWNTIME","SORRYFORSMALLDELAY","SORRYFORBADBUG","20KLIKES","LASTRESTARTIHOPE","DUNGEONSHOP","UPDATE2.5","MOREQOL","3MVISITS","2MVISITS","15KLIKES","5KCCU","UPDATE2","20KMEMBERS","DUNGEONS","BIGUPDATESOON","QOLUPDATE","10KLIKES","15KMEMBERS","SORRYFORQUEST","MANYRESTARTS","QOLUPDATEVERYSOON","UPDATE1","ARTIFACTS","5KLIKES","DELAYSORRY","500KVISITS","10KMEMBERS","UPDATE0.5"
            }
            
            for _, code in ipairs(codes) do
                local args = {
                    code
                }
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("CodeRedeem"):InvokeServer(unpack(args))
                task.wait(0.1)
            end
        end)
    end
    
    -- LEVEL 0
    if currentLevel == 0 and not level0Triggered then
        level0Triggered = true
        loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/199')
    -- LEVEL 100
    elseif currentLevel >= 100 and currentLevel < 500 and not level100Triggered then
        level100Triggered = true
        
        -- ===== LEVEL 100 SCRIPT =====
        task.wait(2)
        
        local targetPos = Vector3.new(-445.70, -2.81, 366.57)
        local reachedTarget = false
        
        -- ===== TWEEN UNTIL REACHED =====
        task.spawn(function()
            local startTweenTime = tick()
            while not reachedTarget do
                -- TIMEOUT 60 SECONDS
                if tick() - startTweenTime > 60 then
                    reachedTarget = true
                    break
                end
                
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - targetPos).Magnitude
                        
                        if distance < 5 then
                            reachedTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(targetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED TARGET =====
            local char = player.Character or player.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            task.wait(2)
            local prompt = workspace.JungleIsland.SpawnPointCrystal_Jungle:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end
            
            -- ===== WAIT AND CHECK LEVEL =====
            task.wait(2)
            
            local checkLevel = data.Level.Value
            if checkLevel >= 99 and checkLevel <= 500 then
                loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/100500')
            end
        end)
    
    -- LEVEL 500
    elseif currentLevel >= 500 and currentLevel < 750 and not level500Triggered then
        level500Triggered = true
        
        -- ===== LEVEL 500 SCRIPT =====
        task.wait(2)
        
        local targetPos = Vector3.new(-691.33, 0.97, -348.32)
        local reachedTarget = false
        
        -- ===== TWEEN UNTIL REACHED =====
        task.spawn(function()
            while not reachedTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - targetPos).Magnitude
                        
                        if distance < 5 then
                            reachedTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(targetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED TARGET =====
            local char = player.Character or player.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            task.wait(2)
            local prompt = workspace.DesertIsland.SpawnPointCrystal_Desert:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end
            
            -- ===== RUN SCRIPT 500-750 =====
            task.wait(2)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/500750')
        end)
    
    -- LEVEL 750
    elseif currentLevel >= 750 and currentLevel < 1500 and not level750Triggered then
        level750Triggered = true
        
        -- ===== LEVEL 750 SCRIPT =====
        local args = {
	        "Use",
	        "Legendary Chest",
	        1,
	        false
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))

        task.wait(10)
        
        local teleportRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        local targetTeleportPos = Vector3.new(-176.16, -4.15, -997.13)
        local finalTargetPos = Vector3.new(-230.96, -3.48, -980)
        local reachedFinalTarget = false
        
        -- ===== TELEPORT AND VERIFY POSITION =====
        task.spawn(function()
            local correctPosition = false
            
            while not correctPosition do
                -- TELEPORT TO SNOW
                teleportRemote:FireServer("Snow")
                task.wait(1)
                
                -- CHECK POSITION
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - targetTeleportPos).Magnitude
                        
                        if distance < 10 then
                            correctPosition = true
                            break
                        else
                            task.wait(2)
                        end
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== TWEEN TO FINAL POSITION =====
            while not reachedFinalTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - finalTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedFinalTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(finalTargetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED FINAL TARGET =====
            task.wait(2)
            local char = player.Character or player.CharacterAdded:Wait()
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            local prompt = workspace.SnowIsland.SpawnPointCrystal_Snow:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3)
            end
            
            -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))

            local args = {
            	"Use",
            	"Common Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            -- ===== MOVE TO DARK BLADE POSITION =====
            task.wait(1)
            
            local nextTargetPos = Vector3.new(-134.90, 13.23, -1091.99)
            local reachedNext = false
            
            while not reachedNext do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - nextTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedNext = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(nextTargetPos)}
                        )
                        
                        tween:Play()
                        
                        local done = false
                        tween.Completed:Connect(function()
                            done = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until done or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== TRIGGER DARK BLADE NPC =====
            task.wait(1)
            
            local npc = workspace:FindFirstChild("ServiceNPCs") and workspace.ServiceNPCs:FindFirstChild("DarkBladeNPC")
            if npc then
                local npcPrompt = npc:FindFirstChildWhichIsA("ProximityPrompt", true)
                
                if npcPrompt then
                    fireproximityprompt(npcPrompt, 3)
                end
            end
            
            -- ===== EQUIP DARK BLADE =====
            local args = {
                "Equip",
                "Dark Blade"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipWeapon"):FireServer(unpack(args))
            
            -- ===== RESET STATS =====
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ResetStats"):FireServer()
            
            -- ===== ALLOCATE STATS =====
            local args = {
            	"Defense",
            	500
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("AllocateStat"):FireServer(unpack(args))
            
            local args = {
            	"Sword",
            	25000
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("AllocateStat"):FireServer(unpack(args))
            
            -- ===== RUN SCRIPT 750-1500 =====
            task.wait(1)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/7501500')
        end)
    
    -- LEVEL 1500
    elseif currentLevel >= 1500 and currentLevel < 3000 and not level1500Triggered then
        level1500Triggered = true
        
        -- ===== LEVEL 1500 SCRIPT =====
        task.wait(10)
        
        local teleportRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        local finalTargetPos = Vector3.new(1356.56, 13.72, 248.94)
        local reachedFinalTarget = false
        
        -- ===== TELEPORT TO SHIBUYA =====
        teleportRemote:FireServer("Shibuya")
        task.wait(1)
        
        -- ===== TWEEN TO FINAL POSITION =====
        task.spawn(function()
            while not reachedFinalTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - finalTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedFinalTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(finalTargetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED FINAL TARGET =====
            task.wait(2)
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            local prompt = workspace.ShibuyaStation.SpawnPointCrystal_Shibuya:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end

                        -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))

            local args = {
            	"Use",
            	"Common Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))

            local codes = {
                "TYFOR170KCCUWOW","INSANE180KCCU","OMG190KCCU","THEBIG200KCCUTYSM","EIDMUBARAK","HOGFRAGBUGSORRY","OP160KCCUWOW","TYFOR130KCCU","TYFOR140KCCUILY","THEINSANE150KCCU","ALTERUPDATE","BIGGESTUPDATENEXT","SMALLDELAYVERYSORRY","45KFOLLOWSTYY","HUGEUPDATEW","3SPECS","INSANE110KCCUFR","BEST120KCCU","THEBIG100KOMG","TY90KCCUWWWWW","95KCCUSOCLOSE","85KCCUABSURD","TY80KCCUWOWWW","75KCCUWOAH","SORRYFORRESTARTS","SORRYFOR1HDELAY","30KFOLLOWTY","30MVISITS","SORRYSUDDENRESTART","BADISSUESSORRY","BOSSRUSH","VERYBIGUPDATESOON","SINOFPRIDE","15KFOLLOWTY","ROGUEALLIES","RUSHKEYCODE","INSANE60KCCU","65KCCUWOWW","55KCCUWOWW","40KCCUWILD","35KCCUWOW","30KCCU","25KCCU","12.5KFOLLOWTY","10KFOLLOWTY","7.5KFOLLOWTY","ROGUE","UPD5","TYFOR20KCCU","TYFOR15KCCU","TYFOR10KCCU","UPD4.5","GILGAGOAT","5KFOLLOWAGAINTY","HUGEUPDATESOONFR","SORRYFORMOREISSUES","25KLIKES","5KFOLLOWS","VALENTINEEVENT","UPD4","BIGUPDATEFR","5MVISITS","CONQHAKIQUESTFIXEDHOPEFULLY","SORRYFORMORERESTART","SORRYFORTHEBUG","UPD3.5","MOREBLEACH","BETTERCODEHERE","HUGEUPDATES","BIGJJK","UPDATE3","NEWCODE","LOWERSPAWNTIME","SORRYFORSMALLDELAY","SORRYFORBADBUG","20KLIKES","LASTRESTARTIHOPE","DUNGEONSHOP","UPDATE2.5","MOREQOL","3MVISITS","2MVISITS","15KLIKES","5KCCU","UPDATE2","20KMEMBERS","DUNGEONS","BIGUPDATESOON","QOLUPDATE","10KLIKES","15KMEMBERS","SORRYFORQUEST","MANYRESTARTS","QOLUPDATEVERYSOON","UPDATE1","ARTIFACTS","5KLIKES","DELAYSORRY","500KVISITS","10KMEMBERS","UPDATE0.5"
            }
            
            for _, code in ipairs(codes) do
                local args = {
                    code
                }
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("CodeRedeem"):InvokeServer(unpack(args))
                task.wait(0.1)
            end
            
            -- ===== WAIT AND TWEEN TO GRYPHON POSITION =====
            task.wait(2)
            
            local gryphonPos = Vector3.new(1431.46, 9.99, 275.81)
            local reachedGryphonPos = false
            
            while not reachedGryphonPos do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - gryphonPos).Magnitude
                        
                        if distance < 5 then
                            reachedGryphonPos = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(gryphonPos)}
                        )
                        
                        tween:Play()
                        
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== TRIGGER GRYPHON BUYER NPC =====
            task.wait(1)
            
            local npc = workspace:FindFirstChild("ServiceNPCs") and workspace.ServiceNPCs:FindFirstChild("GryphonBuyerNPC")
            if npc then
                local npcPrompt = npc:FindFirstChildWhichIsA("ProximityPrompt", true)
                
                if npcPrompt then
                    fireproximityprompt(npcPrompt, 3)
                end
            end
            
            -- ===== EQUIP GRYPHON =====
            local args = {
                "Equip",
                "Gryphon"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipWeapon"):FireServer(unpack(args))

            -- == Clan Reroll ==--
            local args = {
                "Use",
                "Clan Reroll",
                1,
                false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            -- ===== RUN SCRIPT 1500-3000 =====
            task.wait(1)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/15003000')
        end)
    
    -- LEVEL 3000-5000
    elseif currentLevel >= 3000 and currentLevel < 5000 and not level3000Triggered then
        level3000Triggered = true
        
        -- ===== LEVEL 3000-5000 SCRIPT =====
        task.wait(10)
        
        local teleportRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        local finalTargetPos = Vector3.new(-480.79, -3.44, 933.99)
        local reachedFinalTarget = false
        
        -- ===== TELEPORT TO SHIBUYA =====
        teleportRemote:FireServer("HuecoMundo")
        task.wait(1)
        
        -- ===== TWEEN TO FINAL POSITION =====
        task.spawn(function()
            while not reachedFinalTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - finalTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedFinalTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(finalTargetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED FINAL TARGET =====
            task.wait(2)
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            local prompt = workspace.HuecoMundo.SpawnPointCrystal_HuecoMundo:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end

                        -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            -- == Enchant Stat ==--
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RerollAllStats"):InvokeServer()
            -- == Trait Reroll ==--
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("TraitReroll"):FireServer()

            -- ===== RUN SCRIPT 3000-5000 =====
            task.wait(1)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/30005000')
        end)
    
    -- LEVEL 5000-8000
    elseif currentLevel >= 5000 and currentLevel < 8000 and not level5000Triggered then
        level5000Triggered = true
        
        -- ===== LEVEL 5000-8000 SCRIPT =====
        task.wait(10)
        
        local teleportRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        local finalTargetPos = Vector3.new(364.65, -2.35, -1630.44)
        local reachedFinalTarget = false
        
        -- ===== TELEPORT TO SHIBUYA =====
        teleportRemote:FireServer("Shinjiku")
        task.wait(1)
        
        -- ===== TWEEN TO FINAL POSITION =====
        task.spawn(function()
            while not reachedFinalTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - finalTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedFinalTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(finalTargetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED FINAL TARGET =====
            task.wait(2)
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            local prompt = workspace.ShinjukuIsland.SpawnPointCrystal_Shinjuku:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end

            -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            -- ===== RUN SCRIPT 5000-8000 =====
            task.wait(1)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/50008000')
        end)
    
    -- LEVEL 8000-9000
    elseif currentLevel >= 8000 and currentLevel < 9000 and not level8000Triggered then
        level8000Triggered = true
        
        -- ===== LEVEL 8000-9000 SCRIPT =====
        task.wait(10)
        
        local teleportRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        local finalTargetPos = Vector3.new(-984.37, -3.80, 257.90)
        local reachedFinalTarget = false
        
        -- ===== TELEPORT TO SHIBUYA =====
        teleportRemote:FireServer("Slime")
        task.wait(1)
        
        -- ===== TWEEN TO FINAL POSITION =====
        task.spawn(function()
            while not reachedFinalTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - finalTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedFinalTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(finalTargetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED FINAL TARGET =====
            task.wait(2)
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            local prompt = workspace.SlimeIsland.SpawnPointCrystal_Slime:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end

            -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local codes = {
                "TYFOR170KCCUWOW","INSANE180KCCU","OMG190KCCU","THEBIG200KCCUTYSM","EIDMUBARAK","HOGFRAGBUGSORRY","OP160KCCUWOW","TYFOR130KCCU","TYFOR140KCCUILY","THEINSANE150KCCU","ALTERUPDATE","BIGGESTUPDATENEXT","SMALLDELAYVERYSORRY","45KFOLLOWSTYY","HUGEUPDATEW","3SPECS","INSANE110KCCUFR","BEST120KCCU","THEBIG100KOMG","TY90KCCUWWWWW","95KCCUSOCLOSE","85KCCUABSURD","TY80KCCUWOWWW","75KCCUWOAH","SORRYFORRESTARTS","SORRYFOR1HDELAY","30KFOLLOWTY","30MVISITS","SORRYSUDDENRESTART","BADISSUESSORRY","BOSSRUSH","VERYBIGUPDATESOON","SINOFPRIDE","15KFOLLOWTY","ROGUEALLIES","RUSHKEYCODE","INSANE60KCCU","65KCCUWOWW","55KCCUWOWW","40KCCUWILD","35KCCUWOW","30KCCU","25KCCU","12.5KFOLLOWTY","10KFOLLOWTY","7.5KFOLLOWTY","ROGUE","UPD5","TYFOR20KCCU","TYFOR15KCCU","TYFOR10KCCU","UPD4.5","GILGAGOAT","5KFOLLOWAGAINTY","HUGEUPDATESOONFR","SORRYFORMOREISSUES","25KLIKES","5KFOLLOWS","VALENTINEEVENT","UPD4","BIGUPDATEFR","5MVISITS","CONQHAKIQUESTFIXEDHOPEFULLY","SORRYFORMORERESTART","SORRYFORTHEBUG","UPD3.5","MOREBLEACH","BETTERCODEHERE","HUGEUPDATES","BIGJJK","UPDATE3","NEWCODE","LOWERSPAWNTIME","SORRYFORSMALLDELAY","SORRYFORBADBUG","20KLIKES","LASTRESTARTIHOPE","DUNGEONSHOP","UPDATE2.5","MOREQOL","3MVISITS","2MVISITS","15KLIKES","5KCCU","UPDATE2","20KMEMBERS","DUNGEONS","BIGUPDATESOON","QOLUPDATE","10KLIKES","15KMEMBERS","SORRYFORQUEST","MANYRESTARTS","QOLUPDATEVERYSOON","UPDATE1","ARTIFACTS","5KLIKES","DELAYSORRY","500KVISITS","10KMEMBERS","UPDATE0.5"
            }
            
            for _, code in ipairs(codes) do
                local args = {
                    code
                }
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("CodeRedeem"):InvokeServer(unpack(args))
                task.wait(0.1)
            end
            
            local args = {
	            "King"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("TitleEquip"):FireServer(unpack(args))

            -- ===== RUN SCRIPT 8000-9000 =====
            task.wait(2)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/80009000')
        end)
    
    -- LEVEL 9000-11500
    elseif currentLevel >= 9000 and currentLevel < 11500 and not level9000Triggered then
        level9000Triggered = true
        
        -- ===== LEVEL 9000-11500 SCRIPT =====
        task.wait(10)
        
        local teleportRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        local finalTargetPos = Vector3.new(-957.49, -2.08, -1058.58)
        local reachedFinalTarget = false
        
        -- ===== TELEPORT TO SHIBUYA =====
        teleportRemote:FireServer("Judgement")
        task.wait(1)
        
        -- ===== TWEEN TO FINAL POSITION =====
        task.spawn(function()
            while not reachedFinalTarget do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - finalTargetPos).Magnitude
                        
                        if distance < 5 then
                            reachedFinalTarget = true
                            break
                        end
                        
                        -- NOCLIP
                        for _, v in pairs(char:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                        
                        -- TWEEN
                        local speed = 150
                        local time = distance / speed
                        
                        local tween = TweenService:Create(
                            root,
                            TweenInfo.new(time, Enum.EasingStyle.Linear),
                            {CFrame = CFrame.new(finalTargetPos)}
                        )
                        
                        tween:Play()
                        
                        -- WAIT FOR TWEEN OR CHARACTER DEATH
                        local tweenFinished = false
                        tween.Completed:Connect(function()
                            tweenFinished = true
                        end)
                        
                        repeat
                            task.wait(0.1)
                        until tweenFinished or not char.Parent or char:FindFirstChild("Humanoid").Health <= 0
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            
            -- ===== REACHED FINAL TARGET =====
            task.wait(2)
            
            -- ===== TRIGGER PROXIMITY PROMPT =====
            local prompt = workspace.JudgementIsland.SpawnPointCrystal_Judgement:FindFirstChildWhichIsA("ProximityPrompt", true)
            
            if prompt then
                fireproximityprompt(prompt, 3) -- giữ E 3 giây
            end

                        -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))            -- ===== USE CHESTS =====
            task.wait(2)
            
            local args = {
            	"Use",
            	"Rare Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Epic Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            local args = {
            	"Use",
            	"Legendary Chest",
            	999,
            	false
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UseItem"):FireServer(unpack(args))
            
            -- ===== RUN SCRIPT 9000-11500 =====
            task.wait(1)
            loadScriptWithRetry('https://raw.githubusercontent.com/Datxi7567/calemchem/refs/heads/main/900011500')
        end)
    end
end

checkPlayerLevel()

data.Level:GetPropertyChangedSignal("Value"):Connect(function()
    update()
    checkPlayerLevel()
end)
data.Money:GetPropertyChangedSignal("Value"):Connect(update)
data.Gems:GetPropertyChangedSignal("Value"):Connect(update)