/*
Por TheProgrammer Adaptado por Sergio Rex
 [] spawn ica_fnc_menupoli;
*/
#include <macro.h>

if(__GETC__(life_mediclevel) <= 0) exitWith {hint "No eres EMS"; closeDialog 0;};

_type = param [0,0,[0]];
createDialog "The_Programmer_DutyMenu";
_display = findDisplay 8000;
_list = _display displayCtrl 8004;
_rango = (__GETC__(life_mediclevel));

switch (_rango) do {
	case 1: {_rango = "Recluta";};
	case 2: {_rango = "Agente";};
	case 3: {_rango = "Oficial";};
	case 4: {_rango = "Sub Inspector";};
	case 5: {_rango = "Inspector";};
	case 6: {_rango = "Inspector Jefe";};
	case 7: {_rango = "Comisario";};

};

_allControls = allControls (_display);
{
    _x ctrlSetFade 1; 
    _x ctrlCommit 0;
    _x ctrlSetFade 0;
    _x ctrlCommit 1;
} forEach _allControls;


switch (_type) do {
    case 0 : {
        //_text = (['STR_TEXT_COP',"The_programmer_Duty_Config","Prise_Service_Localization"] call theprogrammer_core_fnc_localize);
        (_display displayCtrl 1000) ctrlSetStructuredText parseText format ["<t align = 'center' size='1.7' shadow='0' font='RobotoCondensedBold' color='#0f0f23'>%1</t>","EMS"];


        (_display displayCtrl 8001) ctrlSetText "images\eng_police.paa";
		if (EmsON >= 1) then {_list lbAdd "EMS de servicio"};
       // EmsON = 0;
        {
            _name = name _x;
           if ((side _x) isEqualTo independent) then {
                _list lbAdd format["%1 (%2)",_name,_rango];
                //EmsON = EmsON + 1;
            };
        } foreach playableUnits;
	

        if (EmsON isEqualTo 0) then {_list lbAdd "No hay Medicos de servicio"};
        (_display displayCtrl 8002) buttonSetAction "if (player getVariable ""PoliON"") exitwith {hint ""No puedes estar de policia a la vez."";}; if !(player getvariable ""EMSON"") then {EmsON = EmsON + 1; publicvariable ""EmsON"";}; [""entrar""] spawn ica_fnc_iniciarems; closeDialog 0; ";
        (_display displayCtrl 8003) buttonSetAction "if (player getvariable ""EMSON"") then {EmsON = EmsON - 1; publicvariable ""EmsON"";}; [""salir""] spawn ica_fnc_iniciarems; closeDialog 0;";

    };
 };