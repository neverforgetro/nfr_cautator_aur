local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")
local valva = false



RegisterServerEvent('petrol:start')
AddEventHandler('petrol:start', function()
    local src = source
    local user_id = vRP.getUserId({src})
    local max = vRP.getInventoryMaxWeight({user_id})
    local actual = vRP.getInventoryWeight({user_id})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Petrolist'}) then
        valva = true
        if actual >= max then
            vRPclient.notify(player, {"Eroare: Inventar plin"})
        else
            while valva do
                local max = vRP.getInventoryMaxWeight({user_id})
                local actual = vRP.getInventoryWeight({user_id})
                Wait(1500)
                if actual < max then
                vRP.giveInventoryItem({user_id, 'petrol', Config.amount, true})
                else
                    vRPclient.notify(player, {"Eroare: Inventar plin"})
                end
            end
        end
    else
        vRPclient.notify(player, {"Eroare: Nu ai jobul!"})
    end
end)
RegisterServerEvent('petrol:stop')
AddEventHandler('petrol:stop', function()
    valva = false
end)

RegisterServerEvent('rafinarie:give')
AddEventHandler('rafinarie:give', function()
    local src = source
    local user_id = vRP.getUserId({src})
    local max = vRP.getInventoryMaxWeight({user_id})
    local actual = vRP.getInventoryWeight({user_id})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Petrolist'}) then
        if actual >= max then
            vRPclient.notify(player, {"Eroare: Inventar plin"})
        else
            if vRP.tryGetInventoryItem({user_id,"petrol",1}) then
            vRP.giveInventoryItem({user_id, 'combustibil', Config.amount2, true})
            end
        end
    else
        vRPclient.notify(player, {"Eroare: Nu ai jobul!"})
    end
end)

RegisterServerEvent('vanzare:takeandgive')
AddEventHandler('vanzare:takeandgive', function()
    local src = source
    local user_id = vRP.getUserId({src})
    local max = vRP.getInventoryMaxWeight({user_id})
    local actual = vRP.getInventoryWeight({user_id})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Petrolist'}) then
        if vRP.tryGetInventoryItem({user_id,"combustibil",16}) then
            vRP.giveMoney({user_id,Config.SellPrice})
            vRPclient.notify(player, {"Ai vandut cu "..Config.SellPrice.."$"})
        end
    else
        vRPclient.notify(player, {"Eroare: Nu ai jobul!"})
    end
end)