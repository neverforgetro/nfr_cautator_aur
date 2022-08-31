local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")


vRPclient = Tunnel.getInterface("vRP","vRP")


vRPCconstructor = Tunnel.getInterface("vRP_Constructor","vRP_Constructor")
vRPCfisher = Tunnel.getInterface("vRP_Fisher","vRP_Fisher")
vRPCbus = Tunnel.getInterface("vrp_bus","vrp_bus")
vRPCminer = Tunnel.getInterface("vRP_miner","vRP_miner")
vRPCpadurar = Tunnel.getInterface("vRPPadurar","vRPPadurar")
vRPCmcdonalds = Tunnel.getInterface("vRP_mcdonalds","vRP_mcdonalds")

vRPSmcdonalds = {}
Tunnel.bindInterface("vRP_mcdonalds",vRPSmcdonalds)
Proxy.addInterface("vRP_mcdonalds",vRPSmcdonalds)

vRPSconstructor = {}
Tunnel.bindInterface("vRP_Constructor",vRPSconstructor)
Proxy.addInterface("vRP_Constructor",vRPSconstructor)

vRPSfisher = {}
Tunnel.bindInterface("vRP_Fisher",vRPSfisher)
Proxy.addInterface("vRP_Fisher",vRPSfisher)

vRPSbus = {}
Tunnel.bindInterface("vrp_bus",vRPSbus)
Proxy.addInterface("vrp_bus",vRPSbus)

vRPSminer = {}
Tunnel.bindInterface("vRP_miner",vRPSminer)
Proxy.addInterface("vRP_miner",vRPSminer)

vRPSpadurar = {}
Tunnel.bindInterface("vRPPadurar",vRPSpadurar)
Proxy.addInterface("vRPPadurar",vRPSpadurar)
vRPSpetrolier = {}
Tunnel.bindInterface("vRPpetrolier",vRPSpetrolier)
Proxy.addInterface("vRPPpetrolier",vRPSpetrolier)

