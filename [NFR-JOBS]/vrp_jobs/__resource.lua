ui_page {
    'src/_utils/html/ui.html'
}
files {
	'src/_utils/html/*.*'
}

shared_script 'src/_utils/config.lua'

client_scripts {
    "@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
  
    "src/_utils/vRP/vrp_client.lua",
    "src/_utils/locations.lua",
    "src/_utils/shared.lua",
    
    "src/npc/client/client.lua",
    "src/npc/html/",
  



 

 
}
  
server_scripts{ 
    "@vrp/lib/utils.lua",
   --[cocaina]--
  
   "src/_utils/vRP/vrp_server.lua",
   


  
   
   "src/npc/server/server.lua",

  
}
