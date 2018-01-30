private ["_wateramount","_pos","_server_wells","_center","_wells"];
_center = 'center';
_pos = getMarkerPos _center;
_wells = DZE_wells;
_server_wells = nearestObjects [_pos,_wells, 25000];
if (isNil "wateramount") then { wateramount = 0;};

{ 
if (typeOf _x in DZE_WaterSources_smalls) then {
_wateramount = round((random((DZE_wells_wateramount select 1) - (DZE_wells_wateramount select 0)) + (DZE_wells_wateramount select 0)) / 80);
_x setvariable ["wateramount",_wateramount,true];

};
if (typeOf _x in DZE_WaterSources_mediums) then {
_wateramount = round((random((DZE_wells_wateramount select 1) - (DZE_wells_wateramount select 0)) + (DZE_wells_wateramount select 0)) / 50);
_x setvariable ["wateramount",_wateramount,true];
};
if (typeOf _x in DZE_WaterSources_larges) then {
_wateramount = round((random((DZE_wells_wateramount select 1) - (DZE_wells_wateramount select 0)) + (DZE_wells_wateramount select 0)) / 20);
_x setvariable ["wateramount",_wateramount,true];
};
if (typeOf _x in DZE_WaterSources_Special) then {
_wateramount = round((random((DZE_wells_wateramount select 1) - (DZE_wells_wateramount select 0)) + (DZE_wells_wateramount select 0)) / 5);
_x setvariable ["wateramount",_wateramount,true];
};
} forEach _server_wells;





