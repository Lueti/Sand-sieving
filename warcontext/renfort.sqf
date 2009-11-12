// -----------------------------------------------
// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
// warcontext 
// -----------------------------------------------
playsound "alarm";
if (!isServer) exitWith{};

private [
	"_marker", 
	"_position", 
	"_airfieldposition", 
	"_airfieldposition2", 
	"_x",
	"_y",
	"_z",
	"_position",
	"_group",
	"_unit1",
	"_unit2",
	"_wp",
	"_wp1",
	"_wp2"
	];

_marker = _this select 0;

_position = getmarkerpos _marker;
_x = abs(_position select 0);
_y = abs(_position select 1);
_z = 0;
_position = [_x,_y,_z];

_airfieldposition = [19263,13935,0];

_group = createGroup east;
_vehicle = createVehicle ["Mi17_MG", _airfieldposition, [], 0, "FLY"];
_unit1 = _group createUnit ["SoldierEpilot", _position, [], 0, "NONE"];
_unit2 = _group createUnit ["SoldierEcrew", _position, [], 0, "NONE"];

_unit1 moveindriver _vehicle;
_unit2 moveingunner _vehicle;

_wp = _group addWaypoint [_airfieldposition, 300];
_wp1 = _group addWaypoint [_position, 50];
_wp2 = _group addWaypoint [_airfieldposition, 300];

_wp setWaypointType "MOVE";
_wp setWaypointSpeed "FULL";
_wp setWaypointStatements ["true", "support flyinheight 100;"];

_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "FULL";

vehicletemp = _vehicle;
markertemp = _marker;
_wp1 setWaypointStatements ["true", "[vehicletemp, markertemp] spawn func_para;"];

_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "deletevehicle vehicletemp;"];