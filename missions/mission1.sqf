	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// MISSION TYPE: Search
	// -----------------------------------------------
	if (!isServer) exitWith{};


	wcmissionauthor ="=[A*C]= Lueti";
	wcmissionname = "Fort Lyadiya";
	wcmissiondescriptionW = "Le fort Lyadiya est un symbole important pour la communeaut� d'Avgani,et particuli�rement pour les combatants.Nous devons le prendre afin de leur faire comprendre que c'est d�sormais nous les ma�tres de cette r�gion!";
	wcmissiontarget ="Fort Lyadiya"; 

	_position = [346,3605,0];

	wcmissionposition = _position;
	nil = [] spawn WC_fnc_publishmission;

	nil = [_markername, _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL'] call WC_fnc_createmarker;
	_group = [_markername] call WC_fnc_randomizegroup;

	sleep 10;

	_trg = createTrigger["EmptyDetector", _position]; 
	_trg setTriggerArea[wctriggersize, wctriggersize, 0, false];
	_trg setTriggerActivation["EAST","NOT PRESENT", false];
	_trg setTriggerStatements["this or count thislist < 2", "
		nil = [nil,nil,rHINT,'Fort Lyadiya est clear,bon boulot!'] call RE;
		wcsuccess = true; 
		publicvariable 'wcsuccess'; 
		wcsuccess = false;
		wcmissionok = true;
		wcmissionclear = true;
	"", """"];", wclevel];