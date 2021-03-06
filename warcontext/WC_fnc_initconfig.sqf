	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - Description: init configuration file
	// -----------------------------------------------
	if (!isServer) exitWith{};
		
	// friendly side : resistance, east, west
	wcside 		= west;
	
	// enemy side
	wcenemyside	= east;

	// mission start at 0
	wclevel = 0;

	// number of missions to play
	wclevelmax = 3;

	// limit of playable map
	wcmaptopright 	= [5100, 5100];
	wcmapbottomleft = [0, 0];

	// number of missions in directory 
	wcnumberofmissions = 3;

	// number of campaigns in directory
	wcnumberofcampaigns = 0;

	// campaigns playable
	wccampaigns = [];

	// missions playable
	wcmissions = [0,1,2];

	// debug for warcontext 
	wcdebug	= false;

	// copy debug to clipboard output
	// wcdebugcopytoclipboard = false;	

	// if set start at this position
	// wcdebugstartposition	= [7000, 7000,0];

	// size of dynamic zone generation. At 1500 of zone IA will begin to generate 
	wctriggersize = 450;

	// ia see at x meters
	wciablind = 1000;

	// time in secondes before to garbage dead body
	wctimetogarbagedeadbody = 120;

	// maximun of enemy on map
	wcmaxenemyonmap = 1000;

	// initialise the group counter
	wcgroupcounteast = 0;
	wcgroupcountwest = 0;

	// initialise the index composition
	wccomposition = 0;

	// Index markeur merlin
	wcmerlinmrk = 0;

	// INFANTERY OPPOSITION
	switch (param1) do {
		case 1: {wcgroupsize = 5};
		case 2: {wcgroupsize = 9};
		case 3: {wcgroupsize = 15};
		case 4: {wcgroupsize = 30};
		default {wcgroupsize = 9};
	};

	// Set time
	skiptime (paramsArray select 2);

	// GAME MODE CAMPAIGN - RANDOM
	switch (paramsArray select 3) do {
		case 0: {wcgamemode = 0;};
		case 1: {wcgamemode = 1;};
		default {wcaalevel = 0;};
	};

	// AA SPAWNING LUCK
	switch (paramsArray select 4) do {
		case 0: {wcaalevel = 1;};
		case 1: {wcaalevel = 0.9;};
		case 2: {wcaalevel = 0.7;};
		case 3: {wcaalevel = 0.3;};
		case 4: {wcaalevel = 0.1;};
		default {wcaalevel = 0.7;};
	};

	// SHOW MARKERS
	switch (paramsArray select 5) do {
		case 0: {wcshowmarkers = false;};
		case 1: {wcshowmarkers = true;};
		default {wcshowmarkers = true;};
	};

	// IA level
	switch (paramsArray select 6) do {
		case 1: {wcskill = 0.1;};
		case 2: {wcskill = 0.3;};
		case 3: {wcskill = 0.7;};
		case 4: {wcskill = 1;};
		default {wcskill = 1;};
	};

	// AIRFORCE OPPOSITION
	switch (paramsArray select 7) do {
		case 0: {
			wcenemyair = [];
			};
		case 1: {
			wcenemyair = ["AV8B2"];
			};
		default {wcenemyair = ["AV8B2"];};
	};

	// INFANTERY OPPOSITION
	switch (paramsArray select 8) do {
		case 0: { wcmaxenemyunit = 0; };
		case 1:	{ wcmaxenemyunit = 1; };
		case 2:	{ wcmaxenemyunit = 2; };
		case 3:	{ wcmaxenemyunit = 4; };
		case 4:	{ wcmaxenemyunit = 8; };
		default	{ wcmaxenemyunit = 2; };
	};

	// ARMORED OPPOSITION
	switch (paramsArray select 9) do {
		case 0: { wcmaxenemyvehicle = 0; };
		case 1: { wcmaxenemyvehicle = 1; };
		case 2:	{ wcmaxenemyvehicle = 2; };
		case 3:	{ wcmaxenemyvehicle = 4; };
		case 4:	{ wcmaxenemyvehicle = 8; };
		default	{ wcmaxenemyvehicle = 2; };
	};

	// TOWN OCCUPATION
	switch (paramsArray select 10) do {
		case 0: { wctownoccupation = 1; };
		case 1: { wctownoccupation = 0.7; };
		case 2:	{ wctownoccupation = 0.5; };
		case 3:	{ wctownoccupation = 0.3; };
		case 4:	{ wctownoccupation = 0.1; };
		default	{ wctownoccupation = 0.5; };
	};

	// NUMBER OF MISSIONS
	switch (paramsArray select 11) do {
		case 1: { wclevelmax = 2; };
		case 2: { wclevelmax = 4; };
		case 3:	{ wclevelmax = 6; };
		case 4:	{ wclevelmax = 8; };
		case 5: { wclevelmax = 10; };
		default	{ wclevelmax = 4; };
	};

	//  AA INFANTERY ON - OFF
	switch (paramsArray select 12) do {
		case 0: { wcaainfantery = false; };
		case 1: { wcaainfantery = true; };
		default	{ wcaainfantery = false; };
	};

	//  REINIT SCORE IF DIE
	switch (paramsArray select 13) do {
		case 0: { wcreinitscoreifdie = false; };
		case 1: { wcreinitscoreifdie = true; };
		default	{ wcreinitscoreifdie = false; };
	};

	//  BASE TO HOSPITAL TELEPORT
	switch (paramsArray select 14) do {
		case 0: { wchospitalteleport = false; };
		case 1: { wchospitalteleport = true; };
		default	{ wchospitalteleport = true; };
	};

	// init hospital
	wchospital = objNull;

	// init radar
	wcradar = objNull;

	// init radio
	wcradio = objNull;

	// initialize engine - dont edit
	wcinitialised = false;

	// contains all the groups
	wcgroups = [];

	// contains all markers
	wcarraymarker = [];

	// contains all town locations
	wctownlocations = [];

	// ending game
	wcgameend = false;

	// score send to player
	wcscore = 0;

	true;