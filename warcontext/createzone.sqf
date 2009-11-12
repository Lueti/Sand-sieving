// -----------------------------------------------
// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
// warcontext 
// -----------------------------------------------
private [
	"_targetname",
	"_markername",
	"_position", 
	"_markersize", 
	"_triggersize",  
	"_antenne",
	"_typeofgroup"
	];

// IA level : 1 is stronger
//wcskill		= 1;

// max random number of IA
wcrandom	= 2;

// size of dynamic zone generation. At 400 of zone IA will begin to generate 
_triggersize 	= 450;

// friendly side
wcside 		= "west";

// enemy side
wcenemyside	= EAST;

// zone definition position, name, size of zone, units in zone, radio tower or not
		_targetname = [
			[[333,3606,0],"z01",150,["g8","g1"], false],
			[[1953,1846,0],"z02",150,["g3","g1"], false],
			[[2374,1900,0],"z03",150,["g3","g1"], false],
			[[3303,1360,0],"z04",150,["g2","g1"], false],
			[[2340,2540,0],"z05",150,["g5","g1"], false],
			[[3770,4319,0],"z06",150,["g2","g1"], false],
			[[3867,4757,0],"z07",150,["g2","g1"], false],
			[[3367,4353,0],"z08",150,["g2","g1"], false],
			[[2854,3848,0],"z09",150,["g3","g1"], false],
			[[1356,3945,0],"z10",150,["g6","g1"], false],
			[[1479,2151,0],"z11",70,["sniper"], false],
			[[220,2637,0],"z12",70,["sniper"], false],
			[[417,3160,0],"z13",70,["sniper"], false],
			[[1457,3102,0],"z14",70,["sniper"], false],
			[[3147,2041,0],"z15",70,["sniper"], false],
			[[3387,2922,0],"z16",70,["sniper"], false],
			[[3792,3814,0],"z17",70,["sniper"], false],
			[[1769,4497,0],"z18",70,["sniper"], false],
			[[2738,2419,0],"z19",70,["sniper"], false],
			[[3503,2612,0],"z20",70,["sniper"], false],
			[[1956,3553,0],"z21",70,["g4","g3","g2","g1"], false],
			[[2208,3569,0],"z22",100,["g5","g1"], false],
			[[2316,3494,0],"z23",100,["g5"], false],
			[[2772,3617,0],"z24",100,["g5","g1"], false],
			[[2512,3522,0],"z25",100,["g3","g1"], false],
			[[2511,3522,0],"z26",100,["g3"], false],
			[[2609,3636,0],"z27",100,["g3","g5"], false],
			[[2611,3519,0],"z28",100,["g3","g1"], false],
			[[2252,3443,0],"z29",100,["g2","g1"], false],
			[[2259,3392,0],"z30",100,["g2","g1"], false],
			[[2362,3393,0],"z31",100,["g4"], false],
			[[2505,3361,0],"z32",100,["g5","g1"], false],
			[[2556,3423,0],"z33",100,["g2"], false],
			[[2603,3329,0],"z34",100,["g5","g3","g1"], false],
			[[2658,3423,0],"z35",100,["g4","g1"], false],
			[[2794,3620,0],"z36",100,["g2","g1"], false],
			[[2869,3583,0],"z37",100,["g2","g2"], false],
			[[2834,3478,0],"z38",100,["g2","g2","g2"], false],
			[[2786,3400,0],"z39",100,["g2","g1"], false],
			[[2854,3325,0],"z40",100,["g3","g3","g2","g1"], false],
			[[2969,3530,0],"z41",100,["g1","g1","g1","g1","g1"], false],
			[[2953,3420,0],"z42",100,["g2","g2","g1"], false],
			[[2913,3286,0],"z43",100,["g2","g2b","g2"], false],
			[[2798,3233,0],"z44",150,["g3","g3","g3","g1"], false],
			[[2727,3261,0],"z45",100,["g2","g2b","g2"], false],
			[[2810,3312,0],"z46",100,["g1","g1"], false],
			[[2919,3193,0],"z47",100,["g3","g3","g1"], false],
			[[2822,3167,0],"z48",100,["g4","g1"], false],
			[[2750,3152,0],"z49",100,["g2","g1"], false],
			[[2800,3065,0],"z50",100,["g3","g1"], false],
			[[2922,3059,0],"z51",250,["g2","g2","g1"], false],
			[[2889,2958,0],"z52",100,["g5","g1"], false],
			[[2746,2948,0],"z53",100,["g3","g1"], false],
			[[2772,2825,0],"z54",100,["g2","g1"], false],
			[[2725,2745,0],"z55",100,["g4","g4","g1"], false],
			[[2689,2968,0],"z56",100,["g2"], false],
			[[2652,2866,0],"z57",100,["g5","g3","g1"], false],
			[[2705,3091,0],"z58",100,["g2"], false],
			[[2734,3420,0],"z59",100,["g2","g1"], false],
			[[2741,3686,0],"z60",100,["g3","g3","g3"], false],
			[[2142,3293,0],"z61",250,["g3","g2","g3"], false],
			[[2282,3340,0],"z62",100,["g2","g2b"], false],
			[[2340,3284,0],"z63",100,["g3","g1"], false],
			[[2261,3196,0],"z64",70,["g2","g2b"], false],
			[[2143,3150,0],"z65",150,["g2","g2b"], false],
			[[2337,3142,0],"z66",150,["g2","g2b","g2"], false],
			[[2504,3280,0],"z67",100,["g2","g2b"], false],
			[[2551,3245,0],"z68",100,["g3","g2","g1"], false],
			[[2497,3183,0],"z69",100,["g2"], false],
			[[2596,3166,0],"z70",100,["g2","g2"], false],
			[[2648,3230,0],"z71",100,["g2","g1"], false],
			[[2195,3087,0],"z72",100,["g2","g2b"], false],
			[[2133,3033,0],"z73",100,["g2","g2b","g2"], false],
			[[2192,3014,0],"z74",100,["g2"], false],
			[[2273,2974,0],"z75",100,["g2","g1"], false],
			[[2327,2938,0],"z76",70,["g1","g1"], false],
			[[2338,3046,0],"z77",100,["g5"], false],
			[[2379,2964,0],"z78",100,["g4","g1"], false],
			[[2449,3042,0],"z79",100,["g3","g3"], false],
			[[2412,3092,0],"z80",70,["g1","g1"], false],
			[[2494,3088,0],"z81",100,["g2"], false],
			[[2583,3089,0],"z82",100,["g3","g1"], false],
			[[2626,3040,0],"z83",100,["g2"], false],
			[[2490,2961,0],"z84",100,["g2","g2"], false],
			[[2536,2975,0],"z85",100,["g1","g1"], false],
			[[2629,2960,0],"z86",100,["g2"], false],
			[[2412,3257,0],"z87",90,["g1","g1","g1","g1","g1","g1"], false],
			[[2140,3395,0],"z88",100,["g2","g2b"], false],
			[[2191,2791,0],"z89",250,["g4","g4","g4","g4"], false],
			[[2129,2905,0],"z90",70,["g2"], false],
			[[2058,3275,0],"z91",70,["g8","g1"], false],
			[[1844,2603,0],"z92",70,["g3","g1"], false],
			[[2341,2541,0],"z93",2000,["pickup","pickup","pickup","pickup","pickup","pickup","pickup_spg"], false]
		];

// do not edit below
arrayvariables = [];
countvariables = 0;

{
_position 	= _x select 0;
_markername 	= _x select 1;
_markersize 	= _x select 2;
_typeofgroup 	= _x select 3;
_antenne 	= _x select 4;

[_markername, _position, _markersize, _triggersize, wcside, _typeofgroup, _antenne, wcenemyside] spawn func_createtrigger;

} forEach _targetname;

refreshvariables = {
	{	
	call compile format["%1 = true; publicvariable %1;", _x];
	}foreach arrayvariables;
};

sleep 10; 

onPlayerConnected call refreshvariables;