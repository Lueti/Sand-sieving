FLIROFF = 
{
hint "FLIR mode OFF";
setaperture -1;
ppEffectDestroy ppColor;
ppEffectDestroy ppBlur;
ppEffectDestroy ppInversion;
ppEffectDestroy ppGrain;
};

FLIRON = 
{
ppEffectDestroy ppColor;
ppEffectDestroy ppBlur;
ppEffectDestroy ppInversion;
ppEffectDestroy ppGrain;

ppGrain = ppEffectCreate ["filmGrain", 2005];
ppGrain ppEffectEnable true;
ppGrain ppEffectAdjust [0.02, 1, 1, 0, 1];
ppGrain ppEffectCommit 0;

ppInversion = ppEffectCreate ["colorInversion", 2555];
ppInversion ppEffectEnable true;
ppInversion ppEffectAdjust [0.1,0.1,0.1];
ppInversion ppEffectCommit 0;

ppColor = ppEffectCreate ["ColorCorrections", 1999];
ppColor ppEffectEnable true;
ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0.0], [1, 1, 1, 1.0]];
ppColor ppEffectCommit 0;
ppBlur = ppEffectCreate ["dynamicBlur", 505];
ppBlur ppEffectEnable true;  
ppBlur ppEffectAdjust [.5];
ppBlur ppEffectCommit 0;
};

FLIRREVERSE = {
ppEffectDestroy ppColor;
ppEffectDestroy ppBlur;
ppEffectDestroy ppInversion;
ppEffectDestroy ppGrain;

ppInversion = ppEffectCreate ['colorInversion', 2555];
ppInversion ppEffectEnable true;
ppInversion ppEffectAdjust [1,1,1];
ppInversion ppEffectCommit 0;

ppGrain = ppEffectCreate ["filmGrain", 2005];
ppGrain ppEffectEnable true;
ppGrain ppEffectAdjust [0.02, 1, 1, 0, 1];
ppGrain ppEffectCommit 0;

ppColor = ppEffectCreate ["ColorCorrections", 1999];
ppColor ppEffectEnable true;
ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0.0], [1, 1, 1, 1.0]];
ppColor ppEffectCommit 0;
ppBlur = ppEffectCreate ["dynamicBlur", 505];
ppBlur ppEffectEnable true;  
ppBlur ppEffectAdjust [.5];
ppBlur ppEffectCommit 0;
};

keyEventD =
{
private ["_event","_keyCode","_shift","_control","_alt","_vehicle","_aperture","_FLIR","_color", "_zchange","_oldAperture","_zChangeFinal"];
				_event = (_this select 0);//[_display, _keyCode, _shift, _control, _alt];
				_keyCode 	= 	_event select 1;
				_shift 		= 	_event select 2;
				_control 	= 	_event select 3;
				_alt 		= 	_event select 4;
	_vehicle = vehicle(player);
	_FLIR = _vehicle getvariable 'FLIR';
	_aperture = _FLIR select 1;
	_color = _FLIR select 2;
	switch (_KeyCode) do {
		case 19:{	//R
		   if(_color == "white")then
		   {
		   _color = "black";
		   _vehicle setvariable ["FLIR",["ON",_aperture,_color]];
		   call FLIRREVERSE;
		   }else
		   {
		   _color = "white";
		   _vehicle setvariable ["FLIR",["ON",_aperture,_color]];
		   call FLIRREVERSE;
		   call FLIRON;
		   };
		};
		case 16:{	//Q
		   _zchange = -1;
		   _oldAperture = _FLIR select 1;
		   _zChangeFinal = _zChange / 2;
		   if (_oldAperture <= 1.0) then {_zChangeFinal = _zChange / 10};
		   if (_oldAperture <= 0.1) then {_zChangeFinal = _zChange / 1000};
		   _aperture = _oldAperture + _zchangeFinal;
		   if (_oldaperture > 1.0 && _aperture < 1.0) then {_aperture = 1.0};
		   if (_oldaperture > 0.1 && _aperture < 0.1) then {_aperture = 0.1};
		   if (_aperture < 0.001) then {_aperture = 0.001};
		   _vehicle setvariable ["FLIR",["ON",_aperture,_color]];
		   setaperture _aperture;
		};
		case 18:{	//E
		   _zchange = +1;
		   _oldAperture = _FLIR select 1;
		   _zChangeFinal = _zChange / 2;
		   if (_oldAperture <= 1.0) then {_zChangeFinal = _zChange / 10};
		   if (_oldAperture <= 0.1) then {_zChangeFinal = _zChange / 1000};
		   _aperture = _oldAperture + _zchangeFinal;
		   if (_oldaperture > 1.0 && _aperture < 1.0) then {_aperture = 1.0};
		   if (_oldaperture > 0.1 && _aperture < 0.1) then {_aperture = 0.1};
		   if (_aperture < 0.001) then {_aperture = 0.001};
		   _vehicle setvariable ["FLIR",["ON",_aperture,_color]];
		   setaperture _aperture;
		};
	};
};