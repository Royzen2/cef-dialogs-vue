#include <a_samp>
#include cef
#include Pawn.CMD
#include sscanf2
#include <Pawn.RakNet>
#include <streamer>
#include a_mysql
#include foreach
main(){}

#define ID_BROWSER_DIALOGS  5



public OnGameModeInit(){
	cef_subscribe("OnCustomDialogResponse", "OnCustomDialogResponse");
}

public OnPlayerSpawn(playerid){
	cef_create_browser(playerid, ID_BROWSER_DIALOGS, "file:///C:/Users/petro/OneDrive/%D0%A0%D0%B0%D0%B1%D0%BE%D1%87%D0%B8%D0%B9%20%D1%81%D1%82%D0%BE%D0%BB/cef_dialogs/cef_dialogs/dist/index.html", false, false);

}
forward OnCustomDialogResponse(playerid, params[]);
public OnCustomDialogResponse(playerid, params[]){
	extract params -> new dialog_id, response, listitem, string: inputtext[425];
	
	switch(dialog_id) {
		case 1:{
			if(response) {
			    SendClientMessage(playerid, -1, "Респонсе 1");
			    switch(listitem)
			    {
			        case 0:{
			            SendClientMessage(playerid, -1, "list 1");
			        
			        }
			        case 1:{
			            SendClientMessage(playerid, -1, "list 2");

			        }
			        case 2:{
			            SendClientMessage(playerid, -1, "list 3");

			        }
			    }
			}else SendClientMessage(playerid, -1, "Респонсе 0");
		}
		case 2:{
			if(response) {
			    SendClientMessage(playerid, -1, "Респонсе 1");
                SendClientMessage(playerid, -1, inputtext);
			}else SendClientMessage(playerid, -1, "Респонсе 0");
		}
	}

}
cmd:add_dialog(playerid)
{
	Dialog(playerid,
	1,
	DIALOG_STYLE_LIST,
	"{ff8c00}Тест {ffffff}диалог",
	"{ffffff}Вау\n{ff8c00}круто\nвообще\n",
	"Да",
	"Нет");
}
cmd:add_dialog_input(playerid)
{
	Dialog(playerid,
	2,
	DIALOG_STYLE_INPUT,
	"Тест диалог",
	"Вау\nкруто\nвообще\n",
	"Да",
	"Нет");
}
cmd:add_dialog_msgbox(playerid)
{
	Dialog(playerid,
	2,
	DIALOG_STYLE_MSGBOX,
	"Тест диалог",
	"{ff8c00}Вау\t{ff0000}круто\tвообще\n",
	"Да",
	"Нет");
}
stock client_Dialog(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	cef_focus_browser(playerid, ID_BROWSER_DIALOGS, true);
	static
			buffer[4096 + 1];

	for (new i = sizeof(buffer) - 1; i != -1; i--)
		buffer[i] = '\0';

	for (new i, j; info[i] != '\0'; i++) {
		if (info[i] == '\n')
		strcat(buffer, "<n>"), j += 3;
		else if (info[i] == '\t')
		strcat(buffer, "<t>"), j += 3;
		else if (info[i] == '\"')
		buffer[j++] = '\'';
		else
		buffer[j++] = info[i];
	}
	format(buffer, sizeof(buffer), "[\"%s\", \"%s\", \"%s\", \"%s\"]", caption, buffer, button1, button2);
	cef_emit_event(playerid, "ShowPlayerDialog", CEFINT(dialogid), CEFINT(style), CEFSTR(buffer));
	return 1;
}
stock Dialog(playerid, dialogid, type, captions[], items[],  button1[], button2[]){
	return client_Dialog(playerid, dialogid, type, captions, items, button1, button2);
}
