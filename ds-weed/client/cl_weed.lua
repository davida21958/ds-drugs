local DSBase = exports['ds-base']:GetCoreObject()

isLoggedIn = false
PlayerJob = {}
local SpawnedPlants = {}
local InteractedPlant = nil
local HarvestedPlants = {}
local canHarvest = true
local closestPlant = nil
local isDoingAction = false

-- Create plants
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(150)
    local player = PlayerPedId()
    local position = GetEntityCoords(player)
    local inRange = false
    for i = 1, #Config.Plants do
        local dist = GetDistanceBetweenCoords(position.x, position.y, position.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
            if dist < 50.0 then
                inRange = true
                local hasSpawned = false
                local needsUpgrade = false
                local upgradeId = nil
                local tableRemove = nil    
                for z = 1, #SpawnedPlants do
                    local p = SpawnedPlants[z]    
                    if p.id == Config.Plants[i].id then
                        hasSpawned = true
                        if p.stage ~= Config.Plants[i].stage then
                            needsUpgrade = true
                            upgradeId = p.id
                            tableRemove = z
                        end
                    end
                end    
                if not hasSpawned then
                    local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                    RequestModel(hash)
                    local data = {}
                    data.id = Config.Plants[i].id
                    data.stage = Config.Plants[i].stage    
                    while not HasModelLoaded(hash) do
                        Citizen.Wait(10)
                        RequestModel(hash)
                    end    
                    data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z + GetPlantZ(Config.Plants[i].stage), false, false, false) 
                    SetEntityAsMissionEntity(data.obj, true)
                    FreezeEntityPosition(data.obj, true)
                    table.insert(SpawnedPlants, data)
                    hasSpawned = false
                end    
                if needsUpgrade then
                    for o = 1, #SpawnedPlants do
                        local u = SpawnedPlants[o]    
                        if u.id == upgradeId then
                            SetEntityAsMissionEntity(u.obj, false)
                            FreezeEntityPosition(u.obj, false)
                            DeleteObject(u.obj)   
                            local hash = GetHashKey(Config.WeedStages[Config.Plants[i].stage])
                            RequestModel(hash)
                            local data = {}
                            data.id = Config.Plants[i].id
                            data.stage = Config.Plants[i].stage    
                            while not HasModelLoaded(hash) do
                                Citizen.Wait(10)
                                RequestModel(hash)
                            end    
                            data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z + GetPlantZ(Config.Plants[i].stage), false, false, false) 
                            SetEntityAsMissionEntity(data.obj, true)
                            FreezeEntityPosition(data.obj, true)
                            table.remove(SpawnedPlants, o)
                            table.insert(SpawnedPlants, data)
                            needsUpgrade = false
                        end
                    end
                end
            end
        end
    if not InRange then
        Citizen.Wait(5000)
    end
    end
end)

-- Destroy plants
function DestroyPlant()
    local plant = GetClosestPlant()
    local hasDone = false
    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end
    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local player = PlayerPedId()
		playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
        FreezeEntityPosition(player, true)
        isDoingAction = true
		TriggerServerEvent('ds-weed:server:PlantHarvested', plant.id)
        Progressbar(5000,"Destroying plant")
		ClearPedTasks(playerPed)
		Wait(500) -- Done
        TriggerServerEvent('ds-weed:server:DestroyPlants', plant.id)
        isDoingAction = false
        canHarvest = true
        FreezeEntityPosition(player, false)
        ClearPedTasksImmediately(player)
	end
end

-- Harvest plants
function HarvestWeedPlant()
    local plant = GetClosestPlant()
    local hasDone = false
    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end
    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local player = PlayerPedId()
		playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
        FreezeEntityPosition(player, true)
        isDoingAction = true
        Progressbar(5000,"Harvesting plant")
		ClearPedTasks(playerPed)
		Wait(500) -- Done
        TriggerServerEvent('ds-weed:server:HarvestPlant', plant.id)
        isDoingAction = false
        canHarvest = true
        FreezeEntityPosition(player, false)
        ClearPedTasksImmediately(player)
	end
end

-- Remove plants from sql
function RemovePlantFromTable(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
end

-- Feed/water or destroy plants
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local InRange = false
            local player = PlayerPedId()
            local position = GetEntityCoords(player)
            for k, v in pairs(Config.Plants) do
                if GetDistanceBetweenCoords(position.x, position.y, position.z, v.x, v.y, v.z, true) < 1.3 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(PlayerPedId(), false) then
                    if PlayerJob.name == 'police' then
                        local plant = GetClosestPlant()
                        DrawText3D(v.x, v.y, v.z, 'Type: ' .. v.type .. ' - Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - ~g~Growth~w~: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
                        DrawText3D(v.x, v.y, v.z - 0.18, '~r~G~w~ - Destroy Plant')
                        if IsControlJustReleased(0, 47) then
                            if v.id == plant.id then
                                DestroyPlant()
                            end
                        end
                    else
                        if v.growth < 100 then
                            local plant = GetClosestPlant()    
							DrawText3D(v.x, v.y, v.z, 'Type: ' .. v.type .. ' - Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - ~g~Growth~w~: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
                            DrawText3D(v.x, v.y, v.z - 0.18, '~b~[G]~w~ - Water   -   ~g~[H]~w~ - Feed')
                            if IsControlJustReleased(0, 47) then
                                if v.id == plant.id then
                                    if DSBase.Functions.HasItem('water') then
                                        TriggerEvent("ds-weed:client:WaterPlants")
                                    else
                                        TriggerEvent('ds-weed:client:notify', 'You are missing water','error')
                                    end                                    
                                end
                            elseif IsControlJustReleased(0, 74) then
                                if v.id == plant.id then
                                    if DSBase.Functions.HasItem('fertilizer') then
                                    TriggerEvent("ds-weed:client:FeedPlants")
                                    TriggerEvent("ds-weed:client:WaterPlants")
                                else
                                    TriggerEvent('ds-weed:client:notify', 'You are missing fertilizer','error')
                                end  
                                end
                            end
                        else
                            DrawText3D(v.x, v.y, v.z, 'Type: ' .. v.type .. '[Quality: ' .. v.quality .. ']')
                            DrawText3D(v.x, v.y, v.z - 0.18, '~g~E~w~ - Harvest')
                            if IsControlJustReleased(0, 38) and canHarvest then
                                local plant = GetClosestPlant()
                                if v.id == plant.id then
                                    HarvestWeedPlant()
                                end
                            end
                        end
                    end
                end
            end
    end
end)

-- Get closest plant data
function GetClosestPlant()
    local dist = 1000
    local player = PlayerPedId()
    local position = GetEntityCoords(player)
    local plant = {}
    for i = 1, #Config.Plants do
        local distance = GetDistanceBetweenCoords(position.x, position.y, position.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
        if distance < dist then
            dist = distance
            plant = Config.Plants[i]
        end
    end

    return plant
end

-- Deletes plant
RegisterNetEvent('ds-weed:client:RemovePlant')
AddEventHandler('ds-weed:client:RemovePlant', function(plant)
    for i = 1, #SpawnedPlants do
        local o = SpawnedPlants[i]
        if o.id == plant then
            SetEntityAsMissionEntity(o.obj, false)
            FreezeEntityPosition(o.obj, false)
            DeleteObject(o.obj)
        end
    end
end)

-- Notifications
RegisterNetEvent('ds-weed:client:notify')
AddEventHandler('ds-weed:client:notify', function(msg)
    DSBase.Functions.Notify(msg)
end)

-- Water plants
RegisterNetEvent('ds-weed:client:WaterPlants')
AddEventHandler('ds-weed:client:WaterPlants', function()
    local entity = nil
    local plant = GetClosestPlant()
    local player = PlayerPedId()
	playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
    FreezeEntityPosition(player, true)
    isDoingAction = true
    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
    Progressbar(5000,"Watering plant")
	ClearPedTasks(playerPed)
	Wait(500)
    FreezeEntityPosition(player, false)
    TriggerServerEvent('ds-weed:server:WaterPlants', plant.id)
    ClearPedTasksImmediately(PlayerPedId())
    isDoingAction = false
end)

-- Feed plants
RegisterNetEvent('ds-weed:client:FeedPlants')
AddEventHandler('ds-weed:client:FeedPlants', function()
    local entity = nil
	local playerPed = PlayerPedId()
    local plant = GetClosestPlant()
    local player = PlayerPedId()
	playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
    FreezeEntityPosition(player, true)
    isDoingAction = true
    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
    Progressbar(5000,"Feeding plant")
	ClearPedTasks(playerPed)
	Wait(500)
    TriggerServerEvent('ds-weed:server:FeedPlants', plant.id)
    FreezeEntityPosition(player, false)
    ClearPedTasksImmediately(PlayerPedId())
    isDoingAction = false
end)

-- Update plants
RegisterNetEvent('ds-weed:client:UpdatePlants')
AddEventHandler('ds-weed:client:UpdatePlants', function(data)
    Config.Plants = data
end)

-- Plant seeds
RegisterNetEvent('ds-weed:client:SeedPlanted')
AddEventHandler('ds-weed:client:SeedPlanted', function(type)
    local position = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
    if CanPlantSeedHere(position) and not IsPedInAnyVehicle(PlayerPedId(), false) then
        Progressbar(2000,"Planting Seed")
        TriggerServerEvent('ds-weed:server:SeedPlanted', type, position)
    else
        DSBase.Functions.Notify("Too close to another plant", "error")
    end
end)

-- Confirm seed
RegisterNetEvent('ds-weed:client:ConfirmSeed')
AddEventHandler('ds-weed:client:ConfirmSeed', function()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Citizen.Wait(7)
    end
    TaskPlayAnim(PlayerPedId(), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false)
    Citizen.Wait(1800)
    ClearPedTasks(PlayerPedId())
end)

-- Drawtext 
function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 41, 11, 41, 68)
    ClearDrawOrigin()
end

-- Checks if can plant seed
function CanPlantSeedHere(position)
    local canPlant = true
    for i = 1, #Config.Plants do
        if GetDistanceBetweenCoords(position.x, position.y, position.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true) < 1.3 then
            canPlant = false
        end
    end
    return canPlant
end

-- Plant z stage
function GetPlantZ(stage)
    if stage == 1 then
        return -1.0
    else
        return -3.5
    end
end

-- Animations
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

-- Player loaded
RegisterNetEvent('DSBase:Client:OnPlayerLoaded')
AddEventHandler('DSBase:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = DSBase.Functions.GetPlayerData().job
end)

-- Job update
RegisterNetEvent('DSBase:Client:OnJobUpdate')
AddEventHandler('DSBase:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

function Progressbar(duration, label)
    local retval = nil
    DSBase.Functions.Progressbar("weed", label, duration, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {}, {}, {}, function()
        retval = true
    end, function()
        retval = false
    end)

    while retval == nil do
        Wait(1)
    end

    return retval
end