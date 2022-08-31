

function drawTxt(text, x, y, scale, r, g, b)
    SetTextFont(6)
    SetTextCentre(1)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextDropShadow(30, 5, 5, 5, 255)
    SetTextEntry("STRING")
    SetTextColour(r, g, b, 255)
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*0.75
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end