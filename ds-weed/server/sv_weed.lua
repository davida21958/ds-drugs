local DSBase = exports['ds-base']:GetCoreObject()


local PlantsLoaded = false

-- Plant seeds
DSBase.Functions.CreateUseableItem("weed_white-widow_seed", function(source, item)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('plant_pot') ~= nil then
        item = Player.Functions.GetItemByName('plant_pot').amount
        TriggerClientEvent('ds-weed:client:SeedPlanted', src, 'white-widow')
        Player.Functions.RemoveItem('weed_white-widow_seed', 1)
        Player.Functions.RemoveItem('plant_pot', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_white-widow_seed'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['plant_pot'], "remove")
	else
	    TriggerClientEvent('DSBase:Notify', src, "You dont have any pots to plant seeds.", "error")
	end
end)

DSBase.Functions.CreateUseableItem("weed_skunk_seed", function(source, item)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('plant_pot') ~= nil then
        item = Player.Functions.GetItemByName('plant_pot').amount
        TriggerClientEvent('ds-weed:client:SeedPlanted', src, 'skunk')
        Player.Functions.RemoveItem('weed_skunk_seed', 1)
        Player.Functions.RemoveItem('plant_pot', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_skunk_seed'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['plant_pot'], "remove")
	else
	    TriggerClientEvent('DSBase:Notify', src, "You dont have any pots to plant seeds.", "error")
	end
end)

DSBase.Functions.CreateUseableItem("weed_purple-haze_seed", function(source, item)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('plant_pot') ~= nil then
        item = Player.Functions.GetItemByName('plant_pot').amount
        TriggerClientEvent('ds-weed:client:SeedPlanted', src, 'purple-haze')
        Player.Functions.RemoveItem('weed_purple-haze_seed', 1)
        Player.Functions.RemoveItem('plant_pot', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_purple-haze_seed'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['plant_pot'], "remove")
	else
	    TriggerClientEvent('DSBase:Notify', src, "You dont have any pots to plant seeds.", "error")
	end
end)

DSBase.Functions.CreateUseableItem("weed_og-kush_seed", function(source, item)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('plant_pot') ~= nil then
        item = Player.Functions.GetItemByName('plant_pot').amount
        TriggerClientEvent('ds-weed:client:SeedPlanted', src, 'og-kush')
        Player.Functions.RemoveItem('weed_og-kush_seed', 1)
        Player.Functions.RemoveItem('plant_pot', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_og-kush_seed'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['plant_pot'], "remove")
	else
	    TriggerClientEvent('DSBase:Notify', src, "You dont have any pots to plant seeds.", "error")
	end
end)

DSBase.Functions.CreateUseableItem("weed_amnesia_seed", function(source, item)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('plant_pot') ~= nil then
        item = Player.Functions.GetItemByName('plant_pot').amount
        TriggerClientEvent('ds-weed:client:SeedPlanted', src, 'amnesia')
        Player.Functions.RemoveItem('weed_amnesia_seed', 1)
        Player.Functions.RemoveItem('plant_pot', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_amnesia_seed'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['plant_pot'], "remove")
	else
	    TriggerClientEvent('DSBase:Notify', src, "You dont have any pots to plant seeds.", "error")
	end
end)

DSBase.Functions.CreateUseableItem("weed_ak47_seed", function(source, item)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName('plant_pot') ~= nil then
        item = Player.Functions.GetItemByName('plant_pot').amount
        TriggerClientEvent('ds-weed:client:SeedPlanted', src, 'ak47')
        Player.Functions.RemoveItem('weed_ak47_seed', 1)
        Player.Functions.RemoveItem('plant_pot', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_ak47_seed'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['plant_pot'], "remove")
	else
	    TriggerClientEvent('DSBase:Notify', src, "You dont have any pots to plant seeds.", "error")
	end
end)

-- Roll joints
DSBase.Functions.CreateUseableItem("weed_white-widow", function(source, item) 
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local rollingpaper = Player.Functions.GetItemByName('rolling_paper')
    if rollingpaper ~= nil and not alreadyrolling then
        alreadyrolling = true
	    Citizen.Wait(3700)
	    alreadyrolling = false
        Player.Functions.RemoveItem('weed_white-widow', 1)
        Player.Functions.RemoveItem('rolling_paper', 1)
        Player.Functions.AddItem('joint_whitewidow', 1, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_white-widow'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['rolling_paper'], "remove", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['joint_whitewidow'], "add", 3)
    elseif alreadyrolling then
        TriggerClientEvent('DSBase:Notify', src, "You are already rolling a Joint.", 'error')
    else    
        TriggerClientEvent('DSBase:Notify', src, "You dont have any rolling papers!", 'error')
    end
end)

DSBase.Functions.CreateUseableItem("weed_skunk", function(source, item) 
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local rollingpaper = Player.Functions.GetItemByName('rolling_paper')
    if rollingpaper ~= nil and not alreadyrolling then
        alreadyrolling = true
	    Citizen.Wait(3700)
	    alreadyrolling = false
        Player.Functions.RemoveItem('weed_skunk', 1)
        Player.Functions.RemoveItem('rolling_paper', 2)
        Player.Functions.AddItem('joint_skunk', 2, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_skunk'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['rolling_paper'], "remove", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['joint_skunk'], "add", 3)
    elseif alreadyrolling then
        TriggerClientEvent('DSBase:Notify', src, "You are already rolling a Joint", 'error')
    else    
        TriggerClientEvent('DSBase:Notify', src, "You dont have any rolling papers!", 'error')
    end
end)

DSBase.Functions.CreateUseableItem("weed_purple-haze", function(source, item) 
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local rollingpaper = Player.Functions.GetItemByName('rolling_paper')
    if rollingpaper ~= nil and not alreadyrolling then
        alreadyrolling = true
	    Citizen.Wait(3700)
	    alreadyrolling = false
        Player.Functions.RemoveItem('weed_purple-haze', 1)
        Player.Functions.RemoveItem('rolling_paper', 3)
        Player.Functions.AddItem('joint_purplehaze', 3, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_purple-haze'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['rolling_paper'], "remove", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['joint_purplehaze'], "add", 3)
    elseif alreadyrolling then
        TriggerClientEvent('DSBase:Notify', src, "You are already rolling a Joint", 'error')
    else    
        TriggerClientEvent('DSBase:Notify', src, "You dont have any rolling papers!", 'error')
    end
end)

DSBase.Functions.CreateUseableItem("weed_og-kush", function(source, item) 
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local rollingpaper = Player.Functions.GetItemByName('rolling_paper_vagos')
    if rollingpaper ~= nil and not alreadyrolling then
        alreadyrolling = true
	    Citizen.Wait(3700)
	    alreadyrolling = false
        Player.Functions.RemoveItem('weed_og-kush', 1)
        Player.Functions.RemoveItem('rolling_paper_vagos', 1)
        Player.Functions.AddItem('vagos_joint', 1, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_og-kush'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['rolling_paper_vagos'], "remove", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['vagos_joint'], "add", 3)
    elseif alreadyrolling then
        TriggerClientEvent('DSBase:Notify', src, "You are already rolling a Joint", 'error')
    else    
        TriggerClientEvent('DSBase:Notify', src, "You dont have any rolling papers!", 'error')
    end
end)

DSBase.Functions.CreateUseableItem("weed_amnesia", function(source, item) 
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local rollingpaper = Player.Functions.GetItemByName('rolling_paper_gsf')
    if rollingpaper ~= nil and not alreadyrolling then
        alreadyrolling = true
	    Citizen.Wait(3700)
	    alreadyrolling = false
        Player.Functions.RemoveItem('weed_amnesia', 1)
        Player.Functions.RemoveItem('rolling_paper_gsf', 1)
        Player.Functions.AddItem('gsf_joint', 1, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_amnesia'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['rolling_paper_gsf'], "remove", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['gsf_joint'], "add", 3)
    elseif alreadyrolling then
        TriggerClientEvent('DSBase:Notify', src, "You are already rolling a Joint", 'error')
    else    
        TriggerClientEvent('DSBase:Notify', src, "You dont have any rolling papers!", 'error')
    end
end)

DSBase.Functions.CreateUseableItem("weed_ak47", function(source, item) 
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local rollingpaper = Player.Functions.GetItemByName('rolling_paper_ballas')
    if rollingpaper ~= nil and not alreadyrolling then
        alreadyrolling = true
	    Citizen.Wait(3700)
	    alreadyrolling = false
        Player.Functions.RemoveItem('weed_ak47', 1)
        Player.Functions.RemoveItem('rolling_paper_ballas', 1)
        Player.Functions.AddItem('balla_joint', 1, slot)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['weed_ak47'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['rolling_paper_ballas'], "remove", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['balla_joint'], "add", 3)
    elseif alreadyrolling then
        TriggerClientEvent('DSBase:Notify', src, "You are already rolling a Joint", 'error')
    else    
        TriggerClientEvent('DSBase:Notify', src, "You dont have any rolling papers!", 'error')
    end
end)

-- Select plant data
Citizen.CreateThread(function()
    TriggerEvent('ds-weed:server:SelectPlants')
    PlantsLoaded = true
end)

-- Update plant data
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if PlantsLoaded then
            TriggerClientEvent('ds-weed:client:UpdatePlants', -1, Config.Plants)
        end
    end
end)

-- Save plant data
RegisterServerEvent('ds-weed:server:SavePlants')
AddEventHandler('ds-weed:server:SavePlants', function(data, plantId)
    local data = json.encode(data)
    exports.oxmysql:insert('INSERT INTO outdoor_plants (properties, plantid) VALUES (@properties, @plantid)', {
        ['@properties'] = data,
        ['@plantid'] = plantId
    })
end)


-- Plant seeds
RegisterServerEvent('ds-weed:server:SeedPlanted')
AddEventHandler('ds-weed:server:SeedPlanted', function(type, location)
    local src = source
    local plantId = math.random(111111, 999999)
    local Player = DSBase.Functions.GetPlayer(src)
    local SeedData = {
        id = plantId, 
        type = type, 
        x = location.x, 
        y = location.y, 
        z = location.z, 
        hunger = Config.StartingHunger, 
        thirst = Config.StartingThirst, 
        growth = 0.0, 
        quality = 100.0, 
        stage = 1, 
        grace = true, 
        beingHarvested = false, 
        planter = Player.PlayerData.citizenid
    }
    local PlantCount = 0
    for k, v in pairs(Config.Plants) do
        if v.planter == Player.PlayerData.citizenid then
            PlantCount = PlantCount + 1
        end
    end
    if PlantCount >= Config.MaxPlantCount then
        TriggerClientEvent('ds-weed:client:notify', src, 'You already have ' .. Config.MaxPlantCount .. ' plants placed.')
    else
        table.insert(Config.Plants, SeedData)
        TriggerClientEvent('ds-weed:client:ConfirmSeed', src)
        TriggerEvent('ds-weed:server:SavePlants', SeedData, plantId)
        TriggerEvent('ds-weed:server:UpdatePlants')
    end
end)

-- Harvest plants
RegisterServerEvent('ds-weed:server:PlantHarvested')
AddEventHandler('ds-weed:server:PlantHarvested', function(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            v.beingHarvested = true
        end
    end
    TriggerEvent('ds-weed:server:UpdatePlants')
end)

-- Destroy plants
RegisterServerEvent('ds-weed:server:DestroyPlants')
AddEventHandler('ds-weed:server:DestroyPlants', function(plantId)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
    TriggerClientEvent('ds-weed:client:RemovePlant', -1, plantId)
    TriggerEvent('ds-weed:server:PlantRemoved', plantId)
    TriggerEvent('ds-weed:server:UpdatePlants')
    TriggerClientEvent('ds-weed:client:notify', src, 'You destroyed the weed plant')
end)

-- Harvest plants
RegisterServerEvent('ds-weed:server:HarvestPlant')
AddEventHandler('ds-weed:server:HarvestPlant', function(plantId)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    local amount
    local label
    local item
    local goodQuality = false
    local hasFound = false
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            for y = 1, #Config.SeedTypes do
                if v.type == Config.SeedTypes[y].type then
                    label = Config.SeedTypes[y].label
                    item = Config.SeedTypes[y].item
                    amount = math.random(Config.SeedTypes[y].rewardMin, Config.SeedTypes[y].rewardMax)
                    local quality = math.ceil(v.quality)
                    hasFound = true
                    table.remove(Config.Plants, k)
                    if quality > 94 then
                        goodQuality = true
                    end
                    amount = math.ceil(amount * (quality / 35))
                end
            end
        end
    end

    if hasFound then
        TriggerClientEvent('ds-weed:client:RemovePlant', -1, plantId)
        TriggerEvent('ds-weed:server:PlantRemoved', plantId)
        TriggerEvent('ds-weed:server:UpdatePlants')
        if label ~= nil then
            TriggerClientEvent('ds-weed:client:notify', src, 'You harvest x' .. amount .. ' ' .. label)
        end
        Player.Functions.AddItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, DSBase.Shared.Items[item], "add")
    end
end)

-- Update plants
RegisterServerEvent('ds-weed:server:UpdatePlants')
AddEventHandler('ds-weed:server:UpdatePlants', function()
    TriggerClientEvent('ds-weed:client:UpdatePlants', -1, Config.Plants)
end)

-- Water plants
RegisterServerEvent('ds-weed:server:WaterPlants')
AddEventHandler('ds-weed:server:WaterPlants', function(plantId)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            Config.Plants[k].thirst = Config.Plants[k].thirst + Config.ThirstIncrease
            if Config.Plants[k].thirst > 100.0 then
                Config.Plants[k].thirst = 100.0
            end
        end
    end
    Player.Functions.RemoveItem('water', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['water'], "remove")
    TriggerEvent('ds-weed:server:UpdatePlants')
end)

-- Feed plants
RegisterServerEvent('ds-weed:server:FeedPlants')
AddEventHandler('ds-weed:server:FeedPlants', function(plantId)
    local src = source
    local Player = DSBase.Functions.GetPlayer(src)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            Config.Plants[k].hunger = Config.Plants[k].hunger + Config.HungerIncrease
            if Config.Plants[k].hunger > 100.0 then
                Config.Plants[k].hunger = 100.0
            end
        end
    end
    Player.Functions.RemoveItem('fertilizer', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, DSBase.Shared.Items['fertilizer'], "remove")
    TriggerEvent('ds-weed:server:UpdatePlants')
end)

-- SQL update
RegisterServerEvent('ds-weed:server:UpdatePlants')
AddEventHandler('ds-weed:server:UpdatePlants', function(id, data)
    local result = exports.oxmysql:executeSync('SELECT * FROM outdoor_plants WHERE plantid = @plantid', {
        ['@plantid'] = id
    })
    if result[1] then
        local newData = json.encode(data)
        exports.oxmysql:execute('UPDATE outdoor_plants SET properties = @properties WHERE plantid = @id', {
            ['@properties'] = newData,
            ['@id'] = id
        })
    end
end)

-- SQL remove
RegisterServerEvent('ds-weed:server:PlantRemoved')
AddEventHandler('ds-weed:server:PlantRemoved', function(plantId)
    local result = exports.oxmysql:executeSync('SELECT * FROM outdoor_plants')
    if result then
        for i = 1, #result do
            local plantData = json.decode(result[i].properties)
            if plantData.id == plantId then
                exports.oxmysql:execute('DELETE FROM outdoor_plants WHERE id = @id', {
                    ['@id'] = result[i].id
                })
                for k, v in pairs(Config.Plants) do
                    if v.id == plantId then
                        table.remove(Config.Plants, k)
                    end
                end
            end
        end
    end
end)

-- SQL select
RegisterServerEvent('ds-weed:server:SelectPlants')
AddEventHandler('ds-weed:server:SelectPlants', function()
    local data = {}
    local result = exports.oxmysql:executeSync('SELECT * FROM outdoor_plants')
    if result[1] then
        for i = 1, #result do
            local plantData = json.decode(result[i].properties)
            -- print(plantData.id)
            table.insert(Config.Plants, plantData)
        end
    end
end)

-- Plant degrading
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        for i = 1, #Config.Plants do
            if Config.Plants[i].growth < 100 then
                if Config.Plants[i].grace then
                    Config.Plants[i].grace = false
                else
                    Config.Plants[i].thirst = Config.Plants[i].thirst - math.random(Config.Degrade.min, Config.Degrade.max) / 10
                    Config.Plants[i].hunger = Config.Plants[i].hunger - math.random(Config.Degrade.min, Config.Degrade.max) / 10
                    Config.Plants[i].growth = Config.Plants[i].growth + math.random(Config.GrowthIncrease.min, Config.GrowthIncrease.max) / 10
                    if Config.Plants[i].growth > 100 then
                        Config.Plants[i].growth = 100
                    end
                    if Config.Plants[i].hunger < 0 then
                        Config.Plants[i].hunger = 0
                    end
                    if Config.Plants[i].thirst < 0 then
                        Config.Plants[i].thirst = 0
                    end
                    if Config.Plants[i].quality < 25 then
                        Config.Plants[i].quality = 25
                    end
                    if Config.Plants[i].thirst < 75 or Config.Plants[i].hunger < 75 then
                        Config.Plants[i].quality = Config.Plants[i].quality - math.random(Config.QualityDegrade.min, Config.QualityDegrade.max) / 10
                    end
                    if Config.Plants[i].stage == 1 and Config.Plants[i].growth >= 55 then
                        Config.Plants[i].stage = 2
                    elseif Config.Plants[i].stage == 2 and Config.Plants[i].growth >= 90 then
                        Config.Plants[i].stage = 3
                    end
                end
            end
            TriggerEvent('ds-weed:server:UpdatePlants', Config.Plants[i].id, Config.Plants[i])
        end
        TriggerEvent('ds-weed:server:UpdatePlants')
    end
end)