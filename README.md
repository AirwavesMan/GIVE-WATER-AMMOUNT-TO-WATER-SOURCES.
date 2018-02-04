# GIVE-WATER-AMMOUNT-TO-WATER-SOURCES.

INSTALL:

1.In your init.sqf  below this line:
```ruby
if (dayz_townGenerator) then { execVM "\z\addons\dayz_code\system\mission\chernarus\MainLootableObjects.sqf"; };
```

Paste:

```ruby
execVM "\z\addons\dayz_server\server_WaterAmount.sqf"; //set amount of water in water sources
```

2.In your custom configVariables.sqf at top paste:
 
```ruby
DZE_wells_WaterAmount = [200,400]; //randomize water amount for each water storage type [min,max] 
```

3.in your custom variables.sqf at top paste:
```ruby
DZE_WaterSources_smalls = ["MAP_toilet_b","MAP_P_toilet_b_02","Land_Bucket_EP1","MetalBucket"];
DZE_WaterSources_mediums = ["MAP_P_Basin_A","MAP_P_sink","MAP_F_bath","MAP_P_bath","Land_Barrel_water"];
DZE_WaterSources_larges = ["Land_pumpa","MAP_pumpa","Land_Misc_Well_C_EP1","Land_Misc_Well_L_EP1","Land_Reservoir_EP1","MAP_Misc_Well","Land_stand_waterl_EP1","MAP_Misc_WellPump","land_smd_water_pump"];
DZE_WaterSources_Special = ["Land_Misc_ConcBox_EP1"];
DZE_wells = DZE_WaterSources_smalls + DZE_WaterSources_mediums + DZE_WaterSources_larges + DZE_WaterSources_Special;
```

4.In your custom compiles.sqf into if (!isDedicated) then { PASTE HERE: };
 
```ruby
player_fillWater = compile preprocessFileLineNumbers "dayz_code\compile\water_fill.sqf";
```

5.In your ......\@DayZ_Epoch_Server\addons\dayz_server\system\scheduler\ sced_init.sqf  
 
Find: 
```ruby
call compile preprocessFileLineNumbers (_base+"sched_safetyVehicle.sqf");
```
Below paste: 
```ruby
call compile preprocessFileLineNumbers (_base+"sched_FillWaterSourcesWithRain.sqf");//for check  sched_FillWaterSourcesWithRain
```
```ruby
Find:  [ 120,       48,     sched_safetyVehicle ]
```
Above! paste:
```ruby
[ 420,      0,      sched_FillWaterSourcesWithRain ],
```

6. into : \@DayZ_Epoch_Server\addons\dayz_server\system\scheduler\  put the sched_FillWaterSourcesWithRain.sqf

7. into : \@DayZ_Epoch_Server\addons\dayz_server\  put : server_WaterAmount.sqf

8. into : mpmissions\your instance\dayz_code\compile\   put:  water_fill.sqf 
