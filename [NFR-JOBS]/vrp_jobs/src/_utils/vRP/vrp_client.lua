
vRP = Proxy.getInterface("vRP")


vRPSconstructor = Tunnel.getInterface("vRP_Constructor","vRP_Constructor")
vRPSfisher = Tunnel.getInterface("vRP_Fisher","vRP_Fisher")
vRPSbus = Tunnel.getInterface("vrp_bus","vrp_bus")
vRPSminer = Tunnel.getInterface("vRP_miner","vRP_miner")
vRPSpadurar = Tunnel.getInterface("vRPPadurar","vRPPadurar")

vRPCmcdonalds = {}
Tunnel.bindInterface("vRP_mcdonalds",vRPCmcdonalds)
Proxy.addInterface("vRP_mcdonalds",vRPCmcdonalds)

vRPCconstructor = {}
Tunnel.bindInterface("vRP_Constructor",vRPCconstructor)
Proxy.addInterface("vRP_Constructor",vRPCconstructor)

vRPCfisher = {}
Tunnel.bindInterface("vRP_Fisher",vRPCfisher)
Proxy.addInterface("vRP_Fisher",vRPCfisher)


vRPCbus = {}
Tunnel.bindInterface("vrp_bus",vRPCbus)
Proxy.addInterface("vrp_bus",vRPCbus)

vRPCminer = {}
Tunnel.bindInterface("vRP_miner",vRPCminer)
Proxy.addInterface("vRP_miner",vRPCminer)

vRPCpadurar = {}
Tunnel.bindInterface("vRPPadurar",vRPCpadurar)
Proxy.addInterface("vRPPadurar",vRPCpadurar)






