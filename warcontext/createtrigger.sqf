// -----------------------------------------------
// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
// warcontext 
// -----------------------------------------------
if (!isServer) exitWith{};

private [
	"_markername",
	"_position", 
	"_markersize", 
	"_triggersize", 
	"_side", 
	"_enemyside", 
	"_antenne",
	"_typeofgroup"
	];

	_markername 	= _this select 0;
	_position 	= _this select 1;
	_markersize 	= _this select 2;
	_triggersize 	= _this select 3;
	_side 		= _this select 4;
	_typeofgroup 	= _this select 5;
	_antenne	= _this select 6;
	_enemyside	= _this select 7;

	_line = "";
	{
	_line = _line + format ["nil = [%1ups,'%2'] spawn WC_fnc_creategroup;", _markername, _x];
	}foreach _typeofgroup;

	// trick to use marker design on MAP
	if(_position select 0 != 0) then {
		call compile format["%1 = createMarker[""%1"", %2];",_markername, _position];
		call compile format ["""%1"" setMarkerSize [%2, %2];",_markername, _markersize];
	} else {
		_position = getmarkerpos _markername;
		_markersize = getmarkersize _markername select 0;
	};

	call compile format["%1ups = createMarker[""%1ups"", %2];",_markername, _position];
	call compile format ["""%1ups"" setMarkerSize [%2, %2];",_markername, _markersize];
	
	if(_antenne) then {
		call compile format ["%1radio = createVehicle [""Land_telek1"", getmarkerpos %1, [], _markersize, """"];", _markername];
	};

	call compile format ["%1trg = createTrigger[""EmptyDetector"",%2];",_markername,_position]; 
	call compile format ["%1trg setTriggerArea[%2,%2,0,false];",_markername,_triggersize];
	//call compile format ["%1trg setTriggerTimeout [20, 20, 20, false ];", _markername];
	call compile format ["%1trg setTriggerActivation[""%2"",""PRESENT"",false];",_markername, _side];
	call compile format ["%1trg setTriggerStatements[""this"", ""%2"", """"];", _markername, _line];

	call compile format ["%1trgend = createTrigger[""EmptyDetector"",%2];", _markername, _position];
	call compile format ["%1trgend setTriggerArea[%2,%2,0,false];", _markername, _markersize];
	call compile format ["%1trgend setTriggerActivation[""%2"",""NOT PRESENT"",true];", _markername, _enemyside];
	call compile format ["%1trgend setTriggerStatements[""this and !alive(%1radio)"", ""
	countvariables = countvariables + 1;
	arrayvariables set [countvariables, %1clear];
	%1clear=true; 
	publicVariable '%1clear'; 
	"", """"];", _markername]; 

	if(_antenne) then {
	call compile format ["%1trg2 = createTrigger[""EmptyDetector"",%2];", _markername, _position];
	call compile format ["%1trg2 setTriggerArea[%2,%2,0,false];", _markername ,_markersize];
	call compile format ["%1trg2 setTriggerActivation[""%2"",""%3 D"",false];", _markername, _side, _enemyside];
	//call compile format ["%1trg2 setTriggerTimeout [10, 10, 10, false ];", _markername];
	call compile format ["%1trg2 setTriggerStatements [""this and alive(%1radio)"",""
	nil = [%1] call func_renfort;
	"", """"];", _markername]; 
	};