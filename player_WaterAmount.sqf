private ["_WaterStorage","_WaterStorage_Type","_GetWaterAmount","_Text"];

_WaterStorage = _this select 3;
_WaterStorage_Type = typeOf _WaterStorage;
_GetWaterAmount = _WaterStorage getVariable "wateramount";

_Text = "";
switch (true) do {
            case (_WaterStorage_Type == "Land_Barrel_water"):         {_Text = "Barrel of dirty water";};
			case (_WaterStorage_Type == "Land_Misc_ConcBox_EP1"):     {_Text = "feeding lought";};
			case (_WaterStorage_Type == "Land_Misc_Well_C_EP1"):      {_Text = "Old well";};
			case (_WaterStorage_Type == "Land_Misc_Well_L_EP1"):      {_Text = "Very Old well";};
			case (_WaterStorage_Type == "Land_pumpa"):                {_Text = "Water Pump";};
			case (_WaterStorage_Type == "MAP_toilet_b"):              {_Text = "toilet bowl";};
			case (_WaterStorage_Type == "MAP_P_toilet_b_02"):         {_Text = "toilet bowl";};
			case (_WaterStorage_Type == "Land_Bucket_EP1"):           {_Text = "pail";};
			case (_WaterStorage_Type == "MetalBucket"):               {_Text = "pail";};
			case (_WaterStorage_Type == "MAP_P_Basin_A"):             {_Text = "sink";};
            case (_WaterStorage_Type == "MAP_P_sink"):                {_Text = "sink";};
			case (_WaterStorage_Type == "MAP_F_bath"):                {_Text = "bath";};
			case (_WaterStorage_Type == "MAP_P_bath"):                {_Text = "bath";};
			case (_WaterStorage_Type == "MAP_pumpa"):                 {_Text = "Water Pump";};
			case (_WaterStorage_Type == "Land_Reservoir_EP1"):        {_Text = "water reservoir";};
           	case (_WaterStorage_Type == "MAP_Misc_Well"):             {_Text = "stone well";};
			case (_WaterStorage_Type == "Land_stand_waterl_EP1"):     {_Text = "water reservoir";};
			case (_WaterStorage_Type == "MAP_Misc_WellPump"):         {_Text = "Old well";};
			case (_WaterStorage_Type == "land_smd_water_pump"):       {_Text = "Water Pump";};
		};
_Text = _Text;

format["Apparently the %1 has about %2 lts of water left.",_Text,round(_GetWaterAmount)] call dayz_rollingMessages;
