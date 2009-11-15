	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// units & vehicles class
	// http://community.bistudio.com/wiki/ArmA:_CfgVehicles
	// -----------------------------------------------
	if (!isServer) exitWith{};
	
	private [
		"_arrayofvehicle",
		"_arrayofpilot",
		"_indexparameters",
		"_group",
		"_leader",
		"_nbparameters",
		"_parameters",
		"_marker",
		"_togarbage",
		"_scriptinit",
		"_typeofgroup", 
		"_typeofvehicle",
		"_position", 
		"_motorized",
		"_vehicle", 
		"_soldier",
		"_unitsofgroup",
		"_base"
		];

	_parameters = [
		"_marker",
		"_typeofgroup",
		"_togarbage"
		];

	_indexparameters = 0;
	_nbparameters = count _this;
	{
		if (_indexparameters <= _nbparameters) then {
		call compile format["%1 = _this select %2;", _x, _indexparameters];
		};
		_indexparameters = _indexparameters + 1;
	}foreach _parameters;


	switch (_typeofgroup) do {

		case "sniper":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_SVD"
					];
				};
		case "g1":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_AK"
					];
				};
	
		case "g2":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_AK",
					"ETerrorist1"
					];
				};
	
		case "g2b":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_AK",
					"ffaa_terrorista_ham_AK"
					];
				};
	
		case "g3":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_ham_clerigo",
					"ffaa_terrorista_ham_PK",
					"ffaa_terrorista_agf_RPG"
					];
				};
	
		case "g4":
				{
					_motorized = false;
					_unitsofgroup = [
					"ETerrorist1",
					"ffaa_terrorista_ham_AK",
					"ETerrorist10",
					"ETerrorist6"
					];
				};
	
		case "g5":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_AK",
					"ffaa_terrorista_agf_AK",
					"ffaa_terrorista_agf_AK",
					"ffaa_terrorista_agf_PK",
					"ffaa_terrorista_ham_RPG"
					];
				};
	
		case "g6":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_AA",
					"ffaa_terrorista_agf_RPG",
					"ffaa_terrorista_ham_PK",
					"ETerrorist1",
					"ETerrorist2",
					"Eterrorist4"
					];
				};
	
		case "g8":
				{
					_motorized = false;
					_unitsofgroup = [
					"ffaa_terrorista_agf_AK",
					"ffaa_terrorista_ham_AK",
					"ETerrorist11",
					"ffaa_terrorista_ham_RPG",
					"ETerrorist6",
					"ffaa_terrorista_agf_PK",
					"ffaa_terrorista_ham_SVD",
					"ffaa_terrorista_ham_PK"
					];
				};
		
		case "pickup":
			{
				_motorized = true;
				_typeofvehicle = "Pickup_PK_INS";
			};
	
		case "pickup_spg":
			{
				_motorized = true;
				_typeofvehicle = "Offroad_SPG9_Gue";
			};

		case "t34":
			{
				_motorized = true;
				_typeofvehicle = "T34";
			};
	};

	_position = [_marker] call WC_fnc_createpositioninmarker;
	_group = createGroup wcenemyside;

	if (_motorized) then {
		_arrayofvehicle = [_position, 0, _typeofvehicle, east] call BIS_fnc_spawnVehicle;
		_vehicle = _arrayofvehicle select 0;
		_arrayofpilot = _arrayofvehicle select 1;
		_vehicle setVariable ['togarbage', true, true];
		_vehicle lock true;
		{
			_x setVariable ['togarbage', true, true];
			_group = group _x;
		}foreach _arrayofpilot;
		_vehicle setVehicleInit "[this] spawn EXT_fnc_atot";
		_vehicle addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
	} else {
		{
			call compile format["_soldier = _group createUnit ['%1', _position, [], 0, 'FORM'];", _x];
			if(!isnil "_togarbage") then {
				_soldier setVariable ['togarbage', true, true];
			};
			nil = [_soldier, wcskill] spawn WC_fnc_setskill;
			_soldier addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
		}foreach _unitsofgroup;
	};


	// initialisation script for units
	_scriptinit = format["nil = [this, '%1', 'noslow'] execVM 'extern\ups.sqf';", _marker];
	_leader = leader _group;
	_leader setVehicleInit _scriptinit;
	processInitCommands;

	if (count (units _group) < 1) then {
		if (_motorized) then {
			deletevehicle _vehicle;
		};
	};

	_group;