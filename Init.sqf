	player exec "Intro.sqs";
	viewdist = 1500 ;
	setviewdistance (viewdist);
	wcskill = 1;
	wcdebug = false;
	wcterraingrid = 12.5;
	setterraingrid wcterraingrid;
	player disableConversation true;
	

	nil =[] execVM "briefing.sqf";
	playSound "ac1";

	if (isserver) then {execVM "environnement.sqf";};
	
	skiptime Param1;

	//BIS_Effects_Burn=compile preprocessFile "\ca\Data\ParticleEffects\Scripts\destruction\burn.sqf";	
	func_creategroup = compile preprocessFile "warcontext\creategroup.sqf";
	func_createtrigger = compile preprocessFile "warcontext\createtrigger.sqf";
	func_createzone = compile preprocessFile "warcontext\createzone.sqf";
	func_renfort = compile preprocessFile "warcontext\renfort.sqf";
	func_para = compile preprocessFile "warcontext\para.sqf";
	func_setskill = compile preprocessFile "warcontext\setskill.sqf";
	EXT_fnc_createcomposition = compile preprocessFile "EXT_fnc_createcomposition.sqf";
	WC_fnc_debug = compile preprocessFile "warcontext\WC_fnc_debug.sqf";
	WC_fnc_garbagecollector = compile preprocessFile "warcontext\WC_fnc_garbagecollector.sqf";
	WC_fnc_garbagecollector = compile preprocessFile "warcontext\WC_fnc_garbagecollector.sqf";
	WC_fnc_increaseterraingrid = compile preprocessFile "warcontext\WC_fnc_increaseterraingrid.sqf";
	WC_fnc_decreaseterraingrid = compile preprocessFile "warcontext\WC_fnc_decreaseterraingrid.sqf";
	
	nil = [] call func_createzone;

	server execVM "revive_init.sqf";

	nil = [] spawn WC_fnc_debug;

