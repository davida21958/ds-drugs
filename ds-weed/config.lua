Config = Config or {}
Config.Plants = {}
Config.MaxPlantCount = 6
Config.GrowthTimer = 2880 -- 2 days (in minutes)
Config.StartingThirst = 100.0
Config.StartingHunger = 100.0
Config.HungerIncrease = 20.0
Config.ThirstIncrease = 15.0
Config.Degrade = {min = 2, max = 5}
Config.QualityDegrade = {min = 2, max = 6}
Config.GrowthIncrease = {min = 1, max = 4}

Config.WeedStages = {
    [1] = "bkr_prop_weed_01_small_01c",
    [2] = "bkr_prop_weed_med_01a",
    [3] = "bkr_prop_weed_lrg_01a",
}

Config.SeedTypes = {
    {type = "skunk", rewardMin = 5, rewardMax = 6, item = 'weed_skunk', label = 'Skunk 2g'},
    {type = "og-kush", rewardMin = 4, rewardMax = 6, item = 'weed_og-kush', label = 'OG-Kush 2g'},
    {type = "white-widow", rewardMin = 3, rewardMax = 5, item = 'weed_white-widow', label = 'White Widow 2g'},
    {type = "ak47", rewardMin = 2, rewardMax = 3, item = 'weed_ak47', label = 'AK47 2g'},
	{type = "purple-haze", rewardMin = 2, rewardMax = 3, item = 'weed_purple-haze', label = 'Purple Haze 2g'},
}