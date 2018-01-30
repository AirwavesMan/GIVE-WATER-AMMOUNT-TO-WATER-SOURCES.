sched_FillWaterSourcesWithRain = {

private ["_waterRain","_wateramount","_pos","_currentamount","_server_wells","_center"];
_center = 'center';
_pos = getMarkerPos _center;

//just fill outside watersources

_server_wells = nearestObjects [_pos,["Land_Bucket_EP1","MetalBucket","Land_Barrel_water","Land_Misc_Well_C_EP1","Land_Misc_Well_L_EP1","Land_Reservoir_EP1","MAP_Misc_Well","Land_stand_waterl_EP1","MAP_Misc_WellPump","land_smd_water_pump"], 25000];


if (rain > 0) then {
if ((rain <= 1) && (rain >= 0.5))  then {_waterRain = round(random 4)*2;}else{_waterRain = round(random 4)*1};


{
_currentamount = _x getVariable ["wateramount",0];
_currentamount = _currentamount + _waterRain;
_x setvariable ["wateramount",_currentamount,true];
}forEach _server_wells;

diag_log(format["sched_FillWaterSourcesWithRain:  filling all watersourse with %1 water rain", _waterRain]);

}else{


//add water if server dsnt allow rain after some time
if ((time >= 7200) && (time <= 7800) && (rain < 0.1)) then {
diag_log("sched_FillWaterSourcesWithRain: filling watersourses with unreal rain water");
_waterRain = 5;
{
_currentamount = _x getVariable ["wateramount",0];
_currentamount = _currentamount + _waterRain;
_x setvariable ["wateramount",_currentamount,true];
}forEach _server_wells;
}else{
diag_log("sched_FillWaterSourcesWithRain: no rain to fill watersourses");
};

};

objNull

};

