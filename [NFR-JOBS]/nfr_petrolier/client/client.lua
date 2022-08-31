local inRange = false
CreateThread(function()
    local locations = Config.Pompe
    while true do
        Citizen.Wait(2000) -- teoretic orice valoare mai mare de 1s consuma aproape nimic
        for i = 1, #locations do
        local location = locations[i]
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dst = #(pos - location)
        
        while dst <= 10.0 do
          
            DrawMarker(20, location , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 200, 10, 10, 100, 0, 0, 0, 0, 0, 0, 0)
        if dst <= 3.0 then
            exports['vrp_textui']:Open('Apasa [E] pentru a deschide valva ', 'darkgrey', 'left') 
            if IsControlJustPressed(0, 46) then
                Citizen.Wait(10)
                SetDisplay(not display)
            end
        else 
            exports['vrp_textui']:Close()
            TriggerServerEvent('petrol:stop')
        end
          Citizen.Wait(1)
          dst = #(GetEntityCoords(ped) - location)
        end
    end
    end
end)

CreateThread(function()
    local locations = Config.Rafinare
    while true do
        Citizen.Wait(2000) -- teoretic orice valoare mai mare de 1s consuma aproape nimic
        for i = 1, #locations do
        local location = locations[i]
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dst = #(pos - location)
        
        while dst <= 8.0 do
          
            DrawMarker(20, location , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 200, 10, 10, 100, 0, 0, 0, 0, 0, 0, 0)
        if dst <= 3.0 then
            exports['vrp_textui']:Open('Apasa [E] pentru a rafina petrolul', 'darkgrey', 'left') 
            if IsControlJustPressed(0, 46) then
                exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,                -- Position on x-axis
                    y = 0.85,                -- Position on y-axis
                    From = 0,               -- Percentage to start from
                    To = 100,               -- Percentage to end
                    Duration = 2500,        -- Duration of the progress
                    Radius = 60,            -- Radius of the dial
                    Stroke = 10,            -- Thickness of the progress dial
                    Cap = 'butt',           -- or 'round'
                    Padding = 0,            -- Padding between the progress dial and the background dial
                    MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
                    Rotation = 0,           -- 2D rotation of the dial in degrees
                    Width = 300,            -- Width of bar in px if Type = 'linear'
                    Height = 40,            -- Height of bar in px if Type = 'linear'
                    ShowTimer = true,       -- Shows the timer countdown within the radial dial
                    ShowProgress = false,   -- Shows the progress % within the radial dial    
                    Easing = "easeLinear",
                    Label = "Rafinezi..",
                    LabelPosition = "bottom",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
                    ZoneColor = "rgba(51, 105, 30, 1)",
                    Animation = {
                        animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
                        animationName = "machinic_loop_mechandplayer",
                    },
                    DisableControls = {
                        Mouse = true,
                        Player = true,
                        Vehicle = true
                    },    
                    onComplete = function(cancelled)
                        TriggerServerEvent('rafinarie:give')
                    end
                })
            end
        else 
            exports['vrp_textui']:Close()
        end
          Citizen.Wait(1)
          dst = #(GetEntityCoords(ped) - location)
        end
    end
    end
end)


CreateThread(function()
    local locations = Config.Vanzare
    while true do
        Citizen.Wait(2000) -- teoretic orice valoare mai mare de 1s consuma aproape nimic
        for i = 1, #locations do
        local location = locations[i]
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dst = #(pos - location)
        
        while dst <= 8.0 do
          
            DrawMarker(20, location , 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 200, 10, 10, 100, 0, 0, 0, 0, 0, 0, 0)
        if dst <= 3.0 then
            exports['vrp_textui']:Open('Apasa [E] pentru a incarca combustibilul', 'darkgrey', 'left') 
            if IsControlJustPressed(0, 46) then
                exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,                -- Position on x-axis
                    y = 0.85,                -- Position on y-axis
                    From = 0,               -- Percentage to start from
                    To = 100,               -- Percentage to end
                    Duration = 2500,        -- Duration of the progress
                    Radius = 60,            -- Radius of the dial
                    Stroke = 10,            -- Thickness of the progress dial
                    Cap = 'butt',           -- or 'round'
                    Padding = 0,            -- Padding between the progress dial and the background dial
                    MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
                    Rotation = 0,           -- 2D rotation of the dial in degrees
                    Width = 300,            -- Width of bar in px if Type = 'linear'
                    Height = 40,            -- Height of bar in px if Type = 'linear'
                    ShowTimer = true,       -- Shows the timer countdown within the radial dial
                    ShowProgress = false,   -- Shows the progress % within the radial dial    
                    Easing = "easeLinear",
                    Label = "Incarci combustibilul..",
                    LabelPosition = "bottom",
                    Color = "rgba(255, 255, 255, 1.0)",
                    BGColor = "rgba(0, 0, 0, 0.4)",
                    ZoneColor = "rgba(51, 105, 30, 1)",
                    Animation = {
                        animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
                        animationName = "machinic_loop_mechandplayer",
                    },
                    DisableControls = {
                        Mouse = true,
                        Player = true,
                        Vehicle = true
                    },    
                    onComplete = function(cancelled)
                        TriggerServerEvent('vanzare:takeandgive')
                    end
                })
            end
        else 
            exports['vrp_textui']:Close()
        end
          Citizen.Wait(1)
          dst = #(GetEntityCoords(ped) - location)
        end
    end
    end
end)


Citizen.CreateThread(function()
    local locations = Config.Pompe
for k,v in pairs(locations) do
local blip = AddBlipForCoord(v.x, v.y, v.z)

	SetBlipSprite (blip, 436)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Pompa Petrol')
	EndTextCommandSetBlipName(blip)
end
end)

Citizen.CreateThread(function()
    local locations = Config.Rafinare
for k,v in pairs(locations) do
local blip = AddBlipForCoord(v.x, v.y, v.z)

	SetBlipSprite (blip, 467)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 29)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Rafinare Petrol')
	EndTextCommandSetBlipName(blip)
end
end)

Citizen.CreateThread(function()
    local locations = Config.Vanzare
for k,v in pairs(locations) do
local blip = AddBlipForCoord(v.x, v.y, v.z)

	SetBlipSprite (blip, 500)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 2)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Vanzare Combustibil')
	EndTextCommandSetBlipName(blip)
end
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-476.4401, -2691.937, 8.761134, 47.63889)
    
        SetBlipSprite (blip, 361)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 25)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Petrolist')
        EndTextCommandSetBlipName(blip)
end)
RegisterNUICallback("start", function()
    Citizen.Wait(1000)
    TriggerServerEvent('petrol:start')
end)
RegisterNUICallback("stop", function()
    TriggerServerEvent('petrol:stop')
end)



RegisterNUICallback("exit", function()
    Citizen.Wait(10)
    SetDisplay(false)
    TriggerServerEvent('petrol:stop')
end)



function SetDisplay(bool)
    display = bool
    if bool then
        TriggerScreenblurFadeIn(1000)
    else
    TriggerScreenblurFadeOut(1000)
    end
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(10)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)