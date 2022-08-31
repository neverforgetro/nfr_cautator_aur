local inRange = false

CreateThread(function()
    local locations = Config.Locatii
    while true do
        Citizen.Wait(2000) -- teoretic orice valoare mai mare de 1s consuma aproape nimic
        for i = 1, #locations do
        local location = locations[i]
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dst = #(pos - location)
        
        while dst <= 8.0 do
          
            DrawMarker(2, location, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 200, 10, 10, 150, 0, 0, 0, 0, 0, 0, 0)
        if dst <= 3.5 then
            exports['vrp_textui']:Open('Apasa [E] pentru a cauta aur', 'darkgrey', 'left') 
            if IsControlJustPressed(0, 46) then
                exports.rprogress:Custom({
                    Async = true,
                    x = 0.5,                -- Position on x-axis
                    y = 0.85,                -- Position on y-axis
                    From = 0,               -- Percentage to start from
                    To = 100,               -- Percentage to end
                    Duration = 1000,        -- Duration of the progress
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
                    Label = "Cauti aur..",
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
                        exports.rprogress:MiniGame({
                            Difficulty = "Easy",
                            Timeout = 10000, -- Duration before minigame is cancelled
                            onComplete = function(success)
                                    if success then
                                        TriggerServerEvent('cautator:succes')
                                        ClearPedTasksImmediately(ped)
                                    else
                                        TriggerServerEvent('cautator:unsucces')
                                        ClearPedTasksImmediately(ped)
                                    end    
                            end,
                            onTimeout = function()
                                TriggerServerEvent('cautator:toolong')
                                ClearPedTasksImmediately(ped)
                            end
                        })
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

        if dst <= 3.5 then
            exports['vrp_textui']:Open('Apasa [E] pentru a vinde aurul.', 'darkgrey', 'left') 
            if IsControlJustPressed(0, 46) then
                SetDisplay(not display)
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
    local locations = Config.Rauri
for k,v in pairs(locations) do
local blip = AddBlipForCoord(v.x, v.y, v.z)

	SetBlipSprite (blip, 103)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 74)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('RAU CU AUR')
	EndTextCommandSetBlipName(blip)
end
end)

Citizen.CreateThread(function()
    local locations = Config.Vanzare
for k,v in pairs(locations) do
local blip = AddBlipForCoord(v.x, v.y, v.z)

	SetBlipSprite (blip, 365)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 17)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('VANZARE AUR')
	EndTextCommandSetBlipName(blip)
end
end)

local coordonate = {
    {1082.205, -1997.955, 30.21741,"Vanzare Aur",325.3241,0xC9E5F56B ,"s_m_m_ccrew_01"},
}

Citizen.CreateThread(function()

    for _,v in pairs(coordonate) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)


RegisterNUICallback("ofera", function()
    Citizen.Wait(10)
    TriggerServerEvent('cautator:ofera')
end)

RegisterNUICallback("ofera2", function()
    Citizen.Wait(10)
    TriggerServerEvent('cautator:ofera2')
end)




RegisterNUICallback("exit", function()
    Citizen.Wait(10)
    SetDisplay(false)
    TriggerServerEvent('cautator:stop')
    TriggerServerEvent('cautator:stop2')
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