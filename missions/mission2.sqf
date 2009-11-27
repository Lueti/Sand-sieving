	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// MISSION TYPE: CONVOY
	// -----------------------------------------------
	if (!isServer) exitWith{};

	wcmissionauthor = "=[A*C]= Lueti";
	wcmissionname = "Baygon";
	wcmissiondescription = "L'ennemi vient de mettre en place un site AA qui nous empêchera notre trafic aérien dans cette zone. Il faut détruire ce site!";
	wcmissiontarget = "Site AA !";

	_position = [3377,4416,0];
	wcmissionposition = _position;
	nil = [] spawn WC_fnc_publishmission;

	_markername ="Site AA";
	_markersize = 200;
	nil = [_markername, _markersize, _position, 'ColorBLUE', 'ELLIPSE', 'FDIAGONAL'] call WC_fnc_createmarker;
	_group = [_markername] call WC_fnc_randomizegroup;

	_target = "Igla_AA_pod_East" createVehicle _position;
	nil = ['Site AA', 0.5, position _target,'ColorRed', 'ICON', 'FDIAGONAL', 'Flag', 0, 'AA Crate'] call WC_fnc_createmarker;

	_target addeventhandler ['killed', {
		wcsuccess = true; 
		publicvariable 'wcsuccess'; 
		wcsuccess = false;
		nil = [nil,nil,rHINT,'Le site AA est détruit.'] call RE;
		wcmissionok = true;
		wcmissionclear = true;
	}];

