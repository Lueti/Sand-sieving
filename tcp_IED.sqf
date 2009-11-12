// tcp_IED.sqf v03 executed from init of object that is the IED
// Used examples from Jeevz's Proximity IED, POTS SuicideBomber, Foxhound Random IED, Javhe/HOZ IED, SPON VBIED
// To create a proximity IED/Suicide Bomber place in init line of any object where:
// <this> is object reference/name
// <west,east,guer,civ> is the activating side (1 only)
// <"Small","Medium","Large","Huge","Massive"> is the magnitude of explosion
// <10> is the radius/proximity for detonation 
// <60> affects performance by delaying trigger check and the proximity check which happens to create a gap when IED might miss a target, but unlikely
// <["M1151_M2","M1151G_M2"]> is an array of vehicle types that can detect IEDs (after they are active) 3% chance of detection and 20% chance of detonation every half second starting 40 feet out
// <trigger1> is a trigger reference/name that has to be activated before IED considered active/planted
// _iedh = [this,west,"Medium",15,60] execVM "tcp_IED.sqf";
// _iedh = [this,west,"Medium",15,60,[],trigger1] execVM "tcp_IED.sqf";
// _iedh = [this,west,"Medium",15,60,["HMMWV_Armored"],trigger1] execVM "tcp_IED.sqf";
// _iedh = [this,west,"Medium",15,60,["M1151_M2","M1151G_M2"]] execVM "tcp_IED.sqf";
// IED only set off by Land Vehicles, can be disarmed by player on foot, or by shooting/destroying IED or Suicide bomber
// 33% chance IED will not go off if speed under 10mph, Change class types for target vehicles and EOD personnel below 
if(!isServer) exitWith{};

private ["_ied","_side","_size","_rad","_time","_dtec","_trg","_targ","_eod","_wait","_wait2","_armed","_near","_nrsd","_detect","_tmo","_count","_sel","_luck"];
_ied  = _this select 0;
_side = if (count _this > 1) then {_this select 1} else {west};
_size = if (count _this > 2) then {_this select 2} else {"Medium"};
_rad  = if (count _this > 3) then {_this select 3} else {15};
_time = if (count _this > 4) then {_this select 4} else {60};
_dtec = if (count _this > 5) then {_this select 5} else {[]};
_trg  = if (count _this > 6) then {_this select 6} else {};

// Edit the targeted vehicles to include only the class types that you included in your mission (for better performance)                                      
_targ = switch (_side) do {
	case west: {
		["SoldierWB","Car","Tank"]
	};

	case east: {
		["Car","Tank"]
	};
	default {
		["Car","Tank"]
	};
};

// The class types able to disarm the IEDs
_eod = switch (_side) do {
	case east: {
		["SoldierEB"]
	};
	default {
		["CAManBase"]
	};
};

if (!isnil "_trg") then {
	_wait=true;
	while {alive _ied && _wait} do {
		sleep _time;
		if(triggerActivated _trg) then {_wait=false;};
	};
};

_detect=false;
if(count _dtec > 0) then {_detect=true;};
_armed=true;
_wait=true;
while {alive _ied && _wait} do {  
	sleep _time;
	_near = (getPos _ied) nearObjects 300;
	if(_side countSide _near > 0) then {
		_tmo=300;
		_wait2=true;
		while {(alive _ied) && (_wait2) && (_tmo > 0)} do {
			sleep 0.5;
			_near = (getPos _ied) nearObjects (_rad+40);
			_nrsd = [];
			{if(side _x == _side) then {_nrsd = _nrsd + [_x]}} forEach _near;
			_count=count _nrsd;
			for [{_x=0},{_x<_count},{_x=_x+1}] do {
				_sel = _nrsd select _x;
				_luck = random 1;
				{if((_sel isKindOf _x) && ((_sel distance _ied) <= _rad)) exitWith {_wait=false; _wait2=false; if(_luck < 0.33 && speed _sel < 10 && !(_ied isKindOf "CAManBase")) then{_armed=false;};}} forEach _targ;
				{if((_sel isKindOf _x) && ((_sel distance _ied) <= 5)) exitWith {_wait=false; _wait2=false; if(_luck > 0.10) then {_armed=false; hint "Disarmed";};}} forEach _eod;
				if(_detect) then {
					{
						if(_sel isKindOf _x) then {
							if (_luck > 0.30) then {
									_wait=false;
									_wait2=false;
							};
							if (_luck < 0.03) then {
								hint "Detected IED";
							};
						};
					} forEach _dtec;
				};
			};
			_tmo=_tmo-1;
		};
	};
};
	
if (alive _ied && _armed) then {
	if (_size == "Small") then {"R_57mm_HE" createVehicle (getPos _ied);};
	if (_size == "Medium") then {"M_Sidewinder_AA" createVehicle (getPos _ied);};
	if (_size == "Large") then {for [{_x=1},{_x<=12},{_x=_x+1}] do {"M_Sidewinder_AA" createVehicle (getPos _ied);};};
	if (_size == "Huge") then {"Bo_GBU12_LGB" createVehicle (getPos _ied);};
	if (_size == "Massive") then {"ARTY_R_227mm_HE" createVehicle (getpos _ied); "Bo_GBU12_LGB" createVehicle (getpos _ied);};
};

_ied setDamage 1;

if (true) exitWith {};