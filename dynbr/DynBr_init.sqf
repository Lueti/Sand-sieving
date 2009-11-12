//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: -eutf-Myke
//////////////////////////////////////////////////////////////////
private ["_counter", "_unitlist"];
if (!isServer) exitwith {};

_counter = count _this;

switch (_counter) do
	{
	case 1:
		{
		_unitlist = _this select 0;
		{
		_nul = [_x] execVM "DynBr\DynBr_addEH.sqf";
		}
		foreach _unitlist;
		};
	case 2:
		{
		DynBr_Men = [];
		DynBr_Veh = [];
		DynBr_max_men = _this select 0;
		DynBr_max_veh = _this select 1;
		};
	case 3:
		{
		_unitlist = _this select 0;
		if ((isnil ("DynBr_max_men")) and (isnil ("DynBr_max_veh"))) then
			{
			DynBr_max_men = _this select 1;
			DynBr_max_veh = _this select 2;
			DynBr_Men = [];
			DynBr_Veh = [];
			};
		{
		_nul = [_x] execVM "DynBr\DynBr_addEH.sqf";
		}
		foreach _unitlist;
		};
	};