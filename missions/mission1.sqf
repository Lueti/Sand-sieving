	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// MISSION TYPE: Search
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private["_missionend", "_trg"];

	wcmissionauthor ="=[A*C]= Lueti";
	wcmissionname = "Fort Lyadiya";
	wcmissiondescriptionW = "Le fort Lyadiya est un symbole important pour la communeauté d'Avgani,et particulièrement pour les combatants.Nous devons le prendre afin de leur faire comprendre que c'est désormais nous les maîtres de cette région!";
	wcmissiontarget ="Fort Lyadiya"; 

	_position = [346,3605,0];
	wcbattlefieldfinish = false;

	wcmissionposition = _position;
	nil = [] spawn WC_fnc_publishmission;

	nil = [_markername, _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL'] call WC_fnc_createmarker;
	_group = [_markername] call WC_fnc_randomizegroup;

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
			nil = [nil,nil,rHINT,'Fort Lyadiya est clear,bon boulot!'] call RE;
			wcmissionokW = [0,true];
			publicvariable 'wcmissionokW';
			wcmissionclear = true;
			wcscore = 10;
			_missionend = true;
		};
		sleep 60;
	};

	deletevehicle _trg;