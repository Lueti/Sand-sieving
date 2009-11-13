	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// Enhancement with Xeno script x_playerweapons.sqf
	// Client Side logic
	// -----------------------------------------------

	if (!local player) exitWith {};

	private [
		"_position", 
		"_magazines",
		"_weapons",
		"_primw",
		"_muzzles",
		"_delta",
		"_score"
		];

	// initialize client side configuration
	nil = [] execVM "intro.sqf";
	player disableConversation true;

	wcterraingrid = 25;
	wcviewDist = 1500;
	setViewDistance wcviewDist;
	setTerrainGrid wcterraingrid;

	// Init Revive
	nil = server execVM "revive_init.sqf";

	WC_fnc_attachmarkerinzone2 = compile preprocessFile "warcontext\WC_fnc_attachmarkerinzone2.sqf";
	WC_fnc_createmission	= compile preprocessFile "warcontext\WC_fnc_createmission.sqf";
	WC_fnc_createammobox	= compile preprocessFile "warcontext\WC_fnc_createammobox.sqf";
	WC_fnc_createmarker 	= compile preprocessFile "warcontext\WC_fnc_createmarker.sqf";
	WC_fnc_createradio 	= compile preprocessFile "warcontext\WC_fnc_createradio.sqf";
	WC_fnc_createradar 	= compile preprocessFile "warcontext\WC_fnc_createradar.sqf";
	WC_fnc_repairvehicle 	= compile preprocessFile "warcontext\WC_fnc_repairvehicle.sqf";
	WC_fnc_getobject	= compile preprocessFile "warcontext\WC_fnc_getobject.sqf";
	WC_fnc_score		= compile preprocessFile "warcontext\WC_fnc_score.sqf";

	// Init Dialog BOX
	nil = execVM "dialog\Scripts\ac_init_client.sqf";

	wcsuccess = false;
	wcfail = false;
	wclientinitialised = false;
	wcscore = 0;

	"wcmission" addPublicVariableEventHandler {
		if (wcinitialised && wclientinitialised) then {
			nil = [] spawn WC_fnc_createmission; 
		};
	};

	"wcsuccess" addPublicVariableEventHandler {
		call compile format["task%1 settaskstate 'Succeeded'; ", wclevel];
		wcsuccess = false;
	};

	"wcfail" addPublicVariableEventHandler {
		call compile format["task%1 settaskstate 'Failed'; ", wclevel];
		wcfail = false;
	};

	if (typeOf player == "USMC_Soldier_Medic") then {
		player addaction ["Build \ Remove hospital","warcontext\WC_fnc_createhospital.sqf",[],-1,false];
	};

	if (typeOf player == "USMC_SoldierS_Engineer") then {
		player addaction ["Build \ Remove Radar","warcontext\WC_fnc_createradar.sqf",[],-1,false];
		player addaction ["Repair Vehicle","warcontext\WC_fnc_repairvehicle.sqf",[],-1,false];
	};

	if (typeOf player == "USMC_SoldierS") then {
		player addaction ["Build \ Remove Radio","warcontext\WC_fnc_createradio.sqf",[],-1,false];
	};

	"wcscore" addPublicVariableEventHandler {
		nil = [] spawn WC_fnc_score; 
	};


	// creation du journal sur la carte
	_diary = player createDiaryRecord ["Diary", ["Campaign", "Guerilla is in Avgani. Clear the town!"]];

	// code a executer quand le joueur respawn
	// recuperation des armes identiques a avant la mort
	torespawn = {
		if(wcreinitscoreifdie) then {
			_score = score player;
			_delta = 0 - _score;
			player addscore _delta;
		};
		_weapons = weapons player;
		_magazines = magazines player;
		waitUntil {alive player};
		removeAllItems player;
		removeAllWeapons player;
		{player addMagazine _x;} forEach _magazines;
		{player addWeapon _x;} forEach _weapons;
		_primw = primaryWeapon player;
		if (_primw != "") then {
		        player selectWeapon _primw;
			_muzzles = getArray(configFile>>"cfgWeapons" >> _primw >> "muzzles");
			player selectWeapon (_muzzles select 0);
		};
		// ReInit Dialog BOX
		nil = execVM "dialog\Scripts\ac_init_client.sqf";
		if (typeOf player == "USMC_Soldier_Medic") then {
			player addaction ["Build \ Remove hospital","warcontext\WC_fnc_createhospital.sqf",[],-1,false];
		};
		if (typeOf player == "USMC_SoldierS_Engineer") then {
			player addaction ["Build \ Remove Radar","warcontext\WC_fnc_createradar.sqf",[],-1,false];
			player addaction ["Repair Vehicle","warcontext\WC_fnc_repairvehicle.sqf",[], -1,false];
		};
		if (typeOf player == "USMC_SoldierS") then {
			player addaction ["Build \ Remove Radio","warcontext\WC_fnc_createradio.sqf",[],-1,false];
		};
		[player, name player, 0.5, 'ColorGreen', 'ICON', 'FDIAGONAL', 2, 'Dot', 0 , name player, false, 'RADIOFIELD'] spawn WC_fnc_attachmarkerinzone2;
	};

	player addeventhandler ['killed', {
		hidebody (_this select 0);
		nil = [] spawn torespawn;
	}];

	// introduction text
	PAPABEAR=[West,"HQ"]; PAPABEAR SideChat "Hi there. Your mission is to clear Avgani. Follow your Squad leader!";

	// Init mission for JIP players
	nil = [] spawn WC_fnc_createmission;

	// Preloading all textures
	waitUntil {20000 preloadObject player};

	[player, name player, 0.5, 'ColorGreen', 'ICON', 'FDIAGONAL', 2, 'Dot', 0 , name player, false, 'RADIOFIELD'] spawn WC_fnc_attachmarkerinzone2;

	hint "Init is done!";

	// sleep for ignoring first briefing trigger by eventhandler
	sleep 30;

	wclientinitialised = true;