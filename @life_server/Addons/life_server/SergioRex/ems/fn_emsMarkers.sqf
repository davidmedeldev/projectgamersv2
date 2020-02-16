/*
	File: fn_copMarkers.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Marks cops on the map for other cops. Only initializes when the actual map is open.
*/
//private["MarcadoresEMS","_cops"];
MarcadoresEMS = [];
_cops = [];

sleep 2;
if(visibleMap) then {
	{if(side _x == independent) then {_cops pushBack _x;}} foreach playableUnits; //Fetch list of cops / blufor

	//Create markers
	{
		_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTypeLocal "Mil_dot";
		_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];

		MarcadoresEMS pushBack [_marker,_x];
	} foreach _cops;

	while {visibleMap} do
	{
		{
			private["_marker","_unit"];
			_marker = _x select 0;
			_unit = _x select 1;

			if(!isNil "_unit") then
			{
				if(!isNull _unit) then
				{
					if ("ItemGPS" in assignedItems _unit) then
					{
						_marker setMarkerPosLocal (visiblePosition _unit);
					};
				};
			};

		} foreach MarcadoresEMS;
		if(!visibleMap) exitWith {};
		sleep 0.02;
	};

	{deleteMarkerLocal (_x select 0);} foreach MarcadoresEMS;
	MarcadoresEMS = [];
	_cops = [];
};