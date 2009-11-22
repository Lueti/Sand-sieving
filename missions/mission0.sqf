	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// MISSION TYPE: CLEAR ZONE
	// -----------------------------------------------
	if (!isServer) exitWith{};

	wcmissionauthor = "=[A*C]= Lueti";
	wcmissiondescriptionW = "Cette zone doit �tre vid�e de combatants ennemis,au boulot !";
	wcmissiontarget = "C'est ici que �a se passe !";

	_position = [wcmaptopright, wcmapbottomleft, ""] call WC_fnc_createposition;

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
		nil = [nil,nil,rHINT,'La zone est clear'] call RE;
		wcsuccess = true; 
		publicvariable 'wcsuccess'; 
		wcsuccess = false;
		wcmissionok = true;
		wcmissionclear = true;
	", ""];