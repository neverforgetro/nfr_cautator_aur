local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")



RegisterServerEvent('cautator:succes')
AddEventHandler('cautator:succes', function()
    local src = source
    local user_id = vRP.getUserId({src})
    local max = vRP.getInventoryMaxWeight({user_id})
    local actual = vRP.getInventoryWeight({user_id})
    local player = vRP.getUserSource({user_id})
    local randomizare = math.random(1, 8)
    if vRP.tryGetInventoryItem({user_id,"sita",1, false}) then
        if vRP.hasGroup({user_id, 'Cautator de Aur'}) then
            if actual >= max then
                vRPclient.notify(player, {"Eroare: Inventar plin"})
            else
                if randomizare == 1 then
                    vRPclient.notify(player, {"Succes: A fost aur!"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'aur', Config.amount2, true})
                elseif randomizare == 2 then
                    vRPclient.notify(player, {"Succes: A fost aur!"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'aur', Config.amount2, true})
                elseif randomizare == 3 then
                    vRPclient.notify(player, {"Succes: A fost aur!"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'aur', Config.amount2, true})
                elseif randomizare == 4 then
                    vRPclient.notify(player, {"Eroare: Ai crezut ca era aur dar este defapt piatra"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'piatra', Config.amount2, true})
                elseif randomizare == 5 then
                    vRPclient.notify(player, {"Eroare: Ai crezut ca era aur dar este defapt piatra"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'piatra', Config.amount2, true})
                elseif randomizare == 6 then
                    vRPclient.notify(player, {"Eroare: Ai crezut ca era aur dar este defapt piatra"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'piatra', Config.amount2, true})
                elseif randomizare == 7 then
                    vRPclient.notify(player, {"Eroare: Ai crezut ca era aur dar este defapt piatra"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'piatra', Config.amount2, true})
                elseif randomizare == 8 then
                    vRPclient.notify(player, {"Succes: Ai crezut ca era aur dar este defapt o piatra pretioasa!"})
                    Wait(1000)
                    vRP.giveInventoryItem({user_id, 'pretioasa', 1, true})
                end
                vRP.giveInventoryItem({user_id, 'sita', 1, false})
            end
        else
            vRPclient.notify(player, {"Eroare: Nu ai jobul!"})
        end
    else
        vRPclient.notify(player, {"Eroare: Nu ai sita"})
    end
end)

RegisterServerEvent('cautator:unsucces')
AddEventHandler('cautator:unsucces', function()
    vRPclient.notify(player, {"Eroare: Nu ai gasit aur!"})
end)

RegisterServerEvent('cautator:toolong')
AddEventHandler('cautator:toolong', function()
    vRPclient.notify(player, {"Eroare: Ai asteptat prea mult si nu ai gasit nimic!"})
end)


started = false
started2 = false

RegisterServerEvent('cautator:ofera')
AddEventHandler('cautator:ofera', function()
    started = true
    local src = source
    local user_id = vRP.getUserId({src})
    local max = vRP.getInventoryMaxWeight({user_id})
    local actual = vRP.getInventoryWeight({user_id})
    local player = vRP.getUserSource({user_id})
    if started2 then
        print("caca nu e voie")
    else
        while started do 
            Wait(1000)
            if vRP.hasGroup({user_id, 'Cautator de Aur'}) then
                if vRP.tryGetInventoryItem({user_id,"aur", 1, false}) then
                    vRP.giveMoney({user_id,Config.SellPrice})
                    vRPclient.notify(player, {"Ai vandut aurul cu "..Config.SellPrice.."$"})
                else
                    vRPclient.notify(player, {"Eroare: Nu ai aur"})
                end
            else
                vRPclient.notify(player, {"Eroare: Nu ai jobul!"})
            end
        end
    end

end)

RegisterServerEvent('cautator:stop')
AddEventHandler('cautator:stop', function()
    started = false
    started2 = false
end)



RegisterServerEvent('cautator:ofera2')
AddEventHandler('cautator:ofera2', function()
    started2 = true
    local src = source
    local user_id = vRP.getUserId({src})
    local max = vRP.getInventoryMaxWeight({user_id})
    local actual = vRP.getInventoryWeight({user_id})
    local player = vRP.getUserSource({user_id})
    if started then
        print("caca nu e voie")
    else
        while started2 do 
            Wait(1000)
            if vRP.hasGroup({user_id, 'Cautator de Aur'}) then
                if vRP.tryGetInventoryItem({user_id,"pretioasa", 1, false}) then
                    vRP.giveMoney({user_id,Config.SellPrice2})
                    vRPclient.notify(player, {"Ai vandut o piatra pretioasa cu "..Config.SellPrice2.."$"})
                else
                    vRPclient.notify(player, {"Eroare: Nu ai piatra pretioasa"})
                end
            else
                vRPclient.notify(player, {"Eroare: Nu ai jobul!"})
            end
        end
    end

end)
