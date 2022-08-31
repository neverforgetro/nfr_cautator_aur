SALUT , ITI MULTUMESC PENTRU CA AI DESCARCAT PETROLISTUL FACUT DE CheluAkaGrasu#0001 / NFR

TOT CE AI NEVOIE ESTE DEJA IN FISIER , TREBUIE DECAT SA SCRII IN SERVER.CFG , ensure [NFR-PETROLIST]

BINEINTELES DACA AI DEJA VREO RESURSA DIN FISIER O POTI FOLOSII PE A TA.

PENTRU FUNCTIONAREA CORECTA A ITEMELOR PUNETI IN vrp/cfg/items.lua urmatoarele :


	["petrol"] = {"Petrol", "", nil, 1},
	["combustibil"] = {"Combustibil", "", nil, 0.0625},



PENTRU FUNCTIONAREA JOBULUI TREBUIE SA PUNETI IN vrp/cfg/groups.lua urmatoarele:

  ["Petrolist"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si petrolist!",2000,4}) end},
  "acces.petrolist"
  },


IN CAZ CA NU VA MERGE DELOC SA VA SCHIMBATI PUNETI IN __resource.lua

https://cdn.discordapp.com/attachments/1004126903860465674/1011654944610340895/fixresource.zip

IN CAZ CA NU VA MERG NOTIFICARILE PUNETI INLOCUITI CE ESTE IN vrp-jobs/src/npc/client/client.lua CU CE E MAI JOS

https://cdn.discordapp.com/attachments/1004126903860465674/1011653964321792210/fixnotify.zip

SAU INLOCUiTI IN FIECARE CLIENT.LUA FUNCTIA DE vRP.Notify cu urmatoarele:

exports['vrp_notify']:Alert("TITLU", "DESCRIERE", 3000, 'info')

PENTRU SUPPORT https://discord.gg/9SyrkguAkH SAU CheluAkaGrasu#0001