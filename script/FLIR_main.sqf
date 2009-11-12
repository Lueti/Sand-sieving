//090727 ACTION MENU BUG FIXED.

_caller = (_this select 1);
_vehicle = (_this select 0);

if(!(_caller == gunner _vehicle))exitwith{hint "only gunner can use this function."};

disableSerialization;

sleep 0.1;

hint "FLIR mode ON\nR -> Reverse brightness\nQ -> brightness+\nE -> brightness-";

_disp = findDisplay 46;

//deactivate FLIR
_FLIR = _vehicle getvariable "FLIR";
_isFLIR = (_FLIR select 0);
if(_isFLIR == "ON")
exitwith{
(_disp) displayRemoveEventHandler ["KeyDown",FLIR_keyEvent];
call FLIROFF;
_aperture = (_FLIR select 1);
_vehicle setvariable ["FLIR",["OFF",_aperture,_color]];
};

//daytime -> round value
	_color = "white";
_daytime = round daytime;
	switch (_daytime) do {
	case 0:{_aperture = 0.05;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 1:{_aperture = 0.1;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 2:{_aperture = 0.1;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 3:{_aperture = 0.1;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 4:{_aperture = 0.1;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 5:{_aperture = 0.1;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 6:{_aperture = 1.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 7:{_aperture = 4.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 8:{_aperture = 12.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 9:{_aperture = 23.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 15:{_aperture = 25.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 16:{_aperture = 14.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 17:{_aperture = 4;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 18:{_aperture = 1;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 19:{_aperture = 0.03;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 20:{_aperture = 0.03;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 21:{_aperture = 0.03;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 22:{_aperture = 0.03;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 23:{_aperture = 0.05;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	case 24:{_aperture = 0.05;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	default {_aperture = 35.0;_vehicle setvariable ["FLIR",["ON",_aperture,_color]];setaperture _aperture;};
	};
//activateFLIR
call FLIRON;

FLIR_keyEvent = (_disp) displayaddEventHandler ["KeyDown","[_this] call keyEventD"];

while{true} do
{
scopename "loopF";
if(not (_caller == gunner _vehicle))then{breakout "loopF"};
if((not alive _vehicle)or(not alive _caller))then{breakout "loopF"};
sleep 0.1;
};

_aperture = (_FLIR select 1);
_collor = (_FLIR select 2);
(_disp) displayRemoveEventHandler ["KeyDown",FLIR_keyEvent];
_vehicle setvariable ["FLIR",["OFF",_aperture,_color]];
call FLIROFF;
exit;