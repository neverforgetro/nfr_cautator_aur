local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterServerEvent('petrol:givejob')
AddEventHandler('petrol:givejob', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Petrolist'}) then
        TriggerClientEvent('petrol:isPetrolist', source)
    else
        vRPclient.notify(player,{"Nu ai job-ul"})
    end
end)

RegisterServerEvent('petrol:takejob')
AddEventHandler('petrol:takejob', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Petrolist'}) then
        TriggerClientEvent("raid_clothes:incarcaHainele", player)
    else
        vRPclient.notify(player,{"Imi pare rau , intoarcete unde te-ai angajat inainte."})
    end
end)


RegisterServerEvent('cautator:givejob')
AddEventHandler('cautator:givejob', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasGroup({user_id, 'Cautator de Aur'}) then
        TriggerClientEvent('cautator:iscautator', source)
    else
        vRPclient.notify(player,{"Nu ai job-ul"})
    end
end)

RegisterServerEvent('cautator:incepe')
AddEventHandler('cautator:incepe', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local numaratoare = math.random(1, 2)
    if vRP.hasGroup({user_id, 'Cautator de Aur'}) then
        if numaratoare == 1 then
            TriggerClientEvent('cautator:raul1', source)
        elseif numaratoare == 2 then
            vRPclient.notify(player,{"Du-te la raul #2"})
            TriggerClientEvent('cautator:raul2', source)
        end
    else
        vRPclient.notify(player,{"Nu ai job-ul"})
    end
end)

RegisterServerEvent('cautator:takejob')
AddEventHandler('cautator:takejob', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
        TriggerClientEvent("raid_clothes:incarcaHainele", player)
end)

