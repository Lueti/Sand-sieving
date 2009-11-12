//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: -eutf-Myke
//////////////////////////////////////////////////////////////////
private ["_unit", "_todelete"];
_unit = _this select 0;
sleep 300;

if (_unit iskindof "Man") then
	{
	DynBr_Men = DynBr_Men + [_unit];
	};
	if (count DynBr_Men > DynBr_max_men) then
		{
		while {(count DynBr_Men > DynBr_max_men)} do
			{
			_todelete = DynBr_Men select 0;
			hidebody _todelete;
			sleep 3;
			deletevehicle _todelete;
			DynBr_Men = DynBr_Men - [_todelete];
			};
		}
	else
	{
	DynBr_Veh = DynBr_Veh + [_unit];
	};
	if (count DynBr_Veh > DynBr_max_veh) then
		{
		while {(count DynBr_Veh > DynBr_max_veh)} do
			{
			_todelete = DynBr_Veh select 0;
			deletevehicle _todelete;
			DynBr_Veh = DynBr_Veh - [_todelete];
			};
		};