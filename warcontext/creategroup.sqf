	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// units & vehicles class
	// http://community.bistudio.com/wiki/ArmA:_CfgVehicles
	// -----------------------------------------------
	if (!isServer) exitWith{};
	
	private [
		"_scriptinit",
		"_scriptinitvehicle",
		"_typeofgroup",
		"_group",
		"_group2",
		"_position", 
		"_random",
		"_motorized",
		"_x", 
		"_y", 
		"_z", 
		"_vehicle", 
		"_leader", 
		"_soldier1",
		"_soldier2", 
		"_soldier3",  
		"_unit1", 
		"_unit2", 
		"_unit3",
		"_unitsofgroup"
		];
	
	_marker = _this select 0;
	_markersize = getMarkerSize _marker select 0;
	
	// initialisation script for units
	_scriptinit = format["nil = [this, '%1', 'random', 'min:1/max:%2'] execVM 'ups.sqf';", _marker, wcrandom];
	
	// initialisation script for units in vehicle
	_scriptinitvehicle = format["nil = [this, '%1', 'min:1/max:%2'] execVM 'ups.sqf';", _marker];
	
	_position = getmarkerpos _marker;
	_x = abs(_position select 0);
	_y = abs(_position select 1);
	_z = 0;
	_position = [_x,_y,_z];
	
	_typeofgroup = _this select 1;
	
	_group = createGroup wcenemyside;
	
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
				_vehicle = createVehicle ["Pickup_PK_INS", _position, [], 0, "NONE"];
				_unitsofgroup = [
				"ETerrorist1",
	                        "ffaa_terrorista_agf_AK"
				];
			};
	
		case "pickup_spg":
			{
				_motorized = true;
				_vehicle = createvehicle ["Offroad_SPG9_Gue", _position, [], 0, "NONE"];
				_unitsofgroup = [
					"ETerrorist1",
					"ffaa_terrorista_agf_AK"
				];
			};
	};

		_countunits = 1;
		{
			call compile format["
				_soldier%1 = _group createUnit ['%2', _position, [], 0, 'NONE'];
				_soldier%1 addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
				[_soldier%1] spawn func_setskill;
			", _countunits, _x];
			_countunits = _countunits + 1;
		}foreach _unitsofgroup;
	
		_soldier1 setRank "SERGEANT";
	
		if (_motorized) then {
			_vehicle addeventhandler ['killed', {_this spawn WC_fnc_garbagecollector}];
			if (count(units _group) > 2) then {
				_soldier1 moveincommander _vehicle;
				_soldier2 moveindriver _vehicle;
				_soldier3 moveingunner _vehicle;
			} else {
				_soldier1 moveindriver _vehicle;
				_soldier2 moveingunner _vehicle;
			};
			_soldier1 setVehicleInit _scriptinitvehicle;
		} else {
			if (random 1 > 0.8) then {
				guard = [_soldier1,"STEALTH"] execVM 'HousePatrol.sqf';
				_soldier1 setVehicleInit _scriptinit;
			} else {
				_soldier1 setVehicleInit _scriptinit;
			};
		};
		processInitCommands;
	
	_group;