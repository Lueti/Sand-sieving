	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// MISSION TYPE: CLEAR ZONE
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private ["_missionend"];

	wcmissionauthor = "=[A*C]= Lueti";
	wcmissiondescriptionW = "Cette sone doit être vidée de combatants ennemis,au boulot !";
	wcmissiontarget = "C'est ici que ça se passe !";

	_position = [wcmaptopright, wcmapbottomleft, ""] call WC_fnc_createposition;
	wcbattlefieldfinish = false;

	wcmissionposition = _position;
	nil = [] spawn WC_fnc_publishmission;

	_markername = "Zone de combat";
	_markersize = 150;

	nil = [_markername, _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL'] call WC_fnc_createmarker;
	nil = [_markername] call WC_fnc_randomizegroup;	

	sleep 10;

	_trg = createTrigger["EmptyDetector", _position]; 
	_trg setTriggerArea[wctriggersize, wctriggersize, 0, false];
	_trg setTriggerActivation["EAST","NOT PRESENT", false];
	_trg setTriggerStatements["this or count thislist < 2", "
		wcbattlefieldfinish = true;
	", ""];

	_missionend = false;
	while { !_missionend } do {
		if(wcbattlefieldfinish) then {
			nil = [nil,nil,rHINT,'La zone de combat est clear'] call RE;
			wcmissionokW = [0,true];
			publicvariable 'wcmissionokW';
			wcmissionclear = true;
			wcscore = 10;
			_missionend = true;
		};
		sleep 60;
	};

	deletevehicle _trg;