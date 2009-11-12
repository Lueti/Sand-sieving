

	private [
		"_position",
		"_crate"

	];
	
	_position = _this select 0;
	if (count _this > 1) then {_position = position _crate; _crate = _this select 1;};

	if(isnil "_crate") then {
		_crate = "USVehicleBox" createVehiclelocal _position;
		_crate setposasl _position;
	};

	clearMagazineCargo _crate;
	clearWeaponCargo _crate;

	_crate addWeaponCargo ["M4A1_HWS_GL_camo",2];
	_crate addMagazineCargo ["30Rnd_556x45_Stanag",20];
	_crate addMagazineCargo ["1Rnd_HE_M203",10];
	_crate addWeaponCargo ["M4A1_HWS_GL_SD_camo",2];
	_crate addMagazineCargo ["30Rnd_556x45_StanagSD",20];
	_crate addWeaponCargo ["M249",1];
	_crate addMagazineCargo ["200Rnd_556x45_M249",10];
	_crate addWeaponCargo ["M4SPR",1];
	_crate addWeaponCargo ["M9",1];
	_crate addMagazineCargo ["15Rnd_9x19_M9",8];
	_crate addWeaponCargo ["M16A4_ACG_GL",2];
	_crate addMagazineCargo ["HandGrenade_West",10];
	_crate addWeaponCargo ["M4A1_AIM_camo",1];
	_crate addWeaponCargo ["M4A1_AIM_SD_camo",1];

