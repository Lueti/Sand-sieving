// -----------------------------------------------
// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
// warcontext - Debuger
// -----------------------------------------------

	if (wcdebug) then {
		player allowdammage false;
		if (!isnil ("wcdebugstartposition")) then {player setpos wcdebugstartposition;};
		while{(true)} do {
			wcdebugcoord = getposasl player;
			wcdebugx = ceil(wcdebugcoord select 0);
			wcdebugy = ceil(wcdebugcoord select 1);
			wcdebugz = ceil(wcdebugcoord select 2);
			_listobjects = (position player) nearObjects 20;
			_nbobjects = count _listobjects;
			_nbobjects = [];
			_isflatempty = position player isflatempty [20, 0, 1, 20, 0, false]; 
			_text = format["
			Nb enemi: %1
			Time: %2
			groupcount: %3
			level: %4
			maxenemyonmap: %5
			Coord: %6, %7, %8
			Nb objets near player: %9
			Isflatempty: %10
			Building: %11
			", 
			wccounttotalunit,
			time, 
			wcgroupcount, 
			wclevel, 
			wcmaxenemyonmap, 
			wcdebugx, 
			wcdebugy, 
			wcdebugz,
			_nbobjects,
			_isflatempty,
			nearestBuilding player
			];
			hintsilent _text;
			if (wcdebugcopytoclipboard) then {
				copyToClipboard format["%1", position player];
			};
			sleep 4;
			onMapSingleClick "player setPos _pos; true;";
		};
	};