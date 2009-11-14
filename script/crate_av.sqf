

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
	_crate addMagazineCargo ["30Rnd_556x45_Stanag",60];
	_crate addMagazineCargo ["1Rnd_HE_M203",10];
	_crate addWeaponCargo ["M4A1_HWS_GL_SD_camo",2];
	_crate addMagazineCargo ["30Rnd_556x45_StanagSD",48];
	_crate addWeaponCargo ["M249",2];
	_crate addMagazineCargo ["200Rnd_556x45_M249",15];
	_crate addWeaponCargo ["M4SPR",2];
	_crate addWeaponCargo ["M9",3];
	_crate addMagazineCargo ["15Rnd_9x19_M9",25];
	_crate addWeaponCargo ["M16A4_ACG_GL",5];
	_crate addMagazineCargo ["HandGrenade_West",10];
	_crate addWeaponCargo ["M4A1_AIM_camo",2];
	_crate addWeaponCargo ["M4A1_AIM_SD_camo",2];
	_crate addWeaponCargo ["SmokeShell",20];

