--[[
░█████╗░██████╗░███╗░░██╗██╗███████╗
██╔══██╗██╔══██╗████╗░██║██║██╔════╝
███████║██████╔╝██╔██╗██║██║█████╗░░
██╔══██║██╔══██╗██║╚████║██║██╔══╝░░
██║░░██║██║░░██║██║░╚███║██║███████╗
╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚══════╝
--]]

-- Starter settings --

bilafleveret = false

Citizen.CreateThread(function()
    while true do
       Citizen.Wait(1)
       for k,v in pairs(cfg.Start) do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1], v[2], v[3]) < 2 then
            DrawText3Ds(v[1], v[2], v[3]+0.15, "~g~[E]~w~ Start Arnies Drugrun")
            if IsControlJustPressed(1, 38) then
              Citizen.Wait(10000)
  local spawncar = true
  local lockpick = true
  local vehiclehash = GetHashKey("Exemplar")
  RequestModel(vehiclehash)
  while not HasModelLoaded(vehiclehash) do
      RequestModel(vehiclehash)
      Citizen.Wait(1)
  end
  local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 15.0, 0)
  local spawned_car = CreateVehicle(vehiclehash,150.04524230957,-1334.7122802734,29.202285766602, true, false)
  SetEntityAsMissionEntity(spawned_car, true, true)
  spawncar = true
           TriggerEvent('GPS: Lokation')
           TriggerEvent('LockBil')
            end
          end
       end
    end
end)


RegisterNetEvent('GPS: Lokation')
AddEventHandler('GPS: Lokation', function()
    local player = GetPlayerPed(-1)
    SetNewWaypoint(33.711566925049,3747.0969238281,39.673435211182)
end)


RegisterNetEvent('GPS: Afleverebil')
AddEventHandler('GPS: Afleverebil', function()
    local player = GetPlayerPed(-1)
    SetNewWaypoint(1415.7843017578,1163.5336914062,114.3342666626)
end)

RegisterNetEvent('LockBil')
AddEventHandler('LockBil',function()
  local spawncar = true
  local lockpick = true
  local vehiclehash = GetHashKey("neon")
  RequestModel(vehiclehash)
  while not HasModelLoaded(vehiclehash) do
      RequestModel(vehiclehash)
      Citizen.Wait(1)
  end
  local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 15.0, 0)
  local spawned_car = CreateVehicle(vehiclehash,33.711566925049,3747.0969238281,39.673435211182, true, false)
  SetEntityAsMissionEntity(spawned_car, true, true)
  spawncar = true
  lockStatus = GetVehicleDoorLockStatus(spawned_car)
  if lockStatus == 0 or lockStatus == 1 then
      SetVehicleDoorsLocked(spawned_car, 2)
      SetVehicleDoorsLockedForPlayer(spawned_car, PlayerId(), false)
      Citizen.CreateThread(function()
          while true do
              Citizen.Wait(1)
              if lockpick == true then
                      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 33.711566925049,3747.0969238281,39.673435211182, true) <= 2.5 then
                          DrawText3Ds(33.711566925049,3747.0969238281,39.673435211182, "~g~[E]~w~ Lockpick Varevognen")
                          if IsControlJustReleased(1, 38) then
                              TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                              exports['progressBars']:startUI(10000, "Lockpicker Varevognen")
                              Citizen.Wait(10000)
                              lockpick = false
                              ClearPedTasksImmediately(GetPlayerPed(-1))
                              SetVehicleDoorsLocked(spawned_car, 1)
                              exports['mythic_notify']:SendAlert('success',"Du har nu Lockpicket Varevognen")
                               Citizen.Wait(3000)
                               exports['mythic_notify']:SendAlert('inform',"Der er sat en ny GPS i varevognen")
                               TriggerEvent('GPS: Afleverebil')
                          end
                      end
                end
            end
        end)
    end
end)




  Citizen.CreateThread(function()
    while true do
       Citizen.Wait(1)
       for k,v in pairs(cfg.LeveringNeon) do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1], v[2], v[3]) < 4 then
            DrawText3Ds(v[1], v[2], v[3]+0.4, "~g~[E]~w~ Aflevere bilens nøgler")
            if IsControlJustPressed(1, 38) then
                TriggerEvent('Aflever:Nogler')
                TriggerServerEvent('Betaling')
            end
          end
       end
    end
end)

RegisterNetEvent('Aflever:Nogler')
AddEventHandler('Aflever:Nogler', function()
  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
    vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
    exports['progressBars']:startUI(5000, "Aflevere bilens nøgler")
    Citizen.Wait(5000)
    SetEntityAsMissionEntity(vehicle, true,true)
    DeleteVehicle(vehicle, false)
    exports['mythic_notify']:SendAlert('success', 'Du har afleveret bilen')
  else
    exports['mythic_notify']:SendAlert('error', 'Du skal have den stjålne bil med')
  end
end)


-- 3D TEXT -- 
    function DrawText3Ds(x,y,z, text)
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())

        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 20, 20, 20, 150)
    end