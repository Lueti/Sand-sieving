	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------
	if (!isServer) exitWith{};
	
	private [
		"_markername",
		"_markersize",
		"_position", 
		"_object",
		"_objindex",
		"_locations",
		"_i",
		"_fuelstations",
		"_vehicles",
		"_currentlocation",
		"_distance",
		"_index"
		];

	// CREATE AIRPATROL
	{
		nil = [_x]  spawn WC_fnc_createairpatrol;
		sleep 0.5;
	}foreach wcenemyair;

	// create AA Site
	_locations = nearestLocations [[7000,7000], ["Hill"], 20000]; 
	_index = 0;
	{
		if( random 1 > wcaalevel) then {
			_position = position _x;
			_index = _index + 1;
			_target = "anti-air_ru1";
			_target = [_target, 0, _position] call EXT_fnc_createcomposition;
			_leader = leader _target;
			if(wcdebug or wcshowmarkers) then {
				[_leader, format["AA%1", _index], 0.5, 'ColorRed', 'ICON', 'FDIAGONAL', 30, 'AntiAir', 0 , 'AA SITE', true] spawn WC_fnc_attachmarker;
			} else {
				[_leader, format["AA%1", _index], 0.5, 'ColorRed', 'ICON', 'FDIAGONAL', 30, 'EMPTY', 0 , 'AA SITE', true] spawn WC_fnc_attachmarker;
			};
		};
		sleep 0.5;
	} foreach _locations;

	// CREATE ARMORS	
	for "_x" from 0 to wcmaxenemyvehicle step 1 do {
		_position = [wcmaptopright, wcmapbottomleft, "onflat"] call WC_fnc_createposition;
		call compile format["['armor%1', _position , 4000, 4000, wcside, ['t34'], false, wcenemyside] spawn func_createtrigger;", _x];
	};

	// CREATE PICKUP
	for "_x" from 0 to wcmaxenemyvehicle step 1 do {
		_position = [wcmaptopright, wcmapbottomleft, "onflat"] call WC_fnc_createposition;
		call compile format["['pickup%1', _position , 4000, 4000, wcside, ['pickup'], false, wcenemyside] spawn func_createtrigger;", _x];
	};

	// REFRESH MARKERS
	WC_fnc_refreshmarker = {
		while {!wcgameend} do {
			{
				_position = getmarkerpos (_x select 0);
				(_x select 0) setMarkerPos _position;
				sleep 1;
			}foreach wcarraymarker;
			sleep 60;
		};
	};

	// REFRESH HOSPITAL MARKER
	WC_fnc_refreshhospitalmarker = {
		while {!wcgameend} do {
			if(!isnull wchospital and (format["%1", getmarkerpos "HOSPITAL"] == "[0,0,0]")) then {
				['HOSPITAL', 0.5, position wchospital, 'ColorGreen', 'ICON', 'FDIAGONAL', 'Headquarters', 0, 'HOSPITAL', true] call WC_fnc_createmarker;
			};
			if(isnull wchospital and (format["%1", getmarkerpos "HOSPITAL"] != "[0,0,0]")) then {
				wcarraymarker = wcarraymarker - ["HOSPITAL"];
				deletemarker "HOSPITAL";
			};
			sleep 4;
		};
	};


	wctrgradar = createTrigger["EmptyDetector", [0,0,0]];
	wctrgradar setTriggerArea[0,0,0,false];
	wctrgradar setTriggerActivation["ANY", "PRESENT", TRUE];
	wctrgradar setTriggerStatements["this", "", ""];

	wctrgradio = createTrigger["EmptyDetector", [0,0,0]];
	wctrgradio setTriggerArea[0,0,0,false];
	wctrgradio setTriggerActivation["ANY", "PRESENT", TRUE];
	wctrgradio setTriggerStatements["this", "", ""];

	// REFRESH RADAR MARKER
	WC_fnc_refreshradarmarker = {
		while {!wcgameend} do {
			if(!isnull wcradar and (format["%1", getmarkerpos "RADAR"] == "[0,0,0]")) then {
				_markersize = ((getposasl wcradar) select 2) * 5;
				_position = getpos wcradar;
				nil = ["RADARFIELD", _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL', '', 0, '', true] call WC_fnc_createmarker;
				['RADAR', 0.5, _position, 'ColorGreen', 'ICON', 'FDIAGONAL', 'Defend', 0, 'RADAR', true] call WC_fnc_createmarker;
				wctrgradar setpos _position;
				wctrgradar setTriggerArea[_markersize,_markersize,0,false];
			};
			if((isnull wcradar and (format["%1", getmarkerpos "RADAR"] != "[0,0,0]")) or (!alive wcradar)) then {
				wcarraymarker = wcarraymarker - ["RADARFIELD"];
				deletemarker "RADARFIELD";
				wcarraymarker = wcarraymarker - ["RADAR"];
				deletemarker "RADAR";
				deletevehicle wcradar;
			};
			if(count (list wctrgradar) > 0) then {
				{
					if (_x iskindof "AIR") then {
						_position = position _x;
						_markername = format["%1", group _x];
						if ( format["%1", getmarkerpos _markername] == "[0,0,0]") then {
							[_x, format["%1", group _x], 0.5, 'ColorRed', 'ICON', 'FDIAGONAL', 2, 'Dot', 0 , 'AIR', false, "RADARFIELD"] spawn WC_fnc_attachmarkerinzone;
						};
						if (random 1 > 0.9) then {
							_x doTarget wcradar;
							_x dofire wcradar;
						};
					};
				}foreach (list wctrgradar);
			};
			sleep 4;
		};
	};

	// REFRESH RADIO MARKER
	WC_fnc_refreshradiomarker = {
		while {!wcgameend} do {
			if(!isnull wcradio and (format["%1", getmarkerpos "RADIO"] == "[0,0,0]")) then {
				_markersize = ((getposasl wcradio) select 2) * 5;
				_position = getpos wcradio;
				nil = ["RADIOFIELD", _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL', '', 0, '', true] call WC_fnc_createmarker;
				['RADIO', 0.5, _position, 'ColorGreen', 'ICON', 'FDIAGONAL', 'Defend', 0, 'RADIO', true] call WC_fnc_createmarker;
				wctrgradio setpos _position;
				wctrgradio setTriggerArea[_markersize,_markersize,0,false];
			};
			if((isnull wcradio and (format["%1", getmarkerpos "RADIO"] != "[0,0,0]")) or (!alive wcradio)) then {
				wcarraymarker = wcarraymarker - ["RADIOFIELD"];
				deletemarker "RADIOFIELD";
				wcarraymarker = wcarraymarker - ["RADIO"];
				deletemarker "RADIO";
				deletevehicle wcradio;
			};
			sleep 4;
		};
	};


	nil = [] spawn WC_fnc_refreshmarker;
	sleep 1;
	nil = [] spawn WC_fnc_refreshhospitalmarker;
	sleep 1;
	nil = [] spawn WC_fnc_refreshradarmarker;
	sleep 1;
	nil = [] spawn WC_fnc_refreshradiomarker;
	sleep 1;

	true;