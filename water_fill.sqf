#include "\z\addons\dayz_code\util\player.hpp"

private ["_thirst","_playerPos","_RemoveAmount","_WaterTook","_NewWaterAmount","_GetWaterAmount","_canFill","_water","_filled","_Pos","_posASL","_posATL","_chance","_container","_drinking","_message","_recover","_wells"];

if (typeName _this == "ARRAY") then {
	_container = if (count _this == 1) then {_this select 0} else {_this select 3};
	_drinking = true;
} else {
	_container = _this;
	_drinking = false;

};

call gear_ui_init;
closeDialog 0;

if Player_IsOnLadder() exitWith { (localize "str_player_21") call dayz_rollingMessages; };
_Pos = getPos player;
_posASL = getPosASL player;
_posATL = ASLtoATL _posASL;
//"Land_water_tank" has no spout or opening, doesn't make sense to include
//_wells = ["Land_pumpa","Land_Barrel_water","Land_Misc_Well_C_EP1","Land_Misc_Well_L_EP1","land_smd_water_pump"];
_wells = DZE_Wells;


_canFill = switch true do {
	//Return: [nearWaterHole, isPond]
	case (count nearestObjects [_posATL,_wells,4] > 0): {[true,false]};
	case (toLower worldName in ["chernarus","namalsk","napf"]): {(call fn_nearWaterHole)};
	//Slow searches for maps without waterHoleProxy objects added yet
	case ({["_well",str _x] call fnc_inString} count nearestObjects [_posATL,[],4] > 0): {[true,false]};
	case ({["pond",str _x] call fnc_inString && {_posASL select 2 < ((getPosASL _x) select 2)}} count nearestObjects [player,[],50] > 0): {[true,true]};
	default {[false,false]};
};

_nearest_wells = nearestObjects [_Pos, _wells,4];
_nearest_wells = _nearest_wells select 0;


if !(_canFill select 0) exitWith {
	_message = if (_drinking) then {"str_player_32"} else {"str_player_20"};
	localize _message call dayz_rollingMessages;
};


if (_container == "hands") then {_chance = 0.03;_recover = 80;_WaterTook = 0.5;} else {_chance = 0.06;_recover = 160;_WaterTook = 0.8;};



_GetWaterAmount = _nearest_wells getVariable "wateramount";
_RemoveAmount = _GetWaterAmount - _WaterTook;
//exit if watersource dsnt have more water.
if ((_GetWaterAmount < _WaterTook) or (_GetWaterAmount <= 0)) exitWith {format["The Source is empty."] call dayz_rollingMessages;};



//Check if guaranteed infected (only for ponds)
_water = if (dayz_infectiousWaterholes && {_canFill select 1} && {count nearestObjects [_posATL,["Body","Body1","Body2","Mass_grave"],50] > 0}) then {"infected"} else {"safe"};
_water = "containerwater" + _water;
_filled = 0;


//Additional chance to be infected (only for ponds)
if (_canFill select 1 && {[_chance] call fn_chance}) then {
	_water = "containerwaterinfected";
};

if (!dayz_isSwimming) then {
	player playActionNow "PutDown";
};



if (_drinking) then {

_thirst = round(100 - (dayz_thirst / SleepWater) * 100);
if (_thirst >= 99) exitWith {"You should not waste water, you are not dying of thirst." call dayz_rollingMessages;}; 

if ((player getvariable ["needpiss",0] ==1)) exitWith {systemchat "i need go to the bathroom before drink again";};






//Remove the amount and get the new amount
_nearest_wells setvariable ["wateramount",_RemoveAmount,true];
_NewWaterAmount = _nearest_wells getVariable "wateramount";


	["FoodDrink",0,[0,0,_recover,0]] call dayz_NutritionSystem; //[Energy,food,water,temp]
	[player,"drink",0,false,5] call dayz_zombieSpeak;
	[player,10,true,_posATL] call player_alertZombies;
	
	if (_water == "containerwaterinfected") then {
		r_player_infected = true;
	};
	format["You took with your %2 %1lts of water. Apparently the source has %3lts left.",_WaterTook,_container,round(_NewWaterAmount)] call dayz_rollingMessages;
	//localize "str_drinkwithhands" call dayz_rollingMessages;//Old Msg
} else {

	{
		if (isText (configFile >> "CfgMagazines" >> _x >> _water)) then
		{	
            			
			_filled = _filled + 1;
			player removeMagazine _x;
			player addMagazine getText (configFile >> "CfgMagazines" >> _x >> _water);
			
		};
	}foreach magazines player;
	
	if (_filled > 0) then {
	   
	    _RemoveAmount = _GetWaterAmount - _filled;
	    _nearest_wells setvariable ["wateramount",_RemoveAmount,true];
        _NewWaterAmount = _nearest_wells getVariable "wateramount";
		[player, "fillwater", 0, false, 5] call dayz_zombieSpeak;
		[player, 5, true, _posATL] call player_alertZombies;
		//format [localize "str_player_01", _filled] call dayz_rollingMessages;//Old Msg
		format["You have filled %1 bottles with %1Lts. Apparently the source has %2Lts left.",_filled,round(_NewWaterAmount)] call dayz_rollingMessages;
	} else {
		localize "str_player_02" call dayz_rollingMessages;
	};
};