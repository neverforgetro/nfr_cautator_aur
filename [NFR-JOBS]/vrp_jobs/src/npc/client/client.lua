-- ESX = nil
PlayerData = {}
local pedList = {}
local cam = nil
local name = ''
local waitMore = true
local inMenu = false
local hasEntered = false

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- 	while ESX.GetPlayerData().job == nil do
-- 		Citizen.Wait(10)
-- 	end
-- 	PlayerData = ESX.GetPlayerData()
-- end)


-- CREATE NPCs

Citizen.CreateThread(function()
	local pedInfo = {}
	local camCoords = nil
	local camRotation = nil

	for k, v in pairs(Config.TalkToNPC) do
		RequestModel(GetHashKey(v.npc))
		while not HasModelLoaded(GetHashKey(v.npc)) do
			Wait(10)
		end

		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
			Wait(10)
		end

		ped =  CreatePed(4, v.npc, v.coordinates[1], v.coordinates[2], v.coordinates[3], v.heading, false, true)
		SetEntityHeading(ped, v.heading)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

		if Config.AutoCamPosition then
			local px, py, pz = table.unpack(GetEntityCoords(ped, true))
			local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52

			camCoords = vector3(x, y, z)
		end

		if Config.AutoCamRotation then
			local rx = GetEntityRotation(ped, 2)

			camRotation = rx + vector3(0.0, 0.0, 181)
		end

		pedInfo = {
			name = v.name,
			model = v.npc,
			pedCoords = v.coordinates,
			entity = ped,
			camCoords = camCoords,
			camRotation = camRotation,
		}

		table.insert(pedList, pedInfo)
	end
end)

-- CHECK DISTANCE & JOB

Citizen.CreateThread(function()
	local inZone = false
	local hasSetName = false
	local nearPed = false
	local checkedJob = false
	local isPetrolist = false
	local npcModel = nil
	local npcName = nil
	local npcKey = 0
	
	while true do
		Citizen.Wait(10)
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		inZone = false
		nearPed = false

		if npcName == nil and npcModel == nil then
			for k,v in pairs(Config.TalkToNPC) do
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
			
				if nearPed then

					if distance < v.interactionRange + 2 then
						npcName = v.name
						npcModel = v.npc
						npcKey = k
						nearPed = true

					elseif not waitMore and not nearPed then
						waitMore = true
					elseif checkedJob then
						checkedJob = false
					end
				else
					if distance < v.interactionRange + 2 then
						npcName = v.name
						npcModel = v.npc
						npcKey = k
						nearPed = true
						if not inMenu then
							waitMore = false
						end
						
					elseif not waitMore and not nearPed then
						waitMore = true
					end
				end
			end
		else
			v = Config.TalkToNPC[npcKey]
			if v ~= nil then
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
				local zDistance = playerCoords.z - v.coordinates[3]
				
				if zDistance < 0 then
					zDistance = zDistance * -1
				end
				if zDistance < 2 then
					if nearPed then

						if distance < v.interactionRange + 3 then
							-- if not checkedJob then
							-- 	isPetrolist = false
							-- 	checkedJob = true
							-- 	for k2,v2 in pairs(v.jobs) do
							-- 		if ESX.GetPlayerData().job.name == v2 then
							-- 			isPetrolist = true
							-- 		end
							-- 	end
							-- end
							
							if nearPed then
								if not nearPed then
									nearPed = true
								end
								if not inMenu then
									waitMore = false
								end
								if distance < v.interactionRange then
									if not hasSetName then
										name = v.uiText
										hasSetName = true
									end
									if not inZone then
										inZone = true
									end
									if not Config.UseOkokTextUI and not inMenu then
										HelpText('Apasa ~INPUT_CONTEXT~ pentru a vorbii cu ~g~'..name)
									end
									if IsControlJustReleased(0, Config.Key) then
										inMenu = true
										waitMore = true
										StartCam(v.coordinates, v.camOffset, v.camRotation, v.npc, v.name)
										if Config.UseOkokTextUI then
											exports['vrp_textui']:Close()
										end
										Citizen.Wait(500)
										if Config.HideMinimap then
											DisplayRadar(false)
										end
										SetNuiFocus(true, true)
										SendNUIMessage({
											action = 'openDialog',
											name = v.name,
											dialog = v.dialog,
											options = v.options,
										})
									end
								elseif hasSetName then
									hasSetName = false
								end
							end
						elseif not waitMore and not nearPed then
							waitMore = true
						elseif checkedJob then
							checkedJob = false
						end
						if distance > v.interactionRange + 2 and npcName ~= nil and npcModel ~= nil then
							npcModel = nil
							npcName = nil
							npcKey = 0
						end
					else
						if distance < v.interactionRange + 3 then
							if not nearPed then
								nearPed = true
							end
							if not inMenu then
								waitMore = false
							end
							if distance < v.interactionRange then
								if not hasSetName then
									name = v.uiText
									hasSetName = true
								end
								if not inZone then
									inZone = true
								end
								if not Config.UseOkokTextUI and not inMenu then
									HelpText('Apasa ~INPUT_CONTEXT~ pentru a vorbii cu ~g~')
								end
								if IsControlJustReleased(0, Config.Key) then
									inMenu = true
									waitMore = true
									StartCam(v.coordinates, v.camOffset, v.camRotation, v.npc, v.name)
									if Config.UseOkokTextUI then
										exports['vrp_textui']:Close()
									end
									Citizen.Wait(200)
									if Config.HideMinimap then
										DisplayRadar(false)
									end
									SetNuiFocus(true, true)
									SendNUIMessage({
										action = 'openDialog',
										header = v.header,
										name = v.name,
										dialog = v.dialog,
										options = v.options,
									})
								end
							elseif hasSetName then
								hasSetName = false
							end
						elseif not waitMore and not nearPed then
							waitMore = true
						end
						if distance > v.interactionRange + 2 and npcName ~= nil and npcModel ~= nil then
							npcModel = nil
							npcName = nil
							npcKey = 0
						end
					end
				end
			end
		end

		

		if inZone and not hasEntered then
			if Config.UseOkokTextUI then
				exports['vrp_textui']:Open('Apasa [E] pentru a vorbii cu '..name, 'darkblue', 'left') 
			end
			hasEntered = true
		elseif not inZone and hasEntered then
			if Config.UseOkokTextUI then
				exports['vrp_textui']:Close()
			end
			hasEntered = false
		end 

		if waitMore then
			Citizen.Wait(500)
		end
	end
end)

-- ACTIONS

RegisterNUICallback('action', function(data, cb)
	if data.action == 'close' then
		SetNuiFocus(false, false)
		vRP.notify({"O zi buna."})
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
			exports['vrp_textui']:Open('Apasa [E] pentru a vorbii cu '..name, 'darkblue', 'left') 
		end
		EndCam()
		inMenu = false
		waitMore = false
	elseif data.action == 'option' then
		SetNuiFocus(false, false)
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
			exports['vrp_textui']:Open('Apasa [E] pentru a vorbii cu '..name, 'darkblue', 'left') 
		end
		EndCam()
		inMenu = false
		waitMore = false

		if data.options[3] == 'c' then
			TriggerEvent(data.options[2])
		elseif data.options[3] ~= nil then
			TriggerServerEvent(data.options[2])
		end
	end
end)

-- CAMERA

function StartCam(coords, offset, rotation, model, name)
	ClearFocus()

	if Config.AutoCamRotation then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					rotation = v.camRotation
				end
			end
		end
	end

	if Config.AutoCamPosition then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					coords = v.camCoords
				end
			end
		end
	else
		coords = coords + offset
	end

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, rotation, GetGameplayCamFov())

	SetCamActive(cam, true)
	RenderScriptCams(true, true, Config.CameraAnimationTime, true, false)
end

function EndCam()
	ClearFocus()

	RenderScriptCams(false, true, Config.CameraAnimationTime, true, false)
	DestroyCam(cam, false)

	cam = nil
end





HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end



-- EXAMPLE EVENTS CALLED ON CONFIG.LUA

local isPetrolist = false
local iscautator = false

RegisterNetEvent("petrol:intrebare")
AddEventHandler("petrol:intrebare", function()
	exports['vrp_notify']:Alert("Petrolist", "Incarci petrol in cisterna , il rafinezi \n si il vinzi , simplu!", 3000, 'info')
end)

RegisterNetEvent("petrol:intrebare2")
AddEventHandler("petrol:intrebare2", function()
	exports['vrp_notify']:Alert("Petrolist", "Desigur , uniforma este obligatorie in caz de ceva.", 3000, 'info')
end)
RegisterNetEvent("petrol:intrebare3")
AddEventHandler("petrol:intrebare3", function()
	exports['vrp_notify']:Alert("Petrolist", "Tirul si remorca pot fi cumparate de la Showroom \n du-te unde ti-am pus eu.", 3000, 'info')
	SetNewWaypoint(-33.725563049316,-1101.6942138672,26.422384262085)
end)

RegisterNetEvent("petrol:intratura")
AddEventHandler("petrol:intratura", function()
	local user_id = vRP.getUserId({source})
	local ped = PlayerPedId()
	TriggerServerEvent('petrol:givejob')
	Wait(100)
	if hasjob then
		exports.rprogress:Custom({
			Async = true,
			x = 0.5,                -- Position on x-axis
			y = 0.85,                -- Position on y-axis
			From = 0,               -- Percentage to start from
			To = 100,               -- Percentage to end
			Duration = 5000,        -- Duration of the progress
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
			Label = "Te imbraci..",
			LabelPosition = "bottom",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			ZoneColor = "rgba(51, 105, 30, 1)",
			Animation = {
				animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
				animationName = "try_tie_negative_a",
			},
			DisableControls = {
				Mouse = true,
				Player = true,
				Vehicle = true
			},    
			onComplete = function(cancelled)
				SetPedComponentVariation(ped, 3, 0,0)
        		SetPedComponentVariation(ped, 4, 9,5,0)
        		SetPedComponentVariation(ped, 6, 25,0,0)
        		SetPedComponentVariation(ped, 8, 59,1,2)
        		SetPedComponentVariation(ped, 11, 351,0,0)
				exports['vrp_notify']:Alert("Petrolist", "Ai intrat pe tura!", 3000, 'info')
				Wait(3000)
				exports['vrp_notify']:Alert("Petrolist", "Du-te incarca cisterna!", 3000, 'info')
				SetNewWaypoint(1265.958, -2341.903, 50.81769)
			end
		})
	end
end)

RegisterNetEvent("petrol:iesetura")
AddEventHandler("petrol:iesetura", function()
	exports.rprogress:Custom({
		Async = true,
		x = 0.5,                -- Position on x-axis
		y = 0.85,                -- Position on y-axis
		From = 0,               -- Percentage to start from
		To = 100,               -- Percentage to end
		Duration = 5000,        -- Duration of the progress
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
		Label = "Te imbraci..",
		LabelPosition = "bottom",
		Color = "rgba(255, 255, 255, 1.0)",
		BGColor = "rgba(0, 0, 0, 0.4)",
		ZoneColor = "rgba(51, 105, 30, 1)",
		Animation = {
			animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
			animationName = "try_tie_negative_a",
		},
		DisableControls = {
			Mouse = true,
			Player = true,
			Vehicle = true
		},    
		onComplete = function(cancelled)
			exports['vrp_notify']:Alert("Petrolist", "Ai iesit de pe tura!", 3000, 'info')
			TriggerServerEvent('petrol:takejob')
		end
	})

end)
RegisterNetEvent("petrol:hasjob")
AddEventHandler("petrol:hasjob", function()
	hasjob = true
end)


RegisterNetEvent("cautator:intrebare")
AddEventHandler("cautator:intrebare", function()
	vRP.notify({"Succes: Cauti aur cu sita prin raurile din oras!",4})
end)

RegisterNetEvent("cautator:intrebare2")
AddEventHandler("cautator:intrebare2", function()
	vRP.notify({"Succes: Desigur , uniforma este obligatorie in caz de ceva.",4})
end)
RegisterNetEvent("cautator:intrebare3")
AddEventHandler("cautator:intrebare3", function()
	vRP.notify({"Succes: Sita o cumperi de la orice magazin!",4})
end)

RegisterNetEvent("cautator:intratura")
AddEventHandler("cautator:intratura", function()
	local user_id = vRP.getUserId({source})
	local ped = PlayerPedId()
	TriggerServerEvent('cautator:givejob')
	Wait(100)
	if iscautator then
		exports.rprogress:Custom({
			Async = true,
			x = 0.5,                -- Position on x-axis
			y = 0.85,                -- Position on y-axis
			From = 0,               -- Percentage to start from
			To = 100,               -- Percentage to end
			Duration = 5000,        -- Duration of the progress
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
			Label = "Te imbraci..",
			LabelPosition = "bottom",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			ZoneColor = "rgba(51, 105, 30, 1)",
			Animation = {
				animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
				animationName = "try_tie_negative_a",
			},
			DisableControls = {
				Mouse = true,
				Player = true,
				Vehicle = true
			},    
			onComplete = function(cancelled)
				SetPedPropIndex(ped, 0, 20, 0, 2)
				SetPedComponentVariation(ped, 8, 59,1,2)
				vRP.notify({"Succes: Ai intrat pe tura!",4})
				Wait(3000)
				TriggerServerEvent('cautator:incepe')
			end
		})
	end
end)

RegisterNetEvent("cautator:iesetura")
AddEventHandler("cautator:iesetura", function()
	exports.rprogress:Custom({
		Async = true,
		x = 0.5,                -- Position on x-axis
		y = 0.85,                -- Position on y-axis
		From = 0,               -- Percentage to start from
		To = 100,               -- Percentage to end
		Duration = 5000,        -- Duration of the progress
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
		Label = "Te imbraci..",
		LabelPosition = "bottom",
		Color = "rgba(255, 255, 255, 1.0)",
		BGColor = "rgba(0, 0, 0, 0.4)",
		ZoneColor = "rgba(51, 105, 30, 1)",
		Animation = {
			animationDictionary = "clothingtie", -- https://alexguirre.github.io/animations-list/
			animationName = "try_tie_negative_a",
		},
		DisableControls = {
			Mouse = true,
			Player = true,
			Vehicle = true
		},    
		onComplete = function(cancelled)
			vRP.notify({"Succes: Ai iesit de pe tura!",4})
			TriggerServerEvent('cautator:takejob')
		end
	})

end)
RegisterNetEvent("cautator:iscautator")
AddEventHandler("cautator:iscautator", function()
	iscautator = true
end)

RegisterNetEvent("cautator:raul1")
AddEventHandler("cautator:raul1", function() 
	SetNewWaypoint(-694.6369, 2341.656, 56.63634) 
end)

RegisterNetEvent("cautator:raul2")
AddEventHandler("cautator:raul2", function() 
	SetNewWaypoint(-1564.494, 1432.419, 117.0335)
end)


