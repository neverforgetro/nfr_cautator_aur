SALUT , PENTRU A FUNCTIONA JOB-UL TREBUIE SA ADAUGI CE E MAI JOS IN vrp/cfg/groups.lua

["Cautator de Aur"] = {_config = { gtype = "job",onspawn = function(player) vRPclient.notify(player,{"Lucrezi ca si Cautator de Aur",2000,4}) end},
"acces.cautator"
},

IAR CA SA FUNCTIONEZE ITEMELE TREBUIE SA ADAUGI CE E MAI JOS IN vrp/cfg/items.lua


	["sita"] = {"Sita", "", nil, 1},
	["aur"] = {"O bucatica de aur", "", nil, 1},
	["piatra"] = {"O bucatica de piatra", "", nil, 1},
    ["pretioasa"] = {"O bucatica de piatra pretioasa", "", nil, 1},



CELOR CARE NU LE APARE NPC-UL , INTRATI IN vrp_jobs si inlocuiti __resource.lua cu
https://cdn.discordapp.com/attachments/969672787990048838/1014514659715465367/resource.zip

SAU VERIFICATI DACA AVETI VREUN FISIER NUMIT LA FEL CU CEL CE ESTE AICI!


CELOR CARE NU LE APAR NOTIFICARILE , DACA AVETI OKOKNOTIFY PUNETI LA FIECARE NOTIFICARE IN LOC DE exports[vrp_notify] , PUNETI exports[cum aveti voi trecut numele la okoknotify]

CEI CARE NU AU OKOKNOTIFY IMI DAU MESAJ PE DISCORD LA NFR#0001 SAU PE https://dsc.gg/nfr

PUTETI INLOCUI NOTIFICARILE CARE LE AVETI CU OKOKNOTIFY-UL ACESTA

https://cdn.discordapp.com/attachments/1014172727210414153/1014286688266235904/vrp_notify.zip